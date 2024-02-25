Return-Path: <linux-btrfs+bounces-2749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B09862C2E
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4D1B20EB4
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86FC1B809;
	Sun, 25 Feb 2024 16:57:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985E17BC2
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880231; cv=none; b=rogPXRT8C4cSaaF5ufXqTV77IyQZJhzrEapRBc9jMlphD6xKAV6hTXowqQG+FyiEGGZspDy30HoC7vr/BjZVMV43l0Dr/AdpRWUORUJpedyvdhu1G1VB0sfmGSrxeWgE4IXNtrqpqPF8e8Y0bsfcidxozWohYpEebsBcOPf4E3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880231; c=relaxed/simple;
	bh=ldiOEy1AqqZRm2jpxplq9I8qQHwbubdPAOsFwLgRl3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=auXkzj4NXpZ2hDcA6vGYztqHxNQpORLUz+A5jYVRcDeuM9iWs5NgqPCkgiJ1pLmt7NfkCeszrL/FYIyQodHKMCd0wFRsqI2kFKQzV7mFLuwoogFEF8VOrHzSIAIvMqCcAXjDRkAxV80HEePnrb7P1nMG5l+mtT3WaUwUxbdqet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-DBxHGHkZP8yW0XsruhqEOw-1; Sun, 25 Feb 2024 16:57:00 +0000
X-MC-Unique: DBxHGHkZP8yW0XsruhqEOw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 16:56:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 16:56:59 +0000
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
Subject: [PATCH next v2 11/11] minmax: min() and max() don't need to return
 constant expressions
Thread-Topic: [PATCH next v2 11/11] minmax: min() and max() don't need to
 return constant expressions
Thread-Index: AdpoC6KUHy5Z1N7yRkiaBkc7ZdEdRQ==
Date: Sun, 25 Feb 2024 16:56:58 +0000
Message-ID: <a18dcae310f74dcb9c6fc01d5bdc0568@AcuMS.aculab.com>
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

Changes for v2:
- Typographical and spelling corrections to the commit messages.
  Patches unchanged.

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


