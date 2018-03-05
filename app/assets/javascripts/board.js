$(document).on('turbolinks:load', function() {
  
  $( function() {

    $( ".piece" ).draggable({

       drag: function(event, ui){
       pieceToMove = $(event.target).data("piece"); 
      }
    }).css({'cursor': 'move', containment: 'parent', 'z-index': '5'})

    $( ".square" ).droppable({
      drop: function(event, ui) {
        ui.draggable.position( { of: $(this), my: 'center', at: 'middle' } );
        var targetSquare = $(event.target).data("id");
        var targetX = parseInt(targetSquare.toString().charAt(1));
        var targetY = parseInt(targetSquare.toString().charAt(0));
        $.post("/pieces/" + pieceToMove, {
          _method: "PUT",
          piece: {
            x_coordinate: targetX, y_coordinate: targetY
          }
        }).success(function(data) {
            if (Array.isArray(data)) {
              userSelectsPiece(data, pieceToMove);
            }

        });
      }
    })

  });

  function userSelectsPiece(data, pieceToMove) {

    var queenBtn = document.getElementById('queen');
    var bishopBtn = document.getElementById('bishop');
    var knightBtn = document.getElementById('knight');
    var rookBtn = document.getElementById('rook');

    var modalText = "You may promote your pawn to any of the following pieces, " + data + ".";

    if (data.includes("Queen")) { queenBtn.hidden = false; } else { queenBtn.hidden = true; }
    if (data.includes("Bishop")) { bishopBtn.hidden = false; } else { bishopBtn.hidden = true; }
    if (data.includes("Knight")) { knightBtn.hidden = false; } else { knightBtn.hidden = true; }
    if (data.includes("Rook")) { rookBtn.hidden = false; } else { rookBtn.hidden = true; }
    $(".pieces-available").html(modalText);
    $('#myModal').modal('show'); 

    
    queenBtn.onclick = function(e) {
      applyPromote("Queen",pieceToMove)
    };

    bishopBtn.onclick = function(e) {
      applyPromote("Bishop",pieceToMove)
    };

    knightBtn.onclick = function(e) {
      applyPromote("Knight",pieceToMove)
    };

    rookBtn.onclick = function(e) {
      applyPromote("Rook",pieceToMove)
    };
  }

  function applyPromote(targetPiece, pieceId) {
    $.post('/pieces/promote', {id: pieceId, promotion: targetPiece});
  }


});




