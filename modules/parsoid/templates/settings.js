"use strict";

exports.setup = function( parsoidConfig ) {
	// Wiki end points - Miraheze domains only
<% @wikis.each do |wiki| -%>
	parsoidConfig.setInterwiki( '<%= wiki %>wiki', 'https://<%= wiki %>.miraheze.org/w/api.php' );
<% end -%>

	// Wiki end points - Custom domains only
	parsoidConfig.setInterwiki( 'allthetropeswiki', 'https://allthetropes.org/w/api.php' );
	parsoidConfig.setInterwiki( 'boulderwikiwiki', 'https://boulderwiki.org/w/api.php' );
	parsoidConfig.setInterwiki( 'permanentfuturelabwiki', 'https://permanentfuturelab.wiki/w/api.php');
	parsoidConfig.setInterwiki( 'spiralwiki', 'https://spiral.wiki/w/api.php' );

	// Don't load WMF wikis
	parsoidConfig.loadWMF = false;
	parsoidConfig.defaultWiki = 'metawiki';

	// Enable debug mode (prints extra debugging messages)
	parsoidConfig.debug = false;

	parsoidConfig.usePHPPreProcessor = true;

	// Use selective serialization (default false)
	parsoidConfig.useSelser = true;
};
