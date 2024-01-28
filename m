Return-Path: <linux-btrfs+bounces-1868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05083F96C
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4011B1C215CF
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12663BB55;
	Sun, 28 Jan 2024 19:33:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDB31A89
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470385; cv=none; b=mgjVifkmyyFILlxyNKir7t9mtcAXqOVwtD/IA0TMlY5ktmnhiGi2A9MSgjtqhKqRhlP9UfQJLUsvnXtzwOXlGNH0UN+YnPJnW++QuLcZJ4zYBwws1ggnX9xyeud+c+nW8AhFYZP2fF5Gl1RRqT5pYsm2kCpZwga+GU79XjXl+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470385; c=relaxed/simple;
	bh=Cvne2zLpLHEm/ZIJGi/lxJc8QnXVqT2f4MsKcA1INnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HXTLO4LrM+zF6lypjcXLKNUCdYHZrQJzj3ih5rV+5xghzIbUpkcxAf24/RqVaWkJV57AFLl8WDmB6eO2GLvtfkIWRMPJgKcIYXsA1LNB6jrVl/P1l+Iq2TA67dy4Pl+59q+SK8Z+Rx6xIzWqJ3C9jLVIf3/aj+aX2uZ4abs5Rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-20-3y7XOynoO5CZtz2J7xeVDg-1; Sun, 28 Jan 2024 19:33:00 +0000
X-MC-Unique: 3y7XOynoO5CZtz2J7xeVDg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:32:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:32:36 +0000
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
Subject: [PATCH next 08/11 minmax: Add min_const() and max_const()
Thread-Topic: [PATCH next 08/11 minmax: Add min_const() and max_const()
Thread-Index: AdpSIMoE/wNceAjoSdeU09EW7XnMUA==
Date: Sun, 28 Jan 2024 19:32:36 +0000
Message-ID: <489d199159794ebcbd3d18d4082a88d7@AcuMS.aculab.com>
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

The expansions of min() and max() contain statement expressions so are
not valid for static intialisers.
min_const() and max_const() are expressions so can be used for static
initialisers.
The arguments are checked for being constant and for negative signed
values being converted to large unsigned values.

Using these to size on-stack arrays lets min/max be simplified.
Zero is added before the compare to convert enum values to integers
avoinding the need for casts when enums have been used for constants.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 278a390b8a4c..c08916588425 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -60,19 +60,34 @@
 =09=09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" =
#op "() before " #op "_t()"); \
 =09=09__cmp_once(op, x, y, uniq); }))
=20
+#define __careful_cmp_const(op, x, y)=09=09=09=09\
+=09(BUILD_BUG_ON_ZERO(!__is_constexpr((x) - (y))) +=09\
+=09=09BUILD_BUG_ON_ZERO(!__types_ok(x, y)) +=09=09\
+=09=09__cmp(op, (x) + 0, (y) + 0))
+
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
  * @y: second value
+ *
+ * If @x and @y are constants the return value is constant, but not 'const=
ant
+ * enough' for things like static initialisers.
+ * min_const(@x, @y) is a constant expression for constant inputs.
  */
 #define min(x, y)=09__careful_cmp(min, x, y, __COUNTER__)
+#define min_const(x, y)=09__careful_cmp_const(min, x, y)
=20
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
  * @y: second value
+ *
+ * If @x and @y are constants the return value is constant, but not 'const=
ant
+ * enough' for things like static initialisers.
+ * max_const(@x, @y) is a constant expression for constant inputs.
  */
 #define max(x, y)=09__careful_cmp(max, x, y, __COUNTER__)
+#define max_const(x, y)=09__careful_cmp_const(max, x, y)
=20
 /**
  * umin - return minimum of two non-negative values
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


