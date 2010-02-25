class ArticlesController < ApplicationController
  include Viaduct::Scaffolding

  def search_fields
    [:title, :body]
  end
end
