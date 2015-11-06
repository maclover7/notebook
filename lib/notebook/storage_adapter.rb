module Notebook
  class StorageAdapter
    def delete
      raise(
        NotImplementedError,
        "Compliant Notebook storage adapters should define the `delete` method",
      )
    end

    def get
      raise(
        NotImplementedError,
        "Compliant Notebook storage adapters should define the `get` method",
      )
    end

    def upload
      raise(
        NotImplementedError,
        "Compliant Notebook storage adapters should define the `upload` method",
      )
    end
  end
end
