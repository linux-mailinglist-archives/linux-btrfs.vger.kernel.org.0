Return-Path: <linux-btrfs+bounces-2741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DDD862BE7
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515561C20840
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92218045;
	Sun, 25 Feb 2024 16:50:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A491175A7
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879806; cv=none; b=FzPzRN9LoVNGe14IMTPG/uEiF5Y1gLsilVTa65TriPzoeMPen42+CDbqzr9JFTIR3ElIEW/ayx50ESEVMLXt4JvbyL8D4mkJBtwGiSHkg7jcAP1CM2/TfC7d1qrkE4yIifNZQ1cqMBoIRPSRwdjaWgr4/TvmG2wGiuwxkIZtxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879806; c=relaxed/simple;
	bh=URi7AE+I5CngHeVQukg72Q07R1uxCOMsGMofCc3A+30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=blEsXP66cBYuRUbt7a+Mf0k6IjsUDHr84WT5921wPD4xgN2LBH3MY2Njdd+LZOA/YVl23Lw+tnvfDovE03WnBVZ3sXJlNdZ/VMpV2dsCObJdFzjcUrNtdcZmaEC/zAEREpm+Leych5tpCdLDDfmET2zc/r8g3nMgkoyZ93ZwgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-43-W8RGFR3EPR-AcuGUd8JL4Q-1; Sun, 25 Feb 2024 16:50:00 +0000
X-MC-Unique: W8RGFR3EPR-AcuGUd8JL4Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 16:49:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 16:49:59 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, 'Netdev'
	<netdev@vger.kernel.org>, "'dri-devel@lists.freedesktop.org'"
	<dri-devel@lists.freedesktop.org>
CC: 'Jens Axboe' <axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'"
	<willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>,
	"'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>, "'Andrew
 Morton'" <akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, "'David S . Miller'"
	<davem@davemloft.net>, 'Dan Carpenter' <dan.carpenter@linaro.org>, "'Jani
 Nikula'" <jani.nikula@linux.intel.com>
Subject: [PATCH next v2 03/11] minmax: Simplify signedness check
Thread-Topic: [PATCH next v2 03/11] minmax: Simplify signedness check
Thread-Index: AdpoCqfCgp/0gHjwSqumBl0qZkMqdg==
Date: Sun, 25 Feb 2024 16:49:59 +0000
Message-ID: <8657dd5c2264456f8a005520a3b90e2b@AcuMS.aculab.com>
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
In-Reply-To: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
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

It is enough to check that both 'x' and 'y' are valid for either
a signed compare or an unsigned compare.
For unsigned they must be an unsigned type or a positive constant.
For signed they must be signed after unsigned char/short are promoted.

The predicate for _Static_assert() only needs to be a compile-time
constant not a constant integeger expression.
In particular the short-circuit evaluation of || && ?: can be used
to avoid the non-constantness of (pointer_type)1 in is_signed_type().

The '+ 0' in '(x) + 0 > =3D 0' is there to convert 'bool' to 'int'
and avoid a compiler warning because max() gets used for 'bool'
in one place (a very expensive 'or').
(The code is optimised away by two earlier checks - but the compiler
still bleats.)

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

Changes for v2:
- Typographical and spelling corrections to the commit messages.
  Patches unchanged.

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 900eec7a28e5..c32b4b40ce01 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
=20
 /*
- * min()/max()/clamp() macros must accomplish three things:
+ * min()/max()/clamp() macros must accomplish several things:
  *
  * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
@@ -26,19 +26,17 @@
 #define __typecheck(x, y) \
 =09(!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
=20
-/* is_signed_type() isn't a constexpr for pointer types */
-#define __is_signed(x) =09=09=09=09=09=09=09=09\
-=09__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),=09\
-=09=09is_signed_type(typeof(x)), 0)
+/* Allow unsigned compares against non-negative signed constants. */
+#define __is_ok_unsigned(x) \
+=09(is_unsigned_type(typeof(x)) || (__is_constexpr(x) ? (x) + 0 >=3D 0 : 0=
))
=20
-/* True for a non-negative signed int constant */
-#define __is_noneg_int(x)=09\
-=09(__builtin_choose_expr(__is_constexpr(x) && __is_signed(x), x, -1) >=3D=
 0)
+/* Check for signed after promoting unsigned char/short to int */
+#define __is_ok_signed(x) is_signed_type(typeof((x) + 0))
=20
-#define __types_ok(x, y) =09=09=09=09=09\
-=09(__is_signed(x) =3D=3D __is_signed(y) ||=09=09=09\
-=09=09__is_signed((x) + 0) =3D=3D __is_signed((y) + 0) ||=09\
-=09=09__is_noneg_int(x) || __is_noneg_int(y))
+/* Allow if both x and y are valid for either signed or unsigned compares.=
 */
+#define __types_ok(x, y)=09=09=09=09\
+=09((__is_ok_signed(x) && __is_ok_signed(y)) ||=09\
+=09 (__is_ok_unsigned(x) && __is_ok_unsigned(y)))
=20
 #define __cmp_op_min <
 #define __cmp_op_max >
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


