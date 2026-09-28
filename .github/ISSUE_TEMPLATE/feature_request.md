name: Feature request
about: Suggest a new cheat sheet, topic, or repo improvement
title: ""
labels: enhancement
assignees: ""

body:
  - type: markdown
    attributes:
      value: |
        Suggest something useful to add to CyberVault.

  - type: textarea
    id: idea
    attributes:
      label: Feature or topic suggestion
      description: What should be added or improved?
      placeholder: Example: add a Linux privilege escalation flowchart, new AD notes, or a malware analysis section.
    validations:
      required: true

  - type: textarea
    id: reason
    attributes:
      label: Why this would be useful
      description: Explain the value or learning benefit.
    validations:
      required: false

  - type: textarea
    id: scope
    attributes:
      label: Suggested scope
      description: Tell us whether this should be a small note, a full cheat sheet, or a new knowledge section.
    validations:
      required: false
