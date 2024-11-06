# Invoice Ninja Home Assistant Addon

This addon allows you to run **Invoice Ninja**, a self-hosted invoicing and billing platform, within **Home Assistant**.

### Features:
- Supports integration with the **MariaDB addon**.
- Customizable through the Home Assistant UI, including database and app configurations.

### How to Generate APP_KEY:
Run the following command to generate the APP_KEY:
```bash
docker run --rm -it invoiceninja/invoiceninja php artisan key:generate --show
```

For more info on APP_KEY, visit: [App Key Guide](https://tighten.com/insights/app-key-and-you/).
