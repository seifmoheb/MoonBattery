class StorageController < ApplicationController
    protect_from_forgery with: :null_session
    def new
        @storage = Storage.new
        @previousValue = Storage.last

    end
    
    def register
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
            redirect_to '/storage/new', status: :ok
        end
    end
    def ping 
        macaddress_received = params[:macaddress]
        data = Storage.find_by(macaddress: macaddress_received)
        if data
            if data.update(lastcontact:Time.now)
                redirect_to '/home/index', status: :ok
            end
        end
    end

    private
    def info_params
    end
end
