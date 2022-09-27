#/bin/bash
current_dir="$(basename $(pwd))"
if [[ "$current_dir" != "btcb-por-workshop" || "$current_dir" == "code" ]]; then
    echo "Script must be run from root of repository."
    exit 1
fi

# Run using docker compose
docker compose -f docker/docker-compose.yml --project-directory ./ up --abort-on-container-exit --exit-code-from node --build