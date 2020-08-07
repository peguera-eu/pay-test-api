require Poison
require Logger
defmodule WeatherForecast.Cities do

  alias WeatherForecast.Helpers.BoundingBox

  def get_all() do
    # {:ok, file} = File.open('city_list.json', [:utf8])
    # data = File.read('city_list.json')
    # IO.inspect(data)
    # case data do
    #   {:ok, stringified_cities} ->
        stringified_cities = cities_database()
        cities = Poison.decode(stringified_cities)
        case cities do
          {:ok, cities} ->
            cities
          {:error, _} ->
            {:error, "Unable to parse file"}
          {:error, _,_} ->
            {:error, "Unable to parse file"}
        end
    #   {:error, reason}->
    #     {:error, reason}
    # end
  end

  def get_one(city_id) do

  end

  def get_from_bounds(top_left_lat, top_left_lng, bottom_right_lat, bottom_right_lng) do
    bounds = BoundingBox.resolve_bounds(top_left_lat, top_left_lng, bottom_right_lat, bottom_right_lng)
    stringified_cities = cities_database()
    cities = Poison.decode(stringified_cities)
    case cities do
      {:ok, cities} ->
        cities
        |> sort_by_latitude()
        |> get_within_lat_bounds(bounds.top_left_lat, bounds.bottom_right_lat)
        |> sort_by_longitude()
        |> get_within_lng_bounds(bounds.top_left_lng,bounds.bottom_right_lng)
      {:error, _} ->
        {:error, "Unable to parse file"}
      {:error, _,_} ->
        {:error, "Unable to parse file"}
    end
  end

  defp sort_by_latitude(arr) do
    Enum.sort_by(arr, & &1["coord"]["lat"])
  end

  defp sort_by_longitude(arr) do
    Enum.sort_by(arr, & &1["coord"]["lon"])
  end

  defp get_within_lat_bounds(arr, top_left, bottom_right) do
    Enum.filter(arr, fn x -> bottom_right <= x["coord"]["lat"] && x["coord"]["lat"]<= top_left end)
  end

  defp get_within_lng_bounds(arr,top_left, bottom_right) do
    Enum.filter(arr, fn x -> (x["coord"]["lon"] >= top_left && x["coord"]["lon"]<= bottom_right) end)
  end

  defp cities_database() do
    "[
      {
        \"id\": 3531732,
        \"coord\": {
          \"lon\": -90.533333,
          \"lat\": 19.85
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPLA\",
          \"parent\": 6942858
        },
        \"name\": \"Campeche\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 205212
        },
        \"stations\": [
          {
            \"id\": 3968,
            \"dist\": 4,
            \"kf\": 1
          }
        ],
        \"zoom\": 7
      },
      {
        \"id\": 3531784,
        \"coord\": {
          \"lon\": -98.583328,
          \"lat\": 19.58333
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3515359
        },
        \"name\": \"Calpulalpan\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 29320
        },
        \"stations\": [
          {
            \"id\": 3998,
            \"dist\": 53,
            \"kf\": 1
          },
          {
            \"id\": 4009,
            \"dist\": 51,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3862351,
        \"coord\": {
          \"lon\": -61.16806,
          \"lat\": -33.04417
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3836276
        },
        \"name\": \"Casilda\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 32002
        },
        \"stations\": [
          {
            \"id\": 4681,
            \"dist\": 39,
            \"kf\": 1
          },
          {
            \"id\": 33419,
            \"dist\": 47,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3862655,
        \"coord\": {
          \"lon\": -61.153309,
          \"lat\": -32.856789
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3836276
        },
        \"name\": \"Carcarana\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 15619
        },
        \"stations\": [
          {
            \"id\": 4681,
            \"dist\": 35,
            \"kf\": 1
          },
          {
            \"id\": 33419,
            \"dist\": 43,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3862738,
        \"coord\": {
          \"lon\": -60.718521,
          \"lat\": -32.82262
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3836276
        },
        \"name\": \"Capitan Bermudez\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 27060
        },
        \"stations\": [
          {
            \"id\": 4681,
            \"dist\": 10,
            \"kf\": 1
          },
          {
            \"id\": 33419,
            \"dist\": 7,
            \"kf\": 1
          }
        ],
        \"zoom\": 12
      },
      {
        \"id\": 3862981,
        \"coord\": {
          \"lon\": -61.394932,
          \"lat\": -32.81636
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3836276
        },
        \"name\": \"Canada de Gomez\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 36000
        },
        \"stations\": [
          {
            \"id\": 4681,
            \"dist\": 57,
            \"kf\": 1
          },
          {
            \"id\": 33419,
            \"dist\": 65,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3863379,
        \"coord\": {
          \"lon\": -67.528137,
          \"lat\": -46.439289
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3836350
        },
        \"name\": \"Caleta Olivia\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 36077
        },
        \"stations\": [
          {
            \"id\": 4741,
            \"dist\": 72,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3864331,
        \"coord\": {
          \"lon\": -62.688728,
          \"lat\": -32.625912
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3860255
        },
        \"name\": \"Bell Ville\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 35105
        },
        \"zoom\": 7
      },
      {
        \"id\": 3864375,
        \"coord\": {
          \"lon\": -65.303146,
          \"lat\": -27.03084
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3833578
        },
        \"langs\": [
          {
            \"link\": \"http://en.wikipedia.org/wiki/Bella_Vista%2C_Tucum%C3%A1n\"
          }
        ],
        \"name\": \"Bella Vista\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 15126
        },
        \"stations\": [
          {
            \"id\": 4712,
            \"dist\": 29,
            \"kf\": 1
          }
        ],
        \"zoom\": 11
      },
      {
        \"id\": 3865086,
        \"coord\": {
          \"lon\": -62.27243,
          \"lat\": -38.719601
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3865084
        },
        \"name\": \"Bahia Blanca\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 276546
        },
        \"zoom\": 4
      },
      {
        \"id\": 3865385,
        \"coord\": {
          \"lon\": -60.508629,
          \"lat\": -33.154888
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3836276
        },
        \"name\": \"Arroyo Seco\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 20008
        },
        \"stations\": [
          {
            \"id\": 4681,
            \"dist\": 38,
            \"kf\": 1
          },
          {
            \"id\": 33419,
            \"dist\": 33,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3865424,
        \"coord\": {
          \"lon\": -63.050018,
          \"lat\": -31.420219
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3860255
        },
        \"name\": \"Arroyito\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 19577
        },
        \"zoom\": 8
      },
      {
        \"id\": 3865840,
        \"coord\": {
          \"lon\": -62.834721,
          \"lat\": -28.46064
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3835868
        },
        \"name\": \"Anatuya\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 20261
        },
        \"zoom\": 7
      },
      {
        \"id\": 3866163,
        \"coord\": {
          \"lon\": -64.428261,
          \"lat\": -31.65292
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3860255
        },
        \"name\": \"Alta Gracia\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 40384
        },
        \"stations\": [
          {
            \"id\": 4688,
            \"dist\": 42,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3866242,
        \"coord\": {
          \"lon\": -67.827141,
          \"lat\": -38.97736
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3838830
        },
        \"langs\": [
          {
            \"link\": \"http://en.wikipedia.org/wiki/Allen%2C_R%C3%ADo_Negro\"
          }
        ],
        \"name\": \"Allen\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 26083
        },
        \"stations\": [
          {
            \"id\": 4769,
            \"dist\": 28,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3866367,
        \"coord\": {
          \"lon\": -65.133331,
          \"lat\": -26.816669
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3833578
        },
        \"name\": \"Alderetes\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 38466
        },
        \"stations\": [
          {
            \"id\": 4712,
            \"dist\": 4,
            \"kf\": 1
          }
        ],
        \"zoom\": 11
      },
      {
        \"id\": 3866425,
        \"coord\": {
          \"lon\": -68.525558,
          \"lat\": -31.43722
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3866424
        },
        \"langs\": [
          {
            \"link\": \"http://en.wikipedia.org/wiki/Albard%C3%B3n_Department\"
          }
        ],
        \"name\": \"Albardon\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 20413
        },
        \"zoom\": 12
      },
      {
        \"id\": 3866496,
        \"coord\": {
          \"lon\": -65.614273,
          \"lat\": -27.4338
        },
        \"country\": \"AR\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3833578
        },
        \"name\": \"Aguilares\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 32494
        },
        \"stations\": [
          {
            \"id\": 4712,
            \"dist\": 82,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3868121,
        \"coord\": {
          \"lon\": -71.551826,
          \"lat\": -33.02457
        },
        \"country\": \"CL\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3868621
        },
        \"langs\": [
          {
            \"de\": \"Viña del Mar\"
          },
          {
            \"en\": \"Viña del Mar\"
          },
          {
            \"es\": \"Viña del Mar\"
          },
          {
            \"fi\": \"Viña del Mar\"
          },
          {
            \"fr\": \"Viña del Mar\"
          },
          {
            \"it\": \"Viña del Mar\"
          },
          {
            \"ja\": \"ビニャ・デル・マール\"
          },
          {
            \"link\": \"http://en.wikipedia.org/wiki/Vi%C3%B1a_del_Mar\"
          },
          {
            \"no\": \"Viña del Mar\"
          },
          {
            \"pl\": \"Viña del Mar\"
          },
          {
            \"pt\": \"Viña del Mar\"
          },
          {
            \"ru\": \"Винья-дель-Мар\"
          },
          {
            \"sl\": \"Viña del Mar\"
          },
          {
            \"sv\": \"Viña del Mar\"
          }
        ],
        \"name\": \"Vina del Mar\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 294551
        },
        \"stations\": [
          {
            \"id\": 4676,
            \"dist\": 10,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3868158,
        \"coord\": {
          \"lon\": -72.227898,
          \"lat\": -39.28569
        },
        \"country\": \"CL\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3899463
        },
        \"name\": \"Villarrica\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 31602
        },
        \"stations\": [
          {
            \"id\": 4671,
            \"dist\": 67,
            \"kf\": 1
          },
          {
            \"id\": 4675,
            \"dist\": 70,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3868192,
        \"coord\": {
          \"lon\": -71.373329,
          \"lat\": -33.042221
        },
        \"country\": \"CL\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3868621
        },
        \"name\": \"Villa Alemana\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 97320
        },
        \"stations\": [
          {
            \"id\": 4676,
            \"dist\": 14,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3868326,
        \"coord\": {
          \"lon\": -72.333328,
          \"lat\": -38.216671
        },
        \"country\": \"CL\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3899463
        },
        \"name\": \"Victoria\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 24555
        },
        \"stations\": [
          {
            \"id\": 4650,
            \"dist\": 91,
            \"kf\": 1
          },
          {
            \"id\": 4671,
            \"dist\": 66,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3868626,
        \"coord\": {
          \"lon\": -71.627251,
          \"lat\": -33.039322
        },
        \"country\": \"CL\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPLA\",
          \"parent\": 3868621
        },
        \"name\": \"Valparaiso\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 282448
        },
        \"stations\": [
          {
            \"id\": 4676,
            \"dist\": 16,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3985710,
        \"coord\": {
          \"lon\": -109.912376,
          \"lat\": 22.890881
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4017698
        },
        \"langs\": [
          {
            \"link\": \"http://en.wikipedia.org/wiki/Cabo_San_Lucas\"
          },
          {
            \"ru\": \"Кабо-Сан-Лукас\"
          }
        ],
        \"name\": \"Cabo San Lucas\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 42601
        },
        \"stations\": [
          {
            \"id\": 4015,
            \"dist\": 34,
            \"kf\": 1
          },
          {
            \"id\": 31912,
            \"dist\": 17,
            \"kf\": 1
          },
          {
            \"id\": 34458,
            \"dist\": 31,
            \"kf\": 1
          },
          {
            \"id\": 34841,
            \"dist\": 45,
            \"kf\": 1
          },
          {
            \"id\": 34914,
            \"dist\": 31,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3985865,
        \"coord\": {
          \"lon\": -102.300003,
          \"lat\": 21.25
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4004156
        },
        \"name\": \"San Juan de los Lagos\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 45671
        },
        \"stations\": [
          {
            \"id\": 3966,
            \"dist\": 51,
            \"kf\": 1
          },
          {
            \"id\": 3981,
            \"dist\": 89,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3986088,
        \"coord\": {
          \"lon\": -100.383331,
          \"lat\": 21.0
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4005267
        },
        \"name\": \"San Jose Iturbide\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 16702
        },
        \"stations\": [
          {
            \"id\": 4012,
            \"dist\": 46,
            \"kf\": 1
          },
          {
            \"id\": 32874,
            \"dist\": 42,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3986172,
        \"coord\": {
          \"lon\": -109.697708,
          \"lat\": 23.05888
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4017698
        },
        \"name\": \"San Jose del Cabo\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 48518
        },
        \"stations\": [
          {
            \"id\": 4015,
            \"dist\": 10,
            \"kf\": 1
          },
          {
            \"id\": 31912,
            \"dist\": 11,
            \"kf\": 1
          },
          {
            \"id\": 34458,
            \"dist\": 4,
            \"kf\": 1
          },
          {
            \"id\": 34841,
            \"dist\": 17,
            \"kf\": 1
          },
          {
            \"id\": 34914,
            \"dist\": 3,
            \"kf\": 1
          }
        ],
        \"zoom\": 6
      },
      {
        \"id\": 3986984,
        \"coord\": {
          \"lon\": -101.849998,
          \"lat\": 21.01667
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4005267
        },
        \"name\": \"San Francisco del Rincon\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 66949
        },
        \"stations\": [
          {
            \"id\": 3981,
            \"dist\": 38,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3987224,
        \"coord\": {
          \"lon\": -114.866669,
          \"lat\": 31.0
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4017700
        },
        \"name\": \"San Felipe\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 15386
        },
        \"stations\": [
          {
            \"id\": 31402,
            \"dist\": 87,
            \"kf\": 1
          }
        ],
        \"zoom\": 7
      },
      {
        \"id\": 3987246,
        \"coord\": {
          \"lon\": -101.216667,
          \"lat\": 21.48333
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4005267
        },
        \"langs\": [
          {
            \"link\": \"http://en.wikipedia.org/wiki/San_Felipe%2C_Guanajuato\"
          }
        ],
        \"name\": \"San Felipe\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 26072
        },
        \"stations\": [
          {
            \"id\": 3981,
            \"dist\": 60,
            \"kf\": 1
          },
          {
            \"id\": 4017,
            \"dist\": 90,
            \"kf\": 1
          },
          {
            \"id\": 32874,
            \"dist\": 72,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3987500,
        \"coord\": {
          \"lon\": -101.533333,
          \"lat\": 27.08333
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4013674
        },
        \"name\": \"San Buenaventura\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 18822
        },
        \"stations\": [
          {
            \"id\": 4000,
            \"dist\": 14,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3988025,
        \"coord\": {
          \"lon\": -103.466667,
          \"lat\": 20.533331
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4004156
        },
        \"name\": \"San Agustin\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 15107
        },
        \"stations\": [
          {
            \"id\": 3982,
            \"dist\": 16,
            \"kf\": 1
          }
        ],
        \"zoom\": 12
      },
      {
        \"id\": 3988050,
        \"coord\": {
          \"lon\": -100.883331,
          \"lat\": 20.216669
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4005267
        },
        \"name\": \"Salvatierra\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 32972
        },
        \"stations\": [
          {
            \"id\": 4003,
            \"dist\": 43,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3988086,
        \"coord\": {
          \"lon\": -101.0,
          \"lat\": 25.41667
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPLA\",
          \"parent\": 4013674
        },
        \"name\": \"Saltillo\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 621250
        },
        \"stations\": [
          {
            \"id\": 4001,
            \"dist\": 91,
            \"kf\": 1
          },
          {
            \"id\": 4002,
            \"dist\": 97,
            \"kf\": 1
          },
          {
            \"id\": 4014,
            \"dist\": 16,
            \"kf\": 1
          },
          {
            \"id\": 29091,
            \"dist\": 67,
            \"kf\": 1
          },
          {
            \"id\": 30509,
            \"dist\": 75,
            \"kf\": 1
          },
          {
            \"id\": 30521,
            \"dist\": 68,
            \"kf\": 1
          },
          {
            \"id\": 33646,
            \"dist\": 76,
            \"kf\": 1
          },
          {
            \"id\": 34139,
            \"dist\": 69,
            \"kf\": 1
          }
        ],
        \"zoom\": 6
      },
      {
        \"id\": 3988214,
        \"coord\": {
          \"lon\": -101.199997,
          \"lat\": 20.566669
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4005267
        },
        \"name\": \"Salamanca\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 138614
        },
        \"stations\": [
          {
            \"id\": 3981,
            \"dist\": 55,
            \"kf\": 1
          },
          {
            \"id\": 4003,
            \"dist\": 82,
            \"kf\": 1
          },
          {
            \"id\": 27889,
            \"dist\": 82,
            \"kf\": 1
          },
          {
            \"id\": 32874,
            \"dist\": 61,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3988258,
        \"coord\": {
          \"lon\": -102.716667,
          \"lat\": 20.066669
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3995955
        },
        \"name\": \"Sahuayo de Morelos\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 58513
        },
        \"stations\": [
          {
            \"id\": 3982,
            \"dist\": 79,
            \"kf\": 1
          }
        ],
        \"zoom\": 10
      },
      {
        \"id\": 3988327,
        \"coord\": {
          \"lon\": -100.166672,
          \"lat\": 26.5
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3522542
        },
        \"name\": \"Sabinas Hidalgo\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 32047
        },
        \"stations\": [
          {
            \"id\": 4001,
            \"dist\": 70,
            \"kf\": 1
          },
          {
            \"id\": 4002,
            \"dist\": 80,
            \"kf\": 1
          },
          {
            \"id\": 29091,
            \"dist\": 95,
            \"kf\": 1
          },
          {
            \"id\": 30509,
            \"dist\": 96,
            \"kf\": 1
          },
          {
            \"id\": 30521,
            \"dist\": 87,
            \"kf\": 1
          },
          {
            \"id\": 34139,
            \"dist\": 97,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3988333,
        \"coord\": {
          \"lon\": -101.116669,
          \"lat\": 27.85
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4013674
        },
        \"name\": \"Sabinas\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 49199
        },
        \"zoom\": 8
      },
      {
        \"id\": 3988392,
        \"coord\": {
          \"lon\": -117.033333,
          \"lat\": 32.333328
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4017700
        },
        \"name\": \"Rosarito\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 66020
        },
        \"stations\": [
          {
            \"id\": 437,
            \"dist\": 44,
            \"kf\": 1
          },
          {
            \"id\": 473,
            \"dist\": 46,
            \"kf\": 1
          },
          {
            \"id\": 475,
            \"dist\": 26,
            \"kf\": 1
          },
          {
            \"id\": 4021,
            \"dist\": 23,
            \"kf\": 1
          },
          {
            \"id\": 28734,
            \"dist\": 16,
            \"kf\": 1
          },
          {
            \"id\": 28818,
            \"dist\": 24,
            \"kf\": 1
          },
          {
            \"id\": 32181,
            \"dist\": 13,
            \"kf\": 1
          },
          {
            \"id\": 32993,
            \"dist\": 40,
            \"kf\": 1
          },
          {
            \"id\": 33889,
            \"dist\": 22,
            \"kf\": 1
          },
          {
            \"id\": 34109,
            \"dist\": 48,
            \"kf\": 1
          },
          {
            \"id\": 34588,
            \"dist\": 49,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3988462,
        \"coord\": {
          \"lon\": -101.51667,
          \"lat\": 20.866671
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4005267
        },
        \"name\": \"Romita\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 19351
        },
        \"stations\": [
          {
            \"id\": 3981,
            \"dist\": 14,
            \"kf\": 1
          }
        ],
        \"zoom\": 11
      },
      {
        \"id\": 3988594,
        \"coord\": {
          \"lon\": -103.033333,
          \"lat\": 23.83333
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3979840
        },
        \"name\": \"Rio Grande\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 29841
        },
        \"zoom\": 8
      },
      {
        \"id\": 3988651,
        \"coord\": {
          \"lon\": -102.300003,
          \"lat\": 22.23333
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4019231
        },
        \"name\": \"Rincon de Romos\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 24683
        },
        \"stations\": [
          {
            \"id\": 3966,
            \"dist\": 57,
            \"kf\": 1
          },
          {
            \"id\": 4030,
            \"dist\": 84,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3991043,
        \"coord\": {
          \"lon\": -100.966667,
          \"lat\": 25.549999
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4013674
        },
        \"name\": \"Ramos Arizpe\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 38258
        },
        \"stations\": [
          {
            \"id\": 4001,
            \"dist\": 81,
            \"kf\": 1
          },
          {
            \"id\": 4002,
            \"dist\": 89,
            \"kf\": 1
          },
          {
            \"id\": 4014,
            \"dist\": 4,
            \"kf\": 1
          },
          {
            \"id\": 29091,
            \"dist\": 60,
            \"kf\": 1
          },
          {
            \"id\": 30509,
            \"dist\": 68,
            \"kf\": 1
          },
          {
            \"id\": 30521,
            \"dist\": 59,
            \"kf\": 1
          },
          {
            \"id\": 33646,
            \"dist\": 71,
            \"kf\": 1
          },
          {
            \"id\": 34139,
            \"dist\": 62,
            \"kf\": 1
          }
        ],
        \"zoom\": 11
      },
      {
        \"id\": 3991164,
        \"coord\": {
          \"lon\": -100.383331,
          \"lat\": 20.6
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3520914
        },
        \"name\": \"Santiago de Queretaro\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 611785
        },
        \"stations\": [
          {
            \"id\": 4012,
            \"dist\": 20,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3991219,
        \"coord\": {
          \"lon\": -101.5,
          \"lat\": 20.08333
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3995955
        },
        \"name\": \"Puruandiro\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 28350
        },
        \"stations\": [
          {
            \"id\": 4003,
            \"dist\": 55,
            \"kf\": 1
          },
          {
            \"id\": 4027,
            \"dist\": 94,
            \"kf\": 1
          }
        ],
        \"zoom\": 9
      },
      {
        \"id\": 3991328,
        \"coord\": {
          \"lon\": -105.230659,
          \"lat\": 20.620411
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4004156
        },
        \"name\": \"Puerto Vallarta\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 187134
        },
        \"stations\": [
          {
            \"id\": 4011,
            \"dist\": 6,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3992619,
        \"coord\": {
          \"lon\": -100.51667,
          \"lat\": 28.700001
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 4013674
        },
        \"name\": \"Piedras Negras\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 139619
        },
        \"stations\": [
          {
            \"id\": 2575,
            \"dist\": 80,
            \"kf\": 1
          },
          {
            \"id\": 2598,
            \"dist\": 84,
            \"kf\": 1
          },
          {
            \"id\": 2618,
            \"dist\": 94,
            \"kf\": 1
          },
          {
            \"id\": 2666,
            \"dist\": 77,
            \"kf\": 1
          },
          {
            \"id\": 4007,
            \"dist\": 8,
            \"kf\": 1
          },
          {
            \"id\": 28781,
            \"dist\": 66,
            \"kf\": 1
          }
        ],
        \"zoom\": 8
      },
      {
        \"id\": 3991347,
        \"coord\": {
          \"lon\": -113.533333,
          \"lat\": 31.316669
        },
        \"country\": \"MX\",
        \"geoname\": {
          \"cl\": \"P\",
          \"code\": \"PPL\",
          \"parent\": 3982846
        },
        \"name\": \"Puerto Penasco\",
        \"stat\": {
          \"level\": 1.0,
          \"population\": 33875
        },
        \"zoom\": 7
      }
    ]"
  end
end
