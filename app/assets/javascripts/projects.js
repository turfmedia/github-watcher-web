$(function () {

  $("#searches").show();

  $("input[name='tabs']").click(function () {
    $('.content-datas').hide();
    $($(this).data('target')).show();
  });

  var deleteRepo = function (data) {
    var repoId = data['repoId'];
    $.ajax({
      url: "/deleted_results",
      type: "POST",
      dataType: "json",
      data: {
        projectId: data['projectId'],
        repoId: repoId
      },
      success: function (data) {
        $("#repo-"+repoId).remove();
        console.log('success delete repo '+repoId)
      }
    });
  }

  var saveRepo = function (data) {
    var repoId = data['repoId'];
    $.ajax({
      url: "/saved_results",
      type: "POST",
      dataType: "json",
      data: {
        projectId: data['projectId'],
        repoId: repoId
      },
      success: function (data) {
        $("#repo-"+repoId).addClass('selected');
        console.log('success delete repo '+repoId)
      }
    });
  }

  var readMe = function (data) {
    $.ajax({
      url: "/readme",
      type: "GET",
      dataType: "html",
      data: {
        reference: data['reference'],
      },
      success: function (data) {
        $('#readme').replaceWith(data)
      }
    });
  }

  $('.repo_save').click(function () {
    saveRepo($(this).data())
  });

  $('.repo_delete').click(function () {
    deleteRepo($(this).data())
  });

  $('.repo_readme').click(function () {
    readMe($(this).data())
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