<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="model.Webuser"%>
<%@page import="controller.WebuserJpaController"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Messages - Register</title>
        <link rel="stylesheet" href="../css/mystyles.css">
    </head>
    <body>
        <h1>Welcome to Messages</h1>
        <h3>Register</h3>
        <%
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String newpassword1 = request.getParameter("newpassword1");
            String newpassword2 = request.getParameter("newpassword2");
            String photo = request.getParameter("photo");

            if (request.getMethod().equals("POST")
                    //&& request.getContentType().indexOf("multipart/form-data") >= 0
                    && fname != null
                    && lname != null
                    && email != null
                    && username != null
                    && newpassword1 != null
                    && newpassword2 != null
                    && newpassword2.equals(newpassword1)) {

                String password = newpassword2;
                byte [] photoBytes = null;
                if(photo != null){
                    photoBytes = photo.getBytes();
                }
                out.println("<p>" + fname + "</p>");
                out.println("<p>" + lname + "</p>");
                out.println("<p>" + email + "</p>");
                out.println("<p>" + username + "</p>");            
                out.println("<p>" + photo + "</p>");
                 
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppTomcatPU");
                WebuserJpaController userController = new WebuserJpaController(emf);

                Webuser newUser = new Webuser(username, password, new Date(), fname, lname, email, photoBytes);
                userController.create(newUser);
                out.print("<h4>You succesfully signed up!</h4>");
                
                emf.close();
            }
        %>
        <form action="register.jsp" method="post" enctype="">
            <input type="text" name="fname" id="fname" placeholder="Enter your First name" autocomplete="off" required><br>
            <input type="text" name="lname" id="lname" placeholder="Enter your Last name" autocomplete="off" required><br>
            <input type="email" name="email" id="email" placeholder="Enter your E-Mail" autocomplete="off" required><br>
            <input type="text" name="username" id="username" placeholder="Choose your Username" autocomplete="off" required><br>
            <input type="password" name="newpassword1" id="newpassword1" placeholder="Choose your password" required><br>
            <input type="password" name="newpassword2" id="newpassword2" placeholder="Enter again your password" required><br>
            <input type="file" name="photo" id="photo" accept="image/png, image/jpeg" placeholder="Upload your photo here"><br>
            <input type="submit" value="Save">
            <input type="reset" value="Clear"><br>
        </form>
        <ul>
            <li><a href="../index.jsp">Home</a></li>
        </ul>
        <hr>
        <h4>Copyright My Name 2019</h4>
    </body>
</html>