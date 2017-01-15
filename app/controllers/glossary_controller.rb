require "rubygems"
require "builder"
require "nokogiri"
require "open-uri"

class GlossaryController < ApplicationController
    before_action :load_term_types, :only => [ :edit, :show, :manual]
    before_action :load_glossary, :only => [ :show]
    before_action :load_artefact_status, :only =>  [:edit]
    before_action :load_ontologias


    def product_xml

        #        @types = TermType.find(:all)
        @types = TermType.all
        #        @glossary = Term.find(:all, :conditions=>["version_id = ?", params[:version_id]])
        @glossary = Term.where("version_id = ?", params[:version_id]).all
        @version = Version.find(params[:version_id])
        @importe = Integration.find_by_sql("select * from integrations inner join documents on integrations.document_id = documents.id where documents.version_id = 1")

        builder = Nokogiri::XML::Builder.new do |xml|

            xml.Ontology(:xmlns=>"http://www.w3.org/2002/07/owl#",
                'xmlns:rdfs'=>"http://www.w3.org/2000/01/rdf-schema#",
                'xmlns:xsd'=>"http://www.w3.org/2001/XMLSchema#",
                'xmlns:rdf'=>"http://www.w3.org/1999/02/22-rdf-syntax-ns#",
                'xmlns:xml'=>"http://www.w3.org/XML/1998/namespace") do 

                    xml.Prefix(:name=>"", :IRI=>"http://www.w3.org/2002/07/owl#")
                    xml.Prefix(:name=>"owl", :IRI=>"http://www.w3.org/2002/07/owl#")
                    xml.Prefix(:name=>"rdf", :IRI=>"http://www.w3.org/1999/02/22-rdf-syntax-ns#")
                    xml.Prefix(:name=>"xsd", :IRI=>"http://www.w3.org/2001/XMLSchema#")
                    xml.Prefix(:name=>"rdfs", :IRI=>"http://www.w3.org/2000/01/rdf-schema#")


                    @glossary.each do |termo|
                        case termo.term_type_id
                        when 1..4
                            xml.Declaration{
                                case termo.term_type_id
                                when 1
                                    xml.Class_ :IRI=>"#"+termo.name
                                when 2
                                    xml.DataProperty_ :IRI=>"#"+termo.name
                                when 3
                                    xml.NamedIndividual_ :IRI=>"#"+termo.name
                                else
                                    xml.ObjectProperty_ :IRI=>"#"+termo.name
                                end
                                }
                        when 5
                            #restrição de classe
                        when 6
                            #termo a definir
                        when 7
                            #termo abandonado
                        when 8
                            #função
                        when 9
                            #axioma
                        end     
                    end
                end
        end
        textxml = builder.to_xml
        name = @ontology.name+"-"+@version.number.to_s+".owl"
        directory = "app/views/glossary/arquivos/"+name
        File.open(directory, "w") { 
            |f| f.write(textxml) 
            }
        File.open(directory, 'r') do |f|
            send_data f.read, :type => "text/xml", :filename => name
        end


    end


    def manual
        @documento = Document.find(params[:document_id])
        @version = Version.find(params[:version_id])
        #    @glossary = Term.find(:all, :conditions=>["version_id = ?", @version.id])
        @glossary = Term.where("version_id = ?", @version.id).all
        @types = TermType.all

        if request.post?
            @termo = Term.new
            @termo.attributes = params[:term]
            @termo.attributes = {:version_id => @version.id, :artefact_status_id=>1}
            @termo.save
            redirect_to :action=>'manual', :document_id=>@documento.id, :version_id=>@version.id
        end

    end


    def manualEdit
        if request.post?
            @termo = Term.find(params[:id])
            @termo.update_attributes(:term_type_id => params[:term][:term_type_id], :name => params[:term][:name], :description => params[:term][:description])
            @termo.update_attributes(:version_id => @version.id, :artefact_status_id => 1)
            @termo.save
            redirect_to :action=>'manual', :document_id=>@documento.id, :version_id=>@version.id
        end

    end

    def arquivo
        @documento = Document.find(params[:document_id])
        #        @glossary = Term.find(:all, :conditions=>["version_id = ?", params[:version_id]])
        @glossary = Term.find("version_id = ?", params[:version_id]).all
        if request.post?
            @documento = Document.find(params[:document_id])
            name = params[:upload][:file].original_filename
            directory = "/home/mariana/Documentos/metodoc/app/views/glossary/arquivos"
            path = File.join(directory, name)
            new_name = @documento.id.to_s + ".owl"
            File.open(path, "wb") { |f| f.write(params[:upload][:file].read) 
                File.rename(path, directory + "/" + new_name )
                redirect_to :action=>'arquivo', :document_id=>@documento.id, :version_id=>params[:version_id]
                }
        end
        flash[:notice] = "File uploaded"
    end

    def edit

        @documento = Document.find(params[:document_id])
        @version = Version.find(params[:version_id])

        vClasses = params[:vClasse].split(',')
        vPropriedade = params[:vPropriedade].split(',')

        terms = Term.find(:all, :conditions=>["version_id = ?", @version.id])
        terms.each do |t|
            t.destroy
        end

        vClasses.each do |c| 
            @term = Term.new
            if vPropriedade.include?(c)
                type_id = 4
            else
                type_id = 1
            end         
            @term.attributes = {:term_type_id => type_id, :name => c, :description => "test", :artefact_status_id=>1, :version_id => @version.id}
            @term.save

        end 

        redirect_to :action=>'arquivo', :document_id=>@documento.id, :version_id=>@version.id
    end

    def destroy
        term = Term.find(params[:id])
        if term.destroy
            redirect_to :action => 'index', :version_id => params[:version_id]
        else
            redirect_to :controller => 'authentication', :action => 'error'
        end
    end

    protected
    def load_term_types
        @term_types = TermType.all.collect { |u| [u.description, u.id] }
    end

    def load_ontologias
        @ontologias = Ontology.all
        if params[:document_id]
            @documento = Document.find(params[:document_id])  
            if !@documento.ontology_id.nil?
                @ontology = @documento.ontology
            else
                @version = @documento.version
                @ontology = @documento.version.ontology
            end
        elsif params[:ontology_id]
            @ontology = Ontology.find(params[:ontology_id])
        else params[:version_id] 
            @version = Version.find(params[:version_id])
            @ontology = @version.ontology


        end
    end

    def load_glossary
        unless params[:term_type]
            term_type = 1#pegar o ID de um tipo cadastrado
        else
            term_type = params[:term_type]
        end
        current_version = Version.find(params[:version_id])
        @version_id = current_version.id
        @glossary = Term.find_terms_by_type(current_version.id, term_type)
        @term_type = TermType.find(term_type)

    end
end
