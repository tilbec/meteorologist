require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    address_to_url = @street_address.gsub(" ","+")
    url_root = "http://maps.googleapis.com/maps/api/geocode/json?address="
    url = url_root + address_to_url
    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s

    url_root2 = "https://api.darksky.net/forecast/44c944ecd266c9c1fe29305a8d7fffb1/"
    comma = ","
    url = url_root2 + latitude + comma + longitude
    parsed_data2 = JSON.parse(open(url).read)

    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
