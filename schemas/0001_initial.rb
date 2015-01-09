
schema "0001 initial" do

  entity "Foo" do
    string :name, optional: false
    datetime :updated_at
  end

end
