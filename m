Return-Path: <linux-btrfs+bounces-2756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAA862D12
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 22:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A2F281535
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0061B962;
	Sun, 25 Feb 2024 21:09:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198A1B81B
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895377; cv=none; b=MIB/sXOzvupPxOFkER+cMfyzubr0PMKOwgO2QiaFpp12QYm7ci5axaKu1Tg6iiFD1R6Oe/KWy6c9F+dRSYCHOWrwFbsDE2ztth17Bub00Ku++1hto02YPkpGZlolXlB31XnB5Srz35xq91vVSGGzOrRO4aAMX5r4SfI4CdbAXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895377; c=relaxed/simple;
	bh=5MF9bougW33Z1HHpQQco5/NgIxFQQq3pUp/4ChKgQ3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ljAo7f8U8r/rRRsb6DuaIlKUXPfvXyHbhc8oz15JekgSgQZ6/KHvmOFzfTGSMgrrIAD7trUSr9Zi63ibsz6eQZmRzHzuuouSZ6tDMa5IFdji9QQL7Q15DTB5XvBsp7I37XPxIUsYfxecZTlxMBMpDPW3HY0sTEu7QrulVwSaI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-25-AJDdc1O7Pimm9mrvmQ8LqA-1; Sun, 25 Feb 2024 21:09:30 +0000
X-MC-Unique: AJDdc1O7Pimm9mrvmQ8LqA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 21:09:29 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 21:09:29 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev
	<netdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Jens Axboe <axboe@kernel.dk>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "David S . Miller"
	<davem@davemloft.net>, Dan Carpenter <dan.carpenter@linaro.org>, Jani Nikula
	<jani.nikula@linux.intel.com>
Subject: RE: [PATCH next v2 08/11] minmax: Add min_const() and max_const()
Thread-Topic: [PATCH next v2 08/11] minmax: Add min_const() and max_const()
Thread-Index: AdpoCy246SYrYUdtTu+AtQRSWe90RAAAtXgAAAgCCqA=
Date: Sun, 25 Feb 2024 21:09:29 +0000
Message-ID: <056cfcf737e344acb47d612f642d58b3@AcuMS.aculab.com>
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
 <c6924533f157497b836bff24073934a6@AcuMS.aculab.com>
 <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
In-Reply-To: <CAHk-=wgNh5Gw7RTuaRe7mvf3WrSGDRKzdA55KKdTzKt3xPCnLg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjUgRmVicnVhcnkgMjAyNCAxNzoxNA0KPiAN
Cj4gT24gU3VuLCAyNSBGZWIgMjAyNCBhdCAwODo1MywgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgZXhwYW5zaW9ucyBvZiBtaW4oKSBh
bmQgbWF4KCkgY29udGFpbiBzdGF0ZW1lbnQgZXhwcmVzc2lvbnMgc28gYXJlDQo+ID4gbm90IHZh
bGlkIGZvciBzdGF0aWMgaW50aWFsaXNlcnMuDQo+ID4gbWluX2NvbnN0KCkgYW5kIG1heF9jb25z
dCgpIGFyZSBleHByZXNzaW9ucyBzbyBjYW4gYmUgdXNlZCBmb3Igc3RhdGljDQo+ID4gaW5pdGlh
bGlzZXJzLg0KPiANCj4gSSBoYXRlIHRoZSBuYW1lLg0KDQpQaWNraW5nIG5hbWUgaXMgYWx3YXlz
IGhhcmQuLi4NCg0KPiBOYW1pbmcgc2hvdWxkbid0IGJlIGFib3V0IGFuIGltcGxlbWVudGF0aW9u
IGRldGFpbCwgcGFydGljdWxhcmx5IG5vdA0KPiBhbiBlc290ZXJpYyBvbmUgbGlrZSB0aGUgIkMg
Y29uc3RhbnQgZXhwcmVzc2lvbiIgcnVsZS4gVGhhdCBjYW4gYmUNCj4gdXNlZnVsIGZvciBzb21l
IGludGVybmFsIGhlbHBlciBmdW5jdGlvbnMgb3IgbWFjcm9zLCBidXQgbm90IGZvcg0KPiBzb21l
dGhpbmcgdGhhdCByYW5kb20gcGVvcGxlIGFyZSBzdXBwb3NlZCB0byBVU0UuDQo+IA0KPiBUZWxs
aW5nIHNvbWUgcmFuZG9tIGRldmVsb3BlciB0aGF0IGluc2lkZSBhbiBhcnJheSBzaXplIGRlY2xh
cmF0aW9uIG9yDQo+IGEgc3RhdGljIGluaXRpYWxpemVyIHlvdSBuZWVkIHRvIHVzZSAibWF4X2Nv
bnN0KCkiIGJlY2F1c2UgaXQgbmVlZHMgdG8NCj4gc3ludGFjdGljYWxseSBiZSBhIGNvbnN0YW50
IGV4cHJlc3Npb24sIGFuZCBvdXIgcmVndWxhciAibWF4KCkiDQo+IGZ1bmN0aW9uIGlzbid0IHRo
YXQsIGlzIGp1c3QgKmhvcnJpZCouDQo+IA0KPiBObywgcGxlYXNlIGp1c3QgdXNlIHRoZSB0cmFk
aXRpb25hbCBDIG1vZGVsIG9mIGp1c3QgdXNpbmcgQUxMIENBUFMgZm9yDQo+IG1hY3JvIG5hbWVz
IHRoYXQgZG9uJ3QgYWN0IGxpa2UgYSBmdW5jdGlvbi4NCj4gDQo+IFllcywgeWVzLCB0aGF0IG1h
eSBlbmQgdXAgcmVxdWlyaW5nIGdldHRpbmcgcmlkIG9mIHNvbWUgY3VycmVudCB1c2VycyBvZg0K
PiANCj4gICAjZGVmaW5lIE1JTihhLGIpICgoYSk8KGIpID8gKGEpOihiKSkNCj4gDQo+IGJ1dCBk
YW1taXQsIHdlIGRvbid0IGFjdHVhbGx5IGhhdmUgX3RoYXRfIG1hbnkgb2YgdGhlbSwgYW5kIHdo
eSBzaG91bGQNCj4gd2UgaGF2ZSByYW5kb20gZHJpdmVycyBkb2luZyB0aGF0IGFueXdheT8NCg0K
SSdsbCBoYXZlIGEgbG9vayBhdCB3aGF0IGlzIHRoZXJlLg0KSXQgbWlnaHQgdGFrZSBhIHRocmVl
IHBhcnQgcGF0Y2ggdGhvdWdoLg0KVW5sZXNzIHlvdSBhcHBseSBpdCBhcyBhIHRyZWUtd2lkZSBw
YXRjaD8NCg0KT25lIG9wdGlvbiBpcyB0byBhZGQgYXMgbWF4X2NvbnN0KCksIHRoZW4gY2hhbmdl
IGFueSBleGlzdGluZyBNQVgoKQ0KdG8gYmUgbWF4KCkgb3IgbWF4X2NvbnN0KCkgYW5kIHRoZW4g
ZmluYWxseSByZW5hbWUgdG8gTUFYKCk/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


