class BuyListingDecorator < ApplicationDecorator
  def card_info
    h.content_tag('div',
      h.content_tag('div',
        h.content_tag('span', "#{object.amount}x", class: 'text-sm text-gray-700 font-bold mr-1 mb-8') +

        h.link_to(
          "#{object.card.name}",
          "https://shop.tcgplayer.com/magic/product/show?newSearch=false&IsProductNameExact=false&ProductName=#{object.card.name.gsub(" ", "+")}&orientation=list",
        class: 'text-lg text-orange-600 cursor-pointer', target: '_blank') +

        (object.foil ? h.content_tag('span', 'Foil', class: 'ml-1 text-sm uppercase font-bold tracking-wider') : '') +

        h.content_tag('div',
          object.any_set ? "Edición buscada no especificada. Mostrando #{object.card.set_name}" : object.card.set_name,
        class: 'text-xs italic truncate'),
      class: 'flex-1 mb-1 md:mt-4', style: 'min-width: 8rem') +

      h.content_tag('div',
        h.image_tag(object.card.thumbnail_uri, class: 'w-full'),
      class: "card-image w-full md:w-32 mr-4 #{object.foil ? 'foil' : ''}", style: 'max-width: 8rem'),
    class: 'flex flex-wrap flex-row-reverse justify-end')
  end

  def price
    h.content_tag('div',
      h.content_tag('div',
        h.content_tag('span',
          h.content_tag('div',
            h.content_tag('span', 'USD ', class: 'text-gray-700 text-sm font-bold') +
            h.content_tag('span', h.number_with_precision(object.price, precision: 2) || '?', class: 'text-gray-800 text-xl')
          ) +
          (
            object.discount != 0 ?
            h.content_tag('div', object.foil ? object.card.foil_price : object.card.price, class: 'text-sm text-gray-500 text-right line-through -mt-1')
            :
            ''
          ),
        class: 'inline-block'),
      ) +

      (object.notes ? h.content_tag('div', object.notes, class: 'text-sm') : '') +


      h.content_tag('div',
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
          h.link_to(
            object.user.full_name,
            h.user_path(object.user.pretty_id),
            class: 'text-orange-500'
          ) +
          h.content_tag('div', object.user.phone, class: 'text-gray-800 italic text-xs')
        end,
      class: 'mt-8'),
    )
  end
end
