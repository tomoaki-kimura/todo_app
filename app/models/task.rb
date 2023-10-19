class Task < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, allow_blank: true, length: { minimum: 3, maximum: 500 }
  validates :start_time, presence: true
  validate :start_time_is_now_or_later
  validate :end_time_is_one_day_after_the_start_time

  enum status: { not_started: 0, in_progress: 1, closed: 2 }

  private

  def start_time_is_now_or_later
    if start_time.beginning_of_day < Time.current.beginning_of_day
      errors.add(:start_time, "は本日以降にしか設定できません")
    end
  end

  def end_time_is_one_day_after_the_start_time
    if end_time.present? && end_time < start_time.tomorrow.beginning_of_day
      errors.add(:end_time, "は#{I18n.t 'activerecord.attributes.task.start_time'}の翌日以降からしか設定できません")
    end
  end
end
