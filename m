Return-Path: <linux-btrfs+bounces-2744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF0862BF7
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCD5281AF6
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8E18B09;
	Sun, 25 Feb 2024 16:52:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2217BB5
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879950; cv=none; b=E/YlOZqOkdZ/VNF7TskXwFa8kXq6HTUgAeTXFFNvgkUq5PYZlPevLA1qaZExkvBpLcUeDemg/MA6NjjjEgomq9Qw81pj3OtRjduw5YImRoLgU8j0xKDsR6ba8XOi5OPTlDcyoQhIeAwKNwNzQRg8HsIHLdeJKqBiJSk3q/xoPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879950; c=relaxed/simple;
	bh=dxzwutw/uYInR/fAygjwtW6vRzUH7ChzCxCY1kqoRdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NINFFiW6v+cKxXkz2pPZsBaJACW8A/SXvQZsX+XObCWfGNDJRCzt4iMtPmUD/F/g9yBd9QWGa7lxoxLaVMoKCo2wbKUjhquWRagwBYm/oG9lUzlpXZ6nsVNZWb9bx7nhxHXhNF2olfSuBItsD8QUiRXAab3PoIh7hTcUIxdLVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-98-15ZuON0NN0C4fR-488HG-w-1; Sun, 25 Feb 2024 16:52:24 +0000
X-MC-Unique: 15ZuON0NN0C4fR-488HG-w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 16:52:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 16:52:22 +0000
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
Subject: [PATCH next v2 06/11] minmax: Remove 'constexpr' check from
 __careful_clamp()
Thread-Topic: [PATCH next v2 06/11] minmax: Remove 'constexpr' check from
 __careful_clamp()
Thread-Index: AdpoCvvrOCX/oa+QSiiCG9QfHbI0jw==
Date: Sun, 25 Feb 2024 16:52:22 +0000
Message-ID: <c91f7fb1f5104a57af820e955c254249@AcuMS.aculab.com>
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

Nothing requires that clamp() return a constant expression.
The logic to do so significantly increases the .i file.
Remove the check and directly expand __clamp_once() from clamp_t()
since the type check can't fail.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Changes for v2:
- Typographical and spelling corrections to the commit messages.
  Patches unchanged.

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


