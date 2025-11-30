<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <title>Backbencher Notes - Download Study Materials</title>
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
        }
        
        .hero {
            text-align: center;
            padding: 60px 20px 40px;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff10" d="M0,96L48,112C96,128,192,160,288,186.7C384,213,480,235,576,213.3C672,192,768,128,864,128C960,128,1056,192,1152,208C1248,224,1344,192,1392,176L1440,160L1440,0L1392,0C1344,0,1248,0,1152,0C1056,0,960,0,864,0C768,0,672,0,576,0C480,0,384,0,288,0C192,0,96,0,48,0L0,0Z"></path></svg>') no-repeat top center;
        }
        
        .hero-badge {
            display: inline-block;
            background: linear-gradient(135deg, #ff6b6b, #ee5a5a);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 0.85em;
            font-weight: 600;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .hero h1 {
            font-size: 3em;
            font-weight: 800;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #fff 0%, #a8edea 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .hero h2 {
            font-size: 2.5em;
            font-weight: 700;
            color: #4ecdc4;
            margin-bottom: 15px;
        }
        
        .hero p {
            font-size: 1.1em;
            opacity: 0.8;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .section-title {
            text-align: center;
            margin: 40px 0 30px;
        }
        
        .section-title h3 {
            font-size: 1.8em;
            font-weight: 700;
            color: #fff;
            margin-bottom: 10px;
        }
        
        .section-title p {
            color: rgba(255,255,255,0.7);
        }
        
        .categories {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-bottom: 50px;
        }
        
        .category-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            padding: 30px 20px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: white;
        }
        
        .category-card:nth-child(2) {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        
        .category-card:nth-child(3) {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        
        .category-card:nth-child(4) {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }
        
        .category-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }
        
        .category-icon {
            font-size: 2.5em;
            margin-bottom: 15px;
        }
        
        .category-card h4 {
            font-size: 1.2em;
            font-weight: 600;
        }
        
        .notes-section {
            background: rgba(255,255,255,0.05);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .notes-section h3 {
            font-size: 1.5em;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #4ecdc4;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .notes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .note-card {
            background: rgba(255,255,255,0.08);
            border-radius: 12px;
            padding: 20px;
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.1);
            text-decoration: none;
            color: white;
            display: block;
        }
        
        .note-card:hover {
            background: rgba(255,255,255,0.15);
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            border-color: #4ecdc4;
        }
        
        .note-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .note-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
        }
        
        .note-icon.pdf { background: linear-gradient(135deg, #ff6b6b, #ee5a5a); }
        .note-icon.doc { background: linear-gradient(135deg, #4facfe, #00f2fe); }
        .note-icon.ppt { background: linear-gradient(135deg, #f093fb, #f5576c); }
        .note-icon.xls { background: linear-gradient(135deg, #43e97b, #38f9d7); }
        .note-icon.default { background: linear-gradient(135deg, #667eea, #764ba2); }
        
        .note-info h4 {
            font-size: 1em;
            font-weight: 600;
            margin-bottom: 5px;
            word-break: break-word;
        }
        
        .note-info span {
            font-size: 0.85em;
            opacity: 0.7;
        }
        
        .download-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9em;
            transition: all 0.3s ease;
        }
        
        .note-card:hover .download-btn {
            background: linear-gradient(135deg, #44a08d, #4ecdc4);
        }
        
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
        
        footer {
            text-align: center;
            padding: 40px 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            margin-top: 40px;
        }
        
        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .footer-links a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            font-size: 0.9em;
            transition: color 0.3s ease;
        }
        
        .footer-links a:hover {
            color: #4ecdc4;
        }
        
        .footer-brand {
            font-size: 1.2em;
            font-weight: 700;
            color: #4ecdc4;
            margin-bottom: 10px;
        }
        
        .footer-copyright {
            font-size: 0.85em;
            opacity: 0.6;
        }
        
        .admin-link {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: rgba(255,255,255,0.1);
            color: white;
            padding: 12px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-size: 0.9em;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
        }
        
        .admin-link:hover {
            background: rgba(255,255,255,0.2);
            transform: translateY(-3px);
        }
        
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2em;
            }
            
            .hero h2 {
                font-size: 1.5em;
            }
            
            .notes-section {
                padding: 25px;
            }
            
            .categories {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <div class="hero">
        <span class="hero-badge">Free Study Materials</span>
        <h1>DOWNLOAD NOTES &</h1>
        <h2>QUESTION PAPERS</h2>
        <p>Access quality study materials shared by your instructors</p>
    </div>
    
    <div class="container">
        <div class="section-title">
            <h3>Select Your Course</h3>
            <p>Browse study materials by category</p>
        </div>
        
        <div class="categories">
            <div class="category-card">
                <div class="category-icon">📚</div>
                <h4>All Notes</h4>
            </div>
            <div class="category-card">
                <div class="category-icon">📖</div>
                <h4>Textbooks</h4>
            </div>
            <div class="category-card">
                <div class="category-icon">📝</div>
                <h4>Question Papers</h4>
            </div>
            <div class="category-card">
                <div class="category-icon">🎓</div>
                <h4>Study Guides</h4>
            </div>
        </div>
        
        <div class="notes-section">
            <h3>📁 Available Notes</h3>
            
            <%
                List<String> noteFiles = (List<String>) request.getAttribute("noteFiles");
                
                if (noteFiles == null || noteFiles.isEmpty()) {
            %>
                <div class="empty-state">
                    <div class="icon">📚</div>
                    <h4>No notes have been uploaded yet</h4>
                    <p>Please check back later for study materials!</p>
                </div>
            <%
                } else {
            %>
                <div class="notes-grid">
                    <%
                        for (String fileName : noteFiles) {
                            String iconClass = "default";
                            String fileType = "Document";
                            String lowerName = fileName.toLowerCase();
                            if (lowerName.endsWith(".pdf")) {
                                iconClass = "pdf";
                                fileType = "PDF Document";
                            } else if (lowerName.endsWith(".doc") || lowerName.endsWith(".docx")) {
                                iconClass = "doc";
                                fileType = "Word Document";
                            } else if (lowerName.endsWith(".ppt") || lowerName.endsWith(".pptx")) {
                                iconClass = "ppt";
                                fileType = "Presentation";
                            } else if (lowerName.endsWith(".xls") || lowerName.endsWith(".xlsx")) {
                                iconClass = "xls";
                                fileType = "Spreadsheet";
                            } else if (lowerName.endsWith(".txt")) {
                                fileType = "Text File";
                            } else if (lowerName.endsWith(".zip") || lowerName.endsWith(".rar")) {
                                fileType = "Archive";
                            }
                    %>
                    <a href="download?file=<%= java.net.URLEncoder.encode(fileName, "UTF-8") %>" class="note-card">
                        <div class="note-header">
                            <div class="note-icon <%= iconClass %>">📄</div>
                            <div class="note-info">
                                <h4><%= fileName %></h4>
                                <span><%= fileType %></span>
                            </div>
                        </div>
                        <div class="download-btn">
                            <span>⬇</span> Download
                        </div>
                    </a>
                    <%
                        }
                    %>
                </div>
            <%
                }
            %>
        </div>
    </div>
    
    <footer>
        <div class="footer-links">
            <a href="#">About Us</a>
            <a href="#">Contact</a>
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Use</a>
        </div>
        <div class="footer-brand">Student Notes</div>
        <div class="footer-copyright">Copyright 2025 Student Notes. All rights reserved.</div>
    </footer>
    
    <a href="/admin/dashboard" class="admin-link">🔐 Admin</a>
</body>
</html>
