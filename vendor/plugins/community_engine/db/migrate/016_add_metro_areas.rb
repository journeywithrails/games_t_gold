class AddMetroAreas < ActiveRecord::Migration
  def self.up
    failed = []
    ["Abilene, TX",
    "Akron, OH",
    "Albany, NY",
    "Albuquerque, NM",
    "Alexandria, LA",
    "Allentown, PA",
    "Amarillo, TX",
    "Anchorage, AK",
    "Ann Arbor, MI",
    "Appleton, WI",
    "Asheville, NC",
    "Athens, GA",
    "Atlanta, GA",
    "Auburn / Lewiston, ME",
    "Augusta, GA",
    "Austin, TX",
    "Bakersfield, CA",
    "Baltimore, MD",
    "Bangor, ME",
    "Baton Rouge, LA",
    "Beaumont, TX",
    "Bellevue, WA",
    "Bellingham, WA",
    "Bend, OR",
    "Billings, MT",
    "Binghamton, NY",
    "Birmingham, AL",
    "Bismarck, ND",
    "Bloomington, IN",
    "Boise, ID",
    "Boston, MA",
    "Boulder, CO",
    "Bowling Green, KY",
    "Bozeman, MT",
    "Bridgeport / Stamford, CT",
    "Buffalo, NY",
    "Burlington, VT",
    "Cape Cod, MA, Cataumet",
    "Cape Coral / Fort Myers, FL",
    "Carson City, NV",
    "Casper, WY",
    "Cedar Rapids, IA",
    "Central Alaska, AK, Fairbanks",
    "Central Coast, CA, Watsonville",
    "Central Jersey, NJ, Pennsauken",
    "Charleston, SC",
    "Charleston, WV",
    "Charlotte, NC",
    "Charlottesville, VA",
    "Chattanooga, TN",
    "Cheyenne, WY",
    "Chicago, IL",
    "Chico, CA",
    "Cincinnati, OH",
    "Cleveland, OH",
    "College Station, TX",
    "Colorado Springs, CO",
    "Columbia, SC",
    "Columbus, OH",
    "Concord, NH",
    "Corpus Christi, TX",
    "Corvallis, OR",
    "Dallas / Fort Worth, TX",
    "Davenport, IA",
    "Dayton, OH",
    "Daytona Beach, FL",
    "Denver, CO",
    "Des Moines, IA",
    "Detroit, MI",
    "Dothan, AL",
    "Dover, DE",
    "Duluth, MN",
    "East Bay, CA, Richmond",
    "East Lansing, MI",
    "Eastern Idaho, ID, Idaho Falls",
    "Eau Claire, WI",
    "El Paso, TX",
    "Erie, PA",
    "Eugene, OR",
    "Evansville, IN",
    "Fargo, ND",
    "Farmington, NM",
    "Fayetteville, AR",
    "Fayetteville, NC",
    "Flint, MI",
    "Florence, SC",
    "Fort Lauderdale, FL",
    "Fort Smith, AR",
    "Fort Wayne, IN",
    "Fresno, CA",
    "Gainesville, FL",
    "Grand Forks, ND",
    "Grand Rapids, MI",
    "Great Falls, MT",
    "Green Bay, WI",
    "Greensboro, NC",
    "Greenville, NC",
    "Greenville, SC",
    "Gulfport / Biloxi, MS",
    "Harrisburg, PA",
    "Hartford, CT",
    "Hattiesburg, MS",
    "Hawaii, HI, Honolulu",
    "Hoboken / Jersey City, NJ",
    "Houston, TX",
    "Huntington, WV",
    "Huntsville / Decatur, AL",
    "Indianapolis, IN",
    "Inland Empire, CA, Ontario",
    "Ithaca, NY",
    "Jackson, MS",
    "Jacksonville, FL",
    "Jefferson City / Columbia, MO",
    "Jersey Shore, NJ, Seaside Heights",
    "Jonesboro, AR",
    "Juneau, AK",
    "Kalamazoo / Battle Creek, MI",
    "Kansas City, MO",
    "Kearney, NE",
    "Kingsport, TN",
    "Knoxville, TN",
    "La Crosse, WI",
    "Lafayette, IN",
    "Lafayette, LA",
    "Lake Charles, LA",
    "Lancaster, PA",
    "Laredo, TX",
    "Las Cruces, NM",
    "Las Vegas, NV",
    "Lawton, OK",
    "Lexington, KY",
    "Lima, OH",
    "Lincoln, NE",
    "Little Rock, AR",
    "Logan, UT",
    "Longview / Tyler, TX",
    "Los Angeles, CA",
    "Louisville, KY",
    "Lowell, MA",
    "Lubbock, TX",
    "Lynchburg, VA",
    "Macon / Warner Robins, GA",
    "Madison, WI",
    "Manchester, NH",
    "Mansfield, OH",
    "Medford, OR",
    "Memphis, TN",
    "Miami, FL",
    "Midland / Odessa, TX",
    "Milwaukee, WI",
    "Minneapolis / St. Paul, MN",
    "Missoula, MT",
    "Mobile, AL",
    "Monroe, LA",
    "Monterey Bay, CA, Monterey",
    "Montgomery, AL",
    "Morgantown, WV",
    "Myrtle Beach, SC",
    "Naples, FL",
    "Nashville, TN",
    "Nassau County, NY, Mineola",
    "New Haven, CT",
    "New Orleans, LA",
    "New York, NY",
    "Newark, NJ",
    "Newport, RI",
    "North Jersey, NJ, Hackensack",
    "North Platte, NE",
    "Northern Arizona, AZ, Flagstaff",
    "Northern Colorado, CO, Greeley",
    "Northern Indiana, IN, Syracuse",
    "Ocala, FL",
    "Ogden, UT",
    "Oklahoma City, OK",
    "Olympia, WA",
    "Omaha, NE",
    "Orange County, CA, Anaheim",
    "Orlando, FL",
    "Oshkosh, WI",
    "Panama City, FL",
    "Parkersburg, WV",
    "Peoria, IL",
    "Philadelphia, PA",
    "Phoenix, AZ",
    "Pierre, SD",
    "Pittsburgh, PA",
    "Portland, ME",
    "Portland, OR",
    "Poughkeepsie, NY",
    "Providence, RI",
    "Provo, UT",
    "Raleigh / Durham, NC",
    "Rapid City, SD",
    "Reading, PA",
    "Redding, CA",
    "Reno, NV",
    "Richmond, VA",
    "Rio Grande Valley, TX, Harlingen",
    "Roanoke, VA",
    "Rochester, NY",
    "Rockford, IL",
    "Sacramento, CA",
    "Saginaw / Bay City, MI",
    "Salem, OR",
    "Salisbury, MD",
    "Salt Lake City, UT",
    "San Angelo, TX",
    "San Antonio, TX",
    "San Diego, CA",
    "San Francisco, CA",
    "Santa Barbara, CA",
    "Santa Cruz, CA",
    "Santa Fe, NM",
    "Sarasota, FL",
    "Savannah, GA",
    "Scottsbluff, NE",
    "Scranton, PA",
    "Seattle, WA",
    "Sheboygan, WI",
    "Shreveport, LA",
    "Silicon Valley, CA, San Jose",
    "Sioux City, IA",
    "Sioux Falls, SD",
    "Sonoma / Napa, CA",
    "South Jersey, NJ, Collingswood",
    "Southern Georgia, GA, Mount Vernon",
    "Spokane, WA",
    "Springfield, MA",
    "Springfield, MO",
    "Saint Cloud, MN",
    "Saint George, UT",
    "Saint Louis, MO",
    "State College, PA",
    "Stockton / Modesto, CA",
    "Suffolk County, NY, Cedarhurst",
    "Syracuse, NY",
    "Tacoma, WA",
    "Tallahassee, FL",
    "Tampa Bay, FL, Tampa",
    "Terre Haute, IN",
    "Toledo, OH",
    "Topeka, KS",
    "Trenton / Princeton, NJ",
    "Tri-Cities, WA, Pasco",
    "Tucson, AZ",
    "Tulsa, OK",
    "Tupelo, MS",
    "Urbana / Champaign, IL",
    "Utica, NY",
    "Ventura County, CA, Ventura",
    "Victoria, TX",
    "Virginia Beach / Norfolk, VA",
    "Waco, TX",
    "Washington, DC",
    "Waterloo, IA",
    "Wausau, WI",
    "Wenatchee, WA",
    "West Palm Beach, FL",
    "Westchester, NY, Pelham",
    "Western Arizona, AZ, Yuma",
    "Western Colorado, CO, Grand Junction",
    "Wheeling, WV",
    "Wichita Falls, TX",
    "Wichita, KS",
    "Williamsport, PA",
    "Wilmington, DE",
    "Wilmington, NC",
    "Winston Salem, NC",
    "Worcester, MA",
    "Yakima, WA",
    "York, PA",
    "Youngstown, OH"].each do |ma|
      a = ma.split(', ')
      city_name = a[0]
      state_name = a[1]
      state = State.find(:first, :conditions => "name = '#{state_name}'")

      next if state.nil?
      
      ma = MetroArea.new(:name => a[0], :state => state, :country_id => 0)
      ma.save
    end
    if failed.size > 0
      puts "This many failed: #{failed.size}"
      puts failed
    end
  end

  def self.down
    MetroArea.destroy_all
  end
end
