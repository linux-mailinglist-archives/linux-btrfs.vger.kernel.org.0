Return-Path: <linux-btrfs+bounces-2757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FA7862D26
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 22:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7281F227CF
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199D21B978;
	Sun, 25 Feb 2024 21:26:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898E1B94D
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896398; cv=none; b=BCgVbArlj+ZwyFcJbC8I5Y2QomKdcsZt6msmhv09pm9AXM+dCoTcJwE9U9i/QQLbk4mLB36lVsam1XbWgFW0LVAMSKli6ftI6bXo5mRLkTMwrlb3ON4tkeXTZKH8yqaAB/N/qUnLu1ZK+vVC1OJvR5BqllYjG9a6oxxBZ6K14xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896398; c=relaxed/simple;
	bh=awr8kJdI5qgszjd7wAljG4lLyehoh2HbKi7+xw41HO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KvdzkBVwVcaLZdslzgKyyP2JDnZoc8z5SdYiyO7dWs/jklbrLsz5GDlB862Kw3rAir0OOPPxk86ehv2XPJuAQfIPhC8Vn5nG2fRjLMQNHhIFu8b932/Tqp0Y72NdKsR6RA2JxvmFWuLoq3K8QDmo7ILHu5fdiCsYNTw9RICdoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-274-tAV88Qm8MBmPtn9Zj4ylcQ-1; Sun, 25 Feb 2024 21:26:33 +0000
X-MC-Unique: tAV88Qm8MBmPtn9Zj4ylcQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 21:26:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 21:26:32 +0000
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
Thread-Index: AdpoCy246SYrYUdtTu+AtQRSWe90RAAAtXgAAAim0gA=
Date: Sun, 25 Feb 2024 21:26:31 +0000
Message-ID: <59ae7d89368a4dd5a8b8b3f7bc2ae957@AcuMS.aculab.com>
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

Li4uDQo+IFllcywgeWVzLCB0aGF0IG1heSBlbmQgdXAgcmVxdWlyaW5nIGdldHRpbmcgcmlkIG9m
IHNvbWUgY3VycmVudCB1c2VycyBvZg0KPiANCj4gICAjZGVmaW5lIE1JTihhLGIpICgoYSk8KGIp
ID8gKGEpOihiKSkNCj4gDQo+IGJ1dCBkYW1taXQsIHdlIGRvbid0IGFjdHVhbGx5IGhhdmUgX3Ro
YXRfIG1hbnkgb2YgdGhlbSwgYW5kIHdoeSBzaG91bGQNCj4gd2UgaGF2ZSByYW5kb20gZHJpdmVy
cyBkb2luZyB0aGF0IGFueXdheT8NCg0KVGhleSBsb29rIGxpa2UgdGhleSBjb3VsZCBiZSBjaGFu
Z2VkIHRvIG1pbigpLg0KSXQgaXMgZXZlbiBsaWtlbHkgdGhlIGhlYWRlciBnZXRzIHB1bGxlZCBp
biBzb21ld2hlcmUuDQoNCkknbSBub3Qgc3VyZSBhYm91dCB0aGUgb25lcyBpbiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvKi4uKi8qLmMsIGJ1dCBpdA0Kd291bGRuJ3Qgc3VycHJpc2UgbWUg
aWYgdGhhdCBjb2RlIGRvZXNuJ3QgdXNlIGFueSBzdGFuZGFyZCBrZXJuZWwgaGVhZGVycy4NCklz
bid0IHRoYXQgYWxzbyB0aGUgY29kZSB0aGF0IG1hbmFnZXMgdG8gcGFzcyA0MiBpbnRlZ2VyIHBh
cmFtZXRlcnMNCnRvIGZ1bmN0aW9ucz8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


