<%@page import="controller.WebuserJpaController"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.Persistence"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Messages - Login</title>
    </head>
    <body>

        <h1>Welcome to Messages</h1>
        <h3>Login</h3>
        <%
            String u = request.getParameter("username");
            String p = request.getParameter("password");
            if (request.getMethod().equals("POST")
                    && u != null
                    && p != null) {
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppTomcatPU");
                WebuserJpaController userController = new WebuserJpaController(emf);
                if (userController.checkLogin(u, p)) {
                    if(u.equals("admin")){
                        response.sendRedirect("admin.jsp");
                    } else {
                        response.sendRedirect("messages.jsp");
                    }
                    
                } else {
                    out.print("<h4>Username does not exist or password is not correct! Try again...</h4>");
                }
                emf.close();
            }
        %>
        <form action="login.jsp" method="post">
            <input type="text" name="username" id="username" placeholder="Enter your username" autocomplete="off" required><br>
            <input type="password" name="password" id="password" placeholder="Enter your password" required><br>
            <input type="submit" value="Login"><br>
        </form>
        <ul>
            <li><a href="../index.jsp">Home</a></li>
        </ul>
        <hr>
        <h4>Copyright My Name 2019</h4>
    </body>
</html>