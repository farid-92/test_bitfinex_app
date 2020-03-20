# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: "admin@example.com", password:'password')

Service.create(url: 'https://api-pub.bitfinex.com/v2/candles/', name: 'bitfinex_candles', service_type: 'candle')
Service.create(url: 'https://api-pub.bitfinex.com/v2/ticker/', name: 'bitfinex_ticker', service_type: 'ticker')
Service.create(url: 'https://api-pub.bitfinex.com/v2/tickers/', name: 'bitfinex_tickers', service_type: 'tickers')