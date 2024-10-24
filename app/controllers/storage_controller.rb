class StorageController < ApplicationController
    def new
        @storage = Storage.new
    end
    
    def create
        @storage = Storage.new(info_params) 
        if @storage.save
            redirect_to '/storage/new', notice: 'Storage added successfully'
        else
            render :new
        end
    end

    private
    def info_params
        params.require(:storage).permit(:macaddress, :serialnumber, :lastcontact)
    end
end
