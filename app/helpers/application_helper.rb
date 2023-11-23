module ApplicationHelper
    def reder_if(condition, record)
        if condition
            render record
        end
    end
end
