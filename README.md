NoteShareHub – Student Notes Sharing Platform:

NoteShareHub is a Java-based web application built using Servlets and JSP that allows students to browse and download academic materials, while administrators can securely upload, organize, and manage those materials through an admin dashboard.
This project is intended for educational and academic use, such as college mini-projects and servlet/JSP learning.

Features:
Student (Public Access)Browse study materials without login
Folder-based structure such as:
Notes
Question Papers
Textbooks
Guides
Download files directly

Admin:
Secure admin dashboard
Upload files to selected folders
Create folders and subfolders
Delete files and folders
Breadcrumb navigation for folders

Security:
Admin pages protected using HTTP BASIC Authentication
Security configured via web.xml

Tech Stack:
Java (Servlets, JSP)
Apache Tomcat 9
Maven
HTML, CSS
File-based storage (no database)

Structure:
NoteShareHub
├── src/main/java
│   └── com/notes/servlets
│       ├── AdminDashboardServlet.java
│       ├── UploadServlet.java
│       ├── CreateFolderServlet.java
│       ├── DeleteServlet.java
│       └── ListNotesServlet.java
│
├── src/main/webapp
│   ├── index.jsp
│   ├── logo.png
│   └── WEB-INF
│       ├── admin.jsp
│       └── web.xml
│
├── notes/
│   ├── notes/
│   ├── question-papers/
│   ├── textbooks/
│   └── guides/
│
└── pom.xml

Limitations:
No database (file system only)
No student login system
BASIC authentication only (not production-grade)
Uploaded files are not persistent on free hosting
These limitations are intentional for simplicity and learning.

Intended Use:
College mini-projects
Learning Java Servlets and JSP
Demonstrating file upload/download
Understanding authentication via web.xml

License:
This project is intended for educational use only.
