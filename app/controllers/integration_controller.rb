require 'rubygems'
require 'builder'
require 'nokogiri'
require 'open-uri'

class IntegrationController < ApplicationController
    before_action :load_ontologias

    def index

        # @integracoes = Integration.find(:all, :conditions=>['document_id=?', params[:document_id]])
        @integracoes = Integration.where("document_id = ?", params[:document_id]).all
        if params[:document_id]
            @documento = Document.find(params[:document_id])
        end

        if params[:string]
            pesquisa = params[:string]
            
            url = "http://prefix.cc/" + pesquisa.downcase
            begin
                html = open(url).read
                rescue Exception => e
                puts e.message
                @flag = "Oi"
            end
            begin
                @doc = Nokogiri::HTML(html)
                @entries = @doc.css('.namespace-link')
            rescue Exception => e
                puts e.message
            end
        end
    end

    def adicionar
        @integracoes = Integration.new
        @integracoes.attributes = { :name => params[:integration][:name], :prefix => params[:integration][:prefix], :uri => params[:integration][:uri], :purpose => params[:integration][:purpose] }
        @integracoes.attributes = { :document_id => params[:document_id] }

        begin
            @integracoes.save!
        rescue Exception => e
            puts e.message
        end        

        redirect_to :action=>'index', :document_id => params[:document_id], :version_id=> params[:version_id]
    end

    def load_ontologias
        @ontologias = Ontology.all

        if params[:ontology_id]
            @ontology = Ontology.find(params[:ontology_id])
        elsif params[:version_id] 
            @version = Version.find(params[:version_id])
            @ontology = @version.ontology
        else
            @documento = Document.find(params[:document_id])  
            if !@documento.ontology_id.nil?
                @ontology = @documento.ontology
            else
                @version = @documento.version
                @ontology = @documento.version.ontology
            end
        end
    end

    def integration_params
        params.require(:integration).permit(:name, :prefix, :uri, :purpose, :document_id)
    end

    private


    def sanitize_filename(filename)
        filename.strip.tap do |name|
            # NOTE: File.basename doesn't work right with Windows paths on Unix
            # get only the filename, not the whole path
            name.sub! /\A.*(\\|\/)/, ''
            # Finally, replace all non alphanumeric, underscore
            # or periods with underscore
            name.gsub! /[^\w\.\-]/, '_'
        end
    end

end
