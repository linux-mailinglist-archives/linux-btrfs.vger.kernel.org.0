Return-Path: <linux-btrfs+bounces-1866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78883F962
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227C2B2125E
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068436138;
	Sun, 28 Jan 2024 19:31:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A031A81
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470261; cv=none; b=uJkZgnWFo4o23LEmnwqRvOWBCkjmNIdIMcdfInMzCcneaCTwJPCzZs5Pcv6/9hvViR4pKFiEXmxYU8crJ5a/beBK+tfKy8sghuWRfDQXiXu2ofw+yRU+FTid3+yGX97NPAA3KfIIBTKi3Pufl55wX1J4pc0oFzqM32WHVa1FHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470261; c=relaxed/simple;
	bh=+IrvWOPrzG/zw8pSAZuMCFpCBK3uf5ox+sEpIcxcuDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mFvqWUKP2ex5f1Twp0ht7z/1Fmi8gB1C1NKli72A0rSz9WVGjqLmo9xfOl0hdDVKaIw+yVcGacQRb7vkEAPE9fLoXUFiRaBFKi69ShKowktM4Sv0cycLgZbTN8ZCJZSPDpvRaO7JukBBiNlGX2Ttk9qIz+4BiZrOm3DHjW+ErwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-54-7ZbHWpVmPmCGvRjzXyD65A-1; Sun, 28 Jan 2024 19:30:56 +0000
X-MC-Unique: 7ZbHWpVmPmCGvRjzXyD65A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:30:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:30:32 +0000
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
Subject: RE: [PATCH next 00611] minmax: Remove 'constexpr' check from
 __careful_clamp()
Thread-Topic: [PATCH next 00611] minmax: Remove 'constexpr' check from
 __careful_clamp()
Thread-Index: AdpSIH76BAHML8iRQIeOmBtN5r1qZw==
Date: Sun, 28 Jan 2024 19:30:32 +0000
Message-ID: <f353164c5fe8483399ffc5200f21b970@AcuMS.aculab.com>
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

Nothing requires that clamp() return a constant expression.
The logic to do so significantly increases the .i file.
Remove the check and directly expand __clamp_once() from clamp_t()
since the type check can't fail.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 111c52a14fe5..5c7fce76abe5 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -141,12 +141,10 @@
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
 =09__clamp(__val_##uniq, __lo_##uniq, __hi_##uniq); })
=20
-#define __careful_clamp(val, lo, hi, uniq)=09=09=09=09\
-=09__builtin_choose_expr(__is_constexpr((val) - (lo) + (hi)),=09\
-=09=09__clamp(val, lo, hi),=09=09=09=09=09\
-=09=09({ _Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness erro=
r");=09\
-=09=09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error")=
;=09\
-=09=09__clamp_once(val, lo, hi, uniq); }))
+#define __careful_clamp(val, lo, hi, uniq) ({=09=09=09=09=09\
+=09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
+=09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
+=09__clamp_once(val, lo, hi, uniq); })
=20
 /**
  * clamp - return a value clamped to a given range with strict typecheckin=
g
@@ -168,7 +166,9 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) clamp((type)(val), (type)(lo), (type)(h=
i))
+#define __clamp_t(type, val, lo, hi, uniq) \
+=09__clamp_once((type)(val), (type)(lo), (type)(hi), uniq)
+#define clamp_t(type, val, lo, hi) __clamp_t(type, val, lo, hi, __COUNTER_=
_)
=20
 /**
  * clamp_val - return a value clamped to a given range using val's type
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


