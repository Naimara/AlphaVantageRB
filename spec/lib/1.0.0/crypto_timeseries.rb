require_relative './../../spec_helper'

describe Alphavantage::Crypto_Timeseries do
  context "#new" do
    it "create a new timeseries without stock" do
      stock = Alphavantage::Crypto_Timeseries.new symbol: "BTC", key: @config["key"], verbose: false, market: "DKK", type: "daily"
      expect(stock.class).to eq Alphavantage::Crypto_Timeseries
    end

    it "create a new stock from stock" do
      timeseries = @client.crypto(symbol: "BTC", market: "DKK").timeseries(type: "monthly")
      expect(timeseries.class).to eq Alphavantage::Crypto_Timeseries
    end

    it "own multiple data" do
      timeseries = @client.crypto(symbol: "BTC", market: "DKK").timeseries(type: "monthly")
      bool = []
      bool << timeseries.information.is_a?(String)
      bool << (timeseries.digital_currency_code == "BTC")
      bool << timeseries.digital_currency_name.is_a?(String)
      bool << (timeseries.market_code == "DKK")
      bool << timeseries.market_name.is_a?(String)
      bool << timeseries.last_refreshed.is_a?(String)
      bool << timeseries.time_zone.is_a?(String)
      bool << timeseries.output.is_a?(Hash)
      bool << timeseries.open.is_a?(Array)
      bool << timeseries.high.is_a?(Array)
      bool << timeseries.low.is_a?(Array)
      bool << timeseries.close.is_a?(Array)
      bool << timeseries.volume("asc").is_a?(Array)
      bool << timeseries.open_usd.is_a?(Array)
      bool << timeseries.high_usd.is_a?(Array)
      bool << timeseries.low_usd.is_a?(Array)
      bool << timeseries.close_usd.is_a?(Array)
      bool << timeseries.market_cap_usd.is_a?(Array)
      expect(bool.all?{|e| e}).to eq true
    end

    # it "cannot retrieve with wrong key" do
    #   error = false
    #   begin
    #     stock = Alphavantage::Crypto_Timeseries.new symbol: "BTC", key: "wrong_key", market: "DKK"
    #   rescue Alphavantage::Error => e
    #     error = true
    #   end
    #   expect(error).to eq true
    # end

    it "cannot retrieve with wrong symbol" do
      error = false
      begin
        stock = Alphavantage::Crypto_Timeseries.new symbol: "wrong_symbol", key: @config["key"], market: "DKK", type: "daily"
      rescue Alphavantage::Error => e
        error = true
      end
      expect(error).to eq true
    end
  end
end
