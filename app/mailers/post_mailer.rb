class PostMailer < ActionMailer::Base
  def send_to_all(post)
    @post = post
    mail  :to => ['mkocher@pivotallabs.com'],
          :subject => post.title,
          :from => "#{post.from} <noreply@pivotallabs.com>"
  end
end