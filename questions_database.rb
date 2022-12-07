

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

    def authored_questions
        Questions.find_by_author_id(self.id)
    end

    def authored_replies
        Replies.find_by_user_id(self.id)
    end

end

class Questions

    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM questions WHERE id = '#{id}'")
        data.map {|datum| Questions.new(datum)}
    end

    def find_by_author_id(author_id)
        data = QuestionsConnection.instance.execute("SELECT * FROM questions WHERE author_id = '#{author_id}'") 
        data.map {|datum| Questions.new(datum)}
        # data = QuestionsConnection.instance.execute(<<-SQL, author_id)
        #     SELECT
        #         *
        #     FROM
        #         questions
        #     WHERE
        #         id = ?
        # SQL
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options ['author_id']
    end

    def author
        Users.find_by_id(@author_id)
    end

    def replies
        Replies.find_by_question_id(@id)
    end

end

class QuestionFollows

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM question_follows WHERE id = '#{id}'")
        data.map {|datum| QuestionFollows.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @author_id = options['author_id']
        @question_id = options['question_id']
    end

end

class Replies

    attr_accessor :question_id, :id, :parent_reply_id, :reply_user_id, :body

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM replies WHERE id = '#{id}'")
        data.map {|datum| Replies.new(datum)}
    end

    def self.find_by_user_id(user_id)
        data = QuestionsConnection.instance.execute("SELECT * FROM replies WHERE user_id = '#{user_id}'")
        data.map {|datum| Replies.new(datum)}
    end

    def self.find_by_question_id(question_id)
        data = QuestionsConnection.instance.execute("SELECT * FROM replies WHERE question_id = '#{question_id}'")
        data.map {|datum| Replies.new(datum)}
    end


    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @reply_user_id = options['reply_user_id']
        @body = options['body']
    end

    def author
        Users.find_by_id(<<-SQL)
            SELECT
                id
            FROM
                users
            JOIN 
                questions ON questions.author_id = users.id
            WHERE
                questions.id = #{@question_id}
        SQL
    end

    def question
        Questions.find_by_question_id(@question_id)
    end

    def parent_reply
        Users.find_by_id(@parent_reply_id)
    end

    def child_replies
        Users.find_by_id(@reply_user_id)
    end

end

class QuestionLikes

    def self.find_by_id(id)
        data = QuestionsConnection.instance.execute("SELECT * FROM question_likes WHERE id = '#{id}'")
        data.map {|datum| QuestionsLikes.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @like_user_id = options['like_user_id']
        @question_id = options['question_id']
    end

end
