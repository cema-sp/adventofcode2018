input_file_path = "../input.txt"

input =
  input_file_path
  |> Path.expand(__ENV__.file)
  |> File.read!()
  |> String.trim_trailing()

Solution1.execute(input)
