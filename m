Return-Path: <linux-btrfs+bounces-8919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57E99D8B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 22:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7B9282C7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B3F1D0B9B;
	Mon, 14 Oct 2024 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pOxEtyge"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF41C879A
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939574; cv=none; b=JVoauTFlCeYppGsV+XjTxedrgVupAQ3jNWv/esXRry6jHA3IAMayq47Dd4T4aGmtmCPCmlXTZfjPhdyyDE7nX11Udv5koUPo56RMOQar783Vzxz+tG2VicB2JitwZCRsvBSLpd7LrMmD2OpEu1sbr0OtPtH0my6hUxsK7Y6I5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939574; c=relaxed/simple;
	bh=4YaEBr9JSfCz2LkaiflYQAUNBXMO5sBFDbLFjQZbpT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAqcEqmu/eJaY42N5r8WZYDCMul1/2qwsSwe1ghRoQDJygpMETl35pMmOPUSnZ6G6k4laXH2dZekWkgKh2wEjdDwRLg6rxCn9b8QrmWIt/t3JknirxnOOY42GRhcmL4I5ONyONmDAmC+lH6Cw17PpbqylvmBTtJt3zCiHGK5Zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pOxEtyge; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728939569; x=1729544369; i=quwenruo.btrfs@gmx.com;
	bh=4YaEBr9JSfCz2LkaiflYQAUNBXMO5sBFDbLFjQZbpT8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pOxEtygeW65N7RWym905J+78vK989lxSUw8/TnOFJCbqwQxj5ZFJx9+fcMB+M8+Q
	 IO/psQgVXht/dxqtH7V3UceDcW5EK6kkiMr4SPgo10oNFr8FkIy+kWLQCGhBKLVqQ
	 AyxxxY3ACmImsdPugM71AlAgBlnOYtBwylqD+e2GLjHS461fYaEMMP3QItwpqGCAU
	 fotx2C/a93/+I2eiE/U7+63q97dxfctilip39pAYfT3QeAOY8O8Kwgkhk+e1zA6P7
	 67WotVBai/+IxrMXSaWzKj4p2z3olfjqVwImAUIV2o7ItBzj8RyRZJm9/ALmMgFHl
	 HCPrMrVvtSY+3FDaog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mv2xO-1trBL71Glc-00v6sA; Mon, 14
 Oct 2024 22:59:29 +0200
Message-ID: <71da1b88-1026-4eb8-9946-104b5f46c605@gmx.com>
Date: Tue, 15 Oct 2024 07:29:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
 <20241014141622.GB1609@twin.jikos.cz>
 <8ef15f84-6523-4e47-beda-fa440128df0e@gmx.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <8ef15f84-6523-4e47-beda-fa440128df0e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Rg3o0yi4OV1znIkkeBthRxQThxEAHuk75F8EZu/fFJF5GotAWZ1
 lH0FUcljCQCsfOoKO3iWNSuVuo1RNM5KhZVg9ZPyA8NPIGnb1AYLFI5XgE83uZsuG7uDqP+
 4ObIpB5/9lXYVQ/2ZQRnjzd5BZQhZxdRFY7LiH6y3qNbJWnFlnhZcIJLdapRnquqhzczPN1
 plrMBCjB9PtUzNEpWRuTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cW0AY2ZxLXc=;n5kxITiiFaRa3ES/JQct0W5ZOgo
 cqKpJVaT83JW4AD7RdHhLfpFbJkMHea/7NsdcIB4jzeRlihie6mijjEUgFZSJw3jcWQPeT7PN
 6+wC88U5G8BQDKI9hM4RVOT8IPPYfCwLp/v0hRbrU+mu+jkfpn4KRvxYNuIiJVJy6wDyDxx8R
 z9ghaR/DSiiC7SH5Mh4hlcPwHy09Ev1GrynB6e6NDGjx5WB6tXaTKi+h8wSJqnKE6HXe8qUUm
 lLP/KVap59BHmWM/J3B6aAoXLhgZaCezKD5ylVEqFWyQVYPxVx9+P7hQBCvTLrpvOf6Lpk98s
 1W1aN9pv3PiHu9wNg3FwVnfrZ5gT7lLlGXFtehD1w/76I21t5KYOcvuVvZ4RZ9Ogb328JD2Jn
 USRAcRjR+SJBK42f+oiH8znh10oHPtfFeTkZYBG6Oe1zU3PKmAGQMsA58M+TE4XmIzwtdR1Ff
 Xc5s8gwVpDmzqjdrU655XwvfZ6u870bLN7wv4duLLrRzQJdD7RPkAOiU3pU+5xf3NQ301xuiv
 L1Q3pCyYEdZhZI1RZWqs21PDwZi2H0GmFFzwR7t2QZBof8c9X9gaAXt1dLDj0iUz1AuuyVuk/
 zesQmRty5YHeQJGOqsaetzEk+twW+Ilu7oJnK5nk9YC22HhCfOWao0uhFgpEx8Zn+uVvXwfup
 HNEvFPLZgfZ4SJXmJHS0UPq+0zaBYd+Dxzd24zqpr8rnIDYBGQKUcrzEuG9y3kcHMfvSLiOoa
 ii3VK4KRcyWMpnSlX46/JXwXvaq0F6/kgeK/QGD9HSClhWxxyoIxfToQDC6NQANEFg8J8SGJE
 oKAHqkI1cRMf29DZu5kdaBIQ==

DQoNCuWcqCAyMDI0LzEwLzE1IDA3OjI1LCBRdSBXZW5ydW8g5YaZ6YGTOg0KPiANCj4gDQo+IOWc
qCAyMDI0LzEwLzE1IDAwOjQ2LCBEYXZpZCBTdGVyYmEg5YaZ6YGTOg0KPj4gT24gTW9uLCBPY3Qg
MTQsIDIwMjQgYXQgMDM6MDY6MzFQTSArMTAzMCwgUXUgV2VucnVvIHdyb3RlOg0KPj4+IF9fZmls
ZW1hcF9nZXRfZm9saW8oKSBwcm92aWRlcyB0aGUgZmxhZyBGR1BfU1RBQkxFIHRvIHdhaXQgZm9y
DQo+Pj4gd3JpdGViYWNrLg0KPj4+DQo+Pj4gVGhlcmUgYXJlIHR3byBjYWxsIHNpdGVzIGRvaW5n
IF9fZmlsZW1hcF9nZXRfZm9saW8oKSB0aGVuDQo+Pj4gZm9saW9fd2FpdF93cml0ZWJhY2soKToN
Cj4+Pg0KPj4+IC0gYnRyZnNfdHJ1bmNhdGVfYmxvY2soKQ0KPj4+IC0gZGVmcmFnX3ByZXBhcmVf
b25lX2ZvbGlvKCkNCj4+Pg0KPj4+IFdlIGNhbiBkaXJlY3RseSB1dGlsaXplIHRoYXQgZmxhZyBp
bnN0ZWFkIG9mIG1hbnVhbGx5IGNhbGxpbmcNCj4+PiBmb2xpb193YWl0X3dyaXRlYmFjaygpLg0K
Pj4NCj4+IFdlIGNhbiBkbyB0aGF0IGJ1dCBJJ20gbWlzc2luZyBhIGp1c3RpZmljYXRpb24gZm9y
IHRoYXQuIFRoZSBleHBsaWNpdA0KPj4gd3JpdGViYWNrIGNhbGxzIGFyZSBkb25lIGF0IGEgZGlm
ZmVyZW50IHBvaW50cyB0aGFuIHdoYXQgRkdQX1NUQUJMRQ0KPj4gZG9lcy4gU28gd2hhdCdzIHRo
ZSBkaWZmZXJlbmNlPw0KPj4NCj4gDQo+IFRMO0RSLCBpdCdzIG5vdCBzYWZlIHRvIHJlYWQgZm9s
aW8gYmVmb3JlIHdhaXRpbmcgZm9yIHdyaXRlYmFjayBpbiB0aGVvcnkuDQo+IA0KPiBUaGVyZSBp
cyBhIHBvc3NpYmxlIHJhY2UsIG1vc3RseSByZWxhdGVkIHRvIG15IHByZXZpb3VzIGF0dGVtcHQg
b2YNCj4gc3VicGFnZSBwYXJ0aWFsIHVwdG9kYXRlIHN1cHBvcnQ6DQo+IA0KPiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFRocmVhZCBBwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoCBUaHJlYWQgQg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IGV4dGVudF93cml0ZXBhZ2VfaW8oKcKgwqDCoMKg
wqDCoMKgwqDCoCB8DQo+IHwtIHN1Ym1pdF9vbmVfc2VjdG9yKCnCoMKgwqDCoMKgwqDCoMKgIHwN
Cj4gIMKgIHwtIGZvbGlvX3NldF93cml0ZWJhY2soKcKgwqDCoMKgIHwNCj4gIMKgwqDCoMKgIFRo
ZSBmb2xpbyBpcyBwYXJ0aWFsIGRpcnR5fA0KPiAgwqDCoMKgwqAgYW5kIHVuaW52b2x2ZWQgc2Vj
dG9ycyBhcmV8DQo+ICDCoMKgwqDCoCBub3QgdXB0b2RhdGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8DQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCBidHJmc190cnVuY2F0ZV9ibG9jaygpDQo+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCB8LSBidHJm
c19kb19yZWFkcGFnZSgpDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgfC0gc3VibWl0X29uZV9mb2xpbw0KPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgIFRoaXMgd2lsbCByZWFkIGFsbCBzZWN0b3JzDQo+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKg
wqAgZnJvbSBkaXNrLCBidXQgdGhhdCB3cml0ZWJhY2sNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoCBzZWN0
b3IgaXMgbm90IHlldCBmaW5pc2hlZA0KPiANCj4gSW4gdGhpcyBjYXNlLCB3ZSBjYW4gcmVhZCBv
dXQgZ2FyYmFnZSBmcm9tIGRpc2ssIHNpbmNlIHRoZSB3cml0ZSBpcyBub3QNCj4geWV0IGZpbmlz
aGVkLg0KPiANCj4gVGhpcyBpcyBub3QgeWV0IHBvc3NpYmxlLCBiZWNhdXNlIHdlIGFsd2F5cyBy
ZWFkIG91dCB0aGUgd2hvbGUgcGFnZSBzbw0KPiBpbiB0aGF0IGNhc2UgdGhyZWFkIEIgd29uJ3Qg
dHJpZ2dlciBhIHJlYWQuDQoNCkhlcmUgSSBtZWFuIGF0IHBhZ2UgZGlydHkgdGltZSwgd2UgYWx3
YXlzIHJlYWQgb3V0IHRoZSB3aG9sZSBwYWdlIGlmIHRoZSANCndyaXRlIHJhbmdlIGlzIG5vdCBw
YWdlIGFsaWduZWQuDQoNClNvIHdlIHdvbid0IGhhdmUgcGFydGlhbCBwYWdlIHVwdG9kYXRlIHll
dC4NCg0KQnV0IHRoZSByYWNlIGlzIHN0aWxsIGhlcmUuDQoNCj4gDQo+IA0KPiBCdXQgdGhpcyBh
bHJlYWR5IHNob3dzIHRoZSB3YXkgd2Ugd2FpdCBmb3Igd3JpdGViYWNrIGlzIG5vdCBzYWZlLg0K
PiBBbmQgdGhhdCdzIHdoeSBubyBvdGhlciBmaWxlc3lzdGVtcyBtYW51YWxseSB3YWl0IGZvciB3
cml0ZWJhY2sgYWZ0ZXINCj4gcmVhZGluZyB0aGUgZm9saW8uDQo+IA0KPiBUaHVzIEkgdGhpbmsg
ZG9pbmcgRkdQX1NUQUJMRSBpcyB3YXkgbW9yZSBzYWZlciwgYW5kIHRoYXQncyB3aHkgYWxsDQo+
IG90aGVyIGZzZXMgYXJlIGRvaW5nIHRoaXMgd2F5IGluc3RlYWQuDQo+IA0KPiBUaGFua3MsDQo+
IFF1DQo+IA0KDQo=

