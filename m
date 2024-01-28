Return-Path: <linux-btrfs+bounces-1870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2EE83F97E
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 20:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CCF282A40
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4C3C09F;
	Sun, 28 Jan 2024 19:36:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B05200CC
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470588; cv=none; b=npX7XFrZWzQG28VEhRpTh8paqW94HvvKuDvaNHDabARnrifrDzruNpjTS23gjhdEty07gEPtAdR8rQerz/R0sAKBqYHzA4XaGuAZQUyxqxC5wUPJzgrgHJfRTwaS1e4nPDYstGTlIGkyKwtw4Z6pn8aaR0TH/s0jt6crxfXe7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470588; c=relaxed/simple;
	bh=QB5cBlZmX3HjIcw4VUIAA5Ehr6Qpy5RSN9Fbvir6iZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ZtAtMQjO3rpLPGLDubQ2G2r9uohFxPRUWRK3q0zQKz/vErLQX7zfPoYrgQkFH8MEjnrvKx4xPZCCvrwgem2ViEve2w4Jj+av/7JEBdqwvQi7zOTkFIMS7r199TrVVLgG0+0JGfP529KrrpYaKd2TB4x7HlUwY8lSLdRGkozqOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-253-wsGkhBltNxSy1X4pYfIzig-1; Sun, 28 Jan 2024 19:36:22 +0000
X-MC-Unique: wsGkhBltNxSy1X4pYfIzig-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:35:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:35:38 +0000
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
Subject: [PATCH next 10/11] block: Use a boolean expression instead of max()
 on booleans
Thread-Topic: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
Thread-Index: AdpSITDgD70hEVnBTjm/gYoTnRBnpg==
Date: Sun, 28 Jan 2024 19:35:38 +0000
Message-ID: <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
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
Content-Transfer-Encoding: base64

YmxrX3N0YWNrX2xpbWl0cygpIGNvbnRhaW5zOg0KCXQtPnpvbmVkID0gbWF4KHQtPnpvbmVkLCBi
LT56b25lZCk7DQpUaGVzZSBhcmUgYm9vbCwgc28gaXQgaXMganVzdCBhIGJpdHdpc2Ugb3IuDQpI
b3dldmVyIGl0IGdlbmVyYXRlczoNCmVycm9yOiBjb21wYXJpc29uIG9mIGNvbnN0YW50IMOi4oKs
y5www6LigqzihKIgd2l0aCBib29sZWFuIGV4cHJlc3Npb24gaXMgYWx3YXlzIHRydWUgWy1XZXJy
b3I9Ym9vbC1jb21wYXJlXQ0KaW5zaWRlIHRoZSBzaWduZWRuZXNzIGNoZWNrIHRoYXQgbWF4KCkg
ZG9lcyB1bmxlc3MgYSAnKyAwJyBpcyBhZGRlZC4NCkl0IGlzIGEgc2hhbWUgdGhlIGNvbXBpbGVy
IGdlbmVyYXRlcyB0aGlzIHdhcm5pbmcgZm9yIGNvZGUgdGhhdCB3aWxsDQpiZSBvcHRpbWlzZWQg
YXdheS4NCg0KQ2hhbmdlIHNvIHRoYXQgdGhlIGV4dHJhICcrIDAnIGNhbiBiZSByZW1vdmVkLg0K
DQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMYWlnaHQgPGRhdmlkLmxhaWdodEBhY3VsYWIuY29tPg0K
LS0tDQogYmxvY2svYmxrLXNldHRpbmdzLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ibG9jay9ibGstc2V0dGlu
Z3MuYyBiL2Jsb2NrL2Jsay1zZXR0aW5ncy5jDQppbmRleCAwNmVhOTFlNTFiOGIuLjljYTIxZmVh
MDM5ZCAxMDA2NDQNCi0tLSBhL2Jsb2NrL2Jsay1zZXR0aW5ncy5jDQorKysgYi9ibG9jay9ibGst
c2V0dGluZ3MuYw0KQEAgLTY4OCw3ICs2ODgsNyBAQCBpbnQgYmxrX3N0YWNrX2xpbWl0cyhzdHJ1
Y3QgcXVldWVfbGltaXRzICp0LCBzdHJ1Y3QgcXVldWVfbGltaXRzICpiLA0KIAkJCQkJCSAgIGIt
Pm1heF9zZWN1cmVfZXJhc2Vfc2VjdG9ycyk7DQogCXQtPnpvbmVfd3JpdGVfZ3JhbnVsYXJpdHkg
PSBtYXgodC0+em9uZV93cml0ZV9ncmFudWxhcml0eSwNCiAJCQkJCWItPnpvbmVfd3JpdGVfZ3Jh
bnVsYXJpdHkpOw0KLQl0LT56b25lZCA9IG1heCh0LT56b25lZCwgYi0+em9uZWQpOw0KKwl0LT56
b25lZCA9IHQtPnpvbmVkIHwgYi0+em9uZWQ7DQogCXJldHVybiByZXQ7DQogfQ0KIEVYUE9SVF9T
WU1CT0woYmxrX3N0YWNrX2xpbWl0cyk7DQotLSANCjIuMTcuMQ0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


