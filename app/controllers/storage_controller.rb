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
        @previousValue = previousValue + 1
        
        @storage = Storage.new(info_params.merge(serialnumber: @previousValue))
        if @storage.save
            redirect_to '/storage/new', notice: 'Storage added successfully'
        else
            render :new
        end
    end

    private
    def info_params
        params.require(:storage).permit(:macaddress, :lastcontact)
    end
end
