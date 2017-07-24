class MapController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:addpoint, :getpoints]
  before_action :authenticate_user!, only: [:index, :destroy, :getpoints]
  def index

  end

  def addpoint
    login = decode64(params[:login])
    if params[:method] === 'addPoint'
      user = User.find_by(login: login)
      if user && user.valid_password?(decode64(params[:password])) && params[:points]
        res = false
        params[:points].each do |track|
          res ||= !Trackpoint.create(user: user, latitude: track[:lat], longitude: track[:lon],
                            altitude: track[:alt], speed: track[:speed],
                            direction: track[:dir], name: decode64(track[:name]),
                            session: track[:session], created_at: track[:datetime].to_datetime)
        end
        if !res 
          render json: {user: login, status: "OK"}, layout: false
          return
        end
      end
    end
    render json: {user: login, status: "error"}, layout: false
  end

  def getpoints
    unless user_signed_in?
      render json: {}, layout: false
      return
    end
    id = -1
    if params['lastval']
      id = params['lastval'].to_i;
    end
    if params['lastval'] || params['interval']
      trackpoints = current_user.trackpoints.lastvalues(id, params['interval'])
    elsif params['nameform']
      trackpoints = current_user.trackpoints.byname(params['nameform'])
    else
      trackpoints = current_user.trackpoints.interval(params['from'], params['to'])
    end
    render json: trackpoints.to_json, layout: false
  end

  private
    def decode64 str
      Base64.decode64(str).force_encoding('UTF-8').encode
    end
end
