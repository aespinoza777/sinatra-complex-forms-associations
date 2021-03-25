class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
   @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if params[:owner][:name].present?
      params[:pet] = nil
    end
    @pet = Pet.create(name: params[:pet_name])
    if params[:pet]
      @pet.update(params[:pet])
    end

    if params[:owner][:name].present?
      new_owner = Owner.create(name: params["owner"]["name"])
      @pet.update(owner: new_owner)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end


  patch '/pets/:id' do 
    ####### bug fix
    if params[:owner][:name].present?
      params[:pet] = nil
    end
      #######

    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if params[:pet]
      @pet.update(params[:pet])
    end

    if params[:owner][:name].present?
      new_owner = Owner.create(name: params["owner"]["name"])
      @pet.update(owner: new_owner)
    end
    redirect to "pets/#{@pet.id}"
  end
end