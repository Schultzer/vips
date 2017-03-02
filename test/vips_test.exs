defmodule VipsTest do
  import Vips
  alias Vips.Image

  use ExUnit.Case

  @image Path.join(__DIR__, "test_files/example.jpg")
  @ext Path.extname(@image)
  @dirname Path.dirname(@image)
  @filename Path.basename(@image, Path.extname(@image))

  test "open/1" do
    image = open(@image)
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname} = image

    image = open("./test/test_files/example.jpg")
    assert %Vips.Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname} = image
  end

  test "open/1 when file does not exist" do
    assert_raise File.Error, fn ->
      open("./test/test_files/does_not_exist.jpg")
    end
  end

  test "save([:overwrite])" do
    image = open(@image) |> copy
    image |> save([:overwrite])
    assert File.exists?(image.path)
  end

  test "custom/2" do
    image = open(@image) |> custom(["gamma"])
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "gamma"]} = image
  end

  test "custom_params/2" do
    image = open(@image) |> custom_params(["rot", "d90"])
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "rot", params: "d90"]} = image
  end

  test "jpeg/1" do
    image = open(@image) |> jpeg
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "jpegsave"]} = image
  end

  test "webp/1" do
    image = open(@image) |> webp
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "webpsave"]} = image
  end

  test "tiff/1" do
    image = open(@image) |> tiff
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "tiffsave"]} = image
  end

  test "fit/1" do
    image = open(@image) |> fit
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "fitsave"]} = image
  end

  test "raw/1" do
    image = open(@image) |> raw
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "rawsave"]} = image
  end

  test "csv/1" do
    image = open(@image) |> csv
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "csvsave"]} = image
  end

  test "vips/1" do
    image = open(@image) |> vips
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "vipssave"]} = image
  end

  test "png/1" do
    image = open(@image) |> png
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "pngsave"]} = image
  end

  test "ppm/1" do
    image = open(@image) |> ppm
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "ppmsave"]} = image
  end

  test "rad/1" do
    image = open(@image) |> rad
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "radsave"]} = image
  end

  test "copy/1" do
    image = open(@image) |> copy
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "copy_file"]} = image
  end

  test "flip/2" do
    image = open(@image) |> flip
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "flip", params: "horizontal"]} = image

    image = open(@image) |> flip("vertical")
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "flip", params: "vertical"]} = image
  end

  test "rotate/2" do
    image = open(@image) |> rotate
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "rot", params: "d90"]} = image

    image = open(@image) |> rotate("d180")
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "rot", params: "d180"]} = image
  end

  test "autorot/1" do
    image = open(@image) |> autorot
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "autorot"]} = image
  end

  test "falsecolour/1" do
    image = open(@image) |> falsecolour
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "falsecolour"]} = image
  end

  test "gamma/1" do
    image = open(@image) |> gamma
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "gamma"]} = image
  end

  test "blur/2" do
    image = open(@image) |> blur
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "gaussblur", params: "0.2"]} = image

    image = open(@image) |> blur("5.5")
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "gaussblur", params: "5.5"]} = image
  end

  test "sharpen/1" do
    image = open(@image) |> sharpen
    assert %Image{path: @image, ext: @ext, filename: @filename, dirname: @dirname, operations: [operator: "sharpen"]} = image
  end
end
