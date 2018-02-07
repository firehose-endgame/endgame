/*

// create html for the board of 8 x 8 sqaures
  $(function buildTheBoard() {
    var boardRef = $('.board');
    var boardhtmlElement ="";

    for (var row = 8; row >=1; row--) {
      for (var column = 1; column <= 8; column ++) {

        if (row % 2 == 0 && column % 2 == 0 ) { var colour = "black" };
        if (row % 2 == 0 && column % 2 != 0 ) { var colour = "white" };
        if (row % 2 != 0 && column % 2 == 0 ) { var colour = "white" };
        if (row % 2 != 0 && column % 2 != 0 ) { var colour = "black" };

        boardhtmlElement += '<div class="square ' + colour + ' pos' + row + column + '"' + ' data-id="' + row + column + '"></div>';
      };
    };
    boardRef.html(boardhtmlElement);
  });

  

  // boiler plate for detecting user event
  $('body').click(function(e) {
    var touched = $(e.target).data("id");
    alert("you just clicked " + touched + ".");

    });


    // get the piece that has that x and y co-ordinate which matches
    // how to search database from javascript!!!


    // if none > show no piece here
    // if piece matches > show piece selected
    // when user clicks on destination > show piece from before now at that square
    // and run piece update refresh the show screen.
  */


  $( function() {

    $( ".piece" ).draggable({
       drag: function(event, ui){
       pieceToMove = $(event.target).data("piece"); 
      }
    }).css({'cursor': 'move', containment: 'parent', 'z-index': '5'})

    $( ".square" ).droppable({
      drop: function(event, ui) {

        var targetSquare = $(event.target).data("id");
        var targetX = parseInt(targetSquare.toString().charAt(1));
        var targetY = parseInt(targetSquare.toString().charAt(0));

        // return true/false on validity of move here...

        $.post("/pieces/" + pieceToMove, {
          _method: "PUT",
          piece: {
            x_coordinate: targetX, y_coordinate: targetY
          }
        }).fail(function(response) {
            alert('Error: ' + response.responseText);
        });
      }
    })

  });






