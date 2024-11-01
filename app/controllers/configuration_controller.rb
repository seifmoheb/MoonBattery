class ConfigurationController < ApplicationController
    protect_from_forgery with: :null_session

    def add
        configs = params[:configurations]
        macaddress_received = params[:macaddress]
        configs = configs.split(";", -1)
        configs.each do |item|
            pair = item.split(":", -1)
            key_received = pair[0]
            value_received = pair[1]
            existingConfig = ::Configuration.find_by(macaddress: macaddress_received, configuration: key_received)
            if existingConfig.nil?
                @newConfigRecord = ::Configuration.new(macaddress: macaddress_received, configuration: key_received, value: value_received)
                @newConfigRecord.save
            else
                existingConfig.update(value: value_received)
            end
        end
    end

    def show
        @passed_item_macaddress = params[:macaddress]
        @record = Storage.find(@passed_item_macaddress)
    end
end
