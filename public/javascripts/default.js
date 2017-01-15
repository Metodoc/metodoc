$(function() {
   $( "#tabs" ).tabs({
      collapsible: true
   });
});
$(function() { 

   $("[id^=calendario]").datepicker({ 
	showOn: "button",
        buttonImageOnly: true,
        dateFormat: 'dd-mm-yy',
        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
        dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
        onSelect: function (date) {
           $('[id*=deadline]').attr('value', date);
           }
   });


});

function mostraEsconde(id){
   $("#"+id).animate({bottom:200, opacity:"toggle"}, 200);
}



function mostraEscondeTime(id){
   $("#"+id).animate({bottom:200, opacity:"toggle"}, 1500);
   $("#"+id).delay(2000).animate({bottom:200, opacity:"toggle"}, 1500);
}

function openWindow(id, titulo, tituloId){


 	$('.modal-titulo').text(titulo);
        $('.modal-titulo').attr('id', tituloId);

        var alturaTela = $(document).height();
        var larguraTela = $(window).width();
     
        //colocando o fundo preto
        $('#mascara').css({'width':larguraTela,'height':alturaTela});
        $('#mascara').fadeIn(1000);
        $('#mascara').fadeTo("slow",0.7);
 
        //var left = ($(window).width() /2) - ( ($(id).width() / 2) + 200);
        //var top = ($(window).height() / 2) - ( ($(id).height() / 2) + 50);
	var top = "-70px";
        var left = "270px";
        $(id).css({'top':top,'left':left});
        $(id).show();
        window.location.hash = id;  

}


$("a[rel=modal]").click( function(ev){
        ev.preventDefault();

	var titulo = $(this).attr("titulo");
	var tituloId = $(this).attr("id");
        var id = $(this).attr("href");

 	openWindow(id, titulo, tituloId);
        
});


$('.fecharWindow').click(function(ev){
   ev.preventDefault();
   $("#mascara").hide();
   $(".window").hide();

});

//ação para paginas com abas superiores
$(".page-inter li a").click( function (ev){

  id = this.getAttribute("href");

  $('[class^=stage]').hide(); // hides
 
  $(id).show();
  $(id).focus();

  $('#abas-nav li a').removeClass('page-current');
  $(this).addClass('page-current');
});

//
var aditionUrl = " " ;

$('.window form').submit(function(ev){

   //var page = $(".window:visible .stage:visible").attr("id");   
   //var action = $(this).attr('action');
   //var newAction = "";

   //if (aditionUrl === " "){
   //   newAction = action + '?pag='+ page;
   //}else{
    //  newAction = action + '?pag='+ page + aditionUrl;
   //}

   //$(this).attr('action', newAction);
   
});


$("[id^=bted] , [id^=btad]").click( function (ev){
  
      var str = $(this).attr("id");
      var init = str.indexOf('-');
      var id = str.substring(init+1,str.lenght);

      var isVisible = $("#text-"+id).is(':visible');

      if(isVisible){

        valor = $("#text-"+id).val();
        action = $(this).closest("form").attr('action');
        init1 = action.lastIndexOf('/'); 
        fim1 = action.indexOf('?');
        init2 = action.indexOf('=');
        methodology_id= action.substring(init1+1,fim1);
        etapa_id= action.substring(init2+1,action.lenght);

        newAction = "/methodologies/crudDoc/"+methodology_id+"?etapa_id="+etapa_id+"&doc_type_id="+id+"&nameDT="+valor;
        
        $(this).closest("form").attr('action', newAction);
        $(this).closest("form").submit();

      }else{
         $("#text-"+id).animate({left:200, opacity:"toggle"}, 1500);
         $("#lable-"+id).hide();
      }   
});

$( "[id^=text-]" ).keypress(function( event ) {
   if ( event.which == 13 ) {

        str = $(this).attr("id");
	init = str.indexOf('-');
        id = str.substring(init+1,str.lenght);

        valor = $("#text-"+id).val();
        action = $(this).closest("form").attr('action');
init1 = action.lastIndexOf('/'); 
fim1 = action.indexOf('?');
init2 = action.indexOf('=');
        methodology_id= action.substring(init1+1,fim1);
        etapa_id= action.substring(init2+1,action.lenght);

        newAction = "/methodologies/crudDoc/"+methodology_id+"?etapa_id="+etapa_id+"&doc_type_id="+id+"&nameDT="+valor;
        
        $(this).closest("form").attr('action', newAction);
        $(this).closest("form").submit();

   }
});




