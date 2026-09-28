name: Bug report
about: Report a problem, broken link, or repository issue
title: ""
labels: bug
assignees: ""

body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to report an issue.

  - type: textarea
    id: description
    attributes:
      label: Describe the issue
      description: What is broken, missing, or incorrect?
      placeholder: Provide as much detail as possible.
    validations:
      required: true

  - type: textarea
    id: steps
    attributes:
      label: Steps to reproduce
      description: Include the exact steps that led to the problem.
      placeholder: 1. Open ...
    validations:
      required: false

  - type: textarea
    id: expected
    attributes:
      label: Expected behavior
      description: What did you expect to happen?
    validations:
      required: false

  - type: input
    id: file
    attributes:
      label: Related file or page
      description: If relevant, provide the file or URL
      placeholder: e.g. README.md or /Knowledge/Networking

  - type: textarea
    id: context
    attributes:
      label: Additional context
      description: Add screenshots, logs, or other relevant info.
