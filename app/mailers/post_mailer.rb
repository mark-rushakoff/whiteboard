class PostMailer < ActionMailer::Base
  default :from => 'noreply@pivotallabs.com'

  def send_to_all(post)
    @post = post
    mail :to => ['mkocher@pivotallabs.com'], :subject => post.title
  end
end