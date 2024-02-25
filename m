Return-Path: <linux-btrfs+bounces-2740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A43B862BE4
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1011C211AA
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68F6199AB;
	Sun, 25 Feb 2024 16:49:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3B17BB5
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879758; cv=none; b=SCuVORd8tG6L32u0rnxFj49O4aKLA5BtZZgLQ3S0Nvz3vb69VAL0acgZwvUPpJQsFNfmFKAL2Z01VenuTsMuUBfp8mzCWdRpDawKroZzyWICd3Ory46XHVPH/LSaPUq8R7QyvICEgU7uxGn4L1idNcCxYAwJH+qplLfXJI49Dog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879758; c=relaxed/simple;
	bh=8ye8TjxJr7Qpfxmc8F8Nww5LIwfQZHhRr6Lbkiz0KUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=S4Hv4TJxzJu7Rm3MUmKnAvoi0i+/+vBV48kpUW0VFn1aGeaD67p3HIb/CgRNz7Py9QZvrcaB0R+tkpK7GyfLp7cKara2sAFml3TumOlyDNcWDNpKpoN7yh6ZPyAboVQYCikmJ6bRrtdkWvGnvSF1lr//tUAcpy8c7el5d8QhOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-198-BfGlJeiVOxaAMdciN2scyQ-1; Sun, 25 Feb 2024 16:49:11 +0000
X-MC-Unique: BfGlJeiVOxaAMdciN2scyQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 16:49:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 16:49:10 +0000
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
Subject: [PATCH next v2 02/11] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Topic: [PATCH next v2 02/11] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Index: AdpoComWnYboZopTTWeIFfAWCv2rOw==
Date: Sun, 25 Feb 2024 16:49:10 +0000
Message-ID: <8059bc04da1a45bc810ac339a1129a4c@AcuMS.aculab.com>
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

The wrapper just adds two more lines of error output when the test fails.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Changes for v2:
- Typographical and spelling corrections to the commit messages.
  Patches unchanged.

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 63c45865b48a..900eec7a28e5 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -48,7 +48,7 @@
 #define __cmp_once(op, x, y, unique_x, unique_y) ({=09\
 =09typeof(x) unique_x =3D (x);=09=09=09\
 =09typeof(y) unique_y =3D (y);=09=09=09\
-=09static_assert(__types_ok(x, y),=09=09=09\
+=09_Static_assert(__types_ok(x, y),=09=09=09\
 =09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" #op=
 "() before " #op "_t()"); \
 =09__cmp(op, unique_x, unique_y); })
=20
@@ -137,11 +137,11 @@
 =09typeof(val) unique_val =3D (val);=09=09=09=09=09=09\
 =09typeof(lo) unique_lo =3D (lo);=09=09=09=09=09=09\
 =09typeof(hi) unique_hi =3D (hi);=09=09=09=09=09=09\
-=09static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),=09\
+=09_Static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),=09\
 =09=09=09(lo) <=3D (hi), true),=09=09=09=09=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
-=09static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=09=
\
-=09static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=09=
\
+=09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
+=09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
 =09__clamp(unique_val, unique_lo, unique_hi); })
=20
 #define __careful_clamp(val, lo, hi) ({=09=09=09=09=09\
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


