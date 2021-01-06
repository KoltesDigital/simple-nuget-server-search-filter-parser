const fs = require('fs');
const pegjs = require('pegjs');
const phpegjs = require('phpegjs');

const grammar = fs.readFileSync('grammar.pegjs', 'utf-8');

const parser = pegjs.generate(grammar, {
	phpegjs: {
		mbstringAllowed: false,
		parserClassName: 'SearchFilterParser',
	},
	plugins: [phpegjs],
});

fs.writeFileSync('searchFilterParser.php', parser);
