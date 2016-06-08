module ApplicationHelper

  def load_flash_message
    str = ""
    flash.each do |name, msg|
      if msg.present?
        str = "<div id='flash-alert'>
                  <p align='center' class=\"alert #{name.to_s == 'notice' ? 'alert-success' : 'alert-error'}\">#{msg}</p>
               </div>"
      end
    end
    raw str
  end

end
