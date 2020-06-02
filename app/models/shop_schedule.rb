class ShopSchedule < ApplicationRecord
    belongs_to :shop
    
    enum shop_schedule_time_cd: {
        "10:00〜12:00":1,"12:00〜14:00":2,"14:00〜16:00":3,
        "16:00〜18:00":4,"18:00〜20:00":5,"20:00〜22:00":6
    }
end
