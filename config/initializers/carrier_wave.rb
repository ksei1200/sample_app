#if Rails.env.production?
#  CarrierWave.configure do |config|
#    config.fog_credentials = {
      # Amazon S3用の設定
#      :provider              => 'AWS',
#      :region                => ENV['us-east-2a'],     # 例: 'ap-northeast-1'
#      :aws_access_key_id     => ENV['AKIAIKN6U5NFSS2RVAOA'],
#      :aws_secret_access_key => ENV['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']
#    }
#    config.fog_directory     =  ENV['kseirai']
#  end
#end