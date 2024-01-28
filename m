Return-Path: <linux-btrfs+bounces-1874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0837383FA52
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 23:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C51C21714
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C633C6BA;
	Sun, 28 Jan 2024 22:22:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CF25773
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jan 2024 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480548; cv=none; b=MYd91sYKNTkIGjlFf4G3EXli+ljU3v+vw2/cRY3au6qkdMENG0WjpssyHlIFDw/5fXrcR1JSMjrp78wKESOOU6A2AZ+0OGCcjhe7ZRHrs3DmTi8ljOvYh/OuajwwYm0z9HDHxdpteiWrM8tpFl0+2ttcjMclzAHdktzsbfehVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480548; c=relaxed/simple;
	bh=w+Isv3Nh2z6FjdDokf+f2FGQ9NAyfu3S12nMJKPy8MA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mmQKM6UZpbiv1DlC1IEV+u6LX6nl/a9xVXRDN77VbcXZ4jxzkzUYayKR/ZcaywfdsgzeGwRmOPsDKMHb47tSMt+x1uZkdApEUb+VKwtcYCT6B/8s5vul7wKA5s9274YWlBO1G8CLbMqCfReccsZUkBfxIKMF/Kg9TrWyNEuMPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-vnl-NSxrMcqYOJXJo4DcEw-1; Sun, 28 Jan 2024 22:22:18 +0000
X-MC-Unique: vnl-NSxrMcqYOJXJo4DcEw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 22:21:54 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 22:21:53 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev
	<netdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "David
 S . Miller" <davem@davemloft.net>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
Thread-Topic: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
Thread-Index: AdpSITDgD70hEVnBTjm/gYoTnRBnpgAA0+uAAAR1AXA=
Date: Sun, 28 Jan 2024 22:21:53 +0000
Message-ID: <a756a7712dfe4d03a142520d4c46e7a3@AcuMS.aculab.com>
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
 <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
 <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
In-Reply-To: <CAHk-=whxYjLFhjov39N67ePb3qmCmxrhbVXEtydeadfao53P+A@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjggSmFudWFyeSAyMDI0IDE5OjU5DQo+IA0K
PiBPbiBTdW4sIDI4IEphbiAyMDI0IGF0IDExOjM2LCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdo
dEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhvd2V2ZXIgaXQgZ2VuZXJhdGVzOg0KPiA+
IGVycm9yOiBjb21wYXJpc29uIG9mIGNvbnN0YW50IMOi4oKsy5www6LigqzihKIgd2l0aCBib29s
ZWFuIGV4cHJlc3Npb24gaXMgYWx3YXlzIHRydWUgWy1XZXJyb3I9Ym9vbC1jb21wYXJlXQ0KPiA+
IGluc2lkZSB0aGUgc2lnbmVkbmVzcyBjaGVjayB0aGF0IG1heCgpIGRvZXMgdW5sZXNzIGEgJysg
MCcgaXMgYWRkZWQuDQo+IA0KPiBQbGVhc2UgZml4IHlvdXIgbG9jYWxlLiBZb3UgaGF2ZSByYW5k
b20gZ2FyYmFnZSBjaGFyYWN0ZXJzIHRoZXJlLA0KPiBwcmVzdW1hYmx5IGJlY2F1c2UgeW91IGhh
dmUgc29tZSBpbmNvcnJlY3QgbG9jYWxlIHNldHRpbmcgc29tZXdoZXJlIGluDQo+IHlvdXIgdG9v
bGNoYWluLg0KDQpIbW1tbSBibGFtZSBnY2MgOi0pDQpUaGUgZXJyb3IgbWVzc2FnZSBkaXNwbGF5
cyBhcyAnMCcgYnV0IGlzIGUyOjgwOjk4IDMwIGUyOjgwOjk5DQpJIEhBVEUgVVRGLTgsIGl0IHdv
dWxkbid0IGJlIGFzIGJhZCBpZiBpdCB3ZXJlIGEgYmlqZWN0aW9uLg0KDQpMZXRzIHNlZSBpZiBh
ZGRpbmcgJ0xBTkc9QycgaW4gdGhlIHNoZWxsIHNjcmlwdCBJIHVzZSB0bw0KZG8ga2VybmVsIGJ1
aWxkcyBpcyBlbm91Z2guDQoNCkkgYWxzbyBtYW5hZ2VkIHRvIHNlbmQgcGFydHMgMSB0byA2IHdp
dGhvdXQgZGVsZXRpbmcgdGhlIFJFOg0KKEkgaGF2ZSB0byBjdXQmcGFzdGUgZnJvbSB3b3JkcGFk
IGludG8gYSAncmVwbHktYWxsJyBvZiB0aGUgZmlyc3QNCm1lc3NhZ2UgSSBzZW5kLiBXb3JrIHVz
ZXMgbWltZWNhc3QgYW5kIGl0IGhhcyBzdGFydGVkIGJvdW5jaW5nDQpteSBjb3B5IG9mIGV2ZXJ5
IG1lc3NhZ2UgSSBzZW5kIHRvIHRoZSBsaXN0cy4pDQoNCk1heWJlIEkgc2hvdWxkIHN0YXJ0IHVz
aW5nIHRlbG5ldCB0byBzZW5kIHJhdyBTTVRQIDotKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


