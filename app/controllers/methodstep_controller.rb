class MethodstepController < ApplicationController
    def new
        @etapa = Methodstep.new
        @etapa.attributes = { :name => params[:name], :methodology_id => params[:methodology_id] }
        
        begin
            @etapa.save!
            rescue Exception => e
            puts e.message
        end
        
        redirect_to :controller => 'methodologies', :action => 'show', :id => params[:methodology_id]
    end

    def destroy
        @etapa = Methodstep.find(params[:id])
        @etapa.destroy
        redirect_to :controller => 'methodologies', :action => 'show', :id => params[:methodology_id]
    end
end
