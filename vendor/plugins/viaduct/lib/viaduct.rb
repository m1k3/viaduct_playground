# Viaduct
module Viaduct
  module Scaffolding
    def index
      @list_display = list_display
      @models = model_class.all
      render :template => 'viaduct/index'
    end
 
    def new
      @model = model_class.new
    end
 
    def edit
      @model = model_class.find(params[:id])
    end
 
    def create
      @model = model_class.new(params[:person])
      if @model.save
        flash[:notice] = 'Person was successfully created.'
        redirect_to(@model)
      else
        render :action => "new"
      end
    end
 
    def update
      @model = model_class.find(params[:id])
 
      if @model.update_attributes(params[:person])
        flash[:notice] = 'Person was successfully updated.'
        redirect_to(@model)
      else
        render :action => "edit"
      end
    end
 
    def destroy
      @model = model_class.find(params[:id])
      @model.destroy
      redirect_to(people_url)
    end
 
    protected
      def model_class
        ActiveSupport::Inflector::classify(self.class.to_s.gsub(/Controller$/, '')).constantize
      end
       
      def list_display
        fields
      end

      def fields
        model_class.columns.reject(&:primary).collect(&:name)
      end
  end
end
