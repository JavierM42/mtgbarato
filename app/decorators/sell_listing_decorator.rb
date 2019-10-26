class SellListingDecorator < ApplicationDecorator
  def thumbnail_uri
    h.image_tag object.card.thumbnail_uri, class: 'w-full'
  end

  def card_info
    h.content_tag('span', "#{object.amount}x", class: 'text-sm text-gray-700 font-bold mr-1') +
    h.link_to(
      "#{object.card.name}",
      "https://deckbox.org/mtg/#{URI.escape(object.card.name)}",
      class: 'text-lg text-orange-600 cursor-pointer'
    ) +
    (object.foil ? h.content_tag('span', 'Foil', class: 'ml-1 text-sm uppercase font-bold tracking-wider') : '') +
    h.content_tag('div',
      object.set_not_confirmed ? "Edición no especificada. Mostrando #{object.card.set_name}" : object.card.set_name,
      class: 'text-xs italic') +
    (object.notes ? h.content_tag('div', object.notes, class: 'text-sm') : '')
  end

  def user_info
    if object.user.email == 'dsfoodandgames@gmail.com'
      h.content_tag('div',
        h.link_to(
          h.image_tag('dragonstone.jpg', class: 'h-12 mr-2'),
          "https://www.facebook.com/Dragonstonefoodygames/", target: "_blank"
        ) +
        h.content_tag('div',
          h.link_to('Dragon Stone', "https://www.facebook.com/Dragonstonefoodygames/", class: 'text-gray-600') +
          h.content_tag('div', object.user.phone, class: 'text-gray-800 italic text-xs')
        ),
      class: 'flex items-center')
    elsif h.current_user == object.user
      h.content_tag('div', 'Yo')
    else
      h.content_tag('div', object.user.full_name, class: 'text-gray-600') +
      h.content_tag('div', object.user.phone, class: 'text-gray-800 italic text-xs')
    end
  end

  def price
    h.content_tag('div',
      h.content_tag('span', 'USD', class: 'text-gray-700 text-sm font-bold') +
      h.content_tag('span', object.price || '?', class: 'text-gray-800 text-xl')
    ) + 
    h.link_to( 
      'Ver detalle de precios en TCG',
      "https://shop.tcgplayer.com/magic/product/show?newSearch=false&IsProductNameExact=false&ProductName=#{object.card.name.gsub(" ", "+")}&orientation=list",
      class: "text-orange-600 hover:text-orange-400 cursor-pointer",
      target: "_blank"
    )
  end
end