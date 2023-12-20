Return-Path: <linux-btrfs+bounces-1075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701E819A8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 09:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF89B24023
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74F51CFB2;
	Wed, 20 Dec 2023 08:32:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833861C68D
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-318-j7hyiDmKO0ONbi--YKrX3g-1; Wed, 20 Dec 2023 08:32:04 +0000
X-MC-Unique: j7hyiDmKO0ONbi--YKrX3g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 20 Dec
 2023 08:31:48 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 20 Dec 2023 08:31:48 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Qu Wenruo' <quwenruo.btrfs@gmx.com>, 'David Disseldorp' <ddiss@suse.de>,
	Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Thread-Topic: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Thread-Index: AQHaMbPBRujg17A2g0aXH8N7pLP0+bCwzl3QgABP6QCAALkJYA==
Date: Wed, 20 Dec 2023 08:31:48 +0000
Message-ID: <3f8ee41745ac40e58e0aa535029e8751@AcuMS.aculab.com>
References: <cover.1702628925.git.wqu@suse.com>
 <11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
 <20231218235946.32ab7a69@echidna>
 <8095c6ae5f8d412d8e6ff95707961a08@AcuMS.aculab.com>
 <4fbcab63-347f-4cef-ad35-686844c983ed@gmx.com>
In-Reply-To: <4fbcab63-347f-4cef-ad35-686844c983ed@gmx.com>
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

RnJvbTogUXUgV2VucnVvDQo+IFNlbnQ6IDE5IERlY2VtYmVyIDIwMjMgMjE6MTgNCi4uLg0KPiA+
IEhvdyBhYm91dDoNCj4gPiAJc3VmZml4ID0gKmVuZHB0cjsNCj4gPiAJaWYgKCFzdHJjaHIoc3Vm
Zml4ZXMsIHN1ZmZpeCkpDQo+ID4gCQlyZXR1cm4gLUVOSVZBTDsNCj4gPiAJc2hpZnQgPSBzdHJj
c3BuKCJLa01tR2dUdFBwIiwgc3VmZml4KS8yICogMTAgKyAxMDsNCj4gDQo+IFRoaXMgbWVhbnMg
dGhlIGNhbGxlciBoYXMgdG8gcHJvdmlkZSB0aGUgc3VmZml4IHN0cmluZyBpbiB0aGlzDQo+IHBh
cnRpY3VsYXIgb3JkZXIuDQoNCk5vLCBUaGUgc3RyY2hyKCkgY2hlY2tzIHRoYXQgdGhlIHN1ZmZp
eCBpcyBvbmUgdGhlIGNhbGxlciB3YW50ZWQuDQpUaGUgc3RyY3NwbigpIGlzIGFnYWluc3QgYSBm
aXhlZCBsaXN0IC0gc28gdGhlIG9yZGVyIGNhbiBiZQ0Kc2VsZWN0ZWQgdG8gbWFrZSB0aGUgY29k
ZSBzaG9ydGVyLg0KDQpBY3R1YWxseSBzdHJjc3BuKCkgaXNuJ3QgdGhlIGZ1bmN0aW9uIHlvdSBu
ZWVkLg0KVGhlcmUgbWlnaHQgYmUgYSBmdW5jdGlvbiBsaWtlIHN0cmNocigpIHRoYXQgcmV0dXJu
cyBhIGNvdW50DQpidXQgSSBjYW4ndCByZW1lbWJlciBpdHMgbmFtZSBhbmQgaXQgbWF5IG5vdCBi
ZSBpbiBrZXJuZWwuDQpZb3UgbWlnaHQgaGF2ZSB0byB3cml0ZToNCglzaGlmdCA9IDA7DQoJZm9y
IChjb25zdCBjaGFyICpzZnAgPSAiS2tNbUdnVHRQcCI7IHN1ZmZpeCAhPSAqc2ZwOyBzZnArKywg
c2hpZnQrKykgew0KCQlpZiAoISpzZnApDQoJCQlyZXR1cm4gLUVJTlZBTDsNCgl9DQoJc2hpZnQg
PSBzaGlmdC8yICsgMSAqIDEwOw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


