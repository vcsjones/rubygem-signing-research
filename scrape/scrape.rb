#!/usr/bin/env ruby

require 'nokogiri'
require 'net/https'

GEM_COUNT = 10_000

get_request = Net::HTTP.new('rubygems.org', 443)
get_request.use_ssl = true
uri = URI('https://rubygems.org/stats')

File.open 'gems.csv', 'w' do |file|
    file.puts 'Gem Name,Download Count'
    (1..GEM_COUNT/10).each do |page|
        puts "Fetching page #{page}"
        params = { :page => page }
        uri.query = URI.encode_www_form(params)
        
        response = get_request.get uri
        raise 'Invalid HTTP response' unless response.kind_of?(Net::HTTPOK)

        doc = Nokogiri::HTML(response.body)
        gem_elements = doc.xpath '//div[@class="stats__graph__gem"]'
        gem_elements.each do |gem_element|
            gem_name = gem_element.xpath 'h3/a/text()'
            gem_count = gem_element.xpath('div/div/span[@class="stats__graph__gem__count"]/text()').to_s.gsub(/\D+/, '').to_i
            file.puts "\"#{gem_name}\",#{gem_count}"
        end
    end
end