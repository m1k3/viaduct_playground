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
      @page = 1
      if /\d+/.match(params[:page])
        @page = params[:page].to_i
      end
      if !params[:q].blank?
        @query = params[:q]
        @models = search(params[:q], @page)
      else
        @models = model_class.all(:offset => per_page * (@page - 1), :limit => per_page)
        @models_count = model_class.count
      end
      @total_pages = (@models_count.to_f / per_page).ceil
      render :template => 'viaduct/index'
    end

    def new
      @model = model_class.new
      render :template => 'viaduct/new'
    end

    def edit
      @model = model_class.find(params[:id])
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

    def per_page
      20
    end

    protected
    def update_associations(model)
      associations = model_class.reflect_on_all_associations
      has_many = associations.delete_if { |r| r.macro != :has_many }
      association_items = []

      has_many.each do |association|
        association_items = association.klass.find(params["#{association.name}_ids".to_sym]) if params["#{association.name}_ids".to_sym]
        model.send("#{association.name}=", association_items)
      end
      model.save
    end

    # generic search
    def search(query, page)
      condition = search_fields.map {|field| "`#{field}` LIKE :query"}.join(" OR ")
      conditions = [condition, {:query => "%#{query}%"}]
      @models_count = model_class.count(:conditions => conditions)                             
      model_class.all(:conditions => conditions, :offset => (page - 1) * per_page, :limit => per_page)
    end
  end
end
