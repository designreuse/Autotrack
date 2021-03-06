<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%@ page import="java.io.*" %>
             <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
    <%@ page import="java.sql.Connection"%>
    <%@ page import="java.sql.Statement"%>
    <%@ page import="java.sql.ResultSet"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Welcome to AutoTrack</title>


<link rel="stylesheet" href="../css/style.default.css" type="text/css" />
<link rel="stylesheet" href="../prettify/prettify.css" type="text/css" />
<script type="text/javascript" src="../prettify/prettify.js"></script>
<script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.flot.min.js"></script>
<script type="text/javascript" src="../js/jquery.flot.resize.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/custom.js"></script>
<link rel="shortcut icon" href="../images/fav_icon.ico" />
<!--[if lte IE 8]>
<script language="javascript" type="text/javascript" src="../js/excanvas.min.js"></script><![endif]-->


<!--Current Date and Time-->    
<script type="text/javascript" src="../js/current_date.js"></script>
<script type="text/javascript">
	function noBack() {
		window.history.forward();
	}

	function update() {
            alert("Updated Successfully");
			var license_number = document.DriverInfo.license_number.value;
			document.DriverInfo.action = "/Autotrack/ControllerServlet/DriverInfoUpdateService?actions=update";
			document.DriverInfo.submit();
	

	}
	
	function del() {
		 alert("Deleted Successfully");
		document.DriverInfo.action = "/Autotrack/ControllerServlet/DriverInfoUpdateService?actions=del";
		document.DriverInfo.submit();


}

	function refresh() {
		document.getElementById("licencenum").disabled = true;
	}
</script>
>
<script type="text/javascript">

<%
	String license_number = request.getParameter("licence_number");
	System.out.println(license_number);
	String driver_name = "";
	String gender = "";
	String contact_no = " ";
	String address = "";
	String date_of_birth = "";
	String date_of_joining = " ";
	String date_of_issue = "";
	String date_of_expiry = "";
	String vehicle_number = "";
	String shift_number = "";
	String route_number = "";

	try {

		DBTransaction dbtranobj = new DBTransaction();
		Connection connection = dbtranobj.connect();
		ResultSet rs = null;
		Statement st = null;
		st = connection.createStatement();

		rs = st.executeQuery("SELECT * from driver_info WHERE license_number = '"+ license_number + "'");

		while (rs.next()) {

			license_number = rs.getString("license_number");
			System.out.println("License Number in JSP:"
					+ license_number);
			driver_name = rs.getString("driver_name");

			gender = rs.getString("gender");

			contact_no = rs.getString("contact_no");

			address = rs.getString("address");

			date_of_birth = rs.getString("dob");

			date_of_joining = rs.getString("doj");

			date_of_issue = rs.getString("doi");

			date_of_expiry = rs.getString("doe");

			vehicle_number = rs.getString("vehicle_number");
		
			shift_number = rs.getString("shift_number");

			route_number = rs.getString("route_number");

		}

		 connection.close();
		 rs.close();
		st.close();
		
	} catch (SQLException e) {
		System.err.println(e.getMessage());
	}
%>



<%-- function print_qualification(id) {
	// given the id of the <select> tag as function argument, it inserts <option> tags
	var option_str = document.getElementById(id);
	var x, i = 0;
	option_str.options[i++] = new Option("");
	for (x in qualification) {
		option_str.options[i++] = new Option(qualification[x]);
		if (document.register.qualification.value == "<%=qualification%>")
		{
		document.register.qualification.selectedIndex = i;
		}
} --%>





</script>
</head>

<%
	String message = request.getParameter("message");
	if (message == null) {
		message = "";
	} 
	else if (message.equalsIgnoreCase("updated")) {
	message = "Driver Information Successfully Updated !!!";
	} 
	else if (message.equalsIgnoreCase("deleted")) {
	message = "Driver Information Successfully deleted !!!";
	}
%>



<body>
<div class="mainwrapper">
	<%=message %>
    <!-- START OF LEFT PANEL -->
    <div class="leftpanel">
    	
       <div class="logopanel">
        	<h1><a href="dashboard.jsp"><img src="img/pro_logo.png" /></a></h1>
        </div><!--logopanel--><div class="datewidget"><span id="date"></span></div>
    
    	<div class="searchwidget">
        	<form action="livetracking.jsp" method="post">
            	<div class="input-append">
                    <input type="text" class="span2 search-query" placeholder="Search here...">
                    <button type="submit" class="btn"><span class="icon-search"></span></button>
                </div>
            </form>
        </div><!--searchwidget-->
        
        <div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Main Navigation</li>
                <li><a href="dashboard.jsp"><span class="icon-align-justify"></span> Dashboard</a></li>
                <li><a href="summery.jsp"><span class="icon-picture"></span> Summary</a></li>
                <li><a href="quickview.jsp"><span class="icon-th-list"></span> Quick View</a></li>                
                <li><a href="livetracking.jsp"><span class="icon-pencil"></span> Live Tracking by Vehicle </a></li>
                <li><a href="allvehicle_tracking.jsp"><span class="icon-font"></span> All Vehicle Live Tracking</a></li>
                <li class="dropdown"><a href="#"><span class="icon-signal"></span> Reports</a>
                	<ul>
                    	<li><a href="generalreports.jsp"><span class="icon-pencil"></span>General Reports</a></li>
                        <li><a href="userdefined.jsp"><span class="icon-pencil"></span>User Defined</a></li>
                    </ul>
                	
                </li>
                <li class="active dropdown"><a href="#"><span class="icon-briefcase"></span>Management</a>
                	<ul>
                    	<li><a href="user_account.jsp"><span class="icon-th-list"></span>User Account</a></li>
                        <li><a href="driver_information.jsp"><span class="icon-th-list"></span>Driver Information</a></li>
                        <li><a href="customer_information.jsp"><span class="icon-th-list"></span>Customer Information</a></li>
                        <li><a href="vehicle_register.jsp"><span class="icon-th-list"></span>Vehicle Information</a></li>
                        <li><a href="trip_sheet.jsp"><span class="icon-th-list"></span>Trip Sheet</a></li>
                        <li><a href="tcss_information.jsp"><span class="icon-th-list"></span>TCSS Information</a></li>
                         <li><a href="sblt_tripsheet.jsp"><span class="icon-th-list"></span>SBLT Trip Sheet</a></li>
                    </ul>
                </li>
                
            </ul>
        </div><!--leftmenu-->
        
        
       
        
    </div><!--mainleft-->
    <!-- END OF LEFT PANEL -->
    
    <!-- START OF RIGHT PANEL -->
    <div class="rightpanel">
    	<div class="headerpanel">
        	<a href="" class="showmenu"></a>
            
            <div class="headerright">
            	<div class="dropdown notification">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="/page.jsp">
                    	<span class="iconsweets-globe iconsweets-white"></span>
                    </a>
                    <ul class="dropdown-menu">
                    	<li class="nav-header">Notifications</li>
                        <li>
                        	<a href="">
                        	<strong>3 people viewed your profile</strong><br />
                            <img src="img/thumbs/thumb1.png" alt="" />
                            <img src="img/thumbs/thumb2.png" alt="" />
                            <img src="img/thumbs/thumb3.png" alt="" />
                            </a>
                        </li>
                        <li><a href=""><span class="icon-envelope"></span> New message from <strong>Saamy GM</strong> <small class="muted"> - 19 hours ago</small></a></li>
                        <li><a href=""><span class="icon-envelope"></span> New message from <strong>VJ Vasu</strong> <small class="muted"> - 2 days ago</small></a></li>
                        <li><a href=""><span class="icon-user"></span> <strong>Thiru</strong> is now following you <small class="muted"> - 2 days ago</small></a></li>
                        <li class="viewmore"><a href="">View More Notifications</a></li>
                    </ul>
                </div><!--dropdown-->
                
    			<div class="dropdown userinfo">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="/page.jsp">Hi, Saamy GM! <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="editprofile.jsp"><span class="icon-edit"></span> Edit Profile</a></li>
                        <li class="divider"></li>
                        <li><a href=""><span class="icon-wrench"></span> Account Settings</a></li>
                        <li><a href=""><span class="icon-eye-open"></span> Privacy Settings</a></li>
                        <li class="divider"></li>
                        <li><a href="index.jsp"><span class="icon-off"></span> Sign Out</a></li>
                    </ul>
                </div><!--dropdown-->
    		
            </div><!--headerright-->
            
    	</div><!--headerpanel-->
        <div class="breadcrumbwidget">
        	<ul class="breadcrumb">
                <li><a href="dashboard.jsp">Home</a> <span class="divider">/</span></li>
                <li><a href="#">Management</a> <span class="divider">/</span></li>
                <li class="active">Driver Information</li>
            </ul>
        </div><!--breadcrumbs-->
        <div class="pagetitle">
        	<h1>Driver Information</h1> <span>This is the new user creation page</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner">
            	<h4 class="widgettitle nomargin shadowed">Register Driver Information</h4>
                <div class="widgetcontent bordered shadowed">
                
                	<form name="DriverInfo" class="stdform" method="post">
                         
                          <p>
                        	<label>License Number</label>
                            <span class="field"><input type="text" name="license_number" id="license_number" class="input-xlarge" placeholder="License Number" value="<%=license_number%>" /></span>
                        </p>               	
                        
                        <p>
                        	<label>Full Name</label>
                            <span class="field"><input type="text" name="fullname" id="fullname" value="<%=driver_name%>" class="input-xlarge" placeholder="Full Name"/></span>
                        </p>
                        
                        
                          <p>
                        	<label>Gender</label>
                            <span class="formwrapper">
                            <%
							String maleradio ="";
							String femaleradio ="";
							
							if(gender.equalsIgnoreCase("male"))
									{
										maleradio="checked";
										femaleradio="";
		
								} else if(gender.equalsIgnoreCase("female")){
								femaleradio="checked";
								maleradio="";
								} %>
                                  <label><input name="gender" type="radio" value="male"  id="male" value="male" <%=maleradio %>/>Male</label>&nbsp;
                           		  <label><input name="gender" type="radio" value="female" id="female" value="female" <%=femaleradio %>/>Female</label>
                           		

                           </span>      
                          
                        </p>  
                        <p>
                        	<label>Contact Number</label>
                            <span class="field"><input type="text" name="contact number" id="contact number" value="<%=contact_no%>" placeholder="Contact Number" class="input-xlarge"  /></span>
                        </p>
                        
                         <p>
                        	<label>Address</label>
                            <span class="field"><input type="text" name="address" id="address" value="<%=address%>" placeholder="Address" class="span3"></textarea></span> 
                        </p>
                        
                        <p>
                        	<label>Date Of Birth</label>
                            <input id="datepicker" type="text" name="date" id="date" value="<%=date_of_birth%>" placeholder="Date Of Birth" class="input-small" /> &nbsp; <small><em>mm / dd / yyyy</em></small>
                            <div class="widgetsource">
                            	<div class="divider15"></div>
                            	<pre class="prettyprint linenums">&lt;input id=&quot;datepicker&quot; type=&quot;text&quot; name=&quot;date&quot; /&gt;</pre>
                              <div class="divider15"></div>
                                <pre class="prettyprint linenums">jQuery( &quot;#datepicker&quot; ).datepicker();</pre>
                            </div><!--widgetsource-->
                            
                        </p>
                        
                         <p>
                        	<label>Date Of Joining</label>
                           <input id="datepicker1" type="text" name="dateofjoin" id="dateofjoin" value="<%=date_of_joining%>" placeholder="Date Of Joining" class="input-small" /> &nbsp; <small><em>mm / dd / yyyy</em></small>
                            <div class="widgetsource">
                            	<div class="divider15"></div>
                            	<pre class="prettyprint linenums">&lt;input id=&quot;datepicker&quot; type=&quot;text&quot; name=&quot;date&quot; /&gt;</pre>
                              <div class="divider15"></div>
                                <pre class="prettyprint linenums">jQuery( &quot;#datepicker&quot; ).datepicker();</pre>
                            </div><!--widgetsource-->                           
                        </p>
                        
                        
                        
                         <p>
                        	<label>Date Of Issue</label>
                             <input id="datepicker2" type="text" name="dateofissue" value="<%=date_of_issue%>" placeholder="Date Of Issue" class="input-small" /> &nbsp; <small><em>mm / dd / yyyy</em></small>
                            <div class="widgetsource">
                            	<div class="divider15"></div>
                            	<pre class="prettyprint linenums">&lt;input id=&quot;datepicker&quot; type=&quot;text&quot; name=&quot;date&quot; /&gt;</pre>
                              <div class="divider15"></div>
                                <pre class="prettyprint linenums">jQuery( &quot;#datepicker&quot; ).datepicker();</pre>
                            </div><!--widgetsource--> 
                        </p>
                        
                        <p>
                        	<label>Date Of Expiry</label>
                             <input id="datepicker3" type="text" name="dateofexp" id="dateofexp" value="<%=date_of_expiry%>" placeholder="Date Of Expiry" class="input-small" /> &nbsp; <small><em>mm / dd / yyyy</em></small>
                            <div class="widgetsource">
                            	<div class="divider15"></div>
                            	<pre class="prettyprint linenums">&lt;input id=&quot;datepicker&quot; type=&quot;text&quot; name=&quot;date&quot; /&gt;</pre>
                              <div class="divider15"></div>
                                <pre class="prettyprint linenums">jQuery( &quot;#datepicker&quot; ).datepicker();</pre>
                            </div><!--widgetsource-->
                        </p>
                        
                        <p>
                        	<label>Vehicle Number</label>
                            <span class="field">
                            <select name="vehicleno" class="uniformselect" >
                            	<option><%=vehicle_number%></option>
                                <option>TN 76 U 3083</option>
                                <option>TN 76 Z 3545</option>
                            </select>                            
                            </span>
                        </p>
                        
                        <p>
                        	<label>Shift Number</label>
                            <span class="field">
                            <select name="shift" class="uniformselect">
                            	<option><%=shift_number%></option>
                                <option>First Shift</option>
                                <option>Second Shift </option>
                                <option>Night Shift </option>
                            </select>                            
                            </span>
                        </p>
                        
                         <p>
                        	<label>Route Number</label>
                            <span class="field"><input type="text" name="routenumber" id="routenumber" value="<%=route_number%>" class="input-xlarge" placeholder="Route Number" /></span>
                        </p>
                       
                                                
                        <p class="stdformbutton">
                            <button class="btn btn-success" onclick="update()">Update</button>
                              <button class="btn btn-success" onclick="del()">Delete</button>
                           
                        </p>
                                                
                    </form>  
                </div><!--widgetcontent-->                
               
               
            </div><!--contentinner-->
        </div><!--maincontent-->
        
    </div><!--mainright-->
    <!-- END OF RIGHT PANEL -->
    
    <div class="clearfix"></div>
    
   <div class="footer">
    	<div class="footerleft">Auto Track</div>
    	<div class="footerright">&copy; 2014,&nbsp;<a href="www.sudantechservices.com">Sudan Tech Services</a> </div>
    </div><!--footer-->

    
</div><!--mainwrapper-->
<%=message %>
</body>
</html>