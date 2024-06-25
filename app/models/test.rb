class Test < ApplicationRecord
    include AASM

    aasm(:move , column: 'aasm_state') do
        state :starting , initial: true
        state :running 
        state :ending

        event :run do
            transitions from: :starting , to: :running
        end

        event :end do
            transitions from: :running , to: :ending
        end 
    end  

    aasm(:work ) do
        state :initial ,initial:true
        state :working
        state :pending
        state :complete

        event :work do
            transitions from: :initial ,to: :working
        end
        event :pending do
          transitions from: :working ,to: :pending
        end

        event :complete do
          transitions from: :pending , to: :complete
        end
   end
end
