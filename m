Return-Path: <linux-btrfs+bounces-1864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234283F958
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859641C2165F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06C33CDF;
	Sun, 28 Jan 2024 19:29:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3231A73
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470160; cv=none; b=dKZ94+pI9l9JSEr8+urMO4WbWphxUAfVTFWGf7Xhk+rOBqa2ZVQY72vAYj0f58yMQW790kcyvcUHLzcFPf5ShdLsbOK6PuTUXUty4RpoPV0JWqtQmaHKS7Qz05rE1Fq3ycu8DzKY/9VWhiLH/rMoecS+QmXTHVk7pGfY0Mp7f7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470160; c=relaxed/simple;
	bh=4BWswezJECWklQe2RdolDp2y/EivftIa7ZJsmFkglEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Y2Wi9+vVsgoJKppMxQBmqYZ07MgKtZd1s+dNJpFPFYOLd9ZOAuHeLWmDFy3LNbJlgUdbvIhLIrjZM0Vkdy2IQqbs41fBsT77Mr3e7J6GmI4G/JhPchj0TJyEvF0VdGTRx2JXatlS4u9N5ErdnxHXHRARMSkLBl+AdpDQ6r7/m/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-183-2nv2YaFPM96ZxsrXaqLzNg-1; Sun, 28 Jan 2024 19:29:16 +0000
X-MC-Unique: 2nv2YaFPM96ZxsrXaqLzNg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:28:52 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:28:52 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, 'Netdev'
	<netdev@vger.kernel.org>, "'dri-devel@lists.freedesktop.org'"
	<dri-devel@lists.freedesktop.org>
CC: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>, 'Andrew Morton'
	<akpm@linux-foundation.org>, "'Matthew Wilcox (Oracle)'"
	<willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>, "'Dan
 Carpenter'" <dan.carpenter@linaro.org>, 'Linus Walleij'
	<linus.walleij@linaro.org>, "'David S . Miller'" <davem@davemloft.net>,
	"'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>, 'Jens Axboe'
	<axboe@kernel.dk>
Subject: RE: [PATCH next 04/11] minmax: Replace multiple __UNIQUE_ID() by
 directly using __COUNTER__
Thread-Topic: [PATCH next 04/11] minmax: Replace multiple __UNIQUE_ID() by
 directly using __COUNTER__
Thread-Index: AdpSID253aywfKK5Su+CpPVbG5xRDw==
Date: Sun, 28 Jan 2024 19:28:51 +0000
Message-ID: <24dad5d81c5e4eb0af03ff9ab7748e48@AcuMS.aculab.com>
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
In-Reply-To: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Provided __COUNTER__ is passed through an extra #define it can be pasted
onto multiple local variables to give unique names.
This saves having 3 __UNIQUE_ID() for #defines with three locals and
look less messy in general.

Stop the umin()/umax() lines being overlong by factoring out the
zero-extension logic.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index c32b4b40ce01..8ee003d8abaf 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
=20
 /*
- * min()/max()/clamp() macros must accomplish several things:
+ * min()/max()/clamp() macros must accomplish three things:
  *
  * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
@@ -43,31 +43,31 @@
=20
 #define __cmp(op, x, y)=09((x) __cmp_op_##op (y) ? (x) : (y))
=20
-#define __cmp_once(op, x, y, unique_x, unique_y) ({=09\
-=09typeof(x) unique_x =3D (x);=09=09=09\
-=09typeof(y) unique_y =3D (y);=09=09=09\
-=09_Static_assert(__types_ok(x, y),=09=09=09\
+#define __cmp_once(op, x, y, uniq) ({=09=09\
+=09typeof(x) __x_##uniq =3D (x);=09=09\
+=09typeof(y) __y_##uniq =3D (y);=09=09\
+=09_Static_assert(__types_ok(x, y),=09\
 =09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" #op=
 "() before " #op "_t()"); \
-=09__cmp(op, unique_x, unique_y); })
+=09__cmp(op, __x_##uniq, __y_##uniq); })
=20
-#define __careful_cmp(op, x, y)=09=09=09=09=09\
+#define __careful_cmp(op, x, y, uniq)=09=09=09=09\
 =09__builtin_choose_expr(__is_constexpr((x) - (y)),=09\
 =09=09__cmp(op, x, y),=09=09=09=09\
-=09=09__cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
+=09=09__cmp_once(op, x, y, uniq))
=20
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
-#define min(x, y)=09__careful_cmp(min, x, y)
+#define min(x, y)=09__careful_cmp(min, x, y, __COUNTER__)
=20
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
-#define max(x, y)=09__careful_cmp(max, x, y)
+#define max(x, y)=09__careful_cmp(max, x, y, __COUNTER__)
=20
 /**
  * umin - return minimum of two non-negative values
@@ -75,8 +75,9 @@
  * @x: first value
  * @y: second value
  */
+#define __zero_extend(x) ((x) + 0u + 0ul + 0ull)
 #define umin(x, y)=09\
-=09__careful_cmp(min, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
+=09__careful_cmp(min, __zero_extend(x), _zero_extend(y), __COUNTER__)
=20
 /**
  * umax - return maximum of two non-negative values
@@ -84,7 +85,7 @@
  * @y: second value
  */
 #define umax(x, y)=09\
-=09__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
+=09__careful_cmp(max, __zero_extend(x), _zero_extend(y), __COUNTER__)
=20
 /**
  * min3 - return minimum of three values
@@ -108,7 +109,7 @@
  * @x: first value
  * @y: second value
  */
-#define min_t(type, x, y)=09__careful_cmp(min, (type)(x), (type)(y))
+#define min_t(type, x, y)=09__careful_cmp(min, (type)(x), (type)(y), __COU=
NTER__)
=20
 /**
  * max_t - return maximum of two values, using the specified type
@@ -116,7 +117,7 @@
  * @x: first value
  * @y: second value
  */
-#define max_t(type, x, y)=09__careful_cmp(max, (type)(x), (type)(y))
+#define max_t(type, x, y)=09__careful_cmp(max, (type)(x), (type)(y), __COU=
NTER__)
=20
 /**
  * min_not_zero - return the minimum that is _not_ zero, unless both are z=
ero
@@ -131,22 +132,21 @@
 #define __clamp(val, lo, hi)=09\
 =09((val) >=3D (hi) ? (hi) : ((val) <=3D (lo) ? (lo) : (val)))
=20
-#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({=09=
=09\
-=09typeof(val) unique_val =3D (val);=09=09=09=09=09=09\
-=09typeof(lo) unique_lo =3D (lo);=09=09=09=09=09=09\
-=09typeof(hi) unique_hi =3D (hi);=09=09=09=09=09=09\
+#define __clamp_once(val, lo, hi, uniq) ({=09=09=09=09=09\
+=09typeof(val) __val_##uniq =3D (val);=09=09=09=09=09\
+=09typeof(lo) __lo_##uniq =3D (lo);=09=09=09=09=09=09\
+=09typeof(hi) __hi_##uniq =3D (hi);=09=09=09=09=09=09\
 =09_Static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),=09\
 =09=09=09(lo) <=3D (hi), true),=09=09=09=09=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
 =09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
 =09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
-=09__clamp(unique_val, unique_lo, unique_hi); })
+=09__clamp(__val_##uniq, __lo_##uniq, __hi_##uniq); })
=20
-#define __careful_clamp(val, lo, hi) ({=09=09=09=09=09\
+#define __careful_clamp(val, lo, hi, uniq) ({=09=09=09=09\
 =09__builtin_choose_expr(__is_constexpr((val) - (lo) + (hi)),=09\
 =09=09__clamp(val, lo, hi),=09=09=09=09=09\
-=09=09__clamp_once(val, lo, hi, __UNIQUE_ID(__val),=09=09\
-=09=09=09     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
+=09=09__clamp_once(val, lo, hi, uniq)); })
=20
 /**
  * clamp - return a value clamped to a given range with strict typecheckin=
g
@@ -156,7 +156,7 @@
  *
  * This macro checks that @val, @lo and @hi have the same signedness.
  */
-#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
+#define clamp(val, lo, hi) __careful_clamp(val, lo, hi, __COUNTER__)
=20
 /**
  * clamp_t - return a value clamped to a given range using a given type
@@ -168,7 +168,7 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo)=
, (type)(hi))
+#define clamp_t(type, val, lo, hi) clamp((type)(val), (type)(lo), (type)(h=
i))
=20
 /**
  * clamp_val - return a value clamped to a given range using val's type
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


