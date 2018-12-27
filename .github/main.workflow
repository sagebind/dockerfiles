workflow "New workflow" {
  on = "push"
  resolves = ["Publish"]
}

action "Build" {
  uses = "actions/action-builder/docker@master"
  runs = "make"
  args = "all"
}

action "Publish" {
  needs = "Build"
  uses = "actions/action-builder/docker@master"
  runs = "make"
  args = "push"
}
