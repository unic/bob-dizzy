require(["gitbook", "jQuery"], function(gitbook, $) {
    gitbook.events.bind("start", function(e, config) {
        $(".book-header .pull-left").last().before($("<div class='unic-logo'><img src='http://www.unic.com/img/unic-logo.png' /></div>"));

        $(".font-family-list").hide()
    });


});
