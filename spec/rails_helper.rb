require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
# 短縮系
  config.include FactoryBot::Syntax::Methods

  # 以下テストごとに生成されたテストデータを自動で削除する仕組みを導入する
  # ためのものです。
  # 上記の設定をしていないと、この先、
  # テストを実行していく中で、すでにテスト用のデータベースにデータが
  # 存在しているため、テスト用のデータを作成できないというエラーに
  # 直面することがあるからです。
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:all) do
    DatabaseCleaner.start
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end

end
