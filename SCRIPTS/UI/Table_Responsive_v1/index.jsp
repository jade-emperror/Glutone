<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import=" java.io.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Table V01</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-table100">
			<div class="wrap-table100">
				<div class="table100">
					<table>
						<thead>
							<tr class="table100-head">
								<th class="column1">SYMBOL</th>
								<th class="column2">PERCENT</th>
								<th class="column3">OPEN</th>
								<th class="column4">HIGH</th>
								<th class="column5">LOW</th>
								<th class="column6">RMSE(HIGH)</th>
								<th class="column6">RMSE(LOW)</th>
							</tr>
						</thead>
						<tbody><!--
								<tr>
									<td class="column1">2017-09-29 01:22</td>
									<td class="column2">200398</td>
									<td class="column3">iPhone X 64Gb Grey</td>
									<td class="column4">$999.00</td>
									<td class="column5">1</td>
									<td class="column6">$999.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-28 05:57</td>
									<td class="column2">200397</td>
									<td class="column3">Samsung S8 Black</td>
									<td class="column4">$756.00</td>
									<td class="column5">1</td>
									<td class="column6">$756.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-26 05:57</td>
									<td class="column2">200396</td>
									<td class="column3">Game Console Controller</td>
									<td class="column4">$22.00</td>
									<td class="column5">2</td>
									<td class="column6">$44.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-25 23:06</td>
									<td class="column2">200392</td>
									<td class="column3">USB 3.0 Cable</td>
									<td class="column4">$10.00</td>
									<td class="column5">3</td>
									<td class="column6">$30.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-24 05:57</td>
									<td class="column2">200391</td>
									<td class="column3">Smartwatch 4.0 LTE Wifi</td>
									<td class="column4">$199.00</td>
									<td class="column5">6</td>
									<td class="column6">$1494.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-23 05:57</td>
									<td class="column2">200390</td>
									<td class="column3">Camera C430W 4k</td>
									<td class="column4">$699.00</td>
									<td class="column5">1</td>
									<td class="column6">$699.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-22 05:57</td>
									<td class="column2">200389</td>
									<td class="column3">Macbook Pro Retina 2017</td>
									<td class="column4">$2199.00</td>
									<td class="column5">1</td>
									<td class="column6">$2199.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-21 05:57</td>
									<td class="column2">200388</td>
									<td class="column3">Game Console Controller</td>
									<td class="column4">$999.00</td>
									<td class="column5">1</td>
									<td class="column6">$999.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-19 05:57</td>
									<td class="column2">200387</td>
									<td class="column3">iPhone X 64Gb Grey</td>
									<td class="column4">$999.00</td>
									<td class="column5">1</td>
									<td class="column6">$999.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-18 05:57</td>
									<td class="column2">200386</td>
									<td class="column3">iPhone X 64Gb Grey</td>
									<td class="column4">$999.00</td>
									<td class="column5">1</td>
									<td class="column6">$999.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-22 05:57</td>
									<td class="column2">200389</td>
									<td class="column3">Macbook Pro Retina 2017</td>
									<td class="column4">$2199.00</td>
									<td class="column5">1</td>
									<td class="column6">$2199.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-21 05:57</td>
									<td class="column2">200388</td>
									<td class="column3">Game Console Controller</td>
									<td class="column4">$999.00</td>
									<td class="column5">1</td>
									<td class="column6">$999.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-19 05:57</td>
									<td class="column2">200387</td>
									<td class="column3">iPhone X 64Gb Grey</td>
									<td class="column4">$999.00</td>
									<td class="column5">1</td>
									<td class="column6">$999.00</td>
								</tr>
								<tr>
									<td class="column1">2017-09-18 05:57</td>
									<td class="column2">200386</td>
									<td class="column3">iPhone X 64Gb Grey</td>
									<td class="column4">$999.00</td>
									<td class="column5">1</td>
									<td class="column6">$999.00</td>
								</tr>
							
							{% for row in value %} 
            					<tr>
                					<td class="column1">{{row[0]}}</td>
                					<td class="column2">{{row[1]}}</td>
                					<td class="column3">{{row[2]}}</td>
                					<td class="column4">{{row[3]}}</td>
                					<td class="column5">{{row[4]}}</td>
                					<td class="column6">{{row[5]}}</td>
            					</tr>
							{% endfor %}
							-->

							<%
        
        try {
            /* TODO output your page here. You may use following sample code. */
            
            
      
             Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:49688;databaseName=magic_db";
        Connection con = DriverManager.getConnection(url,"sa","123qwe");

        String query ="select * from magic_db.dbo.show_time";


        Statement myStatement = null;
        myStatement = con.createStatement();
        ResultSet result = myStatement.executeQuery(query);

        while(result.next()){%>
        
                        <tr>
                          <td><%=result.getString("symbol")%></td>
                      <td><%=result.getString("perceent") %></td>
                             <td><%=result.getString("open_price")%></td>
                            <td><%=result.getString("high_rmse")%></td>
							<td><%=result.getString("high")%></td>
							<td><%=result.getString("low_rmse")%></td>
                            <td><%=result.getString("low")%></td>
                            
                        </tr>
                        <%
                          
                        
                    }
con.close();
   
        }
           
       catch (ClassNotFoundException ex) {
           ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>


	

<!--===============================================================================================-->	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>