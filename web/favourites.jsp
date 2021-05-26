<%@page import="java.sql.DriverManager,java.sql.*,java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="font-size: 16px;">
  <head>
    <title>Favourites</title>
  </head>
  <style type="text/css">
    *{
     margin: 0px;
     padding: 0px;
    }
    body{
     font-family: arial;
    }
    nav{
        height: 110px;
        background: #2c3e50;
        box-shadow: 0 10px 15px rgba(0,0,0,0.1);
    }
    .logo{
        float: left;
        width: 150px;
        height: auto;
        margin-left:20px;
    }
    .links {
    margin-right: 150px;
    float: right;
    margin-top: 30px;
    }
       
    .links li {
    display: inline-block;
    list-style: none;
    position: relative;
    font-size: 20px;
    }
    .links li a{
    display: inline-block;
    color: #fff;
    padding: 20px;
    text-decoration: none;
    }
    .links li:hover{
    background: #555;
    }
    .active,.links li:hover{
        background: #555;  
    }
    .links1{
        float: right;
        margin-right: 100px;
        margin-top:10px;
     
    }
    .links1 li {
    display: inline-block;
    list-style: none;
    position: relative;
    font-size: 20px;
    }
    .links1 li a{
    display: inline-block;
    color: #fff;
    padding: 15px;
    text-decoration: none;
    
    }
    .links1 li:hover{
    background: #555;
    }
    .main{
     background: #BFBFFF;
     background-repeat: no-repeat;
     background-size: cover;
     padding-bottom: 90px;
    }
   
    .header_inside {
       width:100%;
       height: 10vh;
       background-color: #000033;
    }
    .navbar{
        width:85%;
        margin: auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .logo{
        width: 120px;
        position: absolute;
        top: 5px;
        left: 10px;
        cursor: pointer;
    }
    .card{
         width: 80%;
         height: 80%;
         background: #E9E9E9;
         display: inline-block;
         box-shadow: 2px 2px 20px black;
         border-radius: 5px; 
         margin-top: 2.25%;
         margin-left: 10%;
         margin-bottom: 2.25%; 
        }

    .image img{
      width: 100%;
      height: 250px;
      border-top-right-radius: 5px;
      border-top-left-radius: 5px;
     }


    .navi {
        align: center;
    }
    label{
        color: white;
        font-size:40px;
        padding-left: 20px;
    }
    .footer {
         padding: 20px;
        text-align: center;
        background-color: #000033;
        color: black;
        height:5vh;
        font-size: 30px;
        position:fixed;
        right: 0;
        left:0;
        bottom:0;
    }
    .pro{
            font-size: 30px;
            font-weight: 500;
            padding-left: 370px;
            padding-top: 180px;
        }
    .btn1 {
    background:#D61E29 ;
    display: inline-block;
    list-style: none;
    position: relative;
    font-size: 20px;
    display: inline-block;
    color: white;
    padding: 20px;
    text-decoration: none;
    font-weight: 600;


    }
    .btn1:hover{
        background:darkred;
    }
    .btn2:hover{
        background:#9e8fb2;

    }
    .btn2 {
    background:blue;
    display: inline-block;
    list-style: none;
    position: relative;
    font-size: 20px;
    display: inline-block;
    color: black;
    padding: 20px;
    font-weight: 600;
    text-decoration: none;
    background-color:  #8693ab;
    margin-left:20%;
    }
</style>
<body style=" background: #BFBFFF;">
<div class="header">
            <nav>
                <img class="logo" src="images/logo.png">
                <ul class="links">
                    <li ><a href="AboutUs.jsp">About Us</a></li>
                    <li><a href="ContactUs.jsp">Contact Us</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
     </div>
            <% 
                 String bid=request.getParameter("bid");
                 String bname="";
                 String query="select b_name from buyer where b_id='"+bid+"'";
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/bvmart");
                Statement stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(query);
                boolean status=rs.next();
                if(status)
                {
                    bname=rs.getString(1);
                }               
             %>
        
<div class="header_inside">
    <div class="navbar">
        <label>Welcome <label><%=bname%></label></label>
        
   
    <div class="links1">
        <ul>
            <li ><a href="buyer_cardpage.jsp?bid=<%=bid%>">Category</a></li>
        </ul>
    </div>
         </div>
</div>  
    <div class="main">
         <%
            try {
                int pageNumber = 0;
                int totalNumberOfRecords = 0;
                int recordPerPage = 5;
                int startIndex = 0;
                int numberOfPages = 0;
                String sPageNo = request.getParameter("pageno");
                pageNumber = Integer.parseInt(sPageNo);
                startIndex = (pageNumber * recordPerPage) - recordPerPage + 1;
                
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/bvmart");  
                Statement st1 = con.createStatement();
                 Statement st2 = con.createStatement();
                                 
                int pid=0;
                String pro_status="";
                String pimage="";
                int count=0;
               
                ResultSet rst1 = st1.executeQuery("SELECT p.p_id,p_image,p_status FROM product p INNER JOIN category c ON p.c_id=c.c_id and c_flag=0 INNER JOIN favourites f ON f.p_id=p.p_id and f.b_id='"+bid+"'");
                ResultSet rst2 = st2.executeQuery("select count(*) from favourites f INNER JOIN product p ON f.b_id='"+bid+"' and f.p_id=p.p_id INNER JOIN category c ON p.c_id=c.c_id and c_flag=0");
		rst2.next();
		count = rst2.getInt(1);
		rst2.close();
                if(count==0){
                    %>
                    <table>
                    <tr>
                        <td class="pro">OOPS!! NO PRODUCT IS ADDED TO YOUR FAVOURITES</td>
                        </tr></table>
                    <%
                }
                else{
                   %>
                   <div class="card">
                    <table style="width:100%;padding:20px;border-style: groove;" border="5">
                    <%
                        int i = 0;
                        while(rst1.next())
                        {   i++;
                            if(i==startIndex)
                                break;

                        }
                        i=0;
                        do {
                            i++;
                            pid=rst1.getInt(1);
                            pimage = rst1.getString(2);
                            int statuss=rst1.getInt(3);
                            if(statuss==0)
                                pro_status="images/instock3.png";
                            else
                                pro_status="images/soldout3.png";
                       
                       
        %>  
            <tr>
               
                <td align="center" width="40%" style="padding:5px;"><a href="zoom_product2.jsp?pid=<%=pid%>"><img src="<%=pimage%>" width="270px" height="200px"/></a></td>
                 <td align="center" width="20%" style="padding:5px;"><image src="<%=pro_status%>" width="150px" height="150px" /></td>
                 <td align="center" width="15%" style="padding:5px;"><a class="btn1" href="removeproduct.jsp?pid=<%=pid%>&bid=<%=bid%>" onclick="return confirm('Are you sure?')">REMOVE</a></td>
                 
                    <td>
                    <form action="SendEmail" method="post">
                            <input type="hidden" name="pid" value="<%=pid%>" />
                            <input type="hidden" name="bid" value="<%=bid%>" />
                            <input type="submit" class="btn2" value="Contact Seller"  />
                        

                    </form>
                </td>
                 
            </tr>
       
        <% 
            }while(rst1.next()&& i!=recordPerPage);
                totalNumberOfRecords = count;
                numberOfPages = totalNumberOfRecords / recordPerPage;
                if(totalNumberOfRecords > numberOfPages * recordPerPage) {
                    numberOfPages = numberOfPages + 1;
                }
%>
        </table>
        </div>
<br>
 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
  <%
            int k;
            for(k = 1; k <= numberOfPages; k++) {
%>
            <b><a href="favourites.jsp?bid=<%=bid%>&pageno=<%=k%>"><%=k%></a>
                &nbsp;&nbsp;&nbsp;&nbsp;</b>
<%
           }
                }  
            } catch (Exception e) {
                out.println(e);
            }
        %>
        
        </div> 
<div class="footer">
        <div class="links">
            <ul>
            <li style="float:left;margin-right:550px;position:relative;margin-top: -42px;"><a href="feedback.jsp">Feedback</a></li>
            </ul>
        </div>
    </div>
<!--cards -->
  </body>
</html>
