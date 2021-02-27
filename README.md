# ac-gema-server-setup

Real life gema server setup using wesen1/assaultcube-wesen-gema-mod-server.
To initialize the setup run `./scripts/upgrade.sh`. Then whenever the docker image is updated or changes are pushed to this repository you can run `upgrade.sh` again to upgrade everything to the latest version.

## Config

All variables are configured in the `.env` file in the main directory of this repository.
If it doesn't exist it will be created from `.env.example`.

Note that there are two types of files inside this repository:

* `*.template`: Template files from which the file `*` is (re-)generated on every upgrade. Variables from `.env` may be used here like this: `${VARIABLE_NAME}`
* `*.example`: Example files that are copied to `*` only if that file doesn't exist yet


## Scripts

The following scripts are available inside the scripts directory:

* `backup-database.sh`: Create a new database backup (optional: --only-data to not include table definitions in the backup)
* `backup-logs.sh`: Create a backup of the docker container logs
* `restore-database.sh <backup name>`: Restore a previously created database backup
* `upgrade.sh`: Update the repository and the docker images, then recreate and restart the containers (optional: -h|--halt to not start the containers when the upgrade is finished)
