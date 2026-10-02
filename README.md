# Brokerage Account Opening — Business Analysis Pet Project

Pet-project бизнес-аналитика: проектирование процесса открытия брокерского счёта в мобильном банке.

## Цель проекта

Спроектировать понятный и контролируемый клиентский путь открытия брокерского счёта:
от нажатия пользователем кнопки «Открыть брокерский счёт» до создания счёта и отображения итогового статуса.

Проект демонстрирует навыки:
- сбора, декомпозиции и формализации требований;
- описания клиентского пути;
- моделирования бизнес-процессов в BPMN 2.0;
- UML / ER-моделирования;
- описания Use Cases, User Stories и Acceptance Criteria;
- анализа REST API и JSON;
- работы с SQL;
- подготовки Test Cases и критериев пользовательской приёмки.

## Сценарий

Пользователь мобильного банка хочет открыть брокерский счёт.

Система должна:
1. Проверить, что пользователь авторизован и идентифицирован.
2. Предложить ознакомиться с условиями брокерского обслуживания.
3. Запросить необходимые согласия.
4. Создать заявку на открытие счёта.
5. Провести проверки данных.
6. В случае успеха создать брокерский счёт.
7. Показать пользователю итоговый статус.
8. Сохранить историю изменения статусов заявки.

## Структура репозитория

```text
brokerage_account_opening/
├── README.md
├── docs/
│   ├── 01_project_scope.md
│   ├── 02_business_requirements.md
│   ├── 03_functional_requirements.md
│   ├── 04_customer_journey.md
│   ├── 05_use_cases.md
│   ├── 06_user_stories_acceptance.md
│   ├── 07_business_rules.md
│   └── 08_acceptance_test_plan.md
├── diagrams/
│   ├── brokerage_opening.bpmn
│   ├── use_case.puml
│   ├── sequence.puml
│   └── er_diagram.puml
├── api/
│   └── openapi.yaml
├── sql/
│   ├── schema.sql
│   └── analytical_queries.sql
├── tests/
│   └── test_cases.csv
└── examples/
    ├── create_application_request.json
    ├── create_application_response.json
    └── application_status_response.json
```

## Основные сущности

- Customer — клиент банка.
- BrokerageApplication — заявка на открытие брокерского счёта.
- BrokerageAccount — брокерский счёт.
- Consent — пользовательское согласие.
- Document — документ, связанный с заявкой.
- StatusHistory — история статусов заявки.

## Основные статусы заявки

- DRAFT
- SUBMITTED
- UNDER_REVIEW
- ADDITIONAL_INFO_REQUIRED
- APPROVED
- REJECTED
- ACCOUNT_OPENED

## API

Пример интерфейсов описан в `api/openapi.yaml`.

Ключевые операции:
- `POST /applications` — создать заявку;
- `GET /applications/{applicationId}` — получить заявку;
- `POST /applications/{applicationId}/submit` — отправить заявку;
- `POST /applications/{applicationId}/consents` — сохранить согласие;
- `GET /applications/{applicationId}/status` — получить статус.

## BPMN

Файл `diagrams/brokerage_opening.bpmn` можно открыть в Camunda Modeler / bpmn.io.

## SQL

В папке `sql/` находятся:
- пример схемы БД;
- запросы для контроля заявок и статусов;
- запросы для простого продуктового анализа.

## Test Cases

В `tests/test_cases.csv` находятся позитивные, негативные и пограничные сценарии для пользовательской и приёмочной проверки.

## Что можно обсуждать на собеседовании

1. Почему процесс разделён на создание заявки и её отправку.
2. Где нужны синхронные проверки, а где асинхронные.
3. Как хранить историю статусов.
4. Как обеспечить идемпотентность API.
5. Какие ошибки API должны быть бизнес-ошибками, а какие техническими.
6. Как уменьшить количество шагов в клиентском пути.
7. Какие метрики продукта можно отслеживать: conversion to submit, approval rate, time-to-open, drop-off по шагам.

## Стек

BPMN 2.0 • UML • ER • REST API • OpenAPI • JSON • SQL • Use Cases • User Stories • Acceptance Criteria • Test Cases
