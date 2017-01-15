require 'rubygems'
require 'builder'
require 'nokogiri'
require 'open-uri'

class IntegrationController < ApplicationController
    before_action :load_ontologias

    def index

        #        @integracoes = Integration.find(:all, :conditions=>['document_id=?', params[:document_id]])
        @integracoes = Integration.where("document_id = ?", params[:document_id]).all
        if params[:document]
            @documento = Document.find(params[:document_id])
        end

        if params[:string]
            pesquisa = params[:string]
            html_data = read('http://prefix.cc/'+pesquisa)
            doc = Nokogiri::HTML(html_data)
            @entries = doc.css('.namespace-link')
        end
    end

    def adicionar
        @integracoes = Integration.new
        @integracoes.update_attributes(:name => params[:integration][:name], :prefix => params[:integration][:prefix], :uri => params[:integration][:uri], :purpose => params[:integration][:purpose])
        @integracoes.update_attributes(:document_id => params[:document_id])
        @integracoes.save
        redirect_to :action=>'index', :document_id=> params[:document_id], :version_id=> params[:version_id]
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

end
