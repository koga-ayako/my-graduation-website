namespace :shops do
  desc "Update photo_url for all shops"
  task update_all_photo_urls: :environment do
    require 'net/http'
    require 'json'
    
    api_key = ENV['PLACES_API_KEY']
    
    shops = Shop.all
    
    puts "📊 Found #{shops.count} shops"
    
    shops.find_each do |shop|
      begin
        place_details = fetch_place_details(shop.place_id, api_key)
        
        photo_url = photo_url_from(place_details, api_key)
        
        if photo_url.present?
          shop.update!(photo_url: photo_url)
          puts "✅ Updated photo_url for #{shop.name}"
        else
          puts "⚠️  No photo available for #{shop.name}"
        end
        
        sleep(0.5)
        
      rescue => e
        puts "❌ Failed to update #{shop.name}: #{e.message}"
      end
    end
    
    puts "🎉 Finished updating photo_urls for all shops"
  end
  
  private
  
  def fetch_place_details(place_id, api_key)
    url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&fields=photos&key=#{api_key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    
    if result["status"] != "OK"
      raise "API Error: #{result['status']}"
    end
    
    result["result"]
  end
  
  def photo_url_from(place, api_key)
    return nil unless place && place["photos"]&.any?
    
    photo_reference = place["photos"].first["photo_reference"]
    "https://maps.googleapis.com/maps/api/place/photo?maxheight=600&photoreference=#{photo_reference}&key=#{api_key}"
  end
end