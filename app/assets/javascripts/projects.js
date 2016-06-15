$(function () {

  $("#searches").show();

  $("input[name='tabs']").click(function () {
    $('.content-data').hide();
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
      url: "/projects/"+ data['projectId'] +"/saved_results",
      type: "POST",
      dataType: "json",
      data: {
        repo_title: data['repoTitle'],
        repo_url: data['repoUrl'],
        repo_description: data['repoDescription'],
        repo_stars: data['repoStars'],
        issues: data['repoIssues'],
        pushed_at: data['repoPushedAt'],
        search_items_id: data['searchItemsId'],
        repo_id: repoId
      },
      success: function (data) {
        for_clone = $("#repo-"+repoId).clone().attr('id', "saved_repo-"+repoId)
        $('.saved-repos').prepend(for_clone)
        $('.noresult').hide()
        $("#repo-"+repoId).addClass('selected');
        console.log('success save repo '+repoId)
      }
    });
  }

  var unsaveRepo = function (data) {
    var repoId = data['repoId'];
    $.ajax({
      url: "/projects/"+ data['projectId'] +"/saved_results/" + repoId,
      type: "DELETE",
      dataType: "json",
      success: function (data) {
        $("#saved_repo-"+repoId).remove()
        $('.noresult').hide()
        if ($('.saved-repo').length == 0) {
          $('.noresult').show()
        }
        $("#repo-"+repoId).removeClass('selected');
        console.log('success unsave repo '+repoId)
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
        $('.read-me:visible').html(data)
      }
    });
  }

  $('.repo_save').click(function (e) {
    if ($(e.target).attr('checked')){
      $(e.target).attr('checked', null)
      unsaveRepo($(this).data())
    }else{
      $(e.target).attr('checked', 'checked')
      saveRepo($(this).data())
    }
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
