Start
  = expr:Expression
  / _ { return NULL; }

Expression
  = lhs:TermOrFlag _ "and" _ rhs:TermOrFlag { return $lhs . ' AND ' . $rhs; }
  / lhs:Term _ "eq" _ rhs:Term { return $lhs . ' = ' . $rhs; }
  / TermOrFlag

TermOrFlag
  = Term
  / Flag

Term
  = "(" _ expr:Expression _ ")" { return '(' . $expr . ')'; }
  / Value

Value
  = FunctionCall
  / Field
  / StringLiteral

FunctionCall
  = "tolower" _ "(" _ value:Value _ ")" { return 'lower(' . $value . ')'; }

Field
  = "Id" { return 'packages.PackageId'; }

Flag
  = "IsAbsoluteLatestVersion" / "IsLatestVersion" { return 'versions.Version = packages.LatestVersion'; }

StringLiteral
  = '"' chars:DoubleStringCharacter* '"' { return '"' . implode($chars) . '"'; }
  / "'" chars:SingleStringCharacter* "'" { return "'" . implode($chars) . "'"; }

DoubleStringCharacter
  = !('"') char:. { return $char; }

SingleStringCharacter
  = !("'") char:. { return $char; }

_ "whitespace"
  = [ \t\n\r]*
