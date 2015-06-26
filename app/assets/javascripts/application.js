// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require qtip2-jquery-rails
//= require_tree .
// Alert/Confirm/Prompt
function dialogue(content, title) {
    $('<div />').qtip({
        content: {
            text: content,
            title: title
        },
        position: {
            my: 'center', at: 'center',
            target: $(window)
        },
        show: {
            ready: true,
            modal: {
                on: true,
                blur: false
            }
        },
        hide: false,
        style: 'qtip-bootstrap qtip-alert',
        events: {
            render: function(event, api) {
                $('button', api.elements.content).click(function(e) {
                    api.hide(e);
                });
            },
            hide: function(event, api) { api.destroy(); }
        }
    });
}

window.Alert = function(msg,title) {
  var message = $('<p />', { text: msg }),
      ok = $('<button />', { text: 'Ok', 'class': 'btn pull-right' });

    dialogue( message.add(ok), title );
}

window.Prompt = function(msg,title) {
  var message = $('<p />', { text: msg }),
      input = $('<input />', { val: 'Fantastic!' }),
      ok = $('<button />', {
        text: 'Ok'
      }),
      cancel = $('<button />', {
        text: 'Cancel'
      });

    dialogue( message.add(input).add(ok).add(cancel), title );
}

window.Confirm = function(msg,title) {
  var message = $('<p />', { text: msg }),
      ok = $('<button />', {
        text: 'Ok'
      }),
      cancel = $('<button />', {
        text: 'Cancel'
      });

    dialogue( message.add(ok).add(cancel), title );
}
