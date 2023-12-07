class LoadBalancerService
  class << self
	  def call
	    server_list = get_servers
	    next_server_url(server_list)
	  end

	  private

	  def get_servers
	    Rails.cache.fetch('server_list') { 
	    	Server.pluck(:url) 
	    }
	  end

	  def next_server_index
	  	Rails.cache.fetch('next_server_index') { 0 }
	  end

		def update_server_index next_index
			next_index = (next_index == 0 ? 1 : 0)
			Rails.cache.write('next_server_index', next_index)
	  end

	  def next_server_url server_list
	    next_index = next_server_index
	    next_server = server_list[next_index]
	    update_server_index next_index 
	    next_server
	  end
	 end
end


