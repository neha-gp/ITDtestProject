class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         has_one_attached :avatar

   validates_presence_of :first_name
   validates_presence_of :last_name
   validates_presence_of :email
   validates_presence_of :contact_no

      

   def self.to_csv
    attributes = %w{first_name last_name email contact_no address}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

    def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
    user_hash = row.to_hash
    user = User.find_by(email: user_hash['email'])
      if user.present?
         user.update(first_name: user_hash['first_name'], last_name: user_hash['last_name'], email: user_hash['email'], contact_no: user_hash['contact_no'], address: user_hash['address'])
      else
         User.create!(first_name: user_hash['first_name'], last_name: user_hash['last_name'], email: user_hash['email'], contact_no: user_hash['contact_no'], address: user_hash['address'])
      end
    end
  end
end