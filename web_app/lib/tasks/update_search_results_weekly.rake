namespace :schedule do
  desc "update search results weekly"
  task update_search_results_weekly: :environment do
    # get all user
    all_users = User.all
    all_users.each do |user|
      # get all project from each user
      user.projects.each do |user_project|
        # get all search items from each project user
        user_project.search_items.each do |project_search_item|
          # # getting data from cache
          caches_search = CACHESEARCH.get("search_"+project_search_item.id.to_s)
          if caches_search.blank?
            user_token = user.token
            topic      = project_search_item.topic
            language   = project_search_item.language
            project_search_item.update(date_request_cache: Time.now)
            client_initialize = Github::Watcher::Client.new(user_token)
            new_search = client_initialize.search(topic, language)

            # storing data to cache and set time out to delete data in one day
            CACHESEARCH.set("search_"+project_search_item.id.to_s, new_search, 1.day)
            caches_search = CACHESEARCH.get("search_"+project_search_item.id.to_s)
          else
            caches_search
          end
        end
      end
    end
  end
end