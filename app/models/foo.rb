class Foo < CDQManagedObject
  def willSave
    setPrimitiveValue(Time.now, forKey:"updated_at")
  end
end
