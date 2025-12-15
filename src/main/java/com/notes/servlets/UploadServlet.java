package com.notes.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/admin/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,        // 1MB
    maxFileSize = 1024 * 1024 * 50,          // 50MB
    maxRequestSize = 1024 * 1024 * 100       // 100MB
)
public class UploadServlet extends HttpServlet {

    // Root storage directory (Docker-safe)
    private static final String NOTES_DIR = System.getProperty("user.dir") + "/notes";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        File notesRoot = new File(NOTES_DIR);
        if (!notesRoot.exists()) {
            notesRoot.mkdirs();
        }

        // ---- CATEGORY FIX ----
        String category = request.getParameter("category");
        if (category == null || category.trim().isEmpty()) {
            category = "notes";   // DEFAULT → NOTES
        }
        category = sanitizePath(category);

        File targetFolder = new File(NOTES_DIR, category);

        // ---- SECURITY CHECK ----
        if (!targetFolder.getCanonicalPath().startsWith(notesRoot.getCanonicalPath())) {
            request.setAttribute("message", "Error: Invalid category path.");
            request.setAttribute("messageType", "error");
            request.setAttribute("currentPath", "");
            request.getRequestDispatcher("/admin/dashboard").forward(request, response);
            return;
        }

        if (!targetFolder.exists()) {
            targetFolder.mkdirs();
        }

        // ---- FILE PART ----
        Part filePart = request.getPart("noteFile");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("message", "Error: Please select a file.");
            request.setAttribute("messageType", "error");
            request.setAttribute("currentPath", category);
            request.getRequestDispatcher("/admin/dashboard").forward(request, response);
            return;
        }

        String fileName = extractFileName(filePart);
        if (fileName == null || fileName.isEmpty()) {
            request.setAttribute("message", "Error: Invalid file name.");
            request.setAttribute("messageType", "error");
        request.setAttribute("currentPath", category);
            request.getRequestDispatcher("/admin/dashboard").forward(request, response);
            return;
        }

        fileName = sanitizeFileName(fileName);

        Path targetPath = Paths.get(targetFolder.getAbsolutePath(), fileName);

        if (Files.exists(targetPath)) {
            request.setAttribute("message", "Error: File already exists.");
            request.setAttribute("messageType", "error");
            request.setAttribute("currentPath", category);
            request.getRequestDispatcher("/admin/dashboard").forward(request, response);
            return;
        }

        // ---- SAVE FILE ----
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, targetPath, StandardCopyOption.REPLACE_EXISTING);
        }

        // ---- SUCCESS ----
        request.setAttribute("message", "Success: File uploaded to '" + category + "'");
        request.setAttribute("messageType", "success");
        request.setAttribute("currentPath", category);
        request.getRequestDispatcher("/admin/dashboard").forward(request, response);
    }

    // ---------------- HELPERS ----------------

    private String extractFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;

        for (String token : cd.split(";")) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(Math.max(fileName.lastIndexOf('/'), fileName.lastIndexOf('\\')) + 1);
            }
        }
        return null;
    }

    private String sanitizeFileName(String name) {
        name = name.replaceAll("[/\\\\]", "");
        name = name.replace("\0", "");
        name = name.replaceAll("\\.{2,}", ".");
        while (name.startsWith(".")) {
            name = name.substring(1);
        }
        return name;
    }

    private String sanitizePath(String path) {
        path = path.replace("\\", "/");
        path = path.replaceAll("\\.{2,}", "");
        path = path.replaceAll("^/+", "");
        path = path.replaceAll("/+$", "");
        path = path.replaceAll("/+", "/");
        return path;
    }
}