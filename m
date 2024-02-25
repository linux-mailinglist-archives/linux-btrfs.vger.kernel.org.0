Return-Path: <linux-btrfs+bounces-2743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11874862BF1
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D0281B1F
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579FA182B5;
	Sun, 25 Feb 2024 16:51:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F9171BB
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879905; cv=none; b=hxO4ZXZBiicvqEILlFbU0b9QSf53fu+fOPei0H2daabye2WFfbX2pnBWSY6xjrEx/ChqgmWC4w0FICq5+tkGvMy82rNf6l3A/Kwrq3WO5HuRxzAymqyHQ6m5Xhl2wybKDJESwbu4uMHUmlh+KxSmGOQzf0V6FptxnyA8Twh/G+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879905; c=relaxed/simple;
	bh=fdTN5Jl2KPnVZr1KBcvoZ0inLKUD64eRXNqOy4BklWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qsgBQ0V/AdLnMC35MeINSXHV35h2dV4HZiSGdJb2zSElI0HdCOZ9+fqVJQsN63SO5veQzk6HKtgoFxvh+J2nQuLV036jAZutru6CMUYveAZBbk8O5UzLhYDfijNgi45PzXKnZh9Tapn0U54BbxtoLsCPTKYRHLHs86bT2PwAXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-162-Lu8Z5gaeMJOpXAp0JCRhCA-1; Sun, 25 Feb 2024 16:51:40 +0000
X-MC-Unique: Lu8Z5gaeMJOpXAp0JCRhCA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 16:51:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 16:51:39 +0000
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
Subject: [PATCH next v2 05/11] minmax: Move the signedness check out of
 __cmp_once() and __clamp_once()
Thread-Topic: [PATCH next v2 05/11] minmax: Move the signedness check out of
 __cmp_once() and __clamp_once()
Thread-Index: AdpoCtyXoWYCYse4RrSXey2WeynGfg==
Date: Sun, 25 Feb 2024 16:51:39 +0000
Message-ID: <996e4d9df3a845488d740b90934a668c@AcuMS.aculab.com>
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

There is no need to do the signedness/type check when the arguments
are being cast to a fixed type.
So move the check out of __xxx_once() into __careful_xxx().

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Changes for v2:
- Typographical and spelling corrections to the commit messages.
  Patches unchanged.

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 8ee003d8abaf..111c52a14fe5 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -46,14 +46,14 @@
 #define __cmp_once(op, x, y, uniq) ({=09=09\
 =09typeof(x) __x_##uniq =3D (x);=09=09\
 =09typeof(y) __y_##uniq =3D (y);=09=09\
-=09_Static_assert(__types_ok(x, y),=09\
-=09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" #op=
 "() before " #op "_t()"); \
 =09__cmp(op, __x_##uniq, __y_##uniq); })
=20
 #define __careful_cmp(op, x, y, uniq)=09=09=09=09\
 =09__builtin_choose_expr(__is_constexpr((x) - (y)),=09\
 =09=09__cmp(op, x, y),=09=09=09=09\
-=09=09__cmp_once(op, x, y, uniq))
+=09=09({ _Static_assert(__types_ok(x, y),=09=09\
+=09=09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" =
#op "() before " #op "_t()"); \
+=09=09__cmp_once(op, x, y, uniq); }))
=20
 /**
  * min - return minimum of two values of the same or compatible types
@@ -139,14 +139,14 @@
 =09_Static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),=09\
 =09=09=09(lo) <=3D (hi), true),=09=09=09=09=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
-=09_Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");=
=09\
-=09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");=
=09\
 =09__clamp(__val_##uniq, __lo_##uniq, __hi_##uniq); })
=20
-#define __careful_clamp(val, lo, hi, uniq) ({=09=09=09=09\
+#define __careful_clamp(val, lo, hi, uniq)=09=09=09=09\
 =09__builtin_choose_expr(__is_constexpr((val) - (lo) + (hi)),=09\
 =09=09__clamp(val, lo, hi),=09=09=09=09=09\
-=09=09__clamp_once(val, lo, hi, uniq)); })
+=09=09({ _Static_assert(__types_ok(val, lo), "clamp() 'lo' signedness erro=
r");=09\
+=09=09_Static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error")=
;=09\
+=09=09__clamp_once(val, lo, hi, uniq); }))
=20
 /**
  * clamp - return a value clamped to a given range with strict typecheckin=
g
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


