
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
*/

  // boiler plate for detecting user event
  $('body').click(function(e) {
    var touched = $(e.target).data("id");
    alert("you just clicked " + touched + ".");
  });

