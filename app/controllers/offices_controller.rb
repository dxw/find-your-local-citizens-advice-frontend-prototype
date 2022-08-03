require 'net/http'
class OfficesController < ApplicationController
  def index

    query = params["search"]
    query_params = params.permit("limit", "eligible_only").to_h.to_query

    url = URI("http://localhost:3001/internal_postgres_search/#{query}?#{query_params}")
    res = Net::HTTP.get(url)

    @offices = JSON.parse(res, object_class: OpenStruct) || []

  end

  def show
    query = params["id"]
    url = URI("http://localhost:3001/offices/#{query}")
    res = Net::HTTP.get(url)

    @office = JSON.parse(res, object_class: OpenStruct) || []
  end
end
