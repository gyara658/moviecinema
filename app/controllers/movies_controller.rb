class MoviesController < ApplicationController
  before_action :movies_uri, only: [:index]

  require 'addressable/uri'


  def index
    trend_select([:trend])
    @num = params[:num]
  end

  def index_all
    @page = params[:content]
    if @page == "index"
      @trend_list = params[:trend_list]
      @name = "title"
      @title = "人気映画一覧"
      @count = @trend_list.size
    elsif @page == "header" or @page == "footer"
      movies_uri
    end
  end


  def search
    code = params[:content_code]
    if code.present?
      search_uri = "https://api.themoviedb.org/3/search/multi?api_key=#{ENV['TMDB_API_KEY']}&language=ja-JA&query=#{code}&include_adult=false"
      enc_uri = Addressable::URI.encode(search_uri)
      uri = URI.parse(enc_uri)
      json = Net::HTTP.get(uri)
      @movies = JSON.parse(json)
      # @base_content = @movies["results"].sort_by { |hash| -hash['popularity'].to_i }
      @base_content = @movies["results"].sort_by { |hash| -hash['popularity'].to_i }
      @cnt = @base_content.size
    else
      redirect_to root_path
    end
  end

  def show
    @content = params[:content]
    @num = params[:num].to_i
    @users = User.pluck(:id, :username)
    @poster_path = Post.pluck(:poster_path)
    @posts = Post.pluck(:user_id, :review, :image, :body, :submitter, :id, :created_at, :poster_path)
    session[:content] = @content
  end

  private

    def movies_uri
      search_uri = "https://api.themoviedb.org/3/trending/movie/week?api_key=#{ENV['TMDB_API_KEY']}&language=ja-JA"
      enc_uri = Addressable::URI.encode(search_uri)
      uri = URI.parse(enc_uri)

      response = Net::HTTP.start(uri.host, uri.port) do |http|
        # 接続時の待機時間
        http.open_timeout = 10
        # ブロックする最大秒数
        http.read_timeout = 20
        # APIをリクエスト
        json = Net::HTTP.get(uri)
        @movies = JSON.parse(json)
      end
      # 例外処理
      begin
        # @movies = JSON.parse(json)
        @movies_content = @movies["results"].sort_by { |hash| -hash['popularity'].to_i }
        @count = @movies_content.size
        # エラー処理
      rescue => e
        @message = e.message
      end

      # json = Net::HTTP.get(uri)
      # @movies = JSON.parse(json)
      # @movies_content = @movies["results"].sort_by { |hash| -hash['popularity'].to_i }
      # @count = @movies_content.size
    end

    def trend_select(code)
      search_uri = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja-JA&query=#{code}&include_adult=false"
      enc_uri = Addressable::URI.encode(search_uri)
      uri = URI.parse(enc_uri)
      json = Net::HTTP.get(uri)
      @movies = JSON.parse(json)
      @base_content = @movies["results"]
      @cnt = @base_content.size
    end
end
