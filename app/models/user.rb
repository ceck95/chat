class User < ActiveRecord::Base
	has_many :messages,dependent: :delete_all
	def self.from_omniauth(auth)
		provider = auth.provider
		uid = auth.uid
		info = auth.info.symbolize_keys!
		user = User.find_or_initialize_by(uid: uid,provider: provider)
		user.name = info.name
		user.status = true
		user.avatar_url = info.image
		user.profile_url = 'https://facebook.com/'+auth.uid
		user.save!
		user
	end
	# def self.update(status)
	#   update_attribute(:status, status)
	# end
end
