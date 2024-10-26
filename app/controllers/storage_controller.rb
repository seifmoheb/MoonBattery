class StorageController < ApplicationController
    protect_from_forgery with: :null_session
    def new
        @storage = Storage.new
        @previousValue = Storage.last

    end
    
    def create
        macaddress_received = params[:macaddress]
        if Storage.last.nil?
            previousValue = 1111101000
        else
            previousValue = Storage.last.serialnumber 
        end
        @serialnumber = previousValue + 1
        @Time = Time.now
        
        @storage = Storage.new(serialnumber: @serialnumber, lastcontact: @Time,macaddress: macaddress_received)
        if @storage.save
            redirect_to '/storage/new'
        else
            render :new
        end
    end
    def ping 

        data = Storage.find_by(macaddress: 'abcde123456')
        data.update(lastcontact:Time.current) if data
    end

    private
    def info_params
    end
end
