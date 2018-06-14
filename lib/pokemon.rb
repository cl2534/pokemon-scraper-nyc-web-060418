require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db, :hp
  def initialize(id:,name:,type:,db:)
    @name = name
    @id = id
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql_string = <<-SQL_STRING
     insert into pokemon (name, type) VALUES (?,?)
    SQL_STRING
    db.execute(sql_string,[name, type])
  end

  def self.find(id, db)
    sql_string = <<-SQL_STRING
      select * from pokemon where id = ?
    SQL_STRING
    array_of_hashes = db.execute(sql_string, id)
    #binding.pry
    array_id = array_of_hashes[0][0]
    array_name = array_of_hashes[0][1]
    array_type = array_of_hashes[0][2]

    pika = Pokemon.new(id: array_id, name:array_name, type: array_type, db: db)
    pika.hp = array_of_hashes[0][3]
    pika
  end

  def alter_hp(hp, db)
    sql_string = <<-SQL_STRING
     update pokemon set hp = ? where id = ?
    SQL_STRING
    db.execute(sql_string, hp, self.id)
  end

end
