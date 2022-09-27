class TelegramController < ApplicationController
    def auth
      if correct_hash?
        current_user.update(id_tg: params[:id])
        flash[:notice] = 'Teleram success connect'
      else
        flash[:error] = 'Incorrect hash'
      end
      redirect_to root_path
    end
  
    private
    
    def correct_hash?
      all_params = []
      auth_params = [:id, :first_name, :last_name, :username, :photo_url, :auth_date]
      auth_params.sort.each do |p|
        all_params << "#{p}=#{params[p]}" if params[p]
      end
      permitted_hash = all_params.join("\n")

      sha_token = OpenSSL::Digest::SHA256.new.digest(ENV['tg_token'])
      hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, sha_token, permitted_hash)

      hash == params[:hash]
    end
    
  end
  