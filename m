Return-Path: <linux-btrfs+bounces-18408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D6C1E56A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 05:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FC114E5113
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 04:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433329AB11;
	Thu, 30 Oct 2025 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="aAy2aqQY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22AB22F74E
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797837; cv=none; b=B4gciXLr8QTWHoQ/Fz5A/IYgF/oJhoS4ki1QSfqHnJSLsvjmjGzmTMOSyvHmxTy/hT+kGnh/Fle05umSpy19Bp845NtDFD91FNCbcud5TkKAc/xpCUSiwYnexaTY8j6y8TvlDhX3roCJKM4ZWP7iRLQZwwiQHSaKqWMTlCU4dbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797837; c=relaxed/simple;
	bh=0l2QbAWWGspg9Y80JugE+bGOVFL34WwuUrBsj7ll8bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hhrnTnH29jEtb46H6gW3KGI3U4B2Q3d0q857T+qt7E3OlViz9m2VGp1x+alMR6S2LylJAA7hRxaMuAr060bcIbHHG4D2b+h+CSgLgbmdRX3fhTUCToqFuagrQRK/CieZCEwQpCGd+1vL7xHerjIm/flZtuvqXQHDXjb+53v9tTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=aAy2aqQY; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1761797811;
	bh=0l2QbAWWGspg9Y80JugE+bGOVFL34WwuUrBsj7ll8bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=aAy2aqQYhYXxtAoxr8EP2bZd82zWKuUa49kfVZ6BFRbZqnJ2DYNJQgyaQBUUrQYp2
	 hDnyUHlj9VgGdxGwb8aNfdY4gzvoBFzhZpmJUovK4XBN695YEAjfILpas+JmgDe28H
	 VChJKREt5P2P3St44rUAbCMGJ4B4RvRGswrniHL8=
X-QQ-mid: zesmtpip2t1761797810tbbf0c312
X-QQ-Originating-IP: hi+Q3MvHchZt1U57uRhkfbt0bGmLyj0rxq/NxgnrQcs=
Received: from [IPV6:2408:8215:5911:8ba0:452f: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 12:16:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6016159955189006943
Message-ID: <FDBD17D73E911416+7ade80f6-f273-4190-83e9-61e98aeac808@bupt.moe>
Date: Thu, 30 Oct 2025 12:16:48 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: convert: prevent data chunks to go beyond
 device size
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------70fkxEPtSipqFKD72BVnlnuo"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MgQY1K25Ph0mFJr9j287pz7quzHxqHHa8aXVVOqmwa5UpxPgmPakPk+y
	Ys/T4VTb52+xUl0zvrwDX2J/V88LHmM77BDhnL/Ivh++OmPWzABUxqYPFVp5qcaDN0fo65P
	VYveTlUouZRC/x5HdzKmiiRXiBro/srfnQFIjFOrxVsIkbzaSZjL+MlT5ti3JZjnFBSiwvc
	Wv8AiWzAVa1l3Z1TPqk/rgFaiL6q/TWIYuKs5sl3PoKWRwFKxSryu4LCwiD52txTLo960Kg
	D4zU2qEyfrtpy1VNooOrYFPdT5tdD0lBrZ64F8aFWO5ggyrrFdXSTU5gUL85foQ/f+UXRKL
	UN85oYF2CIfZsb24l9/Zu/2rO3T4+5AIvPb5ywglgsv0BEdzBsmx93Geu6w2j+ISYGdpaws
	CA34Djfrp5IgNr+WfkcXty/ul1KPGf3+ZZCCiXP7PTbOPXG1fhFqQFw/uSSvZYMh+rCu9xl
	x9AmHDP7bosu2NYtmWlZgQmhQ+91ZSgascrgcydG+VBfkah+9EwNPTMSp+nT7yhfjwo6oRQ
	80mj23jwJ9iITIceR401FN7djyXigp/eBEGqfnEyEVCdidF4o178Hx1j2qxUVoQtCBsquKl
	Cm6EG+5L2ZeCXENGbVaEm241aKx+2zKyBtLi7TK0fqs09KiUdj45ybl8O1JQlVQ98dK6+2V
	l688ELGciHwZ22gugN2MoMXT8D4/MjQec6YkKgVLWmFLVUEQrOquCNdkUEb4vUvQXlGOVXq
	zJ5/B+YsCGWTpaLBD63lgDgzcUkhJ5YbQS0eVFWgtcmJ2f2KFdazgh7axhbHJLEIK3ZuVYx
	A8QG0zYTRot31YjFcv5AFPHLdvb0mSUk29H7rbNgwZT3KxXt0tvvbJoqwH6DMLjP88+IuI6
	AFV/NrRuGkFG0HmjDgwCcvEHq0SUDikD9RqMhYyL5c3bzgTvjTL4fpZA27V6RJj2cUcxrdO
	miWU9hfBFinu4h8iyiPxmt0Y66q1jsA5IUEtwXi2+asgvIHF2u041nboJ
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------70fkxEPtSipqFKD72BVnlnuo
Content-Type: multipart/mixed; boundary="------------57avd2zsOe7v6T0nDpgk3Aw6";
 protected-headers="v1"
From: Yuwei Han <hrx@bupt.moe>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <7ade80f6-f273-4190-83e9-61e98aeac808@bupt.moe>
Subject: Re: [PATCH] btrfs-progs: convert: prevent data chunks to go beyond
 device size
References: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
In-Reply-To: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
Autocrypt-Gossip: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=

--------------57avd2zsOe7v6T0nDpgk3Aw6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDI1LzEwLzI1IDA3OjMwLCBRdSBXZW5ydW8g5YaZ6YGTOg0KPiBbQlVHXQ0K
PiBUaGVyZSBpcyBhIGJ1ZyByZXBvcnQgdGhhdCBrZXJuZWwgaXMgcmVqZWN0aW5nIGEgY29u
dmVydGVkIGJ0cmZzIHRoYXQNCj4gaGFzIGRldiBleHRlbnRzIGJleW9uZCBkZXZpY2UgYm91
bmRhcnkuDQo+IA0KPiBUaGUgaW52b3ZsZWQgZGV2aWNlIGV4dGVudCBpcyBhdCA5OTk2Mjc2
OTQ5ODAsIGxlbmd0aCBpcyAzMDkyNDgwMCwNCj4gbWVhbndoaWxlIHRoZSBkZXZpY2UgaXMg
OTk5NjU4NTU3NDQwLg0KPiANCj4gVGhlIGRldmljZSBpcyBzaXplIG5vdCBhbGlnbmVkIHRv
IDY0SywgbWVhbndoaWxlIHRoZSBkZXYgZXh0ZW50IGlzDQo+IGFsaWduZWQgdG8gNjRLLg0K
PiANCj4gW0NBVVNFXQ0KPiBGb3IgY29udmVydGVkIGJ0cmZzLCB0aGUgc291cmNlIGZzIGhh
cyBhbGwgaXRzIGZyZWVkb20gdG8gY2hvb3NlIGl0cw0KPiBzaXplLCBhcyBsb25nIGFzIGl0
J3MgYWxpZ25lZCB0byB0aGUgZnMgYmxvY2sgc2l6ZS4NCj4gDQo+IFNvIHdoZW4gYWRkaW5n
IG5ldyBjb252ZXJ0ZWQgZGF0YSBibG9jayBncm91cHMgd2UgbmVlZCB0byBkbyBleHRyYQ0K
PiBhbGlnbm1lbnQsIGJ1dCBpbiBtYWtlX2NvbnZlcnRfZGF0YV9ibG9ja19ncm91cHMoKSB3
ZSBhcmUgcm91bmRpbmcgdXANCj4gdGhlIGVuZCwgd2hpY2ggY2FuIGV4Y2VlZCB0aGUgZGV2
aWNlIHNpemUuDQo+IA0KPiBbRklYXQ0KPiBJbnN0ZWFkIG9mIHJvdW5kaW5nIHVwIHRvIHN0
cmlwZSBib3VuZGFyeSwgcm91bmRpbmcgaXQgZG93biB0byBwcmV2ZW50DQo+IGdvaW5nIGJl
eW9uZCB0aGUgZGV2aWNlIGJvdW5kYXJ5Lg0KPiANClJlcG9ydGVkLWJ5OiBBbmRpZXFxcSA8
emVpZ2UyNjU5NzVAZ21haWwuY29tPj4gU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIA0KPHdx
dUBzdXNlLmNvbT4NCj4gLS0tDQo+ICAgY29udmVydC9tYWluLmMgfCA0ICsrLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2NvbnZlcnQvbWFpbi5jIGIvY29udmVydC9tYWluLmMNCj4gaW5kZXgg
ZTI3OWUzZDQwYzVmLi41YzQwYzA4ZGRkNzIgMTAwNjQ0DQo+IC0tLSBhL2NvbnZlcnQvbWFp
bi5jDQo+ICsrKyBiL2NvbnZlcnQvbWFpbi5jDQo+IEBAIC05NDgsOCArOTQ4LDggQEAgc3Rh
dGljIGludCBtYWtlX2NvbnZlcnRfZGF0YV9ibG9ja19ncm91cHMoc3RydWN0IGJ0cmZzX3Ry
YW5zX2hhbmRsZSAqdHJhbnMsDQo+ICAgCQkJdTY0IGN1cl9iYWNrdXAgPSBjdXI7DQo+ICAg
DQo+ICAgCQkJbGVuID0gbWluKG1heF9jaHVua19zaXplLA0KPiAtCQkJCSAgcm91bmRfdXAo
Y2FjaGUtPnN0YXJ0ICsgY2FjaGUtPnNpemUsDQo+IC0JCQkJCSAgIEJUUkZTX1NUUklQRV9M
RU4pIC0gY3VyKTsNCj4gKwkJCQkgIHJvdW5kX2Rvd24oY2FjaGUtPnN0YXJ0ICsgY2FjaGUt
PnNpemUsDQo+ICsJCQkJCSAgICAgQlRSRlNfU1RSSVBFX0xFTikgLSBjdXIpOw0KPiAgIAkJ
CXJldCA9IGJ0cmZzX2FsbG9jX2RhdGFfY2h1bmsodHJhbnMsIGZzX2luZm8sICZjdXJfYmFj
a3VwLCBsZW4pOw0KPiAgIAkJCWlmIChyZXQgPCAwKQ0KPiAgIAkJCQlicmVhazsNCg0K

--------------57avd2zsOe7v6T0nDpgk3Aw6--

--------------70fkxEPtSipqFKD72BVnlnuo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQ3xl0cveqzft47u2GTyL/FEVGAGAUCaQLmsAUDAAAAAAAKCRCTyL/FEVGAGIUG
AQDdJj4NggXQ+zT3zgiWLSQ1f8DMPRV52E5rT0FYJxRD3QD/YegVua1LR5eGoN/yVtLECAussXp7
bXl+ZEsciFAlMAg=
=suex
-----END PGP SIGNATURE-----

--------------70fkxEPtSipqFKD72BVnlnuo--


