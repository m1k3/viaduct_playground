class CommentsController < ApplicationController
  include Viaduct::Scaffolding
  
  def fields
    [:title, :content]
  end

  def list_display
    [:title]
  end

  def actions
    [:destroy]
  end
  
  def belongs_to_search_fields
    [:name]
  end
end
