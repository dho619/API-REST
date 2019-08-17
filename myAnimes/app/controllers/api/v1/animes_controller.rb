module Api 		         # pasando a pasta api
        	module V1    #passando a pasta v1
              	class AnimesController < ApplicationController #herdando

                  #Exibir todos animes cadastrados
                  def index #criando o metodo index
                    animes = Anime.order('created_at DESC'); #recebendo os valores da tabela produto em ordem
                    render json: {status: 'SUCCESS', message:'Animes foram carregados:', data:animes},status: :ok
                  end

                  #Exibir um cadastro especifico
                  def show
          				      anime = Anime.find(params[:id]) #pegando um cadastro especificado
          		          render json: {status: 'SUCCESS', message:'Anime carregado', data:anime},status: :ok
          			  end

                  def create
            				anime = Anime.new(anime_params)
            				if anime.save
            					render json: {status: 'SUCCESS', message:'Anime Salvo', data:anime},status: :ok
            				else
            					render json: {status: 'ERROR', message:'Anime nao Salvado', data:anime.erros},status: :unprocessable_entity
            				end
            			end

                  #Apagar um cadastro
                  def destroy
                    anime = Anime.find(params[:id])
                    anime.destroy
                    render json: {status: 'SUCCESS', messowage:'Anime excluido', data:anime}, status: :ok
                  end

                  #atualizar um cadastro
                  def update
                  	anime = Anime.find(params[:id])
                  	if anime.update_attributes(anime_params)
                  		render json: {status: 'SUCCESS', message:'Anime atualizado', data:anime},status: :ok
          				  else
                			render json: {status: 'ERROR', message:'Anime nao atualizado', data:anime.erros},status: :unprocessable_entity
                    end
                  end

                # Parametros aceitos
          			private #metodo privado
          			def anime_params
          				params.permit(:name, :description, :release_year, :author, :number_eps, :still_casting)
          			end

		   	end
	  	end
	end
