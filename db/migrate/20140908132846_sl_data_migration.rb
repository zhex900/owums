class SlDataMigration < ActiveRecord::Migration
  keys = YAML::load(File.open("db/fixtures/configurations.yml"))

  @configurations = [
    keys[131],
    keys[132],
    keys[133],
    keys[134],
    keys[135],
    keys[136],
    keys[137],
    keys[138],
    keys[139],
    keys[140],
    keys[141],
  ]

  def self.up
    Configuration.where("configurations.key LIKE ?", "%_si").each do |c|
      c.destroy
    end

    @configurations.each do |config|
      if Configuration.find_by_key(config['key']).nil?
        Configuration.set(config['key'], config['value'])
      end
    end
  end

  def self.down
  end
end
