Return-Path: <linux-btrfs+bounces-5197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C388CBB8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546061C21887
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45F78C67;
	Wed, 22 May 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="StGU1j80"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26C77116
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360560; cv=none; b=N6gv2JZfWDi+nNndwD1BhUn4sG8MDNpMd7clwadNZ49/PMrkxMNZKQfZZaKmqL5NQleuw10VuVuPS39TjdPZpXcn2q2cXO0KLZxmpUpbCb63sPWWlvMMwSi5rt7dVFaWw9OyRTLgqfFsKJNlZ1xfq8EjkL79mP+UuhWRVBQS5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360560; c=relaxed/simple;
	bh=MwvGXU/ReVDbO8L386Jjjf8JSWd0GLl6Vp1Dz7AEpzY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fJMJfuvxPHXF71vYlEmrTgZN2kQIfNzrdOMCvTawKTcjLifwwQ8RGDoqOmiEKBdJJuTy0vji3kd8hka6RGxlwIuEWPUOmmxXN0BReKWOWDAfZ+bhakpFIl9vYalM7pvawD/HqrqaJzR6J26vI2DH1t5Lx4mtWwQUe8DoAlqiIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=StGU1j80; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716360554; x=1716965354; i=quwenruo.btrfs@gmx.com;
	bh=MwvGXU/ReVDbO8L386Jjjf8JSWd0GLl6Vp1Dz7AEpzY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=StGU1j80A6ls6DfhSmEqOa40AToviJxufWWgJ9XageDdZmI+tnVA0aEozd3UfqtO
	 9o3pGj4SRWB6PU77Q2ZBue3xJlbTCdUEt56hB5jaWab+aI4YDJRi/1FwZr1tN0Mtl
	 VIjPsJw9pyYVi+on4P93BRH7aX1Q6nT5vy5SuLux8VUYXYH28IrUFjFEB1AuQ8jVe
	 6HnnWIV2VhMhvdoH4lT2Qk8SCo7x+qBNsw13MINhfbEjMyZ/yNaEPQBH5FXXHAws6
	 KXN3N1OpiFz0Ri3ouydxAe3n3vDeBPA4+CWx0OUAphBrexpgdKCz//cBB0yFVEatJ
	 MkSbwQmefQdp/CWFXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1sC8lG1mxP-0065PR; Wed, 22
 May 2024 08:49:14 +0200
Message-ID: <fdc34db2-b6a4-49ee-88e8-26c8f943d447@gmx.com>
Date: Wed, 22 May 2024 16:19:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] btrfs-progs: mkfs: align byte_count with
 sectorsize and zone size
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
 <20240522060232.3569226-6-naohiro.aota@wdc.com>
 <d959127a-d0f0-4444-a69a-0ffa1002d5f1@gmx.com>
Content-Language: en-US
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
In-Reply-To: <d959127a-d0f0-4444-a69a-0ffa1002d5f1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:9YjUFWKDt9L3sBdvm2bHhWtzB4rto2HnaDXj2AmN98kCfEM6ido
 3LrGin2QL1S4IOhpG/XocvPfaI6ji+WWeOQhWel+Zt5zSjCTRC4QTl0aqNlgFpqobr417g3
 PSI/5ykorJD9bnlUcOjGBT8CBiqtKTNQT3YGPWWxY6JnY0nwN562Adv0HW2NeWKwN5McHC3
 QuM2csTKzX9DfFofUOMtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jvP6t80M684=;9itiha8h6V8NrLdgdStS5RQyjsW
 cNk67h0H5pRh0ineTpwLr8wyG0e2Xg9rHhUaKvjNpDIkpeNyRXhzT7BXDvep70aTtRsnv69Pg
 sm8ul9mw5FMupB1neUCuPYl/OJTtyp/b+V/OMwU4R7iZwOODayaWsMrxeb2r76quXNQxB94C3
 wUcAfxffbEvL7/56/YPXeTilogJcD62NHxbc19MgHaeik79twFNfeKB/5zApfka/1NREYFUzP
 MEDObv8PdSzs/anulbSTpv7SKQMIIto2T/SueZZdw8dtr8dr3a619BIAg7vvNLF8EjuDrhOxE
 caBrJ23a4tOHqFaOIXyoP4mofUDkt9Bx5x6mNsB1iN551zgHL14Wy9meG4cPoy4YjfboZv1Pn
 Iffxsicqa3p4jM7vibLAgs+VRvELJfNZw2tTQXDjkqgiZ4ThZTsuLb03D8EShJOh2tMREG5NL
 ILDPZ+7aiKJFaOKX+/2wNPJINs5nk66Gmm2PuJ6TztXIzaO3Rg+tNCwZqmYLWNaVliJsctgjW
 5sxvZotY7YB1gUAHSi0NyPelyxGO3m3f+wW9uHLpmHDPM/2YnUfkLDm4+JbdBYfDV6rdY2ORK
 bWdetsrOGD52xCMQ7liTsAwfYs8erNkUNX35EooxcJGQkh/l6S980BffwHj6RcDyslIQrinoy
 YJYjaRt+MH+mD608EV2INLTW/PaAp8Gwh0VAMO2OK6s/5mkR2VuzHZ+62sM8Ed6bIq9rGOK/x
 o20kepXG+YqY+zLIINQPWIStfCX+wQv62IOxk97eAdwshvcC8nFWAeaE3ZcdEeSdoyyCthABA
 qFWobDiln4gy/mztOHdTL3Hdc0jAbc0Y6YvEVDSahpCDg=

DQoNCuWcqCAyMDI0LzUvMjIgMTY6MTMsIFF1IFdlbnJ1byDlhpnpgZM6DQo+IA0KPiANCj4g5Zyo
IDIwMjQvNS8yMiAxNTozMiwgTmFvaGlybyBBb3RhIOWGmemBkzoNCj4+IFdoaWxlICJieXRlX2Nv
dW50IiBpcyBldmVudHVhbGx5IHJvdW5kZWQgZG93biB0byBzZWN0b3JzaXplIGF0IA0KPj4gbWFr
ZV9idHJmcygpDQo+PiBvciBidHJmc19hZGRfdG9fZnNfaWQoKSwgaXQgd291bGQgYmUgYmV0dGVy
IHJvdW5kIGl0IGRvd24gZmlyc3QgYW5kIGRvIA0KPj4gdGhlDQo+PiBzaXplIGNoZWNrcyBub3Qg
dG8gY29uZnVzZSB0aGUgdGhpbmdzLg0KPj4NCj4+IEFsc28sIG9uIGEgem9uZWQgZGV2aWNlLCBj
cmVhdGluZyBhIGJ0cmZzIHdob3NlIHNpemUgaXMgbm90IGFsaWduZWQgdG8gDQo+PiB0aGUNCj4+
IHpvbmUgYm91bmRhcnkgY2FuIGJlIGNvbmZ1c2luZy4gUm91bmQgaXQgZG93biBmdXJ0aGVyIHRv
IHRoZSB6b25lIA0KPj4gYm91bmRhcnkuDQo+Pg0KPj4gVGhlIHNpemUgY2FsY3VsYXRpb24gd2l0
aCBhIHNvdXJjZSBkaXJlY3RvcnkgaXMgYWxzbyB0d2Vha2VkIHRvIGJlIA0KPj4gYWxpZ25lZC4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29t
Pg0KPj4gLS0tDQo+PiDCoCBta2ZzL21haW4uYyB8IDExICsrKysrKysrKy0tDQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9ta2ZzL21haW4uYyBiL21rZnMvbWFpbi5jDQo+PiBpbmRleCBhNDM3ZWNjNDBjN2Yu
LmJhZjg4OTg3M2I0MSAxMDA2NDQNCj4+IC0tLSBhL21rZnMvbWFpbi5jDQo+PiArKysgYi9ta2Zz
L21haW4uYw0KPj4gQEAgLTE1OTEsNiArMTU5MSwxMiBAQCBpbnQgQk9YX01BSU4obWtmcykoaW50
IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4gwqDCoMKgwqDCoCBtaW5fZGV2X3NpemUgPSBidHJmc19t
aW5fZGV2X3NpemUobm9kZXNpemUsIG1peGVkLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcHRfem9uZWQgPyB6b25lX3NpemUoZmlsZSkgOiAwLA0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZXRhZGF0
YV9wcm9maWxlLCBkYXRhX3Byb2ZpbGUpOw0KPj4gK8KgwqDCoCBpZiAoYnl0ZV9jb3VudCkgew0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGJ5dGVfY291bnQgPSByb3VuZF9kb3duKGJ5dGVfY291bnQsIHNl
Y3RvcnNpemUpOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChvcHRfem9uZWQpDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBieXRlX2NvdW50ID0gcm91bmRfZG93bihieXRlX2NvdW50LMKgIHpv
bmVfc2l6ZShmaWxlKSk7DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+IMKgwqDCoMKgwqAgLyoNCj4+
IMKgwqDCoMKgwqDCoCAqIEVubGFyZ2UgdGhlIGRlc3RpbmF0aW9uIGZpbGUgb3IgY3JlYXRlIGEg
bmV3IG9uZSwgdXNpbmcgdGhlIHNpemUNCj4+IMKgwqDCoMKgwqDCoCAqIGNhbGN1bGF0ZWQgZnJv
bSBzb3VyY2UgZGlyLg0KPj4gQEAgLTE2MjQsMTIgKzE2MzAsMTMgQEAgaW50IEJPWF9NQUlOKG1r
ZnMpKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICogT3Ig
d2Ugd2lsbCBhbHdheXMgdXNlIHNvdXJjZV9kaXJfc2l6ZSBjYWxjdWxhdGVkIGZvciBta2ZzLg0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWJ5
dGVfY291bnQpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBieXRlX2NvdW50ID0gZGV2aWNl
X2dldF9wYXJ0aXRpb25fc2l6ZV9mZF9zdGF0KGZkLCANCj4+ICZzdGF0YnVmKTsNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJ5dGVfY291bnQgPSANCj4+IHJvdW5kX3VwKGRldmljZV9nZXRf
cGFydGl0aW9uX3NpemVfZmRfc3RhdChmZCwgJnN0YXRidWYpLA0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlY3RvcnNpemUpOw0KDQpNeSBi
YWQsIGZvcmdvdCB0aGlzIG9uZSB0b28uDQoNCldlIHNob3VsZCByb3VuZF9kb3duKCkgaGVyZS4N
Cg0KQXMgaWYgd2UgaGF2ZSBhIDUxMiBieXRlcyBibG9ja2VkIGRldmljZSwgYW5kIHRoZSBwYXJ0
aXRpb24gaXMgb25seSANCmFsaWduZWQgdG8gNTEyIGJ5dGVzLCB0aGlzIGNhbiBtYWtlIHRoZSBs
YXN0IHNlY3RvciBnbyBiZXlvbmQgZGV2aWNlIA0KYm91bmRhcnkuDQoNClRoYW5rcywNClF1DQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgc291cmNlX2Rpcl9zaXplID0gYnRyZnNfbWtmc19zaXplX2Rp
cihzb3VyY2VfZGlyLCBzZWN0b3JzaXplLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtaW5fZGV2X3NpemUsIG1ldGFkYXRhX3Byb2ZpbGUsIGRhdGFfcHJvZmlsZSk7DQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGJ5dGVfY291bnQgPCBzb3VyY2VfZGlyX3NpemUpIHsN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChTX0lTUkVHKHN0YXRidWYuc3RfbW9k
ZSkpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnl0ZV9jb3VudCA9IHNv
dXJjZV9kaXJfc2l6ZTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnl0ZV9j
b3VudCA9IHJvdW5kX3VwKHNvdXJjZV9kaXJfc2l6ZSwgc2VjdG9yc2l6ZSk7DQo+IA0KPiBJIGJl
bGlldmUgd2Ugc2hvdWxkIHJvdW5kIHVwIG5vdCByb3VuZCBkb3duLCBpZiB3ZSdyZSB1c2luZyAt
LXJvb3RkaXINCj4gb3B0aW9uLg0KPiANCj4gQXMgc21hbGxlciBzaXplIHdvdWxkIG9ubHkgYmUg
bW9yZSBwb3NzaWJsZSB0byBoaXQgRU5PU1BDLg0KPiANCj4gT3RoZXJ3aXNlIGxvb2tzIGdvb2Qg
dG8gbWUuDQo+IA0KPiBUaGFua3MsDQo+IFF1DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9IGVsc2Ugew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3YXJuaW5n
KA0KPj4gwqAgInRoZSB0YXJnZXQgZGV2aWNlICVsbHUgKCVzKSBpcyBzbWFsbGVyIHRoYW4gdGhl
IGNhbGN1bGF0ZWQgc291cmNlIA0KPj4gZGlyZWN0b3J5IHNpemUgJWxsdSAoJXMpLCBta2ZzIG1h
eSBmYWlsIiwNCj4gDQo=

