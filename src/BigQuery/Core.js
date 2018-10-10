const BQ = require("@google-cloud/bigquery");

exports._createClient = function(projId) {
  return function(keyFileName) {
    return function() {
      return new BQ({ projectId : projId, keyFilename : keyFileName });
    };
  };
};

exports._query = function(errCB, scCB, client, queryOpts) {
  return function() {
    return client.query(queryOpts)
      .then(function(res) {
         scCB(res)();
      })
      .catch(function(err) {
        errCB(err)();
      });
  };
};
