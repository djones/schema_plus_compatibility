# encoding: utf-8
require 'spec_helper'

describe ActiveRecord::ConnectionAdapters::AbstractAdapter do

  context "tables_without_deprecation" do

    let(:connection) { ActiveRecord::Base.connection }

    around(:each) do |example|
      begin
        connection.create_table :t1, force: true
        connection.create_table :t2, force: true
        example.run
      ensure
        connection.drop_table :t1, if_exists: true
        connection.drop_table :t2, if_exists: true
      end
    end

    it "does not create deprecation" do
      expect_not_deprecated {
        connection.tables_without_deprecation
      }
    end

    it "lists all tables" do
      expect(connection.tables_without_deprecation).to match_array %w{t1 t2}
    end
  end
end
