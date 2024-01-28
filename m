Return-Path: <linux-btrfs+bounces-1862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E283F953
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6258282A82
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 19:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D5321B0;
	Sun, 28 Jan 2024 19:27:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FB31A73
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470049; cv=none; b=Ioc1MughsIU+3g9/boOIe/yueVnOuVjE3f6jtz2JBF6snKNzNkjhDPBangpdsvzm0CCwgVkhRoUMAngwK8sqHEd6teA51+wcjP2eoR9aikInMaEMzkCN1oGt8D8+ET1XUAUIwIugaak9zDLygMr/Qwq5xCf7zbK1M07BJ3AQ+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470049; c=relaxed/simple;
	bh=4PlX85F8IQmYp6Gqt8heE31KxwL9l77v53lRBRlREpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mpGJjMUBBeEHr6iC1iaO5/WOZJVe0Pe8YEAoSdjDV4+xawhUThK/ni5e9FfIdYRofGCerpO2k+ZOqSmzb/oDJhjFtiFuDEvajTBoJ3Uz61zeKTZxuMY1oStM2hfokCRks42wDNLvrL5HrLI+nH8Nm7X/N+Sy4A8FzgUNAwU7YRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-159-rCbWEvFaNbeFCgOxkdKWkw-1; Sun, 28 Jan 2024 19:27:25 +0000
X-MC-Unique: rCbWEvFaNbeFCgOxkdKWkw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:27:01 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:27:01 +0000
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
Subject: RE: [PATCH next 02/11] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Topic: [PATCH next 02/11] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Index: AdpSIAEy7Smj9oosQ+KB7MRH0ZnbRA==
Date: Sun, 28 Jan 2024 19:27:01 +0000
Message-ID: <bfdbd45e23c840988540dc0d810f8e21@AcuMS.aculab.com>
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

The wrapper just adds two more lines of error output when the test fails.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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


