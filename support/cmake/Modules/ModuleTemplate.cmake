# Module template characteristics;

# - Always builds in-source
# - Configuring never overwites any pre-existing files
# - Generate step can re-run freely without causing destruction!
# - Never copies any raw source/header files into build tree
# - No install step

# Specifically;

# - The project and it's files are intended to be re-named,
# overwritten, and modified in-source.

# - There should be no distinction between pre- and post-
# configuration in terms of IDE or workflow; Configuring
# the project simply means to prepare the build step.

# - Sources and headers in the source tree exist as sole copies
# to be overwritten and modified during development; these should
# not be configure-copied over into the binary tree during
# configuration.

# - All binary file linkage should be resolved using the source
# tree's extant header and include files. New files may be
# generated and linked to freely, but making copies in the same
# project tree and mixing linkage should be considered illegal.

# - Instead of copying files, the configure_file command can be
# used to rotate/re-generate generic files strictly using @ONLY.

# - Sub-projects should be dis-allowed.
