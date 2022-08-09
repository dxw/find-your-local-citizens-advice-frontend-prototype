require 'net/http'
require 'addressable'

class OfficesController < ApplicationController
  def index
    query = params["search"]
    query_params = params.permit("limit", "eligible_only", "within").to_h.to_query


    if query.present?
      url = URI(Addressable::URI.escape("http://localhost:3001/internal_postgres_search/#{query}?#{query_params}"))
      res = Net::HTTP.get(url)
      result_objects = JSON.parse(res, object_class: OpenStruct)

      offices_by_eligibility = result_objects.results.offices.group_by(&:eligible)

      @offices = offices_by_eligibility[nil]
      @eligible_offices = offices_by_eligibility[true]
      @ineligible_offices = offices_by_eligibility[false]
    else
      @local_authority = nil
      @offices = []
    end
  end

  def show
    query = params["id"]
    url = URI("http://localhost:3001/offices/#{query}")
    res = Net::HTTP.get(url)

    data = JSON.parse(res, object_class: OpenStruct)

    @office = data.office
  end
end
