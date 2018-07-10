$(document).on('ready load mouseenter', function() {
  triggerUserActions();
});

function triggerUserActions() {
  $('#category-status').hide();
  $('#submit-category').hide();

  var typingTimer = null;
  $('#category_name').on('keydown', function() {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(chooseCategoryStatus, 1000);
  });

  $('#category_status').on('change', function() {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(submitCategory, 1000);
  });
};

function chooseCategoryStatus() {
  $('#category-status').show();
};

function submitCategory() {
  $('#submit-category').show();
};
