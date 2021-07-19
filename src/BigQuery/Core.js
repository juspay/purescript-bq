const bq = require("@google-cloud/bigquery");

exports._createClient = function(projId, keyFileName) {
  return function() {
	  try { return new bq.BigQuery({ projectId : projId, keyFilename : keyFileName }); }
    catch(e) {console.log('Error While creating client', e)};
  };
};

exports._query = function (client, queryOpts) {
  return function(errCB, scCB) {
    client.query(queryOpts)
      .then(function(res) {
        scCB(res);
      })
      .catch(function(err) {
        console.log('Error While querying', err);
        errCB(err);
      });
		return function (cancelError, cancelerError, cancelerSuccess) {
      cancelerError(new Error("Cannot perform cancel"));
		};
	};
};