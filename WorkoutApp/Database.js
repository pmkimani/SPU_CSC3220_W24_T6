function dbInit()
{
    let db = LocalStorage.openDatabaseSync("WorkoutApp", "", "Track exercise", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS liftlist_log (benchIdPointer, squatIdPointer, deadliftIdPointer)')
            tx.executeSql('CREATE TABLE IF NOT EXISTS bench_log (currentWeight,goalWeight, goalReps)')
            tx.executeSql('CREATE TABLE IF NOT EXISTS squat_log (currentWeight,goalWeight, goalReps)')
            tx.executeSql('CREATE TABLE IF NOT EXISTS deadlift_log (currentWeight,goalWeight, goalReps)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("WorkoutApp", "",
                                               "Track exercise", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsertSquat(currentWeight, goalWeight, goalReps)
{
    let db = dbGetHandle()
    let rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO squat_log VALUES(?, ?, ?)',
                      [currentWeight, goalWeight, goalReps])
        let result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

// function dbInsertDeadlift(currentWeight, goalWeight, goalReps)
// {
//     let db = dbGetHandle()
//     let rowid = 0;
//     db.transaction(function (tx) {
//         tx.executeSql('INSERT INTO deadlift_log VALUES(?, ?, ?)',
//                       [currentWeight, goalWeight, goalReps])
//         let result = tx.executeSql('SELECT last_insert_rowid()')
//         rowid = result.insertId
//     })
//     return rowid;
// }

// function dbInsertBench(currentWeight, goalWeight, goalReps)
// {
//     let db = dbGetHandle()
//     let rowid = 0;
//     db.transaction(function (tx) {
//         tx.executeSql('INSERT INTO bench_log VALUES(?, ?, ?)',
//                       [currentWeight, goalWeight, goalReps])
//         let result = tx.executeSql('SELECT last_insert_rowid()')
//         rowid = result.insertId
//     })
//     return rowid;
// }

function dbReadAll()
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        let results = tx.executeSql(
                'SELECT rowid,currentWeight,goalWeight,goalReps FROM squat_log order by rowid desc')
        for (let i = 0; i < results.rows.length; i++) {
            listModel.append({
                                 id: results.rows.item(i).rowid,
                                 checked: " ",
                                 currentWeight: results.rows.item(i).currentWeight,
                                 goalWeight: results.rows.item(i).goalWeight,
                                 goalReps: results.rows.item(i).goalReps
                             })
        }
    })
}

// function dbReadAll()
// {
//     let db = dbGetHandle()
//     db.transaction(function (tx) {
//         let results = tx.executeSql(
//                 'SELECT rowid,currentWeight,goalWeight,goalReps FROM deadlift_log order by rowid desc')
//         for (let i = 0; i < results.rows.length; i++) {
//             listModel.append({
//                                  id: results.rows.item(i).rowid,
//                                  checked: " ",
//                                  currentWeight: results.rows.item(i).currentWeight,
//                                  goalWeight: results.rows.item(i).goalWeight,
//                                  goalReps: results.rows.item(i).goalReps
//                              })
//         }
//     })
// }

// function dbReadAll()
// {
//     let db = dbGetHandle()
//     db.transaction(function (tx) {
//         let results = tx.executeSql(
//                 'SELECT rowid,currentWeight,goalWeight,goalReps FROM bench_log order by rowid desc')
//         for (let i = 0; i < results.rows.length; i++) {
//             listModel.append({
//                                  id: results.rows.item(i).rowid,
//                                  checked: " ",
//                                  currentWeight: results.rows.item(i).currentWeight,
//                                  goalWeight: results.rows.item(i).goalWeight,
//                                  goalReps: results.rows.item(i).goalReps
//                              })
//         }
//     })
// }
