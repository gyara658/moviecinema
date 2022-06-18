module MoviesHelper
  def content_select(code)
    search_uri = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja-JA&query=#{code}&include_adult=false"
    enc_uri = Addressable::URI.encode(search_uri)
    uri = URI.parse(enc_uri)
    json = Net::HTTP.get(uri)
    @movies = JSON.parse(json)
    @base_content = @movies["results"]
    @cnt = @base_content.size
  end

  def trend_name(count, type)
     i = 0
     @trend_list = []
     while i < count
       @trend_list.push(type[i]["title"])
       i += 1
     end
  end

  def bubble_sort(ary)
    length = ary.length
    (1..length).each do |i|
      (1..(length - i)).each do |jx|
        jy = jx - 1
        if ary[jy][6].to_s < ary[jx][6].to_s
          tmp = ary[jy]
          ary[jy] = ary[jx]
          ary[jx] = tmp
        end
      end
    end
    ary
  end
end
