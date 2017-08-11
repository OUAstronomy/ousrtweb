// Docs at http://simpleweatherjs.com
$(document).ready(function() {
    $.simpleWeather({
        woeid: '', //2357536
        location: 'NORMAN, OK',
        unit: 'f',
        success: function(weather) {
            html = '<div><p class="hweather">'+weather.temp+'&deg;'+weather.units.temp+'</p></div>';
            //Don't forget to include the moment.js plugin.
            var timestamp = moment(weather.updated);
            html += '<ul><li>'+weather.city+', '+weather.region+'</li>';
            html += '<li class="currently">'+weather.currently+'</li>';
            html += '<li>'+weather.alt.temp+'&deg;C</li></ul>';
            html += '<ul><li>'+weather.wind.speed+' '+weather.units.speed+' '+weather.wind.direction+'</li></ul>';
            html += '<div><li>Weather updated: '+weather.updated+'</li></div>';

            html += '<div><li>3 Day Forcast</li></div>'
            html += '<div class="ulf"><ul>'
            for(var i=0;i<3;i++) {
                html += '<li>'+weather.forecast[i].day+': '+weather.forecast[i].high+'</li>';
            }
            html += '</ul></div>'
            $("#weather").html(html);
        },
        error: function(error) {
            $("#weather").html('<p>'+error+'</p>');
        }
    });
});
