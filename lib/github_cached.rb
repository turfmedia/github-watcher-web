require 'dalli'

module GithubCached
  def self.client
    @@client ||= if ENV["RAILS_ENV"].eql?("production")
      Dalli::Client.new((ENV["MEMCACHIER_SERVERS"] || "").split(","),
        {
          :username => ENV["MEMCACHIER_USERNAME"],
          :password => ENV["MEMCACHIER_PASSWORD"],
          :failover => true,
          :socket_timeout => 3,
          :expires_in => 1.day,
          :compress => true
        })
    else
        Dalli::Client.new('memcached', { :namespace => 'github_watcher', :expires_in => 1.day, :socket_timeout => 3, :compress => true })
    end
  end

  def self.get(key)
    client.get(key)
  end

  def self.set(key, data, ttl)
    client.set(key, data, ttl)
  end

  def search

      if (@caches_search = get(@search.id.to_s)).blank?
        user_token = current_user.token
        topic      = @search.topic
        language   = @search.language
        @search.update(date_request_cache: Time.now)
        client_initialize = Github::Watcher::Client.new(user_token)
        new_search = client_initialize.search(topic, language)

        # storing data to cache and set time out to delete data in one day
        GithubCached.set("search_"+@search.id.to_s, new_search, 1.day)
        caches_search = GithubCached.get("search_"+@search.id.to_s)
      else
        caches_search
      end
  end
end