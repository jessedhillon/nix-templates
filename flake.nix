{
  description = "Basic project templtates";

  outputs = { self }: {
    templates = {
      python-basic = {
        path = ./python-basic;
        description = "Basic Python project scaffolding";
      };
    };
  };
}
