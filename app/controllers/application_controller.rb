class ApplicationController < ActionController::API
  include ::ActionController::Caching
  self.cache_store = :mem_cache_store

end
