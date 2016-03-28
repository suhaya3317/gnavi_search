class RestaurantController < ApplicationController

  def top
    @range_options = [["300m", 1], ["500m", 2], ["1000m", 3], ["2000m", 4], ["3000m", 5]]
  end

  def list
    if params[:next] == "true"
      query = session[:query]
      query["offset_page"] = query["offset_page"].to_i + 1
    elsif params[:prev] == "true"
      query = session[:query]
      query["offset_page"] = query["offset_page"].to_i - 1
    else
      query = params[:query]
      query["offset_page"] = 1
    end
    session[:query] = query
    url = build_url(query)
    res = open(url)

    if res.status[0] == "200"
      json = JSON.parse(res.read, { symbolize_names: true })
      @offset_page = query["offset_page"]
      @rests = json[:rest]
    end

  end

  def detail
    id = params[:id]
    url = build_url({ id: id })
    res = open(url)

    if res.status[0] == "200"
      json = JSON.parse(res.read, { symbolize_names: true })
      @rest = json[:rest]
    end
  end


  private

    def build_url(query)
      url = 'http://api.gnavi.co.jp/RestSearchAPI/20150630/'
      query[:keyid] = KEYID
      query[:format] = 'json'

      url = url + '?' + query.to_query
    end


end
