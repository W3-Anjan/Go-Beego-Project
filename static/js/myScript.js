// Pagination starts from here

var Pagination = {

    code: '',

    Extend: function(data) {
        data = data || {};
        Pagination.size = data.size || 300;
        Pagination.page = data.page || 1;
        Pagination.step = data.step || 3;
    },

    Add: function(s, f) {
        for (var i = s; i < f; i++) {
            Pagination.code += '<a onclick="paginationClick('+i+')">' + i + '</a>';
        }
    },

    Last: function() {
        Pagination.code += '<i>...</i><a onclick="paginationClick('+Pagination.size+')">' + Pagination.size + '</a>';
    },

    First: function() {
        Pagination.code += '<a onclick="paginationClick(1)">1</a><i>...</i>';
    },

    Click: function() {
        Pagination.page = +this.innerHTML;
        Pagination.Start();
    },

    Prev: function() {
        Pagination.page--;
        if (Pagination.page < 1) {
            Pagination.page = 1;
        }
        Pagination.Start();
    },

    Next: function() {
        Pagination.page++;
        if (Pagination.page > Pagination.size) {
            Pagination.page = Pagination.size;
        }
        Pagination.Start();
    },

    Bind: function() {
        var a = Pagination.e.getElementsByTagName('a');
        for (var i = 0; i < a.length; i++) {
            if (+a[i].innerHTML === Pagination.page) a[i].className = 'current';
            a[i].addEventListener('click', Pagination.Click, false);
        }
    },

    Finish: function() {
        Pagination.e.innerHTML = Pagination.code;
        Pagination.code = '';
        Pagination.Bind();
    },

    Start: function() {
        if (Pagination.size < Pagination.step * 2 + 6) {
            Pagination.Add(1, Pagination.size + 1);
        }
        else if (Pagination.page < Pagination.step * 2 + 1) {
            Pagination.Add(1, Pagination.step * 2 + 4);
            Pagination.Last();
        }
        else if (Pagination.page > Pagination.size - Pagination.step * 2) {
            Pagination.First();
            Pagination.Add(Pagination.size - Pagination.step * 2 - 2, Pagination.size + 1);
        }
        else {
            Pagination.First();
            Pagination.Add(Pagination.page - Pagination.step, Pagination.page + Pagination.step + 1);
            Pagination.Last();
        }
        Pagination.Finish();
    },

    Buttons: function(e) {
        var nav = e.getElementsByTagName('a');
        // nav[0].addEventListener('click', Pagination.Prev, false);
        // nav[1].addEventListener('click', Pagination.Next, false);
    },

    Create: function(e) {

        var html = [
            // '<a>&#9668;</a>', 
            '<span></span>', 
            // '<a>&#9658;</a>'
        ];

        e.innerHTML = html.join('');
        Pagination.e = e.getElementsByTagName('span')[0];
        Pagination.Buttons(e);
      },


      Init: function(e, data) {
          Pagination.Extend(data);
          Pagination.Create(e);
          Pagination.Start();
      }
    };

    var init = function() {
    Pagination.Init(document.getElementById('pagination'), {
        size: 30, 
        page: 1, 
        step: 3  
    });
    };

    document.addEventListener('DOMContentLoaded', init, false);


    function paginationClick(pageNum){
      $page = pageNum-1

      $breed = $("#breed");
      $order = $("#order");
      $category = $("#category");
      $limit = $("#limit");
      $mime_types = $("#mime_types");

      $('#loading').show();
      $('#result').hide();

      $.ajax({
          type: "GET",
          url: "/cat",
          data: {"breed": $breed.val(), "order": $order.val(), "category": $category.val(), "limit": $limit.val(), "mime_types": $mime_types.val(), "page": $page},
          success: function( response ) {
            let data = response;
            console.log(data);

            let html_data = "";

            if(data.length == 0){
              html_data += '<div class="col-md-12 mb-2 text-center">',
              html_data += '<h1>No image found!</h1>',
              html_data += '</div>'

              $("#result").html(html_data);

              $('#loading').hide();
              $('#result').show();

              return;
            }

            $.each(data, function(key, value) {
              html_data += '<div class="col-md-4 mb-2 ">',
              html_data += '<img src="' + value.url + '" class="img-fluid" style="height: 300px; width: 100%; object-fit: cover;"></img>',
              html_data += '</div>'
            })

            $("#result").html(html_data);
            $('#loading').hide();
            $('#result').show();
          },
          error: function( error ) {
            let html_data = "";
            html_data += '<div class="col-md-12 mb-2 text-center">',
            html_data += '<h1>Error occured! Please try again.</h1>',
            html_data += '</div>'

            $("#result").html(html_data);
            $('#loading').hide();
            $('#result').show();
          }

        });
    }

    // Pagination ends

    (function() {
      $breed = $("#breed");
      $order = $("#order");
      $category = $("#category");
      $limit = $("#limit");
      $mime_types = $("#mime_types");

      $(document).on('change', 'select', function() {

            $('#loading').show();
            $('#result').hide();

            if($order.val() === ""){
              $("#pagination").css("display", "none")
              $("#moreButton").css("display", "block")
            }
            else{
              $("#pagination").css("display", "block")
              $("#moreButton").css("display", "none")
            }

            $.ajax({
                type: "GET",
                url: "/cat",
                data: {"breed": $breed.val(), "order": $order.val(), "category": $category.val(), "limit": $limit.val(), "mime_types": $mime_types.val()}
            }).done(function(response) {

                let data = response;
                console.log(data);

                let html_data = "";

                if(data.length == 0){
                  html_data += '<div class="col-md-12 mb-2 text-center">',
                  html_data += '<h1>No image found!</h1>',
                  html_data += '</div>'

                  $("#result").html(html_data);

                  $('#loading').hide();
                  $('#result').show();

                  return;
                }

                $.each(data, function(key, value) {
                  html_data += '<div class="col-md-4 mb-2 ">',
                  html_data += '<img src="' + value.url + '" class="img-fluid" style="height: 300px; width: 100%; object-fit: cover;"></img>',
                  html_data += '</div>'
                })

                $("#result").html(html_data);

                $('#loading').hide();
                $('#result').show();

            }).error(function(err) {
              let html_data = "";
              html_data += '<div class="col-md-12 mb-2 text-center">',
              html_data += '<h1>Error occured! Please try again.</h1>',
              html_data += '</div>'

              $("#result").html(html_data);
              $('#loading').hide();
              $('#result').show();
            });
        });

        $(document).on('click', 'button', function() {

            $page = document.getElementById("moreButton").value = parseInt($('#moreButton').val())+1;

            $('#loading').show();
            $('#result').hide();

            $.ajax({
                type: "GET",
                url: "/cat",
                data: {"breed": $breed.val(), "order": $order.val(), "category": $category.val(), "limit": $limit.val(), "mime_types": $mime_types.val(), "page": $page}
            }).done(function(response) {
                let data = response;
                console.log(data);

                let html_data = "";

                if(data.length == 0){
                  html_data += '<div class="col-md-12 mb-2 text-center">',
                  html_data += '<h1>No image found!</h1>',
                  html_data += '</div>'

                  $("#result").html(html_data);

                  $('#loading').hide();
                  $('#result').show();

                  return;
                }

                $.each(data, function(key, value) {
                  html_data += '<div class="col-md-4 mb-2 ">',
                  html_data += '<img src="' + value.url + '" class="img-fluid" style="height: 300px; width: 100%; object-fit: cover;"></img>',
                  html_data += '</div>'
                })

                $("#result").html(html_data);
                $('#loading').hide();
                $('#result').show();
            }).error(function(err) {
              let html_data = "";
              html_data += '<div class="col-md-12 mb-2 text-center">',
              html_data += '<h1>Error occured! Please try again.</h1>',
              html_data += '</div>'

              $("#result").html(html_data);
              $('#loading').hide();
              $('#result').show();
            });
        });

    })();

    window.onload = function(){ 
      $('#loading').hide();
      $('#result').show();
    }