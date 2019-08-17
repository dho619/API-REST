Rails.application.routes.draw do
  			namespace 'api' do  			#dentro da pasta api
  				namespace 'v1' do 		#dento da pasta v1
  					resources :animes   #no arquivo animes
  				end
  			end
		end

#colocar suas rotas
