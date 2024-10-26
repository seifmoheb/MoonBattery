class StorageController < ApplicationController
    def new
        @storage = Storage.new
        @previousValue = Storage.last

    end
    
    def create
        if Storage.last.nil?
            previousValue = 1111101000
        else
            previousValue = Storage.last.serialnumber 
        end
        @serialnumber = previousValue + 1
        @Time = Time.now
        
        @storage = Storage.new(info_params.merge(serialnumber: @serialnumber, lastcontact: @Time))
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
        params.require(:storage).permit(:macaddress)
    end
end
