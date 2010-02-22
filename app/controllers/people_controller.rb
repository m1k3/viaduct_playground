class PeopleController < ApplicationController
  include Viaduct::Scaffolding
  
  def fields
    [:name, :address, :phone]
  end

  def list_display
    [:name]
  end

  def actions
    [:destroy]
  end
end
