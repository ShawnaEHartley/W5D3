

class QuestionsConnection < SQLite3::Database
    include Singleton
  
    def initialize
      super('questions.db')
      self.type_translation = true
      self.results_as_hash = true
    end
  end

  # SQL.execute returns an array of hashes

class Users
    attr_accessor :id, :fname, :lname

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM users WHERE id = '#{id}'")
        data.map {|datum| Users.new(datum)}
    end

    def self.find_by_name(fname, lname)
        data = QuestionsConnection.instance.execute("SELECT * FROM users WHERE fname = '#{fname}' AND lname = '#{lname}'")
        data.map {|datum| Users.new(datum)}
    end


    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end


end

class Questions

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM questions WHERE id = '#{id}'")
        data.map {|datum| Questions.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end

class QuestionFollows

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM question_follows WHERE id = '#{id}'")
        data.map {|datum| QuestionFollows.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end

class Replies

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM replies WHERE id = '#{id}'")
        data.map {|datum| Replies.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end

class QuestionLikes

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM question_likes WHERE id = '#{id}'")
        data.map {|datum| QuestionsLikes.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end
