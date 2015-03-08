###
action.js | Kchan Zen | git.io/p31F
###

((window, document) ->

  action = {}
  modalVisible = false

  showOverlay = ->
    $overlayWrapper = document.createElement 'div'
    $overlayWrapper.setAttribute 'id', 'modal-overlay'
    $overlayHTML = '<div class="modal-overlay"></div>'
    $overlayWrapper.innerHTML = $overlayHTML
    document.body.appendChild $overlayWrapper
    $overlay = document.querySelector '.modal-overlay'
    setTimeout(->
      $overlay.classList.add 'modal-overlay-show'
    ,200)

  getModal = (modalName) ->
    $modal = document.getElementById modalName

  showModal = (modalName) ->
    showOverlay()
    $modal = getModal modalName
    $modal.style.display = 'block'
    setTimeout(->
      $modal.classList.add 'modal-show'
    ,200)
    
    modalVisible = true

  closeModal = (modalName) ->
    modalName = 'modal' if not modalName
    $modal = getModal modalName
    $modal.classList.remove 'modal-show'
    $overlay = document.querySelector '.modal-overlay'
    $overlay.classList.remove 'modal-overlay-show'
    setTimeout( ->
      $modal.style.display = 'none'
      $overlay = document.getElementById 'modal-overlay'
      $overlay.parentNode.removeChild $overlay
    ,200)

  createTip = (message) ->
    $tipWrapper = document.createElement 'div'
    $tipWrapper.setAttribute 'id', 'action-tip'
    $tipWrapper.setAttribute 'class', 'action-tip'
    $tipWrapper.innerHTML = message
    document.body.appendChild $tipWrapper
    $tipWrapper

  keepTip = (t) ->
    clearTimeout t 
    $tip = document.getElementById 'action-tip'
    $tip.addEventListener 'mouseout', -> 
      t = setTimeout( ->
          closeTip()
      ,1000)
    , false

  showTip = (message) ->
    clearTimeout t if typeof t isnt 'undefined'
    $tip = document.getElementById 'action-tip'
    $tip.parentNode.removeChild($tip) if $tip
    $tip = createTip message
    setTimeout( ->
      $tip.style.marginLeft = '-' + $tip.clientWidth / 2 + 'px'
      $tip.classList.add 'action-tip-show'
      
      t = setTimeout( ->
          closeTip()
      ,4000)

      $tip.addEventListener 'mouseover', -> 
        keepTip(t)
      , false
    ,300)

  closeTip = ->
    $tip = document.getElementById 'action-tip'
    $tip.classList.remove 'action-tip-show' if $tip
    setTimeout( ->
      $tip.parentNode.removeChild($tip) if $tip
    ,300)

  action.showModal = (modalName) ->
    showModal modalName

  action.closeModal = (modalName) ->
    closeModal modalName

  action.showTip = (message) ->
    showTip message

  document.onclick = (e) ->
    target = e.target
    isModal = target.classList.contains 'modal-overlay'
    closeModal() if isModal and modalVisible



  window.action = action

) window, document