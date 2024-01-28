Return-Path: <linux-btrfs+bounces-1860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9083F94E
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12301B2197E
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35313C06A;
	Sun, 28 Jan 2024 19:24:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED331A89
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706469874; cv=none; b=YCmkrq9ciFk0dGuBnavQ6MIxdcSkWz+8FSET8Q3uCrDohsBccc2lbQjgNsRKnVo0oRHiHebVYAT0PCvmakrGd14CnLMd5vPNgILJAKVWOqzhTGRn4v7CXT8PCMUjrB3hJyZz0r1bFHS67/OmY7aG5+4kZR0RNA5oAOksVaxAkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706469874; c=relaxed/simple;
	bh=T4RCWv5uss4M6yQTVWwuqyFQKs36lxD+eRGhXyetk/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a2KdLkrKlv+nk0ae0V2tWjg/rh4bbMctDHL4FidJDojx6MWxyuJFSGTn/04glYeNfMDznj2ZCn1W0GhxzROWkHC4PYqJMRNYjDjhCJ7FGzaayv1lp8KzntKYlYKePYU3srAxfrQ/klDpyyIkSk0HsjFRqaApRCejPcxdg0zhp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-155-TMmSv8-RPQmEDi-VJtAU0w-1; Sun, 28 Jan 2024 19:24:28 +0000
X-MC-Unique: TMmSv8-RPQmEDi-VJtAU0w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:24:03 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:24:03 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, Netdev <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>, 'Andrew Morton'
	<akpm@linux-foundation.org>, "'Matthew Wilcox (Oracle)'"
	<willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>, "'Dan
 Carpenter'" <dan.carpenter@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>, "David S . Miller" <davem@davemloft.net>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 'Jens Axboe'
	<axboe@kernel.dk>
Subject: [PATCH next 00/11] minmax: Optimise to reduce .i line length.
Thread-Topic: [PATCH next 00/11] minmax: Optimise to reduce .i line length.
Thread-Index: AdpSH3AbqTsF4YRmSE2KNmeAVHpUdw==
Date: Sun, 28 Jan 2024 19:24:03 +0000
Message-ID: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
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

The changes to minmax.h that changed the type check to a signedness
check significantly increased the length of the expansion.
In some cases it has also significantly increased compile type.
This is particularly noticeable for nested expansions.

The fact that _Static_assert() only requires a compile time constant
not a constant expression allows a lot of simplification.

The other thing that complicates the expansion is the necessity of
returning a constant expression from constant arguments (for VLA).
I can only find a handful of places this is done.
Penalising most of the code for these few cases seems 'suboptimal'.
Instead I've added min_const() and max_const() for VLA and static
initialisers, these check the arguments are constant to avoid misuse.

Patch [9] is dependent on the earlier patches.
Patch [10] isn't dependant on them.
Patch [11] depends on both 9 and 10.

David Laight (11):
  [1] minmax: Put all the clamp() definitions together
  [2] minmax: Use _Static_assert() instead of static_assert()
  [3] minmax: Simplify signedness check
  [4] minmax: Replace multiple __UNIQUE_ID() by directly using __COUNTER__
  [5] minmax: Move the signedness check out of __cmp_once() and
    __clamp_once()
  [6] minmax: Remove 'constexpr' check from __careful_clamp()
  [7] minmax: minmax: Add __types_ok3() and optimise defines with 3
    arguments
  [8] minmax: Add min_const() and max_const()
  [9] tree-wide: minmax: Replace all the uses of max() for array sizes with
    max_const().
  [10] block: Use a boolean expression instead of max() on booleans
  [11] minmax: min() and max() don't need to return constant expressions

 block/blk-settings.c                          |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   2 +-
 drivers/gpu/drm/drm_color_mgmt.c              |   4 +-
 drivers/input/touchscreen/cyttsp4_core.c      |   2 +-
 .../net/can/usb/etas_es58x/es58x_devlink.c    |   2 +-
 fs/btrfs/tree-checker.c                       |   2 +-
 include/linux/minmax.h                        | 211 ++++++++++--------
 lib/vsprintf.c                                |   4 +-
 net/ipv4/proc.c                               |   2 +-
 net/ipv6/proc.c                               |   2 +-
 10 files changed, 127 insertions(+), 106 deletions(-)

--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


