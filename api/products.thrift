// -------------------------------------------------------------------------
//                     The CodeChecker Infrastructure
//   This file is distributed under the University of Illinois Open Source
//   License. See LICENSE.TXT for details.
// -------------------------------------------------------------------------

include "shared.thrift"

namespace py ProductManagement
namespace js codeCheckerProductManagement


/*
struct PrivilegeRecord {
  1: string   name,
  2: bool     isGroup
}
typedef list<PrivilegeRecord> PrivilegeRecords
*/

struct DatabaseConnection {
  1:          string engine,
  2:          string host,
  3:          i32    port,
  4:          string username_b64,
  5: optional string password_b64,   // Database password is NOT sent server->client!
  6:          string database        // SQLite: Database file path; PostgreSQL: Database name
}

/* ProductConfiguration carries administrative data regarding product settings */
struct ProductConfiguration {
  1:          i64                id,
  2:          string             endpoint,
  3:          string             displayedName,
  4:          string             description,
  5: optional DatabaseConnection connection
}
typedef list<ProductConfiguration> ProductConfigurations

/* Product carries data to the end user's product list and tasks */
struct Product {
  1: i64    id,
  2: string endpoint,
  3: string displayedName,
  4: string description,
  5: bool   connected,      // Indicates that the server could set up the database connection properly.
  6: bool   accessible      // Indicates whether the current user can access this product.
}
typedef list<Product> Products

service codeCheckerProductService {

  // *** Handling the add-modify-remove of products registered *** //
  Products getProducts()
                       throws (1: shared.RequestFailed requestError),

  bool addProduct(1: Product product)
                  throws (1: shared.RequestFailed requestError),

  bool removeProduct(1: i64 productId)
                     throws (1: shared.RequestFailed requestError)

}