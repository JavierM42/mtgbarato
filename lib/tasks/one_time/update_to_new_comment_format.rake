namespace :one_time do
  desc "comments are now within underscores"
  task :update_to_new_comment_format => :environment do
    User.all.each do |user|
      user.buy = (user.buy || "").gsub('(', '_').gsub(')', '_')
      user.sell = (user.buy || "")user.sell.gsub('(', '_').gsub(')', '_')
      user.save
    end
  end
end