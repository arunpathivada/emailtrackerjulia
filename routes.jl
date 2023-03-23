using Genie.Router
using Dates
import Pkg;
Pkg.add("SQLite")
using SQLite



db = SQLite.DB("email_tracker.sqlite")

SQLite.execute(db, "CREATE TABLE IF NOT EXISTS openings (email TEXT, time TEXT, pixel_id TEXT)")

route("/pixel/:id") do
    id = params[:id]
    email = "arunpathivada2002@gmail.com"
    time = Dates.now()
    SQLite.execute(db, "INSERT INTO openings (email, time, pixel_id) VALUES (?, ?, ?)", (email, time, id))
    image_path = "/path/to/your/tracking/pixel.png"
    content_type("image/png")
    file(image_path)
end



function count_openings(email::AbstractString)
    result = SQLite.query(db, "SELECT COUNT(*) FROM openings WHERE email=?", (email,))
    return result[1][1]
end



count = count_openings("arunpathivada2002@gmail.com")
print("count",count)





