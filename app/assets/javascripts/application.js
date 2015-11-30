// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require materialize-sprockets 


$(document).ready(function() {
    $('select').material_select();

    $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15, // Creates a dropdown of 15 years to control year
    format: 'yyyy-mm-dd' 
  });

    var source = [
    {
        "iata": "BOM",
        "name": "Mumbai Airport",
    },
    {
        "iata": "FIV",
        "name": "Five Finger CG Heliport",
    },
    {
        "iata": "FOK",
        "name": "False Island Seaplane Base",
    },
    {
        "iata": "DEL",
        "name": "New Delhi",
    }
	    
	    	        

];

    $( "#autocomplete" ).autocomplete({
    source: function(request, response){
        var searchTerm = request.term.toLowerCase();
        var ret = [];
        $.each(source, function(i, airportItem){
            if (airportItem.iata.toLowerCase().indexOf(searchTerm) !== -1 || airportItem.name.toLowerCase().indexOf(searchTerm) === 0)
                ret.push(airportItem.iata + ' - ' + airportItem.name);
        });
       
        response(ret);
    }
});
    $( "#autocomplete1" ).autocomplete({
    source: function(request, response){
        var searchTerm = request.term.toLowerCase();
        var ret = [];
        $.each(source, function(i, airportItem){
            if (airportItem.iata.toLowerCase().indexOf(searchTerm) !== -1 || airportItem.name.toLowerCase().indexOf(searchTerm) === 0)
                ret.push(airportItem.iata + ' - ' + airportItem.name);
        });
       
        response(ret);
    }
});

  });


     