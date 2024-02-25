Return-Path: <linux-btrfs+bounces-2748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D98862C2A
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA8C28193F
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4705718B1B;
	Sun, 25 Feb 2024 16:56:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DF17BD4
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880181; cv=none; b=uJgxffw8Tx37FFkNgSsqYxgBpnRFqVwk5T62NpRcbkD+iJQzIOYTYbRdKW5WYjpaX6LzPVpFnZ4IA6kMVcGEd/F9gEOfzOS4g1O3f59udR+uX5gy1+7NXbynfCWpMU0UMcnN/2wIsvN/+JwFNw0q0iv6oRLCr0wEYqOv/KAP30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880181; c=relaxed/simple;
	bh=zOWFqzB7N0pb8vLD4U0rutFH4q0ufXT6YzwjVxhLXv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=am6ga1zFqipkVcxcrlHgfZIYr/5+ZmwKEjXc/p8MrLu3xCyT5cUXU7RrAB6V1DpJOJ7sLjriqqvjg4WS5VAdS1bfrXui5EuuLWRkHbwCvd3k/tnqAFSxZym4dIOiqNZWByV7NLmMuShtrFBuwfTJEGOwiTxtK1dgAdzV7BxIM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-4eUIVhTQPOq-JwK6Hr19cA-1; Sun, 25 Feb 2024 16:56:17 +0000
X-MC-Unique: 4eUIVhTQPOq-JwK6Hr19cA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 16:56:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 16:56:16 +0000
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
Subject: [PATCH next v2 10/11] block: Use a boolean expression instead of
 max() on booleans
Thread-Topic: [PATCH next v2 10/11] block: Use a boolean expression instead of
 max() on booleans
Thread-Index: AdpoC3sh/004JKwJQQKikvnz7Zkpuw==
Date: Sun, 25 Feb 2024 16:56:16 +0000
Message-ID: <9561641946f1404b931d97a576bfbb28@AcuMS.aculab.com>
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

blk_stack_limits() contains:
=09t->zoned =3D max(t->zoned, b->zoned);
These are bool, so can be replaced by bitwise or.
However it generates:
error: comparison of constant '0' with boolean expression is always true [-=
Werror=3Dbool-compare]
inside the signedness check that max() does unless a '+ 0' is added.
It is a shame the compiler generates this warning for code that will
be optimised away.

Change so that the extra '+ 0' can be removed.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes for v2:
- Typographical and spelling corrections to the commit messages.
  Patches unchanged.

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 06ea91e51b8b..9ca21fea039d 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -688,7 +688,7 @@ int blk_stack_limits(struct queue_limits *t, struct que=
ue_limits *b,
 =09=09=09=09=09=09   b->max_secure_erase_sectors);
 =09t->zone_write_granularity =3D max(t->zone_write_granularity,
 =09=09=09=09=09b->zone_write_granularity);
-=09t->zoned =3D max(t->zoned, b->zoned);
+=09t->zoned =3D t->zoned | b->zoned;
 =09return ret;
 }
 EXPORT_SYMBOL(blk_stack_limits);
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


