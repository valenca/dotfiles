$( "#spotify" ).submit(function( event ) {
    doSearch( $( "#q" ).val() );
    event.preventDefault();
});

function doSearch(e){
    text=e;
    text=jQuery.trim(text);
    e=encodeURIComponent(text).replace(/!/g,'%21').replace(/'/g,'%27').replace(/\(/g,'%28').replace(/\)/g,'%29').replace(/\*/g,'%2A');
    if(!e){
    window.location='https://play.spotify.com';
    return!1
    };
    window.location='https://play.spotify.com/search/'+e+'/';
    return!1
};
