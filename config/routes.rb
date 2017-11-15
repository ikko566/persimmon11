Rails.application.routes.draw do
  resource  :transcript
  resources :transcripts do
      member do
          post 'list'
      end
      collection do
          get 'get_transcript'
         get 'tagsearch'
      end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#  get  'get_transcript' => 'transcripts#get_transcript'
#  get  'list' => 'transcripts#list'
#  post "/" => "transcripts#list"
  post 'tagsearch' => 'transcripts#list'
 
end
