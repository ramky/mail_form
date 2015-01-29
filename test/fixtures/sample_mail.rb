class SampleMail < MailForm::Base
  attributes :name, :email

  def headers
    { to: 'recipeint@example.com', from: self.email }
  end
end
