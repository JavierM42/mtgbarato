class BuyListingDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      card_thumbnail_uri: { source: "Card.thumbnail_uri", searchable: false, orderable: true },
      card_name:          { source: "Card.name", cond: :like, searchable: true, orderable: true },
      set_name:           { source: "Card.set_name", cond: :like, searchable: true, orderable: true },
      price:              { source: "BuyListing.price", searchable: false, orderable: true },
      discount:           { source: "BuyListing.discount", searchable: false, orderable: true },
      user:               { source: "BuyListing.user_id", searchable: false, orderable: true}
    }
  end

  def data
    records.map do |record|
      {
        thumbnail_uri:  record.decorate.thumbnail_uri,
        card_name:      record.decorate.card_info,
        price:          record.decorate.price,
        discount:       record.decorate.discount,
        user:           record.decorate.user_info,
        DT_RowId:       record.id, # This will automagically set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  def get_raw_records
    BuyListing.includes(:card, :user).references(:card, :user).all
  end
end
