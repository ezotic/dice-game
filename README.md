# Dice Game Deployment with Terraform and Docker

This project deploys a static dice game web app with Terraform and Docker.
Terraform builds an Nginx-based image from the local site files and runs it as a container.

## Application Details

The app is a simple two-dice roller served as static assets.

Features:
- Roll two dice and display each value.
- Display running total (`Total: X`).
- Accessible UI with labeled controls and live-updating total.
- Responsive layout for mobile and desktop viewports.

Key files:
- `image/site/index.html`: Semantic markup and accessibility attributes.
- `image/site/styles.css`: Visual styles and responsive behavior.
- `image/site/app.js`: Dice roll logic, initialization, and DOM safety checks.
- `image/Dockerfile`: Nginx image definition and static-file permission hardening.
- `main.tf`: Terraform resources for image build, network, and container runtime.

## Prerequisites

Install the following on your machine:
- Docker Engine (daemon running)
- Terraform >= 1.6.0

Verify:

```bash
docker --version
terraform --version
```

## Project Structure

```text
.
├── image/
│   ├── Dockerfile
│   └── site/
│       ├── app.js
│       ├── index.html
│       └── styles.css
├── main.tf
└── README.md
```

## Startup Instructions (Terraform-managed)

From the project root:

1. Initialize Terraform providers:

```bash
terraform init
```

2. Validate configuration:

```bash
terraform validate
```

3. Preview what will be created:

```bash
terraform plan
```

4. Build and start the application:

```bash
terraform apply
```

When prompted, type `yes`.

5. Open the app:

```text
http://localhost:8080/
```

Terraform outputs include:
- `url`: local endpoint
- `image_built`: built image name and tag
- `container_id`: running container ID

## Configure Port or Image Name (Optional)

You can override defaults at apply time:

```bash
terraform apply \
	-var='host_port=9090' \
	-var='image_name=my-dice-app' \
	-var='image_tag=v1.2'
```

Then open `http://localhost:9090/`.

## Stop and Clean Up

Destroy all Terraform-managed Docker resources:

```bash
terraform destroy
```

## Fast Verification

After startup, verify from terminal:

```bash
curl -I http://localhost:8080/
```

Expected result includes `HTTP/1.1 200 OK`.

## Troubleshooting

- Docker connection errors:
	Ensure Docker daemon is running and your user can access it.
- Port already in use:
	Use a different `host_port` variable value.
- Terraform provider issues:
	Re-run `terraform init -upgrade`.

## Notes

- Terraform state files are ignored by `.gitignore` and should not be committed.
- Image rebuilds are triggered when files in `image/site/` change via a Terraform content hash.

