Return-Path: <linux-btrfs+bounces-2783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11D8670A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 11:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FF51F2BB3D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360B5579F;
	Mon, 26 Feb 2024 10:07:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901B208B4
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942030; cv=none; b=tEIRQVEAvEk6MoGL5lP91qdRpwuwJk+8wVakw1lrcuynx55FTyXQlyHT8Nzv6PbFhdE+u8P+sbg38H//+D5h4bpvvl3F43dNXSv/kCfKII4Si49DQXkXUvfwg0ou+wkxRraRt3ASvpGOXeqDywk2MWABGOpF4Ao/746UzIHz06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942030; c=relaxed/simple;
	bh=tjXnZ4goM1qumYJwf47U7+WWJdpRRWcTWLqYqEFbbQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=RDxrYOy5iOH2YdztKCv8t8h4UNYAKZiuapmKrvMA4xKP/VEFWYhcA5jkEjtvMnRUkAMTKdy97QaG6s96q3HJvEAAgtJYutdLsEg5RV9OaQJ71S/F9ehdGF1YSwD7N7S6Slahlitbk7gy8yfUrUs9gbyP6obQiNjL64hvu8neBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-28-hJeJAT_oPHyxzCcPYljXKg-1; Mon, 26 Feb 2024 10:07:05 +0000
X-MC-Unique: hJeJAT_oPHyxzCcPYljXKg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Feb
 2024 10:07:04 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 26 Feb 2024 10:07:04 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jani Nikula' <jani.nikula@linux.intel.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, 'Netdev'
	<netdev@vger.kernel.org>, "'dri-devel@lists.freedesktop.org'"
	<dri-devel@lists.freedesktop.org>
CC: 'Jens Axboe' <axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'"
	<willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>,
	"'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>, "'Andrew
 Morton'" <akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, "'David S . Miller'"
	<davem@davemloft.net>, 'Dan Carpenter' <dan.carpenter@linaro.org>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH next v2 02/11] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Topic: [PATCH next v2 02/11] minmax: Use _Static_assert() instead of
 static_assert()
Thread-Index: AdpoComWnYboZopTTWeIFfAWCv2rOwAi5neAAAEPFJA=
Date: Mon, 26 Feb 2024 10:07:03 +0000
Message-ID: <824b0f70413d4570bcc97b39aad81a93@AcuMS.aculab.com>
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
 <8059bc04da1a45bc810ac339a1129a4c@AcuMS.aculab.com>
 <87v86bo9qi.fsf@intel.com>
In-Reply-To: <87v86bo9qi.fsf@intel.com>
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

From: Jani Nikula
> Sent: 26 February 2024 09:28
>=20
> On Sun, 25 Feb 2024, David Laight <David.Laight@ACULAB.COM> wrote:
> > The wrapper just adds two more lines of error output when the test fail=
s.
>=20
> There are only a handful of places in kernel code that use
> _Static_assert() directly. Nearly 900 instances of static_assert().

How many of those supply an error message?

> Are we now saying it's fine to use _Static_assert() directly all over
> the place? People will copy-paste and cargo cult.

Is that actually a problem?
The wrapper allows the error message to be omitted and substitutes
the text of the conditional.
But it isn't 'free'.
As well as slightly slowing down the compilation, the error messages
from the compiler get more difficult to interpret.

Most of the static_assert() will probably never generate an error.
But the ones in min()/max() will so it is best to make them as
readable as possible.
(Don't even look as the mess clang makes....)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


