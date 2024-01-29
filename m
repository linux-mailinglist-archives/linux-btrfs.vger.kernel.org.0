Return-Path: <linux-btrfs+bounces-1885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E54840153
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD39A1F234F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF935577D;
	Mon, 29 Jan 2024 09:23:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C125576D
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520192; cv=none; b=mJ9r1djbcohdvcJ7Cxm0BMAcO53F1j7yXXlgGUwSKkMS9ANiKdqBAUhpYdJnD0icbh2+xBLx/Lkc+i1WEnlHKz1tmYDpeYa67FcmYsaCmi7J01fCjwVBShHwuM/W9WHy/TNR7lim597b5XpBULx33vvXMSIAYMbhQiBo2BhNfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520192; c=relaxed/simple;
	bh=6G8K2vrcWsK8/sbuRZURPEgtHaWjvBNgWTy/Ndz5Peo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=d3yDipMLUex2RtgrzSHDhBw/dCD3d6kGrbwXPJUUg+iOjdt6VIbHANFR5QnAre7UzquJZcgHnbfIDWblVHglK075s578OJYv4XLCTc3hZ76TAmgoUcSz9dVZ4hNweRAd2ddLQP5VPw/DpGDHi4hniS+m4qaqbawlWIwIYEfMOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-31-yT1IZiFMOyGriZohOn-eyA-1; Mon, 29 Jan 2024 09:23:07 +0000
X-MC-Unique: yT1IZiFMOyGriZohOn-eyA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 29 Jan
 2024 09:22:40 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 29 Jan 2024 09:22:40 +0000
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
	<davem@davemloft.net>, 'Dan Carpenter' <dan.carpenter@linaro.org>
Subject: RE: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
Thread-Topic: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
Thread-Index: AdpSITDgD70hEVnBTjm/gYoTnRBnpgAcWocAAAB9+7A=
Date: Mon, 29 Jan 2024 09:22:40 +0000
Message-ID: <963d1126612347dd8c398a9449170e16@AcuMS.aculab.com>
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
 <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
 <87sf2gjyn9.fsf@intel.com>
In-Reply-To: <87sf2gjyn9.fsf@intel.com>
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
Content-Transfer-Encoding: base64

RnJvbTogSmFuaSBOaWt1bGENCj4gU2VudDogMjkgSmFudWFyeSAyMDI0IDA5OjA4DQo+IA0KPiBP
biBTdW4sIDI4IEphbiAyMDI0LCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBBQ1VMQUIuQ09N
PiB3cm90ZToNCj4gPiBibGtfc3RhY2tfbGltaXRzKCkgY29udGFpbnM6DQo+ID4gCXQtPnpvbmVk
ID0gbWF4KHQtPnpvbmVkLCBiLT56b25lZCk7DQo+ID4gVGhlc2UgYXJlIGJvb2wsIHNvIGl0IGlz
IGp1c3QgYSBiaXR3aXNlIG9yLg0KPiANCj4gU2hvdWxkIGJlIGEgbG9naWNhbCBvciwgcmVhbGx5
LiBBbmQgfHwgaW4gY29kZS4NCg0KTm90IHJlYWxseSwgYml0d2lzZSBpcyBmaW5lIGZvciBib29s
IChlc3BlY2lhbGx5IGZvciAnb3InKQ0KYW5kIGdlbmVyYXRlcyBiZXR0ZXIgY29kZS4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==


