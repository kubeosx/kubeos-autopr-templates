
vault policy write ${{values.project_name_in_k8}}-policy - <<EOH
path "kubeos/${{values.project_k8_namespace}}/${{values.project_name_in_k8}}"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOH


vault write auth/kubernetes/role/${{values.project_name_in_k8}} \
        bound_service_account_names=${{values.project_name_in_k8}} \
        bound_service_account_namespaces=${{values.project_k8_namespace}} \
        policies=${{values.project_name_in_k8}}-policy \
        ttl=72h