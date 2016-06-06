class StoreController < ApplicationController

  #[POST] /store
  def create
    key_value_object = params[:key_value]
    key = key_value_object.keys[0]
    value = key_value_object[key]

    key_value_object = Store.new.add(key, value)

    render :json => key_value_object.to_json

  end

  #[GET] /store/:key
  def get
    key = params[:key]
    timestamp = params[:timestamp].to_i

    value = Store.new.get(key, timestamp)

    if value.present?
      render :json => {status: 200, value: value}.to_json
    else
      head 404, content_type: "text/html"
    end
  end

end