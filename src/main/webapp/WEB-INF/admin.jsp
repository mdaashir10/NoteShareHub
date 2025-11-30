<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.notes.servlets.AdminDashboardServlet.FileInfo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <title>Admin Dashboard - Student Notes</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(180deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
            min-height: 100vh;
            color: #fff;
            padding: 20px;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 30px;
            background: rgba(255,255,255,0.08);
            border-radius: 15px;
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .header-left h1 {
            font-size: 1.8em;
            font-weight: 700;
            background: linear-gradient(135deg, #fff 0%, #4ecdc4 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .header-left p {
            font-size: 0.9em;
            opacity: 0.7;
            margin-top: 5px;
        }
        
        .header-right {
            text-align: right;
        }
        
        .admin-badge {
            display: inline-block;
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .view-site-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #4ecdc4;
            text-decoration: none;
            font-size: 0.9em;
            transition: all 0.3s ease;
        }
        
        .view-site-link:hover {
            color: #fff;
        }
        
        .message {
            padding: 18px 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .message.success {
            background: rgba(78, 205, 196, 0.2);
            color: #4ecdc4;
            border: 1px solid rgba(78, 205, 196, 0.3);
        }
        
        .message.error {
            background: rgba(255, 107, 107, 0.2);
            color: #ff6b6b;
            border: 1px solid rgba(255, 107, 107, 0.3);
        }
        
        .card {
            background: rgba(255,255,255,0.08);
            border-radius: 20px;
            padding: 35px;
            margin-bottom: 25px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .card h2 {
            font-size: 1.4em;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #4ecdc4;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .upload-form {
            display: flex;
            gap: 15px;
            align-items: stretch;
            flex-wrap: wrap;
        }
        
        .file-input-wrapper {
            flex-grow: 1;
            min-width: 250px;
        }
        
        .file-input-wrapper input[type="file"] {
            width: 100%;
            padding: 18px 20px;
            border: 2px dashed rgba(255,255,255,0.3);
            border-radius: 12px;
            background: rgba(255,255,255,0.05);
            cursor: pointer;
            color: white;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }
        
        .file-input-wrapper input[type="file"]:hover {
            border-color: #4ecdc4;
            background: rgba(78, 205, 196, 0.1);
        }
        
        .file-input-wrapper input[type="file"]::file-selector-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            margin-right: 15px;
            transition: all 0.3s ease;
        }
        
        .file-input-wrapper input[type="file"]::file-selector-button:hover {
            transform: scale(1.02);
        }
        
        .btn {
            padding: 18px 35px;
            border: none;
            border-radius: 12px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
        }
        
        .btn-upload {
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            color: white;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-upload:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(78, 205, 196, 0.3);
        }
        
        .btn-delete {
            background: linear-gradient(135deg, #ff6b6b, #ee5a5a);
            color: white;
            padding: 10px 20px;
            font-size: 0.85em;
        }
        
        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }
        
        .files-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .files-table th,
        .files-table td {
            padding: 18px 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .files-table th {
            background: rgba(255,255,255,0.05);
            font-weight: 600;
            color: #4ecdc4;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .files-table tbody tr {
            transition: all 0.3s ease;
        }
        
        .files-table tbody tr:hover {
            background: rgba(255,255,255,0.05);
        }
        
        .file-name {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .file-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1em;
        }
        
        .file-icon.pdf { background: linear-gradient(135deg, #ff6b6b, #ee5a5a); }
        .file-icon.doc { background: linear-gradient(135deg, #4facfe, #00f2fe); }
        .file-icon.ppt { background: linear-gradient(135deg, #f093fb, #f5576c); }
        .file-icon.xls { background: linear-gradient(135deg, #43e97b, #38f9d7); }
        .file-icon.default { background: linear-gradient(135deg, #667eea, #764ba2); }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        
        .empty-state .icon {
            font-size: 4em;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        .empty-state h4 {
            font-size: 1.3em;
            margin-bottom: 10px;
            opacity: 0.8;
        }
        
        .empty-state p {
            opacity: 0.6;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: rgba(255,255,255,0.05);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .stat-card .value {
            font-size: 2em;
            font-weight: 700;
            color: #4ecdc4;
        }
        
        .stat-card .label {
            font-size: 0.85em;
            opacity: 0.7;
            margin-top: 5px;
        }
        
        @media (max-width: 768px) {
            header {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }
            
            .header-right {
                text-align: center;
            }
            
            .upload-form {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .files-table th:nth-child(2),
            .files-table td:nth-child(2),
            .files-table th:nth-child(3),
            .files-table td:nth-child(3) {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="header-left">
                <h1>Admin Dashboard</h1>
                <p>Manage your study materials</p>
            </div>
            <div class="header-right">
                <div class="admin-badge">👤 <%= request.getAttribute("adminUser") %></div>
                <br>
                <a href="/" class="view-site-link">← View Public Site</a>
            </div>
        </header>
        
        <%
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null && !message.isEmpty()) {
        %>
        <div class="message <%= messageType %>">
            <span><%= "success".equals(messageType) ? "✓" : "✕" %></span>
            <%= message %>
        </div>
        <%
            }
        %>
        
        <%
            List<FileInfo> noteFiles = (List<FileInfo>) request.getAttribute("noteFiles");
            int fileCount = noteFiles != null ? noteFiles.size() : 0;
        %>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="value"><%= fileCount %></div>
                <div class="label">Total Files</div>
            </div>
            <div class="stat-card">
                <div class="value">📚</div>
                <div class="label">Notes Active</div>
            </div>
            <div class="stat-card">
                <div class="value">✓</div>
                <div class="label">System Online</div>
            </div>
        </div>
        
        <div class="card">
            <h2>📤 Upload New Note</h2>
            <form action="upload" method="post" enctype="multipart/form-data" class="upload-form">
                <div class="file-input-wrapper">
                    <input type="file" name="noteFile" required>
                </div>
                <button type="submit" class="btn btn-upload">
                    <span>⬆</span> Upload File
                </button>
            </form>
        </div>
        
        <div class="card">
            <h2>📁 Manage Notes</h2>
            
            <%
                SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy HH:mm");
                
                if (noteFiles == null || noteFiles.isEmpty()) {
            %>
                <div class="empty-state">
                    <div class="icon">📁</div>
                    <h4>No notes uploaded yet</h4>
                    <p>Use the form above to upload your first study material!</p>
                </div>
            <%
                } else {
            %>
                <table class="files-table">
                    <thead>
                        <tr>
                            <th>File Name</th>
                            <th>Size</th>
                            <th>Last Modified</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (FileInfo file : noteFiles) {
                                String iconClass = "default";
                                String lowerName = file.getName().toLowerCase();
                                if (lowerName.endsWith(".pdf")) {
                                    iconClass = "pdf";
                                } else if (lowerName.endsWith(".doc") || lowerName.endsWith(".docx")) {
                                    iconClass = "doc";
                                } else if (lowerName.endsWith(".ppt") || lowerName.endsWith(".pptx")) {
                                    iconClass = "ppt";
                                } else if (lowerName.endsWith(".xls") || lowerName.endsWith(".xlsx")) {
                                    iconClass = "xls";
                                }
                        %>
                        <tr>
                            <td>
                                <div class="file-name">
                                    <div class="file-icon <%= iconClass %>">📄</div>
                                    <span><%= file.getName() %></span>
                                </div>
                            </td>
                            <td><%= file.getSize() %></td>
                            <td><%= dateFormat.format(new Date(file.getLastModified())) %></td>
                            <td>
                                <form action="delete" method="post" style="display: inline;" 
                                      onsubmit="return confirm('Are you sure you want to delete this file?');">
                                    <input type="hidden" name="fileName" value="<%= file.getName() %>">
                                    <button type="submit" class="btn btn-delete">🗑 Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
