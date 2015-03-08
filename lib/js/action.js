
/*
action.js | Kchan Zen | git.io/p31F
 */
(function(window, document) {
  var action, closeModal, closeTip, createTip, getModal, keepTip, modalVisible, showModal, showOverlay, showTip;
  action = {};
  modalVisible = false;
  showOverlay = function() {
    var $overlay, $overlayHTML, $overlayWrapper;
    $overlayWrapper = document.createElement('div');
    $overlayWrapper.setAttribute('id', 'modal-overlay');
    $overlayHTML = '<div class="modal-overlay"></div>';
    $overlayWrapper.innerHTML = $overlayHTML;
    document.body.appendChild($overlayWrapper);
    $overlay = document.querySelector('.modal-overlay');
    return setTimeout(function() {
      return $overlay.classList.add('modal-overlay-show');
    }, 200);
  };
  getModal = function(modalName) {
    var $modal;
    return $modal = document.getElementById(modalName);
  };
  showModal = function(modalName) {
    var $modal;
    showOverlay();
    $modal = getModal(modalName);
    $modal.style.display = 'block';
    setTimeout(function() {
      return $modal.classList.add('modal-show');
    }, 200);
    return modalVisible = true;
  };
  closeModal = function(modalName) {
    var $modal, $overlay;
    if (!modalName) {
      modalName = 'modal';
    }
    $modal = getModal(modalName);
    $modal.classList.remove('modal-show');
    $overlay = document.querySelector('.modal-overlay');
    $overlay.classList.remove('modal-overlay-show');
    return setTimeout(function() {
      $modal.style.display = 'none';
      $overlay = document.getElementById('modal-overlay');
      return $overlay.parentNode.removeChild($overlay);
    }, 200);
  };
  createTip = function(message) {
    var $tipWrapper;
    $tipWrapper = document.createElement('div');
    $tipWrapper.setAttribute('id', 'action-tip');
    $tipWrapper.setAttribute('class', 'action-tip');
    $tipWrapper.innerHTML = message;
    document.body.appendChild($tipWrapper);
    return $tipWrapper;
  };
  keepTip = function(t) {
    var $tip;
    clearTimeout(t);
    $tip = document.getElementById('action-tip');
    return $tip.addEventListener('mouseout', function() {
      return t = setTimeout(function() {
        return closeTip();
      }, 1000);
    }, false);
  };
  showTip = function(message) {
    var $tip;
    if (typeof t !== 'undefined') {
      clearTimeout(t);
    }
    $tip = document.getElementById('action-tip');
    if ($tip) {
      $tip.parentNode.removeChild($tip);
    }
    $tip = createTip(message);
    return setTimeout(function() {
      var t;
      $tip.style.marginLeft = '-' + $tip.clientWidth / 2 + 'px';
      $tip.classList.add('action-tip-show');
      t = setTimeout(function() {
        return closeTip();
      }, 4000);
      return $tip.addEventListener('mouseover', function() {
        return keepTip(t);
      }, false);
    }, 300);
  };
  closeTip = function() {
    var $tip;
    $tip = document.getElementById('action-tip');
    if ($tip) {
      $tip.classList.remove('action-tip-show');
    }
    return setTimeout(function() {
      if ($tip) {
        return $tip.parentNode.removeChild($tip);
      }
    }, 300);
  };
  action.showModal = function(modalName) {
    return showModal(modalName);
  };
  action.closeModal = function(modalName) {
    return closeModal(modalName);
  };
  action.showTip = function(message) {
    return showTip(message);
  };
  document.onclick = function(e) {
    var isModal, target;
    target = e.target;
    isModal = target.classList.contains('modal-overlay');
    if (isModal && modalVisible) {
      return closeModal();
    }
  };
  return window.action = action;
})(window, document);
