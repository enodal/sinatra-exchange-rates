
require "sinatra"
require "sinatra/reloader"
require "http"

@exchange_key = ENV.fetch("EXCHANGE")

# define a route
get("/") do
  @exchange_key = ENV.fetch("EXCHANGE")
  # build the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{@exchange_key}"
# use HTTP.get to retrieve the API information
raw_data = HTTP.get(api_url)

# convert the raw request to a string
raw_data_string = raw_data.to_s

# convert the string to JSON
parsed_data = JSON.parse(raw_data_string)
 
@currencies = parsed_data.fetch("currencies")

@currency_keys =@currencies.keys


erb(:homepage)
end


get("/:currency_one") do
  @exchange_key = ENV.fetch("EXCHANGE")
  @api_url = "https://api.exchangerate.host/list?access_key=#{@exchange_key}"
  @raw1_data = HTTP.get(@api_url)
  @raw1_data_string = @raw1_data.to_s
  @parsed1_data = JSON.parse(@raw1_data_string)
  @currencies1_data = @parsed1_data.fetch("currencies")
  @currencies1_keys = @currencies1_data.keys
  @currency1 = params.fetch("currency_one")
  erb(:one_currency)
end

get("/:currency_one/:currency_two") do
  @exchange_key = ENV.fetch("EXCHANGE")
  @api_url = "https://api.exchangerate.host/list?access_key=#{@exchange_key}"
  @raw1_data = HTTP.get(@api_url)
  @raw1_data_string = @raw1_data.to_s
  @parsed1_data = JSON.parse(@raw1_data_string)
  @currencies1_data = @parsed1_data.fetch("currencies")
  @currencies1_keys = @currencies1_data.keys
  @currency1 = params.fetch("currency_one")
  @currency2 = params.fetch("currency_two")
  erb(:two_currency)


  @api2_url="https://api.exchangerate.host/convert?access_key=#{@exchange_key}&from=#{@currency1}&to=#{@currency2}&amount=1"
  @raw1= HTTP.get(@api2_url)
  @raws_string = @raw1.to_s
  @parsed_data = JSON.parse(@raws_string)
  @result = @parsed_data["result"]
  erb(:two_currency)
end
