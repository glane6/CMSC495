<%@page import="JJIGSAWED.User"%>
<%@page import="JJIGSAWED.Task"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="JJIGSAWED.Project"%>
<% int projectID = Integer.parseInt(request.getParameter("ProjectID")); %>
<!--
HTML written by: Dave Thatcher & Jason Willis 
Class: CMSC 495 UMUC
Date: 4/13/2018
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

    
<head>
  <title>Tasks Page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
</head>

<body>
  <!-- <header> -->
  <div class="jumbotron">
    <h1 align='center'>Manage Tasks</h1>
    <div class="alert alert-danger" role="alert" align="center">Something Went Wrong, Please Try Again!</div>
    <nav class="navbar navbar-right">
      <ul class="nav navbar-nav nav-pills nav-fill">
        <li><a href="index.html">Home</a></li>
        <li><a href="Projects.jsp">Projects</a></li>
        <li><a href="UserSetup.jsp">User Setup</a></li>
        <li><a href="#">Sign Out</a></li>
      </ul>
    </nav>
  </div>

  <!-- Could Use Alerts Success/Error after Save | Search:  https://getbootstrap.com/docs/3.3/components/#alerts
<div class="alert alert-success" role="alert">You Successfully Saved Your Information!</div>


  <!-- Input / Search Form -->
  <!-- Top Row -->
  <div class="container" id="projectInput">
    <div class="panel panel-default">
      <!-- Default panel contents -->
      <div class="panel-heading">Project Informaton to Input or Search:</div>
      <!-- <div class="col-xs-12 col-sm-12"> -->

      <!-- Task Name -->
      <!-- <div class="col-sm-3"> -->
      <form class="form-horizontal" action="${pageContext.request.contextPath}/TaskCreate?ProjectID=<%= projectID %>" method="post">
        <div class="form-group.required" style="margin-top: 10px">
          <label class="control-label mt-2 col-sm-2">*Task Name:</label>
          <div class="col-sm-4">
            <input class="form-control" type="text" name="task_name" id="task_name" placeholder="JJIGSAWED">
          </div>
        </div>

      <!-- Priority -->
      <!-- <div class="col-sm-3"> -->
        <div class="form-group.required" style="margin-top: 10px">
          <label class="control-label col-sm-2">*Priority:</label>
          <div class="col-sm-4">
            <select class="form-control" name="task_priority" id="task_priority">
            <option value="3">Low</option>
            <option value="2">Medium</option>
            <option value="1">High</option>
          </select>
          </div>
        </div>

      <!-- User Assignment -->
      <!-- <div class="col-sm-3"> -->
        <div class="form-group.required" style="margin-top: 10px">
          <label class="control-label col-sm-2">*User Assignment:</label>
          <div class="col-sm-4">
            <select class="form-control" name="user_assignment" id="user_assignment">
            <%
                        ArrayList<Integer> userList = User.getUserIDs();


                        for (int i = 0; i < userList.size(); i++) 
                        {
                            ResultSet rs = User.getUser(userList.get(i));

                            // convert resultset to array
                        while (rs.next()) 
                        {
                %>
                <option value="<%= rs.getString("UserID") %>"><%= rs.getString("Name") %></option>
                <%
                        }
                }
                %>
          </select>
          </div>
        </div>

      <!-- Start Date -->
      <!-- <div class="col-sm-3"> -->
        <div class="form-group.required" style="margin-top: 60px">
          <label class="control-label col-sm-2">*Start Date:</label>
          <div class="col-sm-4">
            <input class="form-control" type="date" name="date_created" id="date_created">
          </div>
        </div>

      <!-- Due Date -->
      <!-- <div class="col-sm-3"> -->
        <div class="form-group.required" style="margin-top: 60px">
          <label class="control-label col-sm-2">*Due Date:</label>
          <div class="col-sm-4">
            <input class="form-control" type="date" name="date_ended" id="date_ended">
          </div>
        </div>
          
      <!-- Search | Save buttons -->
        <div class="form-group.required" style="margin-top: 110px">
          <label class="control-label col-sm-2">*Search | Save:</label>
          <div class="col-sm-4">
            <button type="button" class="btn btn-info" onclick="getValue()">Search</button>
            <button type="submit" class="btn btn-success">Save</button>
          </div>
        </div>

      <!-- Task Summary -->
        <div class="form-group">
          <div class="form-group.required" style="margin-top: 50px; margin-left:10px">
            <label class="control-label col-sm-2">*Task Summary:</label>
            <div class="col-sm-4">
              <textarea class="form-control" name="task_summary" id="task_summary" rows="5" placeholder="Describe your task here..."></textarea>
            </div>
          </div>
        </div>

      <!-- Whole Form -->
      </form>
    </div>
  </div>
  <!-- </div> -->
  <!-- Container Div -->


  <br />
  <br />

  <div class="container">
    <table class="table table-hover table-responsive-md table-fixed">
                <tr>
                  <th>Name</th>
                  <th>Summary</th>
                  <th>Priority</th>
                  <th>Assigned User</th>
                  <th>Project ID</th>
                  <th>Edit</th>
                  <th>Remove</th>
                </tr>
                <%

                   ArrayList<Integer> list = Task.getTaskIDs(projectID);

                   for (int i = 0; i < list.size(); i++) 
                   {
                       ResultSet rs = Task.loadTasks(list.get(i)); // null

                       // convert resultset to array
                       while (rs.next()) 
                       {
                %>
                <tr>
                <td><%= rs.getString("TaskName") %></td>
                <td><%= rs.getString("TaskSummary") %></td>
                <td><%= rs.getString("TaskPriority") %></td>
                <td><%= User.getUserName(rs.getInt("FKUserID")) %></td>
                <td><%= projectID %></td>
                <td>
                    <a href="TasksUpdate.jsp?ProjectID=<%= projectID %>&task_name=<%= rs.getString("TaskName") %>&task_priority=<%= rs.getInt("TaskPriority")%>&user_assignment=<%= rs.getInt("FKUserID") %>&date_created=<%= rs.getString("TaskDateCreated")%>&date_ended=<%= rs.getString("TaskDateEnded")%>&task_summary=<%= rs.getString("TaskSummary") %>">
                    <button class="btn btn-success">Edit Task</button>
                    </a>
                </td>
                <td>
                    <a href="TaskRemove?TaskName=<%= rs.getString("TaskName") %>&ProjectID=<%= projectID %>">
                    <button class="btn btn-danger">Remove Task</button>
                    </a>
                </td>
                </tr>
                <%

                       }
                   }

                %>
        </table>
  </div>

  <!-- Pagination -->
    <ul class="pagination">
      <li>
        <a href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
      </li>
      <li><a href="#">1</a></li>
      <li><a href="#">2</a></li>
      <li><a href="#">3</a></li>
      <li><a href="#">4</a></li>
      <li><a href="#">5</a></li>
      <li>
        <a href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
      </li>
    </ul>


  <!-- Footer -->
  <div class="footer navbar-fixed-bottom well">
    <p class="text-center text-muted">JJIGSAWED Software Company, Copyright 2018.</p>
  </div>

  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
      function getValue(){
      //alert($("#projectName").val());
      var val = $("#task_name").val();
      val = "TaskSearch.jsp?TaskName=" + val;
      //alert("ProjectSearch?ProjectName=" + val);
      var url = val;
      $(location).attr('href',url);
      
  }
  </script>
</body>

</html>