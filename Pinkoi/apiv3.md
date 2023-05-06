Repo 位置：`/apiv3`

# 範例結構

```plaintext
└── apiv3
    ├── dependencies
    │   ├── __init__.py
    │   ├── acl.py
    │   └── rbac.py
    └── routes
    │   └── admin
    │       ├── shop
    │       │   ├── __init__.py
    │       │   └── seller_rating.py
    │       ├── __init__.py
    │       └── coupon.py
    ├── __init__.py
    └── app.py
```

# 資料夾結構即 API Enpoint Path

在 `/apiv3/routes` 底下的資料夾結構，應該等同於 api endpoint 的 path。

比如若有一個 API endpoint path 為 `/apiv3/admin/coupon/query_coupons`，那它對應到的檔案就會是 `/apiv3/routes/admin/coupon.py`，且 `coupon.py` 中會有一個叫做 `query_coupons` 的 function。

# Include Router

在 `/apiv3` 底下會有一個 `app.py` file，其中會 include `/apiv3/routes` 下的所有 modules，以開頭的例子來說，`app.py` 就會有下面這段：

```py
from .routes.admin import router as admin_router
from .routes.brand_management import router as brand_management_router

api = OpenAPI(
    title='Pinkoi API v3',
    root_path="/apiv3",
    responses={
        400: {'model': BadRequestResponse},
        401: {'model': LoginRequiredResponse},
        228: {'model': OverlayScreenResponse},
        202: {'model': AsyncTaskResponse}
    },
    servers=_SERVERS,
    openapi_url='/openapi.json' if not settings.PRODUCTION else None,
)

api.include_router(admin_router, prefix='/admin')
api.include_router(
    brand_management_router,
    prefix='/brand_management',
    tags=['brand_management']
)
```

上方程式碼的最後一行中，若該 router 為中間層級（只是一個 sub-directory），則**不需要** `tags` 參數，反之則需要，`tags` 會設為 `/apiv3/routes` **以後**的 path，且開頭不用 `/`。

在 `/apiv3/routes` 底下的每層 sub-directory 都要有自己的 `__init__.py` file（但 `/apiv3/routes` 自己不用有），`__init__.py` 內要 include 所有與自己同層的 modules，比如開頭例子中的 `/apiv3/routes/admin/__init__.py` 裡面就應該要有下面這段：

```py
from django_mini_fastapi import APIRouter

from .shop import router as shop_router
from .coupon import router as coupon_router

router = APIRouter()

router.include_router(
    shop_router,
    prefix='/shop',
    tags=['admin/shop'],
)

router.include_router(
    coupon_router,
    prefix='/coupon',
    tags=['admin/coupon']
)
```

`/apiv3/routes/admin/shop/__init__.py` 裡面則應該要有下面這段：

```py
from django_mini_fastapi import APIRouter

from .seller_rating import router as seller_rating_router

router = APIRouter()

router.include_router(
    seller_rating_router,
    prefix='/seller_rating',
    tags=['admin/shop/seller_rating'],
)
```

### `tag` 參數

`tag` 參數會讓 API Document 出現對應的段落，因此若一個 sub-directory 中全部都是下一層的 route directory、沒有 api endpoint，那該 sub-directory 在其 parent 的 `__init__.py` 或者是 `/apiv3/app.py` 中就不需要 `tag`

# API 文件

以下三個 URL 可以查看自動產生的 API 文件：

- `/apiv3/docs` (OpenAPI)
- `/apiv3/redoc`