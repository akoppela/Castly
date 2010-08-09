var SubmitLink = new Class({
  initialize: function(el){
    el.addEvent("click", function(e){
      var form = el.getParent("form");
      if (form){
        e.stop();
        form.submit();
      }
    });
  }
});
window.addEvent('domready', function() {
   $$(".submit").each(function(el){
     new SubmitLink(el);
   });
});
