$(document).ready(function(){
  clearRide();
});

function clearRide(){
  $(".active-ride").on('click', '.clear-ride-btn', function(e){
    this.closest(".active-ride").remove()
  })
}
