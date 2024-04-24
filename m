Return-Path: <linux-btrfs+bounces-4525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A38B0F85
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 18:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3340A2962D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704BE161310;
	Wed, 24 Apr 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="kQ3TFKyM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EEB160873
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975378; cv=none; b=h2/kSBCCQfap7Q5fHBhRZfTwJ3at7tojLoqX8UvSbTJB4ESWHdmdYb9sCtj84Zu6WuTQSHwqNlKK76tSCwV4v32QXMkfnyABMHSJqWUVypbU+YddQpJPk96UVS9/IlePhBcBTJkwyZBAf8r7OPVAOW9QgZiMm6VBBcigDeXoivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975378; c=relaxed/simple;
	bh=U2GGcmGOX7vDhrLPDfxXhLWXydQvKYBTcFbnxquMP+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxV45wF5fS7BcFviOqFa9dA6fwu4jmVUxg/LdkQrJfMJqlFhXL6X8oUor+laprJR+guhX5hr1q9pZEMy2TTl4TlNv+a/Z1JsNm+RXX+im9K0NetgEu1Z1A5FPdlrIGUT09H8p58yr0uaxPpjwF91sORBXvQWH2wwSTNpZWszQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=kQ3TFKyM; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1713975364;
	bh=U2GGcmGOX7vDhrLPDfxXhLWXydQvKYBTcFbnxquMP+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kQ3TFKyMGh9yXdMhO/WPQ+F3OOnstpALG3QzaVJEkbJlAzKXxIX3i7vPZfYD+BQT1
	 ef3tW912V52msq9Cl4oM36rRgYe85s6HUxpHaLWkDbRrZSjyiRXIgUAkpNkp+iEdTr
	 zewls8HqDZazlQowd6g+983z2fRmI08EawZkzwLA=
X-QQ-mid: bizesmtpsz15t1713975362tqd1ah
X-QQ-Originating-IP: 0x52NWKW/SHJZAwPOdFOOMxi2ZxWYR7gs4YoRM+3Rlc=
Received: from [192.168.1.5] ( [223.150.241.123])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Apr 2024 00:16:00 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: Q4gfBD3K7t/7gwYmFMnf6VPUonEeleQ3Ib2DUJRK7HAG1p4hr64cadAmDpH/7
	UecJK/ubY7fY4lf48U6rKdehSDRcGCx4/cxzv8KLkmQ3I9tqmHIOpXynNx9ZTFrz+qgCNpw
	NxaZferwfadhVCt7kA7vlVgWSRdhHen6WasH5IDEDfn0rVWAhEAUFAJZeJytfkD5qpbFvFx
	MRxuNypHnsZqeJ0RPK8KXPQ1gmvmpQmCgRR+clCtBZbbsrLvr8ehFzfyNDQ3spoSD83EcrX
	X2XfbT1uULOX9ApZVly36wOQGjeve970jMW/+vk3SOXLstkdUbW5cBNMvj7yOF+1WGkSA8D
	iY+GwO0X2bMJ2tBh4ylo9HDHTyGsZzlRFJVtLEG
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3308411662228814400
Message-ID: <CC278E560522C9D1+f2ceab96-c158-49b9-b885-7ae55fa260ff@bupt.moe>
Date: Thu, 25 Apr 2024 00:15:57 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mkfs.btrfs enabled RST by default casuing unable to mount on
 stable kernel
To: dsterba@suse.cz
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <46FCC719DD77BA7B+fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
 <20240424094818.GJ3492@twin.jikos.cz>
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <20240424094818.GJ3492@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d1J6bv317j0IjgAbHfo9rX8v"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------d1J6bv317j0IjgAbHfo9rX8v
Content-Type: multipart/mixed; boundary="------------5dWG22qcfAsR9UuZFy5IE0Qp";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: dsterba@suse.cz
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <f2ceab96-c158-49b9-b885-7ae55fa260ff@bupt.moe>
Subject: Re: mkfs.btrfs enabled RST by default casuing unable to mount on
 stable kernel
References: <46FCC719DD77BA7B+fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
 <20240424094818.GJ3492@twin.jikos.cz>
In-Reply-To: <20240424094818.GJ3492@twin.jikos.cz>

--------------5dWG22qcfAsR9UuZFy5IE0Qp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQrlnKggMjAyNC80LzI0IDE3OjQ4LCBEYXZpZCBTdGVyYmEg5YaZ6YGTOg0KPiBPbiBXZWQs
IEFwciAyNCwgMjAyNCBhdCAwMTo0NToyNFBNICswODAwLCBIQU4gWXV3ZWkgd3JvdGU6DQo+
PiBJIGhhdmUgZm91bmQgaW5jb21wYXRpYmlsaXR5IGlzc3VlIG9uIGJ0cmZzLXByb2cgJiBr
ZXJuZWwuIGJ0cmZzLXByb2dzDQo+PiBpcyB2Ni43LjEsIGtlcm5lbCBpcyA2LjcuNS1hb3Nj
LW1haW4uDQo+Pg0KPj4gVXNpbmcgdGhpcyBjb21tYW5kIHRvIGNyZWF0ZSBidHJmcyB2b2x1
bWU6DQo+PiAjIG1rZnMuYnRyZnMgLWYgLWQgcmFpZDEwIC1tIHJhaWQxYzQgLXMgMTZrIC1M
IEhZV0RBVEFfWk9ORURfVEVTVA0KPj4gL2Rldi9zZGIgL2Rldi9zZGMgL2Rldi9zZGQgL2Rl
di9zZGUNCj4+DQo+PiBXaGVuIG1vdW50aW5nLCBkbWVzZyBzYWlkOg0KPj4gW8KgIDMyOS4w
NzE0MDNdIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiBmaXJzdCBtb3VudCBvZiBmaWxlc3lz
dGVtDQo+PiA3YjRmMmNhNi1lZmUzLTQ4ZDktODFmNi1iYTY1YTAwZGI4NWUNCj4+IFvCoCAz
MjkuMDgwNDIyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogdXNpbmcgY3JjMzJjIChjcmMz
MmMtZ2VuZXJpYykNCj4+IGNoZWNrc3VtIGFsZ29yaXRobQ0KPj4gW8KgIDMyOS4wODgyMjJd
IEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiB1c2luZyBmcmVlIHNwYWNlIHRyZWUNCj4+IFvC
oCAzMjkuMDkzNjczXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYik6IGNhbm5vdCBtb3VudCBi
ZWNhdXNlIG9mIHVua25vd24NCj4+IGluY29tcGF0IGZlYXR1cmVzICgweDViNDEpDQo+PiBb
wqAgMzI5LjEwMjQ0Ml0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGIpOiBvcGVuX2N0cmVlIGZh
aWxlZA0KPj4NCj4+IGR1bXAtc3VwZXIgc2FpZDoNCj4+IFsuLi5dDQo+PiBpbmNvbXBhdF9m
bGFnc8KgwqDCoMKgwqDCoMKgwqDCoCAweDViNDENCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoIE1JWEVEX0JBQ0tSRUYgfA0KPj4gICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFWFRF
TkRFRF9JUkVGIHwNCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgU0tJTk5ZX01FVEFEQVRBIHwNCj4+ICAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTk9fSE9MRVMgfA0KPj4gICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSQUlE
MUMzNCB8DQo+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFpPTkVEIHwNCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgUkFJRF9TVFJJUEVfVFJFRSApDQo+PiBbLi4uXQ0KPj4N
Cj4+DQo+PiBSQUlEX1NUUklQRV9UUkVFIG5lZWQgQ09ORklHX0JUUkZTX0RFQlVHIHRvIGJl
IHN1cHBvcnRlZCBhbmQgdGhpcw0KPj4gZmVhdHVyZSBmbGFnIGlzIGRpc2FibGVkIG9uIG1v
c3QgZGlzdHJpYnV0aW9ucy4gSSBob3BlIFJTVCBjYW4gYmUNCj4+IGRpc2FibGVkIGJ5IGRl
ZmF1bHQgb24gYnRyZnMtcHJvZ3MuDQo+IElNTyB0aGlzIHdvcmtzIGFzIGludGVuZGVkLiBG
ZWF0dXJlcyBtYXkgYmUgZW5hYmxlZCBhaGVhZCBvZiB0aW1lIGluDQo+IGJ0cmZzLXByb2dz
IGR1ZSB0byBlYXJseSB0ZXN0aW5nIGFuZCBub3QgcmVxdWlyaW5nIHRoZSBleHBlcmltZW50
YWwNCj4gYnVpbGQuIFRoZSBleHBlcmltZW50YWwgc3RhdHVzIG9mIHByb2dzIGZlYXR1cmVz
IGlzIGFib3V0IGNvbXBsZXRlbmVzcw0KPiBvZiB0aGUgaW1wbGVtZW50YXRpb24sIHNvIGlm
IG1rZnMgY3JlYXRlcyBhIGZpbGVzeXN0ZW0gd2l0aCBSU1QgdGhlbiBpdA0KPiBjb3VsZCBi
ZSBlbmFibGVkLg0KSWYgZHVlIHRvIGVhcmx5IHRlc3RpbmcsIGJ0cmZzLXByb2dzIGNvdWxk
IGhhdmUgLS1leHBlcmltZW50YWwgb3B0aW9uIHRvIA0KZW5hYmxlIGl0IGluc3RlYWQgb2YN
Cg0KZW5hYmxpbmcgaXQgYnkgZGVmYXVsdCB3aGljaCB3b3VsZCBjYXVzaW5nIGNvbmZ1c2lv
biB0byBub3JtYWwgdXNlcnMuIA0KRm9yIGV4cGVyaWVuY2VkIHVzZXIgd2hvIHdhbnRzIHRv
IHRlc3QgbmV3IGZlYXR1cmUsIHdlIGNhbiBoaW50IHRoZW0gdG8gDQp1c2UgdGhpcyBvcHRp
b24gd2hlbiBuZWVkZWQuDQoNCmUuZy4NCg0KIyBta2ZzLmJ0cmZzIC1mIC1kIHJhaWQxMCAt
bSByYWlkMWM0IC1zIDE2aw0KY2FuJ3QgdXNlIHJhaWQxMCwgdGhpcyBpcyBhIGV4cGVyaW1l
bnRhbCBmZWF0dXJlLCB1c2UgLS1leHBlcmltZW50YWwgaWYgDQp5b3UgcmVhbGx5IHdhbnQg
aXQuDQoNCiMgbWtmcy5idHJmcyAtZiAtZCByYWlkMTAgLW0gcmFpZDFjNCAtcyAxNmsgLS1l
eHBlcmltZW50YWwNCg0KW3N1Y2NlZWRdDQoNCj4gVGhlIGtlcm5lbCBzdXBwb3J0IGlzIHN0
aWxsIG1pc3Npbmcgc29tZSBmZWF0dXJlcyBhbmQgdGhlcmUgYXJlIHNvbWUNCj4ga25vd24g
YnVncywgdGhpcyBpcyBjb252ZW5pZW50bHkgaGlkZGVuIGJlaGluZCB0aGUgREVCVUcgb3B0
aW9uIHNvIGl0DQo+IGRvZXMgbm90IGFmZmVjdCBkaXN0cmlidXRpb25zLg0KPg0KPiBIb3dl
dmVyIGl0IHNlZW1zIHRoYXQgdGhlIGRvY3VtZW50YXRpb24gaXMgbm90IGNsZWFyIGFib3V0
IHRoYXQgYW5kIHRoZQ0KPiBzdGF0dXMgcGFnZSBzaG91bGQgYmUgdXBkYXRlZC4NCj4NCg==


--------------5dWG22qcfAsR9UuZFy5IE0Qp--

--------------d1J6bv317j0IjgAbHfo9rX8v
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZikwPgAKCRBLkKfpYfpB
U3JxAP9bsvoCzGkn2R0T55sTcs1NLcCkBAeAy32sFE2buNUqLAEA9gWgcscn7nqd
I2ylhCF3HYbgC5/2CTVTNYZHgmnY0QY=
=jvy5
-----END PGP SIGNATURE-----

--------------d1J6bv317j0IjgAbHfo9rX8v--


