module ApplicationHelper

  # to show flash alert
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

  # compare cache data with saved result
  def is_selected?(repo)
    saved_result_data = SavedResult.find_by(repo_id: repo[:id])
    return !saved_result_data.blank?
  end

  # check cache data include in deleted result or not
  def is_deleted?(repo)
    deleted_result_data = DeletedResult.find_by(repo_id: repo[:id])
    return !deleted_result_data.blank?
  end

  # get search items name
  def search_item_topic(search_item)
    search_item_topic = begin
      SearchItem.find(search_item).topic
    rescue
      ""
    end
  end

  # #show readme
  # def show_readme(cache)
  #   begin
  #     repo_url    = cache[:url] || cache[:repo_url]
  #     url_readme = '#'
  #     unless repo_url.blank?
  #       #request to repo for get readme link/url
  #       get_readme  =  Octokit.readme(repo_url.split('https://github.com/').last)
  #       url_readme = get_readme[:html_url]
  #     end

  #     return url_readme
  #   rescue Exception => e
  #     flash[:error] = 'Rate limit/to many request. Please wait.'
  #   end
  # end
end
