Sequel.migration do
  up do
    create_table "interests" do |t|
      primary_key :id
      String :email
      String :item
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
