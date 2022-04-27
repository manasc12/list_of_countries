import 'package:graphql/client.dart';

const _baseURL = "https://countries.trevorblades.com/";

final _httpLink = HttpLink(
  _baseURL,
);

final GraphQLClient client = GraphQLClient(
  link: _httpLink,
  cache: GraphQLCache(),
);

const getAllCountries = r'''
query {
  countries{
    code
    name
    }
  }
''';
const getCountry = r'''
query getCountry($code:ID!){
  country(code:$code){
  	code
    name
  	native
 	 	phone
  	continent{
    	code
  		name}
    capital
    currency
  	languages{code
    name
    native
    rtl
    }
    emoji
  	emojiU
  }
}
''';
enum Status { waiting, success, failure, initialized }
