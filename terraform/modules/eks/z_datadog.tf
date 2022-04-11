# Namespace "monitoring"
resource "kubernetes_namespace" "monitoring" {

  metadata {
    name = "monitoring"
    labels = {
      "name" = "monitoring"
    }
  }
}


# install Vault using the official Helm chart:
resource "helm_release" "datadog-helm-release" {
  name = "datadog"

  repository = local.helm_repository_datadog
  chart = "datadog"

  namespace = kubernetes_namespace.monitoring.metadata[0].name

  recreate_pods = true

  values = [
    data.template_file.datadog-values.rendered
  ]
}


data "template_file" "datadog-values" {
  template = file("${path.module}/datadog.values.yaml")
}