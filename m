Return-Path: <linux-btrfs+bounces-4543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860448B192C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 05:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897161C21331
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 03:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7D17BD9;
	Thu, 25 Apr 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="g/KTIyKh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674FC629
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014467; cv=none; b=jhowQu9wYSkmJdRvlpRfThD0HI2AV7neIeNvkCr83BmX8wa87MDZov/79hTSqejYyFVCZ7PkrWWu7gIRIfwTFKf2HkGy8ec74AMUHKHGdfnVbMD80PtKXkCE/KJiaeUXj1FpZOYNFVzWT/0T+qHfCve2rZsQ+JuGatnVNW4Vi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014467; c=relaxed/simple;
	bh=ft4hucsAY2FmBS3GLywT0At1f6cJRAWPQyxFb+HCVmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fib5DYF4axNOP22f/MM+etFtAEPtJnT3cvu5rH9PDQ2cIxXkEbce+4G0EX4Jmz/eemjVgeZ76Av7QXRF65H7SnihV+P8AP0tCQTJiy35d9RPZW9VQcut3JxPtzrXG2MigCARlWOTtUiweUjgeV82L+xXIt9MNW2S297pJKyvtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=g/KTIyKh; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1714014451;
	bh=ft4hucsAY2FmBS3GLywT0At1f6cJRAWPQyxFb+HCVmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=g/KTIyKh/TbVRTxszKIljSnUMfQdDdXz1Mb77a08jOEQWxsEWQmNyJjmm5Ukufcte
	 I/HlIJaZSd1kh/441PDvu6WgYGaOp1M3BDtbPWKSJawpd8cqOMjw/6HL1pp4B0KKa5
	 u+3xwCSvt28Dw1b5AIOF4aZtSsz92fCcvK5aHT8w=
X-QQ-mid: bizesmtp84t1714014449tqwfc7jj
X-QQ-Originating-IP: WrdHM39JoxoJ0b3/k16y4AhtlYADhTxs8WwUyUYINWs=
Received: from [192.168.1.5] ( [223.150.241.123])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Apr 2024 11:07:26 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: vAA8WNYefta9Vw97IiVydT6OAkO9VMNDFx+ItCygodxJHP+zfuiobNWYoBd+q
	b2iUKB4cZaKlfmDK5JNX4kXyx+UGu8AjLvu7VxjR2lC87ZXDDUI0mStK1duZyNB9Pp3TP2k
	rHIpvVzxjmIJ/nqwZjoJK0Ro7SCOg1HpmojmKZvFesJsAZRDTvF6Mp3QMMOX7GbPE7wNak/
	HhnFSscm4dGirlw/So56vX+h9OGh37bv8YU3kyxqhJvJtnD4Ud1oyxu0++mSJdxXX7vmN2v
	+XppGUpzvUv2zbBVFiwzYLtfyknfAR62UAzCxGB61/5t7rAczBGTr2N6epotY1RJaW7LWvk
	rNONJLmvuHXQXKIg94N/Uf+qeWIqAdPG3MSNzRLlIcjBQi6PzopLU8oDXxKaSj/uj3wOABj
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3758918843705813871
Message-ID: <B9DB8244635257EC+464c494f-aa0f-44b2-8026-f20035df9f9d@bupt.moe>
Date: Thu, 25 Apr 2024 11:07:25 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mkfs.btrfs enabled RST by default casuing unable to mount on
 stable kernel
To: kreijack@inwind.it, dsterba@suse.cz
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <46FCC719DD77BA7B+fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
 <20240424094818.GJ3492@twin.jikos.cz>
 <CC278E560522C9D1+f2ceab96-c158-49b9-b885-7ae55fa260ff@bupt.moe>
 <04a4bfa7-9596-424d-afb0-c9ab9458f969@libero.it>
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <04a4bfa7-9596-424d-afb0-c9ab9458f969@libero.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0OXbRPOxhNWt0dFZodKU05XN"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0OXbRPOxhNWt0dFZodKU05XN
Content-Type: multipart/mixed; boundary="------------TND2nxkt0Pmznu9jHdC0DHyH";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: kreijack@inwind.it, dsterba@suse.cz
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <464c494f-aa0f-44b2-8026-f20035df9f9d@bupt.moe>
Subject: Re: mkfs.btrfs enabled RST by default casuing unable to mount on
 stable kernel
References: <46FCC719DD77BA7B+fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
 <20240424094818.GJ3492@twin.jikos.cz>
 <CC278E560522C9D1+f2ceab96-c158-49b9-b885-7ae55fa260ff@bupt.moe>
 <04a4bfa7-9596-424d-afb0-c9ab9458f969@libero.it>
In-Reply-To: <04a4bfa7-9596-424d-afb0-c9ab9458f969@libero.it>

--------------TND2nxkt0Pmznu9jHdC0DHyH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

5ZyoIDIwMjQvNC8yNSAzOjU3LCBHb2ZmcmVkbyBCYXJvbmNlbGxpIOWGmemBkzoNCj4gT24g
MjQvMDQvMjAyNCAxOC4xNSwgSEFOIFl1d2VpIHdyb3RlOg0KPj4NCj4+IOWcqCAyMDI0LzQv
MjQgMTc6NDgsIERhdmlkIFN0ZXJiYSDlhpnpgZM6DQo+Pj4gT24gV2VkLCBBcHIgMjQsIDIw
MjQgYXQgMDE6NDU6MjRQTSArMDgwMCwgSEFOIFl1d2VpIHdyb3RlOg0KPj4+PiBJIGhhdmUg
Zm91bmQgaW5jb21wYXRpYmlsaXR5IGlzc3VlIG9uIGJ0cmZzLXByb2cgJiBrZXJuZWwuIGJ0
cmZzLXByb2dzDQo+Pj4+IGlzIHY2LjcuMSwga2VybmVsIGlzIDYuNy41LWFvc2MtbWFpbi4N
Cj4+Pj4NCj4+Pj4gVXNpbmcgdGhpcyBjb21tYW5kIHRvIGNyZWF0ZSBidHJmcyB2b2x1bWU6
DQo+Pj4+ICMgbWtmcy5idHJmcyAtZiAtZCByYWlkMTAgLW0gcmFpZDFjNCAtcyAxNmsgLUwg
SFlXREFUQV9aT05FRF9URVNUDQo+Pj4+IC9kZXYvc2RiIC9kZXYvc2RjIC9kZXYvc2RkIC9k
ZXYvc2RlDQo+Pj4+DQo+Pj4+IFdoZW4gbW91bnRpbmcsIGRtZXNnIHNhaWQ6DQo+Pj4+IFvC
oCAzMjkuMDcxNDAzXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogZmlyc3QgbW91bnQgb2Yg
ZmlsZXN5c3RlbQ0KPj4+PiA3YjRmMmNhNi1lZmUzLTQ4ZDktODFmNi1iYTY1YTAwZGI4NWUN
Cj4+Pj4gW8KgIDMyOS4wODA0MjJdIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiB1c2luZyBj
cmMzMmMgKGNyYzMyYy1nZW5lcmljKQ0KPj4+PiBjaGVja3N1bSBhbGdvcml0aG0NCj4+Pj4g
W8KgIDMyOS4wODgyMjJdIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiB1c2luZyBmcmVlIHNw
YWNlIHRyZWUNCj4+Pj4gW8KgIDMyOS4wOTM2NzNdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2Ri
KTogY2Fubm90IG1vdW50IGJlY2F1c2Ugb2YgDQo+Pj4+IHVua25vd24NCj4+Pj4gaW5jb21w
YXQgZmVhdHVyZXMgKDB4NWI0MSkNCj4+Pj4gW8KgIDMyOS4xMDI0NDJdIEJUUkZTIGVycm9y
IChkZXZpY2Ugc2RiKTogb3Blbl9jdHJlZSBmYWlsZWQNCj4+Pj4NCj4+Pj4gZHVtcC1zdXBl
ciBzYWlkOg0KPj4+PiBbLi4uXQ0KPj4+PiBpbmNvbXBhdF9mbGFnc8KgwqDCoMKgwqDCoMKg
wqDCoCAweDViNDENCj4+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoIE1JWEVEX0JBQ0tSRUYgfA0KPj4+PiDCoCDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFWFRFTkRFRF9JUkVGIHwN
Cj4+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgU0tJTk5ZX01FVEFEQVRBIHwNCj4+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTk9fSE9MRVMgfA0KPj4+PiDCoCDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSQUlEMUMz
NCB8DQo+Pj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFpPTkVEIHwNCj4+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUkFJRF9TVFJJUEVfVFJFRSApDQo+Pj4+IFsuLi5d
DQo+Pj4+DQo+Pj4+DQo+Pj4+IFJBSURfU1RSSVBFX1RSRUUgbmVlZCBDT05GSUdfQlRSRlNf
REVCVUcgdG8gYmUgc3VwcG9ydGVkIGFuZCB0aGlzDQo+Pj4+IGZlYXR1cmUgZmxhZyBpcyBk
aXNhYmxlZCBvbiBtb3N0IGRpc3RyaWJ1dGlvbnMuIEkgaG9wZSBSU1QgY2FuIGJlDQo+Pj4+
IGRpc2FibGVkIGJ5IGRlZmF1bHQgb24gYnRyZnMtcHJvZ3MuDQo+Pj4gSU1PIHRoaXMgd29y
a3MgYXMgaW50ZW5kZWQuIEZlYXR1cmVzIG1heSBiZSBlbmFibGVkIGFoZWFkIG9mIHRpbWUg
aW4NCj4+PiBidHJmcy1wcm9ncyBkdWUgdG8gZWFybHkgdGVzdGluZyBhbmQgbm90IHJlcXVp
cmluZyB0aGUgZXhwZXJpbWVudGFsDQo+Pj4gYnVpbGQuIFRoZSBleHBlcmltZW50YWwgc3Rh
dHVzIG9mIHByb2dzIGZlYXR1cmVzIGlzIGFib3V0IGNvbXBsZXRlbmVzcw0KPj4+IG9mIHRo
ZSBpbXBsZW1lbnRhdGlvbiwgc28gaWYgbWtmcyBjcmVhdGVzIGEgZmlsZXN5c3RlbSB3aXRo
IFJTVCB0aGVuIGl0DQo+Pj4gY291bGQgYmUgZW5hYmxlZC4NCj4+IElmIGR1ZSB0byBlYXJs
eSB0ZXN0aW5nLCBidHJmcy1wcm9ncyBjb3VsZCBoYXZlIC0tZXhwZXJpbWVudGFsIG9wdGlv
biANCj4+IHRvIGVuYWJsZSBpdCBpbnN0ZWFkIG9mDQo+Pg0KPj4gZW5hYmxpbmcgaXQgYnkg
ZGVmYXVsdCB3aGljaCB3b3VsZCBjYXVzaW5nIGNvbmZ1c2lvbiB0byBub3JtYWwgdXNlcnMu
IA0KPj4gRm9yIGV4cGVyaWVuY2VkIHVzZXIgd2hvIHdhbnRzIHRvIHRlc3QgbmV3IGZlYXR1
cmUsIHdlIGNhbiBoaW50IHRoZW0gDQo+PiB0byB1c2UgdGhpcyBvcHRpb24gd2hlbiBuZWVk
ZWQuDQo+Pg0KPj4gZS5nLg0KPj4NCj4+ICMgbWtmcy5idHJmcyAtZiAtZCByYWlkMTAgLW0g
cmFpZDFjNCAtcyAxNmsNCj4+IGNhbid0IHVzZSByYWlkMTAsIHRoaXMgaXMgYSBleHBlcmlt
ZW50YWwgZmVhdHVyZSwgdXNlIC0tZXhwZXJpbWVudGFsIA0KPj4gaWYgeW91IHJlYWxseSB3
YW50IGl0Lg0KPj4NCj4+ICMgbWtmcy5idHJmcyAtZiAtZCByYWlkMTAgLW0gcmFpZDFjNCAt
cyAxNmsgLS1leHBlcmltZW50YWwNCj4+DQo+PiBbc3VjY2VlZF0NCj4+DQo+Pj4gVGhlIGtl
cm5lbCBzdXBwb3J0IGlzIHN0aWxsIG1pc3Npbmcgc29tZSBmZWF0dXJlcyBhbmQgdGhlcmUg
YXJlIHNvbWUNCj4+PiBrbm93biBidWdzLCB0aGlzIGlzIGNvbnZlbmllbnRseSBoaWRkZW4g
YmVoaW5kIHRoZSBERUJVRyBvcHRpb24gc28gaXQNCj4+PiBkb2VzIG5vdCBhZmZlY3QgZGlz
dHJpYnV0aW9ucy4NCj4+Pg0KPj4+IEhvd2V2ZXIgaXQgc2VlbXMgdGhhdCB0aGUgZG9jdW1l
bnRhdGlvbiBpcyBub3QgY2xlYXIgYWJvdXQgdGhhdCBhbmQgdGhlDQo+Pj4gc3RhdHVzIHBh
Z2Ugc2hvdWxkIGJlIHVwZGF0ZWQuDQo+Pj4NCj4NCj4gSSB0aGluayB0aGF0IHRoZSBwcm9i
bGVtIGlzIHRoZSBmb2xsb3dpbmc6IGlmIHlvdSB3YW50IHRvIHVzZSBhICJ6b25lZCANCj4g
ZGV2aWNlIg0KPiBhbmQgYSAicmFpZCBkZXZpY2UiLCB5b3UgTkVFRCBhIHJhaWQtc3RyaXBl
LXRyZWUuDQo+IEluIGZhY3QgYnkgZGVmYXVsdCB0aGUgUlNUIGlzIG5vdCBlbmFibGVkLCBi
dXQgaXQgaXMgcHVsbGVkIGlmIHdlIGhhdmUNCj4gYSB6b25lZCBkZXZpY2UgYW5kIGEgcmFp
ZDEwLg0KPg0KPiBTbyBpdCBpcyBub3QgYSBwcm9ibGVtIG9mIGJ0cmZzLXByb2dzIGl0c2Vs
Zi4NCj4NCj4gSSB0aGluayB0aGF0IGJ0cmZzLm1rZnMgc2hvdWxkIGJlIG1vcmUgdmVyYm9z
ZSBhYm91dCBwdWxsaW5nIGluY29tYXB0DQo+IGZlYXR1cmUgYXMgYSBkZXBlbmRlbmN5Lg0K
Pg0KPg0KSSB0aGluayB0aGF0IGJ0cmZzLXByb2dzIGNvdWxkIHJlcXVpcmUgdXNlciB0byBl
eHBsaWNpdGx5IGludHJvZHVjZSANCmZlYXR1cmVzIHdoaWNoIGN1cnJlbnQgc3RhYmxlIGtl
cm5lbCBtYXkgbm90IGVuYWJsZWQgYnkgZGVmYXVsdCBpbnN0ZWFkIA0Kb2YgYmVpbmcgbW9y
ZSB2ZXJib3NlIGluIG91dHB1dC4NCg0KQmVjYXVzZSB1c2VycyBtYXkgMS4gZG9uJ3QgcmVh
ZCBvdXRwdXQgMi4gYXJlIHVzaW5nIHR0eSB3aGljaCB3b3VsZCANCnRydW5jYXRlIHRoZWly
IG91dHB1dC4gTWFraW5nIHRoaXMgZXhwbGljaXRseSBpcyBiZXR0ZXIgdGhhbiBzdXJwcmlz
aW5nIA0KdXNlcnMgYWZ0ZXJ3YXJkcy4NCg0KSEFOIFl1d2VpDQoNCg==

--------------TND2nxkt0Pmznu9jHdC0DHyH--

--------------0OXbRPOxhNWt0dFZodKU05XN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZinI7QAKCRBLkKfpYfpB
U737AQDltPU2rAHBqimnrj0PYOOcvMGeoe6r4KkZcxcQmi0jYQEAhHoh1k8G0UWL
q7SGxtyaVQ4fQVluGqR8vZprNcD3twM=
=wCyc
-----END PGP SIGNATURE-----

--------------0OXbRPOxhNWt0dFZodKU05XN--

