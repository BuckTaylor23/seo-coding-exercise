# The below uses Atlas to define artefacts as part of the context that the cucumber steps are run in and then makes those artefacts globally available.
# For more advanced uses of Atlas, see here: https://bitbucket.tooling.dvla.gov.uk/projects/QE/repos/dvla-atlas-ruby/browse/README.md
World do
  world = DVLA::Atlas.base_world
  world.artefacts.define_fields(
    driver: nil,
    response: nil,
    request_body: nil,
  )

  DVLA::Atlas.make_artefacts_global(world.artefacts)
  world
end
