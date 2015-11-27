class FlightsController < ApplicationController
  def index
  end
  def search
  	require 'json'
require 'rest_client'
require 'net/http'
  	@origin = params[:from]
  	@dest = params[:to]
  	@dep_date = params[:date]
  	@adult = params[:adults]
  	@child = params[:child]
  	


org=@origin
dest=@dest
date="2016-01-21"
r_date="2016-01-19"
solution=5
adult=1
child=0
senior=0

trip = "one way"

if trip == "one way" then
 req_param = {
  :request => {
    :slice => [
      {
        :origin => org,
        :destination => dest,
        :date => date,
        :prohibitedCarrier => [
          "AI",
         "9W"
       ] 
       # :maxStops => 0
      }
    ],
    	:passengers => {
      :adultCount => adult,
      :infantInLapCount => 0,
      :infantInSeatCount => 0,
      :childCount => child,
      :seniorCount => senior
   	 },
   	 :solutions => solution
 #  	 :refundable => false
  	}
   }.to_json
else
req_param =		{
  :request => {
    :slice => [
      {
        :origin => org,
        :destination => dest,
        :date => date,
        :maxStops => 0
      },
      {
        :origin => dest,
        :destination => org,
        :date => r_date,
        :maxStops => 0
      }
    ],
    :passengers => {
      :adultCount => adult,
      :infantInLapCount => 0,
      :infantInSeatCount => 0,
      :childCount => child,
      :seniorCount => senior
    },
     :solutions => solution
 #   :refundable => false
   }
  }.to_json
end



 
#puts req_param

@price = []
@flight_code = Array.new(100) { Array.new(100) }
@flight_number = Array.new(100) { Array.new(100) }
@cabin= Array.new(100) { Array.new(100) }
@arr_time = Array.new(100) { Array.new(100) }
@dep_time = Array.new(100) { Array.new(100) }


apikey= "AIzaSyB3XKN0B5Ui7QwIB8zlQ0tsFidCtPBpAZg"


@response = RestClient.post "https://www.googleapis.com/qpxExpress/v1/trips/search?key=#{apikey} ",
              req_param,
             :content_type => :json,
              :accept => :json


result = JSON.parse @response
#puts response.code

@segment_size= []
count=0
result["trips"]["tripOption"].each do |sol|

     @segment_size[count] = sol["slice"][0]["segment"].size
	
	count+=1
end



k=0

result["trips"]["tripOption"].each do |sol|

	@price[k] = sol["saleTotal"]	

		 m=0
		 sol["slice"][0]["segment"].each do |seg|

	 			@flight_code[k][m] = sol["slice"][0]["segment"][m]["flight"]["carrier"]
				@flight_number[k][m] = sol["slice"][0]["segment"][m]["flight"]["number"]			
				@cabin[k][m] = sol["slice"][0]["segment"][m]["cabin"]
				@arr_time[k][m] = sol["slice"][0]["segment"][m]["leg"][0]["arrivalTime"]
				@dep_time[k][m] = sol["slice"][0]["segment"][m]["leg"][0]["departureTime"]	
				m+=1		
	 	 end

	k+=1
end

@avail_sol=k
=begin
k=0

@avail_sol.times do 

puts "********************************************************************************************"
			puts " Price => Rs. #{price[k]}"
		 m=0
		 segment_size[k].times do 
					
				puts " Segment #{m+1}                                                                      "
				puts " #{org} to #{dest}                     #{flight_code[k][m]} #{flight_number[k][m]} \n"
				puts " Cabin => #{cabin[k][m]}  "
				puts " Departure time => #{dep_time[k][m]}            Arrival Time => #{arr_time[k][m]}    "	
				m+=1		
	 	 end


puts "********************************************************************************************"
			puts " "

	k+=1
end






puts "Trips/Solutions - #{result["trips"]["tripOption"].size}"
puts "Segments - #{result["trips"]["tripOption"][0]["slice"][0]["segment"].size}"
=end



  end
end