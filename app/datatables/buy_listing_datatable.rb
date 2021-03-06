class BuyListingDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      card_name:          { source: "Card.name", cond: :like, searchable: true, orderable: true },
      price:              { source: "BuyListing.price", searchable: false, orderable: true }
    }
  end

  def data
    records.map do |record|
      {
        card_name:      record.decorate.card_info,
        price:          record.decorate.price,
        DT_RowId:       record.id, # This will automagically set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  def get_raw_records
    if params[:user_id]
      BuyListing.includes(:card, :user).references(:card, :user).where(user_id: params[:user_id])
    else
      BuyListing.includes(:card, :user).references(:card, :user).all
    end
  end
end
