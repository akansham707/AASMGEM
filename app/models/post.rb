class Post < ApplicationRecord
    include AASM

    aasm whiny_transitions: false do
        state :draft, initial: true, display: 'First State '  #( post.aasm.human_state)
        state :published ,before_enter: :do_something
        state :archived
        after_all_transitions :enter_message
    
        event :publish, persistence: true do
          transitions from: :draft, to: :published, guard: [:has_body?]
        end
    
        event :archive do
          transitions from: [:draft, :published], to: :archived
        end
    end
    # enum status: { draft: 0, published: 1, archived: 2 }
    validates :text, :body, presence: true


    private 

    def has_text?
      !self.text.nil? && !self.text.empty?
    end

    def has_body?
        !self.body.nil? && !self.body.empty?
    end 
    
    def do_something
       puts "Message"
    end

    def enter_message
      puts "Enter Message"
    end
end


# aasm  whiny_transitions: false do  by using this line if exception is raise then it return false instead of throwing any exception because we already publish the event and we want to try again to publish the event it throw an error so by using whiny_transitions we handle this 


# what is difference between sleep and sleep!

# sleep: Attempts the transition, returns true if successful, false otherwise.
# sleep!: Forces the transition, raises an AASM::InvalidTransition exception if it fails.

# p.aasm.fire!(:publish) saved
# p.aasm.fire(:publish) not saved 

# aasm no_direct_assignment: true do  by using this we avoid direct assign the value in current_state it throw an error if you do this 

# timestamp: true we use the time stamp true so when we assign the value then it save the time and 
# also provide the attribute with the name of the state is _at so we can check the time when we change the state 