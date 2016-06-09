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
  def compare_data(caches_search)
    saved_result_data = SavedResult.find_by(repo_id: caches_search[:id])
    return saved_result_data.blank?
  end

  # check cache data include in deleted result or not
  def include_in_deleted_result?(caches_search)
    deleted_result_data = DeletedResult.find_by(repo_id: caches_search[:id])
    return deleted_result_data.blank?
  end

  # get search items name
  def search_item_topic(search_item)
    search_item_topic = begin 
      SearchItem.find(search_item).topic
    rescue
      ""
    end
  end
end
