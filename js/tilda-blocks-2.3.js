 
function t544_setHeight(recid) {
  var el=$('#rec'+recid);
  var sizer = el.find('.t544__sizer');
  var height = sizer.height();
  var width = sizer.width();
  var ratio = width/height;
  var imgwrapper = el.find(".t544__blockimg, .t544__textwrapper");
  var imgwidth = imgwrapper.width();
  if (height != $(window).height()) {
    imgwrapper.css({'height':((imgwidth/ratio)+'px')});
  }
}