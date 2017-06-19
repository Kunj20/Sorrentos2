require "sinatra"
require 'sendgrid-ruby'
include SendGrid

get "/" do
  erb :home
end

get "/about-us" do
  erb :about_us
end

get "/contact-us" do
  erb :contact_us
end

get "/menu" do
  erb :menu
end

get "/email" do
  erb :email
end

post "/contact-us-response" do
  from = SendGrid::Email.new(email: params[:from])
  subject = params[:subject]
  to = SendGrid::Email.new(email: params[:to])
  content = SendGrid::Content.new(type: 'text/plain', value: params[:content])
  mail = SendGrid::Mail.new(from, subject, to, content)
  sg = SendGrid::API.new(api_key: "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")
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  redirect "/contact-us"
 end
