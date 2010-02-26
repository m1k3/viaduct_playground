# Viaduct
module Viaduct
  module Scaffolding
    def self.included(base)
      base.append_view_path(File.join(File.dirname(__FILE__), 'app', 'views'))
      base.before_filter :assign_definition
    end

    def assign_definition
      @definition = self
    end

    def index
      if !params[:q].blank?
        @query = params[:q]
        @models = search(params[:q])      
      else
        @models = model_class.all
      end

      render :template => 'viaduct/index'
    end
 
    def new
      @model = model_class.new
      render :template => 'viaduct/new'
    end

    def edit
      @model = model_class.find(params[:id])
      @belongs_to_search_field = belongs_to_search_fields.first
      render :template => 'viaduct/edit'
    end

    def create
      @model = model_class.new(params[model_class.class_name.downcase.to_sym])
      if @model.valid? && @model.save && update_associations(@model)
        flash[:notice] = "#{model_class} was successfully created."
        redirect_to(:action => "index")
      else
        render :template => 'viaduct/new'
      end
    end

    def update
      @model = model_class.find(params[:id])
      if @model.valid? && @model.update_attributes(params[model_class.class_name.downcase.to_sym]) && update_associations(@model)
        flash[:notice] = "#{model_class} was successfully updated."
        redirect_to(:action => "index")
      else
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
    
    def belongs_to_autocomplete
      @matches = search(params[:query], params[:model].constantize, belongs_to_search_fields).first(7)
      @belongs_to_search_fields = belongs_to_search_fields
      render :layout => false, :template => 'viaduct/autocomplete'
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

    def search_fields
      []
    end
    
    def belongs_to_search_fields
      [:name]
    end

    protected
      def update_associations(model)
        association_items = []
        
        model_class.reflect_on_all_associations(:has_many).each do |association|
          association_items = association.klass.find(params["#{association.name}_ids".to_sym]) if params["#{association.name}_ids".to_sym]
          model.send("#{association.name}=", association_items)
        end
        
        model_class.reflect_on_all_associations(:belongs_to).each do |association|
          association_item = association.klass.first(:conditions => {belongs_to_search_fields.first => params["belongs_to_#{association.class_name}"]})
          model.send("#{association.name}=", association_item)
        end
        
        model.save
      end

      # generic search
      def search(query, model = model_class, model_search_fields = search_fields)
        condition = model_search_fields.map {|field| "`#{field}` LIKE :query"}.join(" OR ")
        model.all(:conditions => [condition, {:query => "%#{query}%"}])
      end
  end
end
