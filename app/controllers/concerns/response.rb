module Response
  def json_repsonse(object, status = :ok)
    render json: object, status: status
  end
end
