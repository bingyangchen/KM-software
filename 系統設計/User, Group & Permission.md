```mermaid
erDiagram
	User }o--o{ UserGroups: contains
	UserGroups }o--o{ Group: contains
	Group }o--o{ GroupPermissions: has
	GroupPermissions }o--o{ Permissions: contains
	Permissions }o--o{ UserPermissions: contains
	UserPermissions }o--o{ User: has
```
