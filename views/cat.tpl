<!DOCTYPE html>

<html>
<head>
  <title>Beego</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

  <style type="text/css">
    *,body {
      margin: 0px;
      padding: 0px;
    }

    body {
      margin: 0px;
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
      font-size: 14px;
      line-height: 20px;
      background-color: #fff;
    }

    header,
    footer {
      width: 960px;
      margin-left: auto;
      margin-right: auto;
    }

    .logo {
      background-repeat: no-repeat;
      -webkit-background-size: 100px 100px;
      background-size: 100px 100px;
      background-position: center center;
      text-align: center;
      font-size: 42px;
      padding: 250px 0 70px;
      font-weight: normal;
      text-shadow: 0px 1px 2px #ddd;
    }

    header {
      padding: 100px 0;
    }

    footer {
      line-height: 1.8;
      text-align: center;
      padding: 50px 0;
      color: #999;
    }

    .description {
      text-align: center;
      font-size: 16px;
    }

    a {
      color: #444;
      text-decoration: none;
    }

    .backdrop {
      position: absolute;
      width: 100%;
      height: 100%;
      box-shadow: inset 0px 0px 100px #ddd;
      z-index: -1;
      top: 0px;
      left: 0px;
    }
  </style>
</head>

<body>
  <header>
    <h1 class="logo">Welcome to Beego</h1>
    <div>
      <form>

        <select name="breed" id="breed">
          <option value="tang">Turkish Angora</option>
          <option value="sfol">Scottish Fold</option>
        </select>

        <select name="order" id="order">
          <option value="asc">Ascending</option>
          <option value="desc">Descending</option>
        </select>
      
      </form>

      
    </div>
    <br/>
    <br/>
    <div class="description">

      {{range $i,$val := .catdata}}
        <p>{{$val.Url}}</p>
        <img style="height: 180px; width: 300px" src="{{$val.Url}}"/>
      {{end}}
    </div>
  </header>
  <footer>
  <!--
    <div class="author">
      Official website:
      <a href="http://{{.Website}}">{{.Website}}</a> /
      Contact me:
      <a class="email" href="mailto:{{.Email}}">{{.Email}}</a>
    </div>
  -->
  </footer>
  <div class="backdrop"></div>

  <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
  
  <script type="text/javascript">
      (function() {
          $breed = $("#breed");
          $order = $("#order");
          $breed.on('change', function() {
              $.ajax({
                  type: "GET",
                  url: "/cat",
                  data: {"breed": $breed.val(), "order": $order.val()} // The data passed to / by POST method
                  
              }).done(function(msg) {
                  // Render your result
                  // $("#result").html(msg.Val);
                  // window.location='http://localhost:8080/cat'
              });
          });

          $order.on('change', function() {
              $.ajax({
                  type: "GET",
                  url: "/cat",
                  data: {"breed": $breed.val(), "order": $order.val()} // The data passed to / by POST method
              }).done(function(msg) {
                  // Render your result
                  // $("#result").html(msg.Val);
              });
          });
      })();
  </script>
  <script src="/static/js/reload.min.js"></script>
</body>
</html>
