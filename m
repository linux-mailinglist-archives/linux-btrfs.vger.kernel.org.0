Return-Path: <linux-btrfs+bounces-1871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD783F981
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB7F1C215A1
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627683C463;
	Sun, 28 Jan 2024 19:37:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CF33CD3
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470634; cv=none; b=gzcAV/NBvSr6R7GXxw0cN94HqeEtdgWeiYcZuB0jAS28P4FeQi0qOeFPGjMK35op9MGpS2i2zMe10LChvQrxkCZ3891hum4M5sXpzrIX7F8rB1X3K/bowagruM1I2IN9bosu8/lry2EfELxLo4YNN0BJm6lZC5LRXaQpr2xgnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470634; c=relaxed/simple;
	bh=ZrixvhkJhbKZGck4jka4XG69l4/CfS4dYctLM5kLuEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JBeMh5bC7lXUm3FJlFbWWd+8ka/mCuH6nDyDDBwMdoDSEDY8mF1IRiBD0Q9peiIWQ5Ae5ZkpZeHeyWo78APfmv8frYyri9+cBb3pc2cn2umexB1YeMbY60ONKSX2r2RctpD4WM5iizWvMFwgnEJaLKxS8c0ERm1ZOV2hs/pnOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-227-RgW8bFtTPC263FLYeWYyZg-1; Sun, 28 Jan 2024 19:37:05 +0000
X-MC-Unique: RgW8bFtTPC263FLYeWYyZg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:36:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:36:41 +0000
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
Subject: [PATCH next 11/11] minmax: min() and max() don't need to return
 constant expressions
Thread-Topic: [PATCH next 11/11] minmax: min() and max() don't need to return
 constant expressions
Thread-Index: AdpSIVojuBa8D6X6RNmhjGfjyElxVg==
Date: Sun, 28 Jan 2024 19:36:41 +0000
Message-ID: <30b5bc6c60a147f9985b47fb1cc08d2e@AcuMS.aculab.com>
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

After changing the handful of places max() was used to size an on-stack
array to use max_const() it is no longer necessary for min() and max()
to return constant expressions from constant inputs.
Remove the associated logic to reduce the expanded text.

Remove the 'hack' that allowed max(bool, bool).

Fixup the initial block comment to match current reality.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index c08916588425..5e65c98ff256 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -8,13 +8,10 @@
 #include <linux/types.h>
=20
 /*
- * min()/max()/clamp() macros must accomplish three things:
+ * min()/max()/clamp() macros must accomplish several things:
  *
  * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - Retain result as a constant expressions when called with only
- *   constant expressions (to avoid tripping VLA warnings in stack
- *   allocation usage).
  * - Perform signed v unsigned type-checking (to generate compile
  *   errors instead of nasty runtime surprises).
  * - Unsigned char/short are always promoted to signed int and can be
@@ -22,13 +19,19 @@
  * - Unsigned arguments can be compared against non-negative signed consta=
nts.
  * - Comparison of a signed argument against an unsigned constant fails
  *   even if the constant is below __INT_MAX__ and could be cast to int.
+ *
+ * The return value of min()/max() is not a constant expression for
+ * constant parameters - so will trigger a VLA warging if used to size
+ * an on-stack array.
+ * Instead use min_const() or max_const() which do generate constant
+ * expressions and are also valid for static initialisers.
  */
 #define __typecheck(x, y) \
 =09(!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
=20
 /* Allow unsigned compares against non-negative signed constants. */
 #define __is_ok_unsigned(x) \
-=09(is_unsigned_type(typeof(x)) || (__is_constexpr(x) ? (x) + 0 >=3D 0 : 0=
))
+=09(is_unsigned_type(typeof(x)) || (__is_constexpr(x) ? (x) >=3D 0 : 0))
=20
 /* Check for signed after promoting unsigned char/short to int */
 #define __is_ok_signed(x) is_signed_type(typeof((x) + 0))
@@ -53,12 +56,10 @@
 =09typeof(y) __y_##uniq =3D (y);=09=09\
 =09__cmp(op, __x_##uniq, __y_##uniq); })
=20
-#define __careful_cmp(op, x, y, uniq)=09=09=09=09\
-=09__builtin_choose_expr(__is_constexpr((x) - (y)),=09\
-=09=09__cmp(op, x, y),=09=09=09=09\
-=09=09({ _Static_assert(__types_ok(x, y),=09=09\
-=09=09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" =
#op "() before " #op "_t()"); \
-=09=09__cmp_once(op, x, y, uniq); }))
+#define __careful_cmp(op, x, y, uniq) ({=09\
+=09_Static_assert(__types_ok(x, y),=09\
+=09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" #op=
 "() before " #op "_t()"); \
+=09__cmp_once(op, x, y, uniq); })
=20
 #define __careful_cmp_const(op, x, y)=09=09=09=09\
 =09(BUILD_BUG_ON_ZERO(!__is_constexpr((x) - (y))) +=09\
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


