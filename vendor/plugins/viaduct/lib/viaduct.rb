# Viaduct
module Viaduct
  module Scaffolding
    
    def self.included(base)
      base.append_view_path(File.join(File.dirname(__FILE__), 'app', 'views'))
    end

    def index
      @list_display = list_display
      @models = model_class.all
      @model_class = model_class
      @actions = actions
      render :template => 'viaduct/index'
    end
 
    def new
      @model = model_class.new
      @fields = fields
      @associations = model_class.reflect_on_all_associations
      render :template => 'viaduct/new'
    end

    def edit
      @model = model_class.find(params[:id])
      @fields = fields
      @associations = model_class.reflect_on_all_associations
      render :template => 'viaduct/edit'
    end

    def create
      @model = model_class.new(params[model_class.class_name.downcase.to_sym])
      if @model.valid? && @model.save && update_associations(@model)
        flash[:notice] = "#{model_class} was successfully created."
        redirect_to(:action => "index")
      else
        @fields = fields
        @associations = model_class.reflect_on_all_associations
        render :template => 'viaduct/new'
      end
    end

    def update
      @model = model_class.find(params[:id])
      if @model.valid? && @model.update_attributes(params[model_class.class_name.downcase.to_sym]) && update_associations(@model)
        flash[:notice] = "#{model_class} was successfully updated."
        redirect_to(:action => "index")
      else
        @fields = fields
        @associations = model_class.reflect_on_all_associations
        render :template => 'viaduct/edit'
      end
    end

    def destroy
      @model = model_class.find(params[:id])
      @model.destroy
      redirect_to(:action => "index")
    end

    def bulk_action
      action = params[:selected][:action]
      if !action.blank? and actions.include?(action.to_sym)
        @models = model_class.find_all_by_id(params[:selected_models])
        @models.each do |model|
          model.send(action)
        end
      end
      redirect_to(:action => "index")
    end

    protected
      def update_associations(model)
        model_class.reflect_on_all_associations.each do |association|
          model.send("#{association.class_name.downcase}=".to_sym,
            association.class_name.constantize.find(params[model_class.class_name.downcase.to_sym][association.class_name.downcase.to_sym]))
        end
        model.save
      end
    
      def model_class
        controller_name.classify.constantize
      end

      def list_display
        fields
      end

      def fields
        model_class.columns.reject(&:primary).collect(&:name)
      end

      def actions
        [:destroy]
      end
  end
end
