class GoodsController < ApplicationController
  def search  
    
    if params[:keyword]
      items = SearchForm.new(keyword: params[:keyword])

      if items.valid?
        #.search()の中に上でitemsに格納したkeywordをitems.keywordで出してあげます。
        @items = RakutenWebService::Ichiba::Item.search(keyword: items.keyword)
      else
        #validationにかかった場合の処理
        flash[:danger] = "検索キーワードが空欄です。
        キーワードを入力して検索してください。"
        redirect_to goods_search_path    #任意のパス
      end
    end
  end
end