class Event < ApplicationRecord
    validates :tracker_type, presence: true
    validates :summary, presence: true
    validates :date, presence: true, timeliness: { type: :date }
    validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :external_identifier, presence: true
end