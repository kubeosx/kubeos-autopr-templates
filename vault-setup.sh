
vault policy write ${{values.project_name_in_k8}}-policy - <<EOH
path "kubeos/${{values.project_k8_namespace}}/${{values.project_name_in_k8}}"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "kubeos/dev/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
path "kubeos/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOH


vault write auth/kubernetes/role/${{values.project_name_in_k8}} \
        bound_service_account_names=${{values.project_name_in_k8}} \
        bound_service_account_namespaces=${{values.project_k8_namespace}} \
        policies=${{values.project_name_in_k8}}-policy \
        ttl=72h

vault kv put kubeos/dev/${{values.project_name_in_k8}} name=${{values.project_name_in_k8}}