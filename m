Return-Path: <linux-btrfs+bounces-2271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F384F147
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 09:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE351F255D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D64165BBC;
	Fri,  9 Feb 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="lUlmDpsm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFE56B89
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466627; cv=none; b=fVeubT8H2UrTFRn+tqZ4Vh5Y8OWq/T64y4F41zwePNsZHrDaZT1TKst8r/wBkZV+e+KSD2AqMllxyoT3FqPrictQOgwB9egEw5N5J2+x/iNUxlrmDA/sspBTG7ql4Y8MhniHio212CQQg9UV7juMC6qKjsMyPEBTwAq2uwZngvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466627; c=relaxed/simple;
	bh=5NKq743ADI+v1QXyEb5g/Lr2EuZkdXriyB1sI5GL/M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/HVkBRp6SwVX2py5dX3eRyKulBEWph5/1eK1Sp+dzYvTriQbB3ldX6AKzH23cGsD1YvWkIFoFkgXytd1ghhNTVYSspk+zZE7OjgdxZTKl5rGI+CE8P7nq54/P2TPN0WZksDy3xzWqA4fPbcD4omndIYh59fCHNqatMIAXz4TLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=lUlmDpsm; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1707466611;
	bh=5NKq743ADI+v1QXyEb5g/Lr2EuZkdXriyB1sI5GL/M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lUlmDpsmUhgns7ZOMUK7yao+dHGBTfKB90r12NuQyidq9zbMvavaZIHc8dbb50xwq
	 YiMGnkR852ZhgdePBP5IKy/gVJ3Ph0eKD+3YAAdcUHDhXLAHlsnElMLBp1SkyKO3lI
	 DZ2YiBvZDifAqdzQInPXAaSLKY+RxhV/k3fVTLBE=
X-QQ-mid: bizesmtp84t1707466609tchaacgr
X-QQ-Originating-IP: NS94EzNTUjfOhS5Cs/c8koFffRJBaZL81xFvY77xzjU=
Received: from [192.168.1.136] ( [223.150.249.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Feb 2024 16:16:48 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJmy7xKitAofnckjnFD19oYkeI28NN3tn732cTJTXJmTCYfWabk50
	DA/ldoc6Eib73eDdG+BKSJT+rhpU1ILaGZzy97iMwvTKELSAPoX+Hw4iCc5mJvP1hpRiSxx
	2tusQjVKGZorJDvtzMXzInL+K2kXX0tR3goH33sWcvsh3Ew8RepOz1HbTI6Wz0nMtWY7X90
	tj0i6uh+WNDmgpmRMphz5qEskmkZpYLRJZcL7FqaJrrGuBHonnZIMJBOKFjhCdPMe5IJMwP
	tTNiVeyQn+nd67EvGlWuehehOm+551H+mvmItUvKe318dP8a38zsafmoCtcJufO6ZmqAKDw
	4hfABYstYu2U3tkDjDSCa0sarirOjRnjP5w+6LWDC0OZyMTYFE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18017807371879608683
Message-ID: <1573ACF30347C754+463b9523-d8b9-48ba-806f-c7eb89c55827@bupt.moe>
Date: Fri, 9 Feb 2024 16:16:44 +0800
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
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
In-Reply-To: <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yXriCQbbesw4iShL08Uopl0d"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yXriCQbbesw4iShL08Uopl0d
Content-Type: multipart/mixed; boundary="------------przI8IVTi5uNfA0n0AQMQkRB";
 protected-headers="v1"
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <463b9523-d8b9-48ba-806f-c7eb89c55827@bupt.moe>
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
In-Reply-To: <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
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

--------------przI8IVTi5uNfA0n0AQMQkRB
Content-Type: multipart/mixed; boundary="------------5oGQwwuIKwLvUZhcc70unEOd"

--------------5oGQwwuIKwLvUZhcc70unEOd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQrlnKggMjAyNC8yLzggMjA6NDIsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+IE9u
IDA1LjAyLjI0IDA4OjU2LCBRdSBXZW5ydW8gd3JvdGU6DQo+Pj4gICAgPiAuL251bGxiIHNl
dHVwDQo+Pj4gICAgPiAuL251bGxiIGNyZWF0ZSAtcyA0MDk2IC16IDI1Ng0KPj4+ICAgID4g
Li9udWxsYiBjcmVhdGUgLXMgNDA5NiAteiAyNTYNCj4+PiAgICA+IC4vbnVsbGIgbHMNCj4+
PiAgICA+IG1rZnMuYnRyZnMgLXMgMTZrIC9kZXYvbnVsbGIwDQo+Pj4gICAgPiBtb3VudCAv
ZGV2L251bGxiMCAvbW50L3RtcA0KPj4+ICAgID4gYnRyZnMgZGV2aWNlIGFkZCAvZGV2L251
bGxiMSAvbW50L3RtcA0KPj4+ICAgID4gYnRyZnMgYmFsYW5jZSBzdGFydCAtZGNvbnZlcnQ9
cmFpZDEgLW1jb252ZXJ0PXJhaWQxIC9tbnQvdG1wDQo+PiBKdXN0IHdhbnQgdG8gYmUgc3Vy
ZSwgZm9yIHlvdXIgY2FzZSwgeW91J3JlIGRvaW5nIHRoZSBzYW1lIG1rZnMgKDRLDQo+PiBz
ZWN0b3JzaXplKSBvbiB0aGUgcGh5c2ljYWwgZGlzaywgdGhlbiBhZGQgYSBuZXcgZGlzaywg
YW5kIGZpbmFsbHkNCj4+IGJhbGFuY2VkIHRoZSBmcz8NCj4+DQo+PiBJSVJDIHRoZSBiYWxh
bmNlIGl0c2VsZiBzaG91bGQgbm90IHN1Y2NlZWQsIG5vIG1hdHRlciBpZiBpdCdzIGVtdWxh
dGVkDQo+PiBvciByZWFsIGRpc2tzLCBhcyBkYXRhIFJBSUQxIHJlcXVpcmVzIHpvbmVkIFJT
VCBzdXBwb3J0Lg0KPiBGb3IgbWUsIGJhbGFuY2UgZG9lc24ndCBhY2NlcHQgUkFJRCBvbiB6
b25lZCBkZXZpY2VzLCBhcyBpdCdzIHN1cHBvc2VkDQo+IHRvIGRvOg0KPg0KPiBbICAyMTIu
NzIxODcyXSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IGhvc3QtbWFuYWdlZCB6b25l
ZCBibG9jaw0KPiBkZXZpY2UgL2Rldi9udm1lMm4xLCAxNjAgem9uZXMgb2YgMTM0MjE3NzI4
IGJ5dGVzDQo+IFsgIDIxMi43MjU2OTRdIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4xKTog
ZGlzayBhZGRlZCAvZGV2L252bWUybjENCj4gWyAgMjEyLjc0NDgwN10gQlRSRlMgd2Fybmlu
ZyAoZGV2aWNlIG52bWUxbjEpOiBiYWxhbmNlOiBtZXRhZGF0YSBwcm9maWxlDQo+IGR1cCBo
YXMgbG93ZXIgcmVkdW5kYW5jeSB0aGFuIGRhdGEgcHJvZmlsZSByYWlkMQ0KPiBbICAyMTIu
NzQ4NzA2XSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IGJhbGFuY2U6IHN0YXJ0IC1k
Y29udmVydD1yYWlkMQ0KPiBbICAyMTIuNzUwMDA2XSBCVFJGUyBlcnJvciAoZGV2aWNlIG52
bWUxbjEpOiB6b25lZDogZGF0YSByYWlkMSBuZWVkcw0KPiByYWlkLXN0cmlwZS10cmVlDQo+
IFsgIDIxMi43NTEyNjddIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4xKTogYmFsYW5jZTog
ZW5kZWQgd2l0aCBzdGF0dXM6IC0yMg0KVGhpcyBpcyB1c2luZyBudm1lIGRyaXZlciwgbWlu
ZSBpcyBTQVRBLiBJdCB0aGlzIHJlbGF0ZWQ/DQo+IFNvIEknbSBub3QgZXhhY3RseSBzdXJl
IHdoYXQncyBoYXBwZW5pbmcgaGVyZS4NCg==
--------------5oGQwwuIKwLvUZhcc70unEOd
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

--------------5oGQwwuIKwLvUZhcc70unEOd--

--------------przI8IVTi5uNfA0n0AQMQkRB--

--------------yXriCQbbesw4iShL08Uopl0d
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZcXfbAAKCRBLkKfpYfpB
U5jeAPwM+rlV6ETVgJg05w5iNgIpbwNA7Gc2VXe2/eqTtaTGXwEA5DfXyjSrZxfT
YDxPo8eyrqwMtiGxBTKeD4C5bkfnggY=
=H5PI
-----END PGP SIGNATURE-----

--------------yXriCQbbesw4iShL08Uopl0d--


