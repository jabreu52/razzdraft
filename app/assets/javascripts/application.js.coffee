#= require jquery
#= require jquery_ujs
#= require foundation

jQuery ->
	$(document).foundation()

	$('#player_search').on 'keyup', () ->
		query = $('#player_search').val()
		$.ajax({
			url: "/baseball_projections/search",
			data:
				query: query
			})