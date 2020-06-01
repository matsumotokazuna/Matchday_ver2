class Admin::ShopsController < Admin::Base
    def index
        @shops = Shop.all
    end

    def new
        @shop = Shop.new
    end

    def create
        @shop = Shop.new(shop_params)
        @shop.save
        redirect_to admin_shops_path
    end

    def show
        @shop = Shop.find(params[:id])
    end

    def edit
        @shop = Shop.find(params[:id])       
    end

    def update
        @shop = Shop.find(params[:id])  
        @shop.update(shop_params)
        redirect_to admin_shop_path(@shop.id)
    end

    private
    def shop_params
        params.require(:shop).permit(:shop_name, :postal_code, :prefecture_cd, :city, :building, :shop_image, :invalid_flg)
    end
end
