Return-Path: <linux-btrfs+bounces-2275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E1F84F281
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 10:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22031C20E07
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B356D67C58;
	Fri,  9 Feb 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="h8ZFsVa+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8D679ED
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471970; cv=none; b=q9ZQ2HLOhe+F7vh+epDMwbjBldGLyeyenSIYEjKDntsSSWTl5A09wvCSyuqJ9ICbBG+cFACWvofZR9VTzAkxDd85sw2kDQre4Vh7PWzQrTx6xImxImMIxQWiSsTmQqsyyvauMzXWkPwUhaOpxijuEoKVENlLODUXf6DMSRSjR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471970; c=relaxed/simple;
	bh=WkkLSBAEtCqts7nqjBN1v57Ldx8mDsgW6EYa5fc3Ld4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gL2Dl7apaHMgp3ZqNuICQZhKpsPGHNnOiwkRtPUKcnHam0C4zOHjD+V29+e60JyGWd+8fNY9EHpb+jT8dx/A1ULXFW9hWDW2PaO8i6+zaDvFeJ10yAQJ/qTDS2hpxThdwfqLKI28miN/1UWx5hehqgvCbEobfqi2YPQGyf2lfAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=h8ZFsVa+; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1707471960;
	bh=WkkLSBAEtCqts7nqjBN1v57Ldx8mDsgW6EYa5fc3Ld4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=h8ZFsVa+Ncx2ihuDr1gwQLqvZan2bzTPXBUYBDeo5CRFbKZZKfp9Y9Scm0sXGPZNn
	 OK/O41cG+Lcfi6g4F2GhjX5fdnaGbAzAw1IWT0PwG86wsQtFeMPJNjI+Ml1C87jLnH
	 UCiPNKBBm4oY1Ji9NuTj16f2HySSTNI+hXuXkCuA=
X-QQ-mid: bizesmtp87t1707471958t63ivfna
X-QQ-Originating-IP: EDG2+zDA0A/ff/85ly0pZu2jbOkoxmeTgeTLqRZ9MIM=
Received: from [192.168.1.136] ( [223.150.249.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Feb 2024 17:45:57 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: PS+4EKbh/3XQW6+fHvEm5Pod0TIM+WvUrufWlFfazEwTDLC8aXsfWh89fp4wu
	Ay4u56dHK9JAt9s2upfv1I/xYNslz9hPbNWEVfVRUnMNhYKXhPk4rTp71DAmezJpOXRwXjt
	Gydp4VhKD8mDNyHhtSrKORV2ae5mlUdQBYJBcPK9/4q2DSr/X+nSSoFW1EBgz4xTt/Y11lF
	83D2O2exURAfc8DxmkfNdEzTkJwBnnF8WgDMsdJxUWA2Avnd021omOd7nvmgvHdvK5zKoiQ
	DoJzO8elq+HDyGDH1Te2XNrDqzTdVPBMzLlmWXg5PzA0uxceA3VNdAnePo6J2Jp2LvR4IO2
	jFmhql6aoubGkLJkTV7FU9XYLomYo9qMY0U5jA+t4efQO6joRROCxweiWKLOXZAYjW14Nnv
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11179320683406079160
Message-ID: <F2A15209522D6722+993f1405-05ca-483c-9263-8c68034e506b@bupt.moe>
Date: Fri, 9 Feb 2024 17:45:54 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
 <1573ACF30347C754+463b9523-d8b9-48ba-806f-c7eb89c55827@bupt.moe>
 <7c852b20-dcc9-4dcf-9c36-5c33692559e6@wdc.com>
 <d3b8ff0b-0f76-40c3-aa01-f5a9bc405512@wdc.com>
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
In-Reply-To: <d3b8ff0b-0f76-40c3-aa01-f5a9bc405512@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5LR543e7ZQ8YiGPJZHRXsw85"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5LR543e7ZQ8YiGPJZHRXsw85
Content-Type: multipart/mixed; boundary="------------PoESpA7N9fGfx9MHRSFAUutI";
 protected-headers="v1"
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <993f1405-05ca-483c-9263-8c68034e506b@bupt.moe>
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
 <1573ACF30347C754+463b9523-d8b9-48ba-806f-c7eb89c55827@bupt.moe>
 <7c852b20-dcc9-4dcf-9c36-5c33692559e6@wdc.com>
 <d3b8ff0b-0f76-40c3-aa01-f5a9bc405512@wdc.com>
In-Reply-To: <d3b8ff0b-0f76-40c3-aa01-f5a9bc405512@wdc.com>
Autocrypt-Gossip: addr=quwenruo.btrfs@gmx.com; keydata=
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

--------------PoESpA7N9fGfx9MHRSFAUutI
Content-Type: multipart/mixed; boundary="------------qd6fK5G0mP340a7Ls0mrJm0X"

--------------qd6fK5G0mP340a7Ls0mrJm0X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQrlnKggMjAyNC8yLzkgMTc6MDYsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+IE9u
IDA5LjAyLjI0IDEwOjAxLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBPbiAwOS4w
Mi4yNCAwOToxNywg6Z+p5LqO5oOfIHdyb3RlOg0KPj4+IOWcqCAyMDI0LzIvOCAyMDo0Miwg
Sm9oYW5uZXMgVGh1bXNoaXJuIOWGmemBkzoNCj4+Pj4gT24gMDUuMDIuMjQgMDg6NTYsIFF1
IFdlbnJ1byB3cm90ZToNCj4+Pj4+PiAgIMKgwqAgPiAuL251bGxiIHNldHVwDQo+Pj4+Pj4g
ICDCoMKgID4gLi9udWxsYiBjcmVhdGUgLXMgNDA5NiAteiAyNTYNCj4+Pj4+PiAgIMKgwqAg
PiAuL251bGxiIGNyZWF0ZSAtcyA0MDk2IC16IDI1Ng0KPj4+Pj4+ICAgwqDCoCA+IC4vbnVs
bGIgbHMNCj4+Pj4+PiAgIMKgwqAgPiBta2ZzLmJ0cmZzIC1zIDE2ayAvZGV2L251bGxiMA0K
Pj4+Pj4+ICAgwqDCoCA+IG1vdW50IC9kZXYvbnVsbGIwIC9tbnQvdG1wDQo+Pj4+Pj4gICDC
oMKgID4gYnRyZnMgZGV2aWNlIGFkZCAvZGV2L251bGxiMSAvbW50L3RtcA0KPj4+Pj4+ICAg
wqDCoCA+IGJ0cmZzIGJhbGFuY2Ugc3RhcnQgLWRjb252ZXJ0PXJhaWQxIC1tY29udmVydD1y
YWlkMSAvbW50L3RtcA0KPj4+Pj4gSnVzdCB3YW50IHRvIGJlIHN1cmUsIGZvciB5b3VyIGNh
c2UsIHlvdSdyZSBkb2luZyB0aGUgc2FtZSBta2ZzICg0Sw0KPj4+Pj4gc2VjdG9yc2l6ZSkg
b24gdGhlIHBoeXNpY2FsIGRpc2ssIHRoZW4gYWRkIGEgbmV3IGRpc2ssIGFuZCBmaW5hbGx5
DQo+Pj4+PiBiYWxhbmNlZCB0aGUgZnM/DQo+Pj4+Pg0KPj4+Pj4gSUlSQyB0aGUgYmFsYW5j
ZSBpdHNlbGYgc2hvdWxkIG5vdCBzdWNjZWVkLCBubyBtYXR0ZXIgaWYgaXQncyBlbXVsYXRl
ZA0KPj4+Pj4gb3IgcmVhbCBkaXNrcywgYXMgZGF0YSBSQUlEMSByZXF1aXJlcyB6b25lZCBS
U1Qgc3VwcG9ydC4NCj4+Pj4gRm9yIG1lLCBiYWxhbmNlIGRvZXNuJ3QgYWNjZXB0IFJBSUQg
b24gem9uZWQgZGV2aWNlcywgYXMgaXQncyBzdXBwb3NlZA0KPj4+PiB0byBkbzoNCj4+Pj4N
Cj4+Pj4gW8KgIDIxMi43MjE4NzJdIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4xKTogaG9z
dC1tYW5hZ2VkIHpvbmVkIGJsb2NrDQo+Pj4+IGRldmljZSAvZGV2L252bWUybjEsIDE2MCB6
b25lcyBvZiAxMzQyMTc3MjggYnl0ZXMNCj4+Pj4gW8KgIDIxMi43MjU2OTRdIEJUUkZTIGlu
Zm8gKGRldmljZSBudm1lMW4xKTogZGlzayBhZGRlZCAvZGV2L252bWUybjENCj4+Pj4gW8Kg
IDIxMi43NDQ4MDddIEJUUkZTIHdhcm5pbmcgKGRldmljZSBudm1lMW4xKTogYmFsYW5jZTog
bWV0YWRhdGEgcHJvZmlsZQ0KPj4+PiBkdXAgaGFzIGxvd2VyIHJlZHVuZGFuY3kgdGhhbiBk
YXRhIHByb2ZpbGUgcmFpZDENCj4+Pj4gW8KgIDIxMi43NDg3MDZdIEJUUkZTIGluZm8gKGRl
dmljZSBudm1lMW4xKTogYmFsYW5jZTogc3RhcnQNCj4+Pj4gLWRjb252ZXJ0PXJhaWQxDQo+
Pj4+IFvCoCAyMTIuNzUwMDA2XSBCVFJGUyBlcnJvciAoZGV2aWNlIG52bWUxbjEpOiB6b25l
ZDogZGF0YSByYWlkMSBuZWVkcw0KPj4+PiByYWlkLXN0cmlwZS10cmVlDQo+Pj4+IFvCoCAy
MTIuNzUxMjY3XSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IGJhbGFuY2U6IGVuZGVk
IHdpdGgNCj4+Pj4gc3RhdHVzOiAtMjINCj4+PiBUaGlzIGlzIHVzaW5nIG52bWUgZHJpdmVy
LCBtaW5lIGlzIFNBVEEuIEl0IHRoaXMgcmVsYXRlZD8NCj4+IFRoZSBvbmx5IGRpZmZlcmVu
Y2UgaGVyZSAoZm9yIGJ0cmZzKSBpcywgdGhhdCBhbiBTTVIgSEREIGNhbiBoYXZlDQo+PiBj
b252ZW50aW9uYWwgem9uZXMuDQo+Pg0KPj4gQnV0IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBf
em9uZV9pbmZvKCkgZG9lcyBjaGVjayBmb3IgdGhlIHByb2ZpbGUgaW4NCj4+IGJvdGggY2Fz
ZXM6DQo+Pg0KPj4gYnRyZnNfbG9hZF9ibG9ja19ncm91cF96b25lX2luZm8oKQ0KPj4gYC0+
IHN3aXRjaCAobWFwLT50eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfUFJPRklMRV9NQVNLKSB7
DQo+PiAgICAgICAgYC0+IGNhc2UgQlRSRlNfQkxPQ0tfR1JPVVBfUkFJRDE6DQo+PiAgICAg
ICAgICAgIGAtPiBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3JhaWQxKCkNCj4+ICAgICAgICAg
ICAgICAgIGAtPiBpZiAoKG1hcC0+dHlwZSAmIEJUUkZTX0JMT0NLX0dST1VQX0RBVEEpICYm
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAhZnNfaW5mby0+c3RyaXBlX3Jvb3QpIHsN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBidHJmc19lcnIoLi4uKQ0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+DQo+PiBJIGRvbid0IHNl
ZSB0aGUgZGlmZmVyZW5jZSB5ZXQuIEknbGwgcmUtcnVuIGEgdGVzdCBvbiBhbiBTTVIgZHJp
dmUsIGp1c3QNCj4+IHRvIGJlIHN1cmUuDQo+Pg0KPg0KPiBPaCBJIHRoaW5rIEkgc2VlIHRo
ZSBwcm9ibGVtIG5vdywgY2FuIHlvdSB0cnkgdGhlIGZvbGxvd2luZyBwYXRjaDoNCj4gaHR0
cHM6Ly90ZXJtYmluLmNvbS9mc3MwDQoNCkkgY2FuJ3QgbW91bnQgYWZ0ZXIgbmV3IG1rZnMu
YnRyZnMuDQoNClsxOTUxNTguODA3OTYwXSBCVFJGUzogZGV2aWNlIGZzaWQgNGZiM2FlMTct
OWYxOC00N2Q5LWI3YmYtMDBkNDI1ZmU0NTBlIA0KZGV2aWQgMSB0cmFuc2lkIDYgL2Rldi9z
ZGIgc2Nhbm5lZCBieSBtb3VudCAoNDc2MSkgWzE5NTE1OC44MjI4MjddIEJUUkZTIA0KaW5m
byAoZGV2aWNlIHNkYik6IGZpcnN0IG1vdW50IG9mIGZpbGVzeXN0ZW0gDQo0ZmIzYWUxNy05
ZjE4LTQ3ZDktYjdiZi0wMGQ0MjVmZTQ1MGUgWzE5NTE1OC44MzE5MTVdIEJUUkZTIGluZm8g
KGRldmljZSANCnNkYik6IHVzaW5nIGNyYzMyYyAoY3JjMzJjLWdlbmVyaWMpIGNoZWNrc3Vt
IGFsZ29yaXRobSBbMTk1MTU4LjgzOTc5NV0gDQpCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTog
dXNpbmcgZnJlZS1zcGFjZS10cmVlIFsxOTUxNTkuMzk5NDc3XSBCVFJGUyANCmluZm8gKGRl
dmljZSBzZGIpOiBob3N0LW1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlIC9kZXYvc2RiLCA1
MjE1NiB6b25lcyANCm9mIDI2ODQzNTQ1NiBieXRlcyBbMTk1MTU5LjQwOTQzMV0gQlRSRlMg
aW5mbyAoZGV2aWNlIHNkYik6IHpvbmVkIG1vZGUgDQplbmFibGVkIHdpdGggem9uZSBzaXpl
IDI2ODQzNTQ1NiBbMTk1MTU5LjQxNjkzNF0gQlRSRlMgZXJyb3IgKGRldmljZSANCnNkYik6
IHpvbmVkOiBpbnZhbGlkIHdyaXRlIHBvaW50ZXIgMTg0NDY3NDQwNzM3MDk1NTE2MTQgKGxh
cmdlciB0aGFuIA0Kem9uZSBjYXBhY2l0eSAwKSBpbiBibG9jayBncm91cCAxMDczNzQxODI0
IFsxOTUxNTkuNDI5ODE1XSBCVFJGUyBlcnJvciANCihkZXZpY2Ugc2RiKTogem9uZWQ6IGZh
aWxlZCB0byBsb2FkIHpvbmUgaW5mbyBvZiBiZyAxMDczNzQxODI0IA0KWzE5NTE1OS40Mzc3
NzFdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RiKTogZmFpbGVkIHRvIHJlYWQgYmxvY2sgZ3Jv
dXBzOiANCi01IFsxOTUxNTkuNDQ0NDczXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYik6IG9w
ZW5fY3RyZWUgZmFpbGVkDQoNCg==
--------------qd6fK5G0mP340a7Ls0mrJm0X
Content-Type: application/pgp-keys; name="OpenPGP_0xCC7801A4C3E3A368.asc"
Content-Disposition: attachment; filename="OpenPGP_0xCC7801A4C3E3A368.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYd2CwRYJKwYBBAHaRw8BAQdA+Cjl7faceXuI8bf4TOInbIgM8RRMSrlNqkJM
iX6XUOjNLUhBTiBZdXdlaSAoaGFueXV3ZWk3MCkgPGhhbnl1d2VpNzBAZ21haWwu
Y29tPsKQBBMWCAA4FiEE5jAMjRwseUJjIHytzHgBpMPjo2gFAmHdg0QCGwEFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQzHgBpMPjo2huYQD+IBK5NHWTngw/Ujcf
wnTmjXVBqJdrjC8XSHoMQepgwE4BALosq8/PFwesiQjXRo5a7dGyvswgkWtr0LMo
Bp5SQXkKzSXpn6nkuo7mg58gKGhhbnl1d2VpNzApIDxocnhAYnVwdC5tb2U+wpAE
ExYIADgWIQTmMAyNHCx5QmMgfK3MeAGkw+OjaAUCYd2CwQIbAQULCQgHAgYVCgkI
CwIEFgIDAQIeAQIXgAAKCRDMeAGkw+OjaLlDAP9Wh3ee0/6NIL76n6qx9jvM3EKm
51/AzDdLEz1T26b+fwEAg9vWtLc8gPfjVGsKsXMBJAv57qkz+kws/229mux51wHN
HemfqeS6juaDnyA8aGFueXV3ZWk3MEBxcS5jb20+wpAEExYIADgWIQTmMAyNHCx5
QmMgfK3MeAGkw+OjaAUCYd2DJAIbAQULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
CRDMeAGkw+OjaIxvAP9PxxZKTM60lDb/SbyDbfP8Bzi4LfZSa8T6GcBK5gUbGQD/
cw7hCEHEYdqIa1HATmXIsWozofsrlc4nRVeOjBm7SAbOMwRh3YXMFgkrBgEEAdpH
DwEBB0BjhXs3EEqaQMMe+y6eQPrN/iijsRn0+V7Yfxgv3LZNMsLANQQYFggAJhYh
BOYwDI0cLHlCYyB8rcx4AaTD46NoBQJh3YXMAhsCBQkJZgGAAIEJEMx4AaTD46No
diAEGRYIAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCYd2FzAAKCRBLkKfpYfpB
U/OHAP98maDWlKN7WlOaIlIuL4nnmeeKlW1zRweQ4nbngJWTZQD+IZ07dJMb41M7
3k3jPaT+uspGa+D3HivKAvnYGogLAw14AQEAywpAA/ze6ujATllsN9bQFOMThnaC
FYS3fYEVucLp57sA/RBfjnsQxA4ADe1EJaE0YYwDMo5UKga/wT9Wk90a5LIPzjgE
Yd2DUhIKKwYBBAGXVQEFAQEHQObBEtGrlnW9aBtHCkwYROmOqVF9AZuLZnAyJotA
j/4KAwEIB8J+BBgWCAAmFiEE5jAMjRwseUJjIHytzHgBpMPjo2gFAmHdg1ICGwwF
CQlmAYAACgkQzHgBpMPjo2jG2gD+LkrU5GPlDTUEYxBYBEyfd4igkf2TyeGbwFU5
pUwrFtgA/0tbB+3oaUUI3jwAbGWlUpXn2+iROFfqokr+fGa4SSUM
=3D/880
-----END PGP PUBLIC KEY BLOCK-----

--------------qd6fK5G0mP340a7Ls0mrJm0X--

--------------PoESpA7N9fGfx9MHRSFAUutI--

--------------5LR543e7ZQ8YiGPJZHRXsw85
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZcX0UwAKCRBLkKfpYfpB
Uy/YAP9vzN4A8qTVMepvC3eVwI5Ct4r6ageeMYZTQRrnCqHpowD/aNmRt04QZBf+
ILwk5TvLGQAHhYh/zO8vJCbgnirT6Ao=
=gNkr
-----END PGP SIGNATURE-----

--------------5LR543e7ZQ8YiGPJZHRXsw85--

