module ApplicationHelper
    # 生年月日から年齢を計算
    def get_age(birth_date)
        (Date.today.strftime("%Y%m%d").to_i - birth_date.strftime("%Y%m%d").to_i) / 10000
    end
end
