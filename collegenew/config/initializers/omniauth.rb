require 'twitter'
#OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
provider :facebook, '155744601595097', 'c53fa7036894809c7e15025651e36afa',
           :scope => 'email', :display => 'popup'
provider :twitter, 'UKnBuX9mqd2kTzvhv8pjeky3M', 'WCdQ8Hhym25zp4n8Jq5EHhDEcKu0xg5ESde3c9pjYT19Yw6U4y',:scope => 'email', :display => 'popup'



end


