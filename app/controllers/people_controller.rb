class PeopleController < ApplicationController
  include Viaduct::Scaffolding
  
  def fields
    [:name, :address]
  end

  def list_display
    [:name]
  end
end
