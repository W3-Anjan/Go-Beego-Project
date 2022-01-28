<!DOCTYPE html>

<html>
<head>
  <title>Beego</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

  <link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
  />
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
  />
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
    crossorigin="anonymous"
  />

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

    #pagination a, #pagination i {
        display: inline-block;
        vertical-align: middle;
        width: 30px;
        color: black;
        text-align: center;
        font-size: 18px;
        padding: 5px 0 5px 0;
        font-weight: bolder;
    }

    #pagination a {
        margin: 0 2px 0 2px;
        border-radius: 4px;
        border: 1px solid #E3E3E3;
        cursor: pointer;
        box-shadow: inset 0 1px 0 0 #FFF, 0 1px 2px #666;
        text-shadow: 0 1px 1px #FFF;
        background-color: #E6E6E6;
    }
    #pagination i {
        margin: 0 3px 0 3px;
    }
    #pagination a.current {
        border: 1px solid #E9E9E9;
        box-shadow: 0 1px 1px #999;
        background-color: #740a0a;
        color: white;
        text-decoration: none;
    }

  </style>
</head>

<body>

  <div class="container-fluid">
    <div class="container" style="margin-top: 20px; margin-bottom: 30px; box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px; border-radius: 10px;">
      <div class="row bg-danger p-1" style="border-top-right-radius: 10px; border-top-left-radius: 10px">
        <div class="col-lg-12 d-flex align-items-center justify-content-center">
          <h2 style="color: white; font-weight: bolder;">Cat Images</h2>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-4 mt-4">
          <form>
            <label>Order</label>
            <select class="form-select" aria-label="Default select example" name="order" id="order">
              <option value="">Random</option>
              <option value="asc">Ascending</option>
              <option value="desc">Descending</option>
            </select>
            
          </form>
        </div>
        <div class="col-lg-4 mt-4">
          <form>
            <label>Type</label>
            <select class="form-select" aria-label="Default select example" name="mime_types" id="mime_types">
              <option value="gif,jpg,png">All</option>
              <option value="jpg,png">Static</option>
              <option value="gif">Animated</option>
            </select>
          </form>
        </div>

        <div class="col-lg-4 mt-4">
          <form>
            <label>Category</label>
            <select class="form-select" aria-label="Default select example" name="category" id="category">
              <option value="">None</option>
              {{range $i,$val := .category}}
              <option value="{{$val.Id}}">{{$val.Name}}</option>
              {{end}}
            </select>
          </form>
        </div>
        
      </div>
      <div class="row">
        
        <div class="col-lg-4 mt-4">
          <form>
            <label>Breed</label>
            <select class="form-select" aria-label="Default select example" name="breed" id="breed">
              <option value="">None</option>
              {{range $i,$val := .breeddata}}
              <option value="{{$val.Id}}">{{$val.Name}}</option>
              {{end}}
            </select>
          
          </form>
        </div>

        <div class="col-lg-4 mt-4">
          <form>
            <label>Per Page</label>
            <select class="form-select" aria-label="Default select example" id="limit" name="limit">
              <option value="9">9</option>
              <option value="18">18</option>
              <option value="80">80</option>
            </select>
          </form>
        </div>
        <div class="col-lg-4 mt-4">
          <br/>
          <button id="moreButton" value="0" type="button" class="btn btn-danger" style="width: 100%;"><i class="bi bi-arrow-clockwise" style="color: white;"></i>  More</button>
        </div>
        
      </div>
      <div class="row mt-4 mb-2 text-center" id="pagination" style="display: none;">
        
      </div>
      <br/>
      <div class="row" id="loading">
        <div class="col-md-12 mb-2 text-center">
          <h1>Loading...</h1>
        </div>
      </div>
      <div class="row" id="result">

        {{range $i,$val := .catdata}}
        <div class="col-lg-4 mb-2">
          <img class="img-fluid" style="height: 300px; width: 100%; object-fit: cover;" src="{{$val.Url}}"/>
        </div>
        {{end}}
      </div>
      
    </div>

  </div>
  

  <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.3.min.js"></script>


  <script>
    
  </script>
  
  <script src="/static/js/myScript.js" type="text/javascript">
      
  </script>

  <!-- <script src="/static/js/reload.min.js"></script> -->
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
    crossorigin="anonymous"
  ></script>
</body>
</html>
