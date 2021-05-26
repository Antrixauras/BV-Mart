import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/paging1"})
public class paging1 extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try
        {   PrintWriter pw = response.getWriter();
            int pageNumber = 0;
            int totalNumberOfRecords = 0;
            int recordPerPage = 3;
            int startIndex = 0;
            int numberOfPages = 0;
            String sPageNo = request.getParameter("pageno");
            pw.println(sPageNo);
            pageNumber = Integer.parseInt(sPageNo);
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/employee","kg","kg");
            Statement stmt=con.createStatement();
            response.setContentType("text/html"); 
            stmt = con.createStatement();    
            startIndex = (pageNumber * recordPerPage) - recordPerPage + 1;
            ResultSet rs1 = stmt.executeQuery("select * from employee");
            
//            pw.println("<html><body>"); 
            pw.println("<center><table border=3>");
            pw.println("<tr>");
            pw.println("<b>");
            pw.println("<th>eid</th><th>ename</th>");
            pw.println("</b>");
            pw.println("</tr>");
            //rs1.absolute(startIndex);
            int i = 0;
            while(rs1.next())
            {
                if(i==startIndex)
                    break;
                i++;
            }
            pw.println("<h1>"+startIndex+"</h1>");
            i=0;
            do
            {   i++;
                pw.println("<tr>");
                pw.println("<td>" + rs1.getInt(1) + "</td>");
                pw.println("<td>" + rs1.getString(2) + "</td>");
                pw.println("</tr>");
            }while(rs1.next()&&i!=recordPerPage);
            pw.println("</table>");
            rs1.close();
            
            ResultSet rs2 = stmt.executeQuery("select count(*) from employee");
            rs2.next();
            totalNumberOfRecords = rs2.getInt(1);
            rs2.close();
            numberOfPages = totalNumberOfRecords / recordPerPage;
            if(totalNumberOfRecords > numberOfPages * recordPerPage) {
                numberOfPages = numberOfPages + 1;
            }
            for(int k = 1; k <= numberOfPages; k++) {
//                pw.println(" <a href=/paging1?pageno= "+k+">" + k + "</a>");

                pw.println("<b><a href=paging1?pageno=" + k + ">" + k + "</a></b>");
                pw.println("&nbsp;&nbsp;&nbsp;&nbsp;");
            }
            pw.println("</center>");
//            pw.println("</body></html>");
            con.close();
        }
        catch(Exception ex){
            
        } 
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
