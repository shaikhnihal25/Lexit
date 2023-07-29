class LexitDocsModel {
  String? artNo;
  String? name;
  String? artDesc;
  List<Clause>? clauses;
  String? status;
  List<Explanation>? explanations;
  String? subHeading;
  String? partNo;
  List<String>? articles;

  LexitDocsModel({
    this.artNo,
    this.name,
    this.artDesc,
    this.clauses,
    this.status,
    this.explanations,
    this.subHeading,
    this.partNo,
    this.articles,
  });
}

class Clause {
  String? clauseNo;
  String? clauseDesc;
  List<SubClause>? subClauses;
  String? followUp;

  Clause({
    this.clauseNo,
    this.clauseDesc,
    this.subClauses,
    this.followUp,
  });
}

class SubClause {
  String? subClauseNo;
  String? subClauseDesc;
  String? status;

  SubClause({
    this.subClauseNo,
    this.subClauseDesc,
    this.status,
  });
}

class Explanation {
  String? explanationNo;
  String? explanation;

  Explanation({
    this.explanationNo,
    this.explanation,
  });
}

List<LexitDocsModel> _fromJsonList(List<dynamic> jsonDataList) {
  return jsonDataList.map((jsonData) => fromJson(jsonData)).toList();
}

List<Clause>? _fromJsonClauseList(List<dynamic>? jsonData) {
  if (jsonData == null) return null;
  return jsonData.map((clause) => _fromJsonClause(clause)).toList();
}

Clause _fromJsonClause(Map<String, dynamic> jsonData) {
  return Clause(
    clauseNo: jsonData['clauseNo'],
    clauseDesc: jsonData['clauseDesc'],
    subClauses: _fromJsonSubClauseList(jsonData['subClauses']),
    followUp: jsonData['followUp'],
  );
}

List<SubClause>? _fromJsonSubClauseList(List<dynamic>? jsonData) {
  if (jsonData == null) return null;
  return jsonData.map((subClause) => _fromJsonSubClause(subClause)).toList();
}

SubClause _fromJsonSubClause(Map<String, dynamic> jsonData) {
  return SubClause(
    subClauseNo: jsonData['subClauseNo'],
    subClauseDesc: jsonData['subClauseDesc'],
    status: jsonData['status'],
  );
}

List<Explanation>? _fromJsonExplanationList(List<dynamic>? jsonData) {
  if (jsonData == null) return null;
  return jsonData
      .map((explanation) => _fromJsonExplanation(explanation))
      .toList();
}

Explanation _fromJsonExplanation(Map<String, dynamic> jsonData) {
  return Explanation(
    explanationNo: jsonData['explanationNo'],
    explanation: jsonData['explanation'],
  );
}

LexitDocsModel fromJson(var jsonData) {
  return LexitDocsModel(
    artNo: jsonData['ArtNo'],
    name: jsonData['name'],
    artDesc: jsonData['artDesc'],
    clauses: _fromJsonClauseList(jsonData['clauses']),
    status: jsonData['status'],
    explanations: _fromJsonExplanationList(jsonData['explanations']),
    subHeading: jsonData['subHeading'],
    partNo: jsonData['partNo'],
    articles: (jsonData['articles'] as List<dynamic>?)
        ?.map((article) => article.toString())
        .toList(),
  );
}
