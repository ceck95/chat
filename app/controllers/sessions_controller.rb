class SessionsController < ApplicationController
	def create
		user = User.from_omniauth(request.env['omniauth.auth'])
		user.status = true
		user.save
		session[:user_id] = user.id
		flash[:success] = "Chào bạn, #{user.name}"
		redirect_to root_url
	end
	def destroy
		user = User.find(session[:user_id])
		# user.update_attribute(:status, false)
		user.status = false
		user.save

		# flash[:success] = "Hẹn gặp lại !"
		respond_to do |format|
		      format.json { render json: {messages: "Offline"} }
		      format.js
		  end
		session.delete(:user_id)
	end

	def auth_fails
		render text: "Bạn đang cố gắng đăng nhập #{params[:strategy]},nhưng theo chúng tôi biết bạn đang gặp lỗi#{params[:messages]}",status: 500
	end
	def offline
		user = User.find(session[:user_id])
		# user.update_attribute(:status, false)
		user.status = false
		user.save
		render json: {
			  messages: "Offline"
			}, status: 200
	end
	def online
		user = User.find(session[:user_id])
		# user.update_attribute(:status, false)
		user.status = true
		user.save
		respond_to do |format|
			format.js
		end
		render json: {
			  messages: "Online"
			}, status: 200	
	end
end