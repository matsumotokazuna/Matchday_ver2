class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :activities, dependent: :destroy
  has_many :user_schedules, dependent: :destroy
  
  attachment :user_image
  
  enum gender_cd: {
    男性:1,女性:2
  }
  enum prefecture_cd: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }
  enum job_cd: {
    営業職:1,経理:2,企画・管理:3,事務・アシスタント:4,販売・サービス職:5,専門職（コンサルや監査法人など）:6,
    金融系専門職:7,公務員・教員・農林水産関連職:8,技術職:9,医療系専門職:10,クリエイター・クリエイティブ職:11
  }
  enum height_cd: {
    "130":1,"131":2,"132":3,"133":4,"134":5,"135":6,"136":7,"137":8,"138":9,"139":10,"140":11,"141":12,"142":13,
    "143":14,"144":15,"145":16,"146":17,"147":18,"148":19,"149":20,"150":21,"151":22,"152":23,"153":24,"154":25,
    "155":26,"156":27,"157":28,"158":29,"159":30,"160":31,"161":32,"162":33,"163":34,"164":35,"165":36,"166":37,
    "167":38,"168":39,"169":40,"170":41,"171":42,"172":43,"173":44,"174":45,"175":46,"176":47,"177":48,"178":49,
    "179":50,"180":51,"181":52,"182":53,"183":54,"184":55,"185":56,"186":57,"187":58,"188":59,"189":60,"190":61,
    "191":62,"192":63,"193":64,"194":65,"195":66,"196":67,"197":68,"198":69,"199":70,"200":71
  }
  enum income_cd: {
    "200万円未満":1,"200万円以上〜400万円未満":2,"400万円以上〜600万円未満":3,"600万円以上〜800万円未満":4,"800万円以上〜1000万円未満":5,
    "800万円以上〜1000万円未満":6,"1000万円以上〜1500万円未満":7,"1500万円以上〜2000万円未満":8,"1500万円以上〜2000万円未満":9,
    "2000万円以上〜3000万円未満":10,"3000万円以上":11
  }
  enum marriage_history_cd: {
    未婚:1,離婚:2,離婚（死別）:3
  }
  enum marriage_purpose_cd: {
    すぐにでもしたい:1,"2〜3年のうちに":2,良い人がいればしたい:3,今のところ結婚は考えていない:4,わからない:5
  }
  enum housemate_cd: {
    一人暮らし:1,友達と一緒:2,実家暮らし:3,その他:4
  }
  enum holiday_cd: {
    土日:1,平日:2,不定期:3
  }
  enum alcohol_cd: {
    飲まない:1,飲む:2,ときどき飲む:3
  }
  enum cigaret_cd: {
    吸わない:1,吸う:2,ときどき吸う:3,非喫煙者の前では吸わない:4,相手が嫌ならやめる:5,電子たばこを吸う:6
  }

  def self.search(prefecture_cd,search_min_age,search_max_age)
      min_age = Date.today.strftime("%Y%m%d").to_i - search_min_age.to_i * 10000
      max_age = Date.today.strftime("%Y%m%d").to_i - search_max_age.to_i * 10000
      if prefecture_cd == ""
        User.where( birth_date: "#{max_age}".."#{min_age}" )
      else
        User.where( prefecture_cd: "#{prefecture_cd}", birth_date: "#{max_age}".."#{min_age}" )
      end
  end

  def active_for_authentication?
    super && (self.disabled_at == nil )
  end
  
  def self.opposite(gender)
    if gender == "男性"
      User.where(gender_cd: "女性", disabled_at: nil)
    else
      User.where(gender_cd: "男性", disabled_at: nil)
    end
  end

end
