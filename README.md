
# Nimiq Ansible

This repository contains Ansible playbooks for setting up Nimiq nodes.


# Hardware requirements

These are based on testnet requirements early on, disk might need be bigger later!

Mainnet is not yet available!
## Minimum
- CPU: 2 core
- Memory: 4 GB
- Disk: 40 GB SSD
- OS: Ubuntu 20.04+

## Recommended
- CPU: 2 core
- Memory: 4 GB
- Disk: 80 GB SSD
- OS: Ubuntu 24.04+

## Setup or Update

To quickly set up or update a Nimiq node using this repository, you can use the provided setup script. The script will install Ansible if not already installed, clone this repository, and run the Ansible playbook with the specified arguments.

### Usage

Run the following command in your terminal:

```sh
curl -s https://raw.githubusercontent.com/maestroi/nimiq-ansible/master/setup.sh | bash -s <network> <node_type>
```

Replace `<network>` and `<node_type>` with the appropriate values:

- `<network>`: The network to connect to (`testnet`, `mainnet`, etc.).
- `<node_type>`: The type of node to set up (`validator`, `full_node`, `history_node`).

### Example

To set up or update a validator node on the testnet:

```sh
curl -s https://raw.githubusercontent.com/maestroi/nimiq-ansible/master/setup.sh | bash -s testnet validator
```

### Setup Script

The setup script (`setup.sh`) performs the following tasks:

1. Installs necessary dependencies.
2. Adds the Ansible repository and installs Ansible if not already installed.
3. Clones or updates the Nimiq Ansible repository.
4. Runs the Ansible playbook with the specified network and node type.

### Playbooks

The main playbook is `playbook.yml`, which includes roles for setting up common dependencies, Docker, Nimiq nodes, and monitoring.

## Roles

### Common

Installs common dependencies and performs system checks.

### Docker

Installs Docker and Docker Compose.

### Nimiq

Sets up the Nimiq node based on the specified network and node type.

### Monitoring

Sets up monitoring tools like Promtail, Loki, Prometheus, and Grafana.

## Repository Structure

```
ansible/
├── playbook.yml
├── roles/
│   ├── common/
│   │   ├── tasks/
│   │   │   └── main.yml
│   ├── docker/
│   │   ├── tasks/
│   │   │   └── main.yml
│   ├── nimiq/
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   ├── templates/
│   │   │   └── docker-compose.yml.j2
│   │   │   └── config.toml.j2
│   │   │   └── nginx.conf.j2
│   └── monitoring/
│       ├── tasks/
│       │   └── main.yml
│       ├── templates/
│       │   └── promtail-config.yml.j2
│       │   └── prometheus.yml.j2
│       │   └── loki-config.yaml.j2
│       │   └── docker-compose.yml.j2
│       │   └── dashboards.yml
│       │   └── datasource.yml
│       │   └── dashboards/
│       │       └── nimiq.json
│       │       └── prometheus.json
│       └── vars/
│           └── main.yml
├── setup.sh
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
