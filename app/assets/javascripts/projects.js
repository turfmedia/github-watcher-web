$(function () {

  $("#searches").show();

  $("input[name='tabs']").click(function () {
    $('.content-datas').hide();
    $($(this).data('target')).show();
  });

  $('.caches_search').click(function () {
    var $obj = $(this);
    $.ajax({
      url: "#{saved_results_path}",
      type: "POST",
      dataType: "json",
      data: {
        caches_search_ids: $(this).data('caches-search-ids'),
        checked: $(this).prop('checked'),
        search_items_id: $(this).data('search-items-id')
      },
      success: function (data) {
        $($obj.data("target")).addClass('choose-cache')
        console.log('Ajax success!!')
        location.reload();
      }
    });
  });

  $('.caches_search_delete').click(function () {
    var $obj = $(this);
    $.ajax({
      url: "#{deleted_results_path}",
      type: "POST",
      dataType: "json",
      data: {
        caches_search_ids: $(this).data('caches-search-ids'),
        search_items_id: $(this).data('search-items-id')
      },
      success: function (data) {
        console.log('Ajax success!!')
        $($obj.data("target")).remove();
        location.reload();
      },
      error: function () {
        console.log('Ajax error!!')
      }
    });
  });

  $('.click-caches-search, .click-caches-search-saved, .click-caches-search-deleted').click(function () {
    var cache = $(this).data('caches-search');
    var linkId = $(this).data('link');
    var nameCache = $(this).data('cache');

    var cache_name = 'README FROM ' + $(this).data('caches-name').toUpperCase()
    $.ajax({
      url: "#{show_readme_path}",
      type: "GET",
      dataType: "json",
      data: { cache_href: cache },
      success: function (data) {
        $('#' + linkId).attr('href', data.readme_url);
        $('#' + nameCache).html(cache_name);
      },
      error: function () {
        console.log('Ajax error!!')
      }
    });
  });
});