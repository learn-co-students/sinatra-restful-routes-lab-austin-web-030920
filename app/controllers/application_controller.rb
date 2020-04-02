class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

    # Index Action
    get '/recipes' do
      @recipes = Recipe.all
      erb :index
    end


    # New Action
    get '/recipes/new' do
      erb :new
    end

    post '/recipes' do
      @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time].to_s)
      redirect to("/recipes/#{@recipe.id}")
    end


    # Show Action
    get '/recipes/:id' do
      @recipe = Recipe.find_by_id(params[:id])
      erb :show
    end

    # Edit Action
    get '/recipes/:id/edit' do
      @recipe = Recipe.find_by_id(params[:id])
      erb :edit
    end

    patch '/recipes/:id' do
      @recipe = Recipe.find_by_id(params[:id])
      @recipe.title = params[:title]
      @recipe.content = params[:content]
      @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    end

    delete '/recipes/:id' do
      Recipe.all.delete(params[:id])
      
      redirect to('/recipes')
    end
end
