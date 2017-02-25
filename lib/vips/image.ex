defmodule Vips.Image do

  @type path        :: binary
  @type ext         :: binary
  @type filename    :: binary
  @type dirname     :: binary
  @type tmp         :: binary
  @type inplace     :: binary
  @type operations  :: Keyword.t

  @type t :: %__MODULE__{
    path:        path,
    ext:         ext,
    filename:    filename,
    dirname:     dirname,
    tmp:         tmp,
    inplace:     inplace,
    operations:  operations,
  }

  defstruct path:        nil,
            ext:         nil,
            filename:    nil,
            dirname:     nil,
            tmp:         nil,
            inplace:     nil,
            operations:  []
end
