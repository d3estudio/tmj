#= require 'jquery'
#= require 'jquery-ujs'

API_URL = 'http://' + window.location.hostname + ':3000'

$('.remix-container').each ->
  $remix = $(this)
  $composer = $remix.find('.remix-composing')

  $remix.on
    'reset': ->
      # removes all states
      $remix.removeClass('can-choose-picture can-compose can-publish can-share')

      # goes back to category tool selection
      $composer
        .find('.toolbox .toolbox-item').removeClass('on')
        .filter('.category').addClass('on')

      # removes all elements from artboard and display empty message
      $composer.find('.artboard .canvas *').remove()
      $composer.find('.artboard .empty').show()

    # initialize state: can select a category of pictures
    'init': ->
      $(this).trigger('reset').addClass('initial')

    # choose state: can choose a picture to background elements
    'choose-picture': ->
      $(this).addClass('can-choose-picture')

    # compose state: can compose elements above the chosen picture
    'compose': ->
      $composer.find('.toolbox .toolbox-item').removeClass('on')
      $(this).removeClass('can-choose-picture').addClass('can-compose')

    # publish state: can publish the composed image to the site and generate an image
    'publish': ->
      $(this).removeClass('can-compose').addClass('can-publish')

    # share state: can share the generated image to networks
    'share': ->
      $(this).removeClass('can-compose can-publish').addClass('can-share')
      # todo: save image

    # finish state
    'finish': ->
      $(this).trigger('reset').removeClass('initial')

    # sets picture element to the artboard and hides empty message
    'set-picture': (event, src) ->
      $picture = $composer.find('.artboard .canvas .picture')

      if !$picture.length
        $picture = $('<img>')
        $composer.find('.artboard .canvas').append $picture

      $picture.attr
        src: src
        alt: ''
        class: 'picture'

      $composer.find('.artboard .empty').hide()

  $remix.find('.remix-landing .new').click ->
    $remix.trigger 'init'

  $composer.find('.cancel').click ->
    $remix.trigger 'finish'

  $composer.find('.top-actions .next').click ->
    $remix.trigger 'publish'

  $composer.find('.publish').click ->
    $remix.trigger 'share'

  $composer.find('.top-actions .skip-share').click ->
    $remix.trigger 'finish'

  $composer.find('.toolbox .categories > div').click ->
    $(this).closest('.toolbox-item')

    # todo: check take-photo class
    $remix.trigger 'choose-picture'

  $composer.find('.toolbox .pictures .go-back').click ->
    $remix.trigger 'init'

  $composer.find('.toolbox .pictures > div[data-picture-src]').click ->
    $remix.trigger 'set-picture', $(this).data('picture-src')
    $remix.trigger 'compose'

  # toggles between tools
  $composer.find('.toolbox .toggler').click ->
    if $remix.hasClass('can-compose')
      $(this).closest('.toolbox-item').toggleClass('on').siblings().removeClass('on')
      $remix.removeClass('can-choose-picture')
