$(function () {

  $("#searches").show();

  $("input[name='tabs']").click(function () {
    $('.content-data').hide();
    $($(this).data('target')).show();
  });

  var deleteRepo = function (data) {
    var repoId = data['repoId'];
    $.ajax({
      url: "/projects/"+ data['projectId'] + "/deleted_results",
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
        for_clone = $("#repo-"+repoId).clone()
        for_clone.attr('id', "deleted_repo-"+repoId)
        for_clone.find('.repo_delete').removeClass('repo_delete').addClass('repo_restore')
        for_clone.find('.fa-trash').removeClass('fa-trash').addClass('fa-reply')
        for_clone.find('.repo_save').remove()
        $('.deleted-repos').prepend(for_clone)
        $('.noresult-deleted').hide()
        $("#repo-"+repoId).remove();
        initHandlers()
        console.log('success delete repo '+repoId)
      }
    });
  }

  var restoreRepo = function (data) {
    var repoId = data['repoId'];
    var searchId = data['searchItemsId']
    $.ajax({
      url: "/projects/"+ data['projectId'] +"/deleted_results/" + repoId,
      type: "DELETE",
      dataType: "json",
      success: function (data) {
        if ($('.searched-repos').data('searchId') == searchId) {
          for_clone = $("#deleted_repo-"+repoId).clone()
          for_clone.attr('id', "repo-"+repoId)
          for_clone.find('.repo_restore').removeClass('repo_restore').addClass('repo_delete')
          for_clone.find('.fa-reply').removeClass('fa-reply').addClass('fa-trash')
          for_clone.find('.link .inner-report').append('<input type="checkbox" name="repo_ids" id="repo_ids" value="'+repoId+'" style="position: absolute;right: 5px;" class="repo_save">')
          $('.searched-repos').prepend(for_clone)
        }
        $("#deleted_repo-"+repoId).remove()
        $('.noresult-deleted').hide()
        if ($('.deleted-repos .repo').length == 0) {
          $('.noresult-deleted').show()
        }
        $("#repo-"+repoId).find('.fa-trash').css({color: ''})
        $("#repo-"+repoId).find('.fa-trash').attr('title', "")
        $("#repo-"+repoId).removeClass('selected');
        initHandlers()
        console.log('success unsave repo '+repoId)
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
        for_clone.find('.fa-trash').remove()
        $('.saved-repos').prepend(for_clone)
        $('.noresult-saved').hide()
        $("#repo-"+repoId).addClass('selected');
        $("#repo-"+repoId).find('.fa-trash').css({color: 'grey'})
        $("#repo-"+repoId).find('.fa-trash').attr('title', "Can't delete saved repo")
        initHandlers()
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
        $('.noresult-saved').hide()
        if ($('.saved-repos .repo').length == 0) {
          $('.noresult-saved').show()
        }
        $("#repo-"+repoId).find('.repo_save').attr('checked', null)
        $("#repo-"+repoId).find('.fa-trash').css({color: ''})
        $("#repo-"+repoId).find('.fa-trash').attr('title', "")
        $("#repo-"+repoId).removeClass('selected');
        initHandlers()
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

  var initHandlers = function () {
    $('.repo_save, .repo_readme, .repo_restore, .repo_delete, .click-caches-search, .click-caches-search-saved, .click-caches-search-deleted').off('click')

    $('.repo_save').click(function (e) {
      if ($(e.target).attr('checked')){
        $(e.target).attr('checked', null)
        unsaveRepo($(this).closest('.repo').data())
      }else{
        $(e.target).attr('checked', 'checked')
        saveRepo($(this).closest('.repo').data())
      }
    });

    $('.repo_delete').click(function () {
      if ($(this).closest('.repo').find('.repo_save').attr('checked') == 'checked'){
        return false
      }
      deleteRepo($(this).closest('.repo').data())
    });

    $('.repo_restore').click(function () {
      restoreRepo($(this).closest('.repo').data())
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
  }
  initHandlers()
});
