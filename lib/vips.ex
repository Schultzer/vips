defmodule Vips do
  alias Vips.Image

  @doc """
  Opens image source
  """
  def open(path) do
    path
    |> file_check
    |> expand_path
    |> map_image
    |> map_ext
    |> map_filename
    |> map_dirname
    |> map_inplace
    |> map_tmp
  end

  defp file_check(path) do
    cond do
      File.regular?(path) == true ->
        path

      File.regular?(path) == false ->
        raise(File.Error)
    end
  end
  defp expand_path(path), do: Path.expand(path)
  defp map_image(expanded_path), do: %Image{path: expanded_path}
  defp map_ext(image), do: %{image | ext: Path.extname(image.path)}
  defp map_filename(image), do: %{image | filename: Path.basename(image.path, image.ext)}
  defp map_dirname(image), do: %{image | dirname: Path.dirname(image.path)}
  defp map_inplace(image), do: %{image | inplace: Path.join(image.dirname, "#{:crypto.rand_uniform(100_000, 999_999)}" <> "-" <> image.filename  <> image.ext)}
  defp map_tmp(image), do: %{image | tmp: Path.join(System.tmp_dir, "#{:crypto.rand_uniform(100_000, 999_999)}" <> "-" <> image.filename  <> image.ext)}

  @doc """
  Overwrite image source
  """
  def save(image, [:overwrite]), do: exec(image, image.path)
  @doc """
  Save image in temperary directory
  """
  def save(image, [:tmp]), do: exec(image, image.tmp)
  @doc """
  Save image in same directory as source
  """
  def save(image, [:inplace]), do: exec(image, image.inplace)

  defp exec(image, outfile), do: System.cmd "vips",  args(image, outfile), stderr_to_stdout: true
  defp args(image, outfile) do
    case image.operations do
      [{_operator, _value}] ->
        [ Keyword.get(image.operations, :operator) ] ++ [ image.path, outfile ]
      _ ->
        [ Keyword.get(image.operations, :operator) ] ++ [ image.path, outfile ] ++ [ Keyword.get(image.operations, :params) ]
    end
  end

  @doc """
  Custom operation with no parameters
  """
  def custom(image, [ operation ]), do: %{image | operations: [operator: operation]}
  @doc """
  Custom operation with parameters
  """
  def custom_params(image, [ operation, params ]), do: %{image | operations: [operator: operation, params: params]}

# VipsForeignSave http://www.vips.ecs.soton.ac.uk/supported/current/doc/html/libvips/VipsForeignSave.html
  @doc """
  Save the image as jpeg file format
  """
  def jpeg(image), do: %{image | operations: [operator: "jpegsave"], inplace: Path.rootname(image.inplace) <> ".jpg", tmp: Path.rootname(image.tmp) <> ".jpg"}
  @doc """
  Save the image as webp file format
  """
  def webp(image), do: %{image | operations: [operator: "webpsave"], inplace: Path.rootname(image.inplace) <> ".webp", tmp: Path.rootname(image.tmp) <> ".webp"}
  @doc """
  Save the image as tiff file format
  """
  def tiff(image), do: %{image | operations: [operator: "tiffsave"], inplace: Path.rootname(image.inplace) <> ".tiff", tmp: Path.rootname(image.tmp) <> ".tiff"}
  @doc """
  Save the image as fit file format
  """
  def fit(image), do: %{image | operations: [operator: "fitsave"], inplace: Path.rootname(image.inplace) <> ".fit", tmp: Path.rootname(image.tmp) <> ".fit"}
  @doc """
  Save the image as raw file format
  """
  def raw(image), do: %{image | operations: [operator: "rawsave"], inplace: Path.rootname(image.inplace) <> ".raw", tmp: Path.rootname(image.tmp) <> ".raw"}
  @doc """
  Save the image as csv file format
  """
  def csv(image), do: %{image | operations: [operator: "csvsave"], inplace: Path.rootname(image.inplace) <> ".csv", tmp: Path.rootname(image.tmp) <> ".csv"}
  @doc """
  Save the image as vips file format
  """
  def vips(image), do: %{image | operations: [operator: "vipssave"], inplace: Path.rootname(image.inplace) <> ".vips", tmp: Path.rootname(image.tmp) <> ".vips"}
  @doc """
  Save the image as png file format
  """
  def png(image), do: %{image | operations: [operator: "pngsave"], inplace: Path.rootname(image.inplace) <> ".png", tmp: Path.rootname(image.tmp) <> ".png"}
  @doc """
  Save the image as ppm file format
  """
  def ppm(image), do: %{image | operations: [operator: "ppmsave"], inplace: Path.rootname(image.inplace) <> ".ppm", tmp: Path.rootname(image.tmp) <> ".ppm"}
  @doc """
  Save the image as rad file format
  """
  def rad(image), do: %{image | operations: [operator: "radsave"], inplace: Path.rootname(image.inplace) <> ".rad", tmp: Path.rootname(image.tmp) <> ".rad"}


# Conversion http://www.vips.ecs.soton.ac.uk/supported/current/doc/html/libvips/libvips-conversion.html
  @doc """
  Copys the image
  """
  def copy(image), do: %{image | operations: [operator: "copy_file"]}
  @doc """
  Flips the image
  Parameters
  defualt: "horizontal"
  allowed: "horizontal", "vertical"
  """
  def flip(image, params \\ "horizontal"), do: %{image | operations: [operator: "flip", params: params]}
  @doc """
  Rotates the image
  Parameters
  defualt: "d90"
  allowed: "d0", "d90", "d180", "d270"
  """
  def rotate(image, params \\ "d90"), do: %{image | operations: [operator: "rot", params: params]}
  @doc """
  Look at the image metadata and rotate the image to make it upright.
  """
  def autorot(image), do: %{image | operations: [operator: "autorot"]}
  @doc """
  Sets falsecolour in image
  """
  def falsecolour(image), do: %{image | operations: [operator: "falsecolour"]}
  @doc """
  Sets gamma in image
  """
  def gamma(image), do: %{image | operations: [operator: "gamma"]}

# Convolution http://www.vips.ecs.soton.ac.uk/supported/current/doc/html/libvips/libvips-convolution.html
  @doc """
  Blur the image
  """
  def blur(image, params \\ "0.2"), do: %{image | operations: [operator: "gaussblur", params: params]}
  @doc """
  Sharpen the image
  """
  def sharpen(image), do: %{image | operations: [operator: "sharpen"]}

end
