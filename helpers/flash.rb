class App < Sinatra::Base
  helpers do
    # Custom rendering for Sinatra::Flash
    # TODO: move all this to a partial.
    def render_flash(key=:flash)
      return "" if flash(key).empty?
      id = (key == :flash ? "flash" : "flash_#{key}")
      messages = flash(key).collect { |m|
        "  <div class='msg #{m[0]}'>#{m[1]}</div>\n"
      }
      "<div id='#{id}' class='container'>\n" + messages.join + "</div>"
    end
  end
end