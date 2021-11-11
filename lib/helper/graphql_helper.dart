import 'package:graphql/client.dart';

GraphQLClient graphQLClient() {
  final Link _link = HttpLink(
    'https://examplegraphql.herokuapp.com/graphql',
  );

  return GraphQLClient(
    cache: GraphQLCache(),
    link: _link,
  );
}

readStudent() async {
  final GraphQLClient _client = graphQLClient();
  final QueryOptions options = QueryOptions(
    document: gql(
      r'''
        query {
          persons {
          name,
          id,
          name,
          lastName,
          age
        }
      }
      ''',
    ),
  );

  final QueryResult result = await _client.query(options);
  return result;
}

addStudent({id, name, age, lastName}) async {
  final GraphQLClient _client = graphQLClient();
  final MutationOptions options = MutationOptions(
    document: gql(
      """
      mutation{
        addPerson(id: $id, name: "$name", lastName: "$lastName", age: $age) {
          id
          name
          lastName
          age
        }
      }""",
    ),
  );

  final QueryResult result = await _client.mutate(options);
  print(result.data);
  return result;
}

editStudent({id, name, age, lastName}) async {
  final GraphQLClient _client = graphQLClient();
  final MutationOptions options = MutationOptions(
    document: gql(
      """
      mutation{
        editPerson(id: $id, name: "$name", lastName: "$lastName", age: $age) {
          id
          name
          lastName
          age
        }
      }""",
    ),
  );

  final QueryResult result = await _client.mutate(options);
  print(result.data);
  return result;
}

deleteStudent({id}) async {
  final GraphQLClient _client = graphQLClient();
  final MutationOptions options = MutationOptions(
    document: gql(
      """
      mutation{
        deletePerson(id: $id) {
          id
          name
          lastName
          age
        }
      }""",
    ),
  );

  final QueryResult result = await _client.mutate(options);
  print(result.data);
  return result;
}
