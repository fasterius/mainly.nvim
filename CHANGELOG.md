# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## Versioning

Per SemVer, `0.y.z` is for initial development, with no stable API and no
users depending on it yet -- don't tag every commit during that phase, and
don't feel obliged to start at `0.1.0`; once the plugin is genuinely stable
and in real use, `1.0.0` is simply the first tag.

From there:

- `MAJOR` bumps mean a public command, Lua function, or `setup()` option was
  removed or renamed. Where practical, such a change goes through a
  deprecation period via `vim.deprecate()` rather than an instant break.
- `MINOR` bumps mean new, backward-compatible functionality was added.
- `PATCH` bumps mean bug fixes with no change to the public API.

New tags are cut after a coherent, meaningful batch of changes lands, not
after every commit.

## [Unreleased]
