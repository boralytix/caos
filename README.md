# Архитектура компьютера и операционные системы

## Создание приватной копии репозитория

1. Нажмите кнопку `Use this template` (справа вверху).
2. Выберите `Create a new repository`.
3. В появившейся форме:
    - В поле `Owner` выберите свой личный аккаунт.
    - Задайте `Repository name`.
    - В списке `Visibility` отметьте `Private`.

## Настройка и синхронизация обновлений

Поскольку это не &laquo;fork&raquo;, кнопки &laquo;Sync fork&raquo; не будет. Чтобы получать изменения из данного шаблона, нужно добавить оригинал как удалённый репозиторий и подтягивать его вручную по инструкции ниже.

1. Склонируйте свой приватный репозиторий:
```bash
git clone git@github.com:username/repo_name.git destination
```

2. Откройте в терминале папку с репозиторием.

3. Добавьте &laquo;upstream&raquo; &ndash; ссылку на этот шаблон‑репозиторий:
```bash
git remote add upstream \
  git@github.com:boralytix/caos.git
```

4. Когда будут внесены изменения в оригинальный шаблон, внутри локального клона делаем:
```bash
git fetch upstream
```

5. Сливаем изменения в свою рабочую ветку (обычно `main`):
```bash
git checkout main
git merge upstream/main --allow-unrelated-histories -m "Merge upstream into my repo"
```
6. Отправляем обновления в свой приватный репозиторий на GitHub:
```bash
git push origin main
```

## Домашние задания

### [Задание 1. Системы счисления и представление чисел в компьютере (23:59 3 ноября 2025 года)](hw/lab01/README.md)