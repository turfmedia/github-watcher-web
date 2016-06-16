require 'dalli'
require 'open-uri'

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
    client.get(key.to_s)
  end

  def self.set(key, data, ttl)
    client.set(key.to_s, data, ttl)
  end

  def self.readme(repo_name)
    result = get(repo_name)
    if result.blank?
      # readme_url = JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/#{repo_name}/readme")))['html_url']
      result = Nokogiri::HTML(open("https://github.com/#{repo_name}")).css('#readme > article').to_html
      set(repo_name, result, 1.day)
    end
    result
  end

  def self.search(token, terms, language = nil)
    key = "#{terms.gsub(' ', '_')}_#{language}"
    result = get(key)
    if result.blank?
      # @search.update(date_request_cache: Time.now)
      client = Github::Watcher::Client.new(token)
      result = client.search(terms, language)

      # storing data to cache and set time out to delete data in one day
      GithubCached.set(key, result, 1.day)
    end
    result
  end
end
