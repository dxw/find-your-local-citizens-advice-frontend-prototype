require 'net/http'
class OfficesController < ApplicationController
  def index
    query = params["search"]
    query_params = params.permit("limit", "eligible_only", "within").to_h.to_query

    if query.present?
      url = URI("http://localhost:3001/internal_postgres_search/#{query}?#{query_params}")
      res = Net::HTTP.get(url)
      result_objects = JSON.parse(res, object_class: OpenStruct)

      @local_authority = result_objects.local_authority
      @offices = result_objects.offices
    else
      @local_authority = nil
      @offices = []
    end
  end

  def show
    query = params["id"]
    url = URI("http://localhost:3001/offices/#{query}")
    res = Net::HTTP.get(url)

    @office = JSON.parse(res, object_class: OpenStruct) || []
  end
end
