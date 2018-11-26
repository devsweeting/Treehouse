require "sinatra"
require ('sinatra/reloader')
require "uri" #fills invalid characters for the URL title creation

set :bind, "0.0.0.0"

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

def save_content(title, content)
  File.open("pages/#{title}.txt", "w") do |file|
    file.print(content)
  end
end

def delete_content(title)
  File.delete("pages/#{title}.txt")
end


get "/" do
  erb :welcome
end

get "/new" do
  erb :new
end

delete "/:title" do
  delete_content(params[:title])
  redirect "/"
end

get "/:title" do #creates every page by what the user enters in as a URL parameter
  # params hash holds the url parameters
@title = params[:title]
@content = page_content(@title)
erb :show
end

get "/:title/edit" do
@title =  params[:title]
@content = page_content(@title)
erb :edit
end

# create PAGE
post "/create" do
 save_content(params["title"], params["content"])
 #use redirect to end a post by redirecting to a GET method
 redirect URI.escape"/#{params["title"]}"
end

# Edit PAGE
put "/:title" do
  save_content(params["title"], params["content"])
  redirect URI.escape("/#{params["title"]}")
end
