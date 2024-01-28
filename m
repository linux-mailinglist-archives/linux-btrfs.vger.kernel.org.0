Return-Path: <linux-btrfs+bounces-1867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21183F967
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A49B20ED3
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EDF36AE1;
	Sun, 28 Jan 2024 19:31:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE931A81
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470311; cv=none; b=p3wcYktQCrjuEwthnH73dFJ3+Apzmxz/FT6T/Da5KHJ8dYsErzk7Xa7y8TX+vXGXO2SemLTsfDx7FVM7I6uHGOsbHQp7xjUIVla7WhbWNyhZnoHqBrZjUJWDFemxvo9KzNieR5+wGgdr0EI8GrfFT8E+JMCgO9ZqEnNlJrCk/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470311; c=relaxed/simple;
	bh=7CXwjdiDT55ZZOOhjTgeG/9fLB0VllvCffmj//4XF4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=K+nrfsFAe6hwbx1lXwQC8X7Ajr+MZo1/a5ourRDDQpKo1w3EvNlw0kcX3qbjmXqoGvEuGwRAsPihZFqHHrsP0x7ooJIpUq97K22QHpBfPIVpotUpKyFapmshXGmHjXoKdBXxDTIzQcteNshHKDKuAJvRX7iKOMAQcSUjzrvIBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-169-WRvxRy7ONzyzi7NxjGX4Dw-1; Sun, 28 Jan 2024 19:31:47 +0000
X-MC-Unique: WRvxRy7ONzyzi7NxjGX4Dw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:31:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:31:22 +0000
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
Subject: RE: [PATCH next 0711] minmax: minmax: Add __types_ok3() and optimise
 defines with 3 arguments
Thread-Topic: [PATCH next 0711] minmax: minmax: Add __types_ok3() and optimise
 defines with 3 arguments
Thread-Index: AdpSIJ67DKuJ6SuSTnaAcsGvmvekeg==
Date: Sun, 28 Jan 2024 19:31:22 +0000
Message-ID: <78f9c15ad67940fe91ac39b9c26113be@AcuMS.aculab.com>
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

min3() and max3() were added to optimise nested min(x, min(y, z))
sequences, bit only moved where the expansion was requiested.

Add a separate implementation for 3 argument calls.
These are never required to generate constant expressiions to
remove that logic.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 5c7fce76abe5..278a390b8a4c 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -38,6 +38,11 @@
 =09((__is_ok_signed(x) && __is_ok_signed(y)) ||=09\
 =09 (__is_ok_unsigned(x) && __is_ok_unsigned(y)))
=20
+/* Check three values for min3(), max3() and clamp() */
+#define __types_ok3(x, y, z)=09=09=09=09=09=09=09\
+=09((__is_ok_signed(x) && __is_ok_signed(y) && __is_ok_signed(z)) ||=09\
+=09 (__is_ok_unsigned(x) && __is_ok_unsigned(y) && __is_ok_unsigned(z)))
+
 #define __cmp_op_min <
 #define __cmp_op_max >
=20
@@ -87,13 +92,24 @@
 #define umax(x, y)=09\
 =09__careful_cmp(max, __zero_extend(x), _zero_extend(y), __COUNTER__)
=20
+#define __cmp_once3(op, x, y, z, uniq) ({=09\
+=09typeof(x) __x_##uniq =3D (x);=09=09\
+=09typeof(x) __y_##uniq =3D (y);=09=09\
+=09typeof(x) __z_##uniq =3D (z);=09=09\
+=09__cmp(op, __cmp(op, __x_##uniq, __y_##uniq), __z_##uniq); })
+
+#define __careful_cmp3(op, x, y, z, uniq) ({=09=09=09=09\
+=09static_assert(__types_ok3(x, y, z),=09=09=09=09\
+=09=09#op "3(" #x ", " #y ", " #z ") signedness error");=09\
+=09__cmp_once3(op, x, y, z, uniq); })
+
 /**
  * min3 - return minimum of three values
  * @x: first value
  * @y: second value
  * @z: third value
  */
-#define min3(x, y, z) min((typeof(x))min(x, y), z)
+#define min3(x, y, z) __careful_cmp3(min, x, y, z, __COUNTER__)
=20
 /**
  * max3 - return maximum of three values
@@ -101,7 +117,7 @@
  * @y: second value
  * @z: third value
  */
-#define max3(x, y, z) max((typeof(x))max(x, y), z)
+#define max3(x, y, z) __careful_cmp3(max, x, y, z, __COUNTER__)
=20
 /**
  * min_t - return minimum of two values, using the specified type
@@ -142,8 +158,7 @@
 =09__clamp(__val_##uniq, __lo_##uniq, __hi_##uniq); })
=20
 #define __careful_clamp(val, lo, hi, uniq) ({=09=09=09=09=09\
-=09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
-=09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
+=09_Static_assert(__types_ok3(val, lo, hi), "clamp() signedness error");=
=09\
 =09__clamp_once(val, lo, hi, uniq); })
=20
 /**
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


