Return-Path: <linux-btrfs+bounces-2828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA508687C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 04:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A9F1C222CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 03:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E161B7E9;
	Tue, 27 Feb 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="VbJs7zfG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188C1DA21
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709004067; cv=none; b=cAWPQBBlqCQfw8F8zjbWNkHKQIG2Uht2uR9Z9diN3DyeYJjBcrjIoGF2JtMtCh8l8ZvLYeFVfJX62nD5977e9gq6kkiovXuCgLNaflpMqge5BlMkNtGa5jc3kjlHdt52LyzIpiPGmGWpGGxx4qBeZ0F9JLz3VakE1JR6Mbz4NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709004067; c=relaxed/simple;
	bh=IpoxsNghvHycwMHjWSSb+QK8/2A5GGfEgXk0QFyFSjI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sIt7tvUWT1GGLIkhymqGqjmrJLuXrbLJszcWpgYPbluftvuXO1c7YaUCxayhMCRqZL0PgDWqdcljK0ySgvm6zSMiUuBWylMEovdCZuumnkF8RK8PhY6jCDgVPdZWXXRXZCc9FqPzWAq1yzbHnqfZp7X6rfIOvcpTbxKGqnK6cl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=VbJs7zfG; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1709004049;
	bh=IpoxsNghvHycwMHjWSSb+QK8/2A5GGfEgXk0QFyFSjI=;
	h=Message-ID:Date:MIME-Version:To:Subject:From;
	b=VbJs7zfGS8vr4HpLKLZjqSHbpyViWLD0rz2gamIgjvHsmDuPAkzW6s3W4wEuMTWX9
	 AavD90SsEcMQV0e5X643t4W/PVmWy4+xoiWYLElBEygfTa/747l81cxKzRJhkH799t
	 kfSvjuMT1DrbLKVxIy5bVDsvEo4HzFZRD7c5bff8=
X-QQ-mid: bizesmtp83t1709004047tc60z7fs
X-QQ-Originating-IP: u8Kcn4FMG2t3AYW7utIsizD8524RFsZ/82UvMs7h+UM=
Received: from [192.168.1.136] ( [223.150.232.63])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 Feb 2024 11:20:45 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: J5JfekO1Wshwy21ivLpXCYi4eSmVl0usrmWEJLqPIZWhXWI4eckI2WXk3d7hy
	zAhuBpxIAFPXGConT20dpt0wzsgkF4+GXTciUF/7popU5wKeYrh6SmrYpApIjdvUEHufw36
	BvT+A8GAe5Xgde/8nISVbDXtNU7kxPZinbdRP7tlUE4+mtHRTObhWFkPSx4IDRhFsejWXfe
	7tzc4bNhZNhFb03T6Fa3etd//X75Flt9kUiGX6wCumGKcApzsfBhzek3QxwBnbNjEcV5MfG
	y71EA1PA5aYQSlHCOBCOIN1jRBz8WUiIrFykzs8bPHOOHReqxuBDfhn2U0jP64yjez5fn+6
	uhi7yqjy5zHowXDWohJM030BaEB2c7x6EtLTlnLGnTOsxtLbss=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10810783671633817371
Message-ID: <644D15E850597B18+ccced28b-1cc6-4f5d-9bd6-dbbf57f904d0@bupt.moe>
Date: Tue, 27 Feb 2024 11:20:16 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: quwenruo.btrfs@gmx.com
Cc: johannes.thumshirn@wdc.com, linux-btrfs@vger.kernel.org,
 naohiro.aota@wdc.com, waautomata@gmail.com
References: <e88f9520-1d10-4d66-94fa-3ee86c515118@gmx.com>
Subject: Re: Super blocks checksum error on HM-SMR device
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <e88f9520-1d10-4d66-94fa-3ee86c515118@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bBet7nhQRa2BJPirTPgMpPEC"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bBet7nhQRa2BJPirTPgMpPEC
Content-Type: multipart/mixed; boundary="------------JA38uq7H0sUxROfc3rpkjXKi";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: quwenruo.btrfs@gmx.com
Cc: johannes.thumshirn@wdc.com, linux-btrfs@vger.kernel.org,
 naohiro.aota@wdc.com, waautomata@gmail.com
Message-ID: <ccced28b-1cc6-4f5d-9bd6-dbbf57f904d0@bupt.moe>
Subject: Re: Super blocks checksum error on HM-SMR device
References: <e88f9520-1d10-4d66-94fa-3ee86c515118@gmx.com>
In-Reply-To: <e88f9520-1d10-4d66-94fa-3ee86c515118@gmx.com>
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

--------------JA38uq7H0sUxROfc3rpkjXKi
Content-Type: multipart/mixed; boundary="------------W1fEIIK0Z0v3TLUprFNfpmNr"

--------------W1fEIIK0Z0v3TLUprFNfpmNr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiDlnKggMjAyNC8yLzI0IDIyOjQ2LCBXQSBBTSDlhpnpgZM6DQo+ID4gR3JlZXRpbmdzLCA+
ID4gSSBoYXZlIGEgV2VzdGVybiBEaWdpdGFsIFVsdHJhc3RhciBEQyBIQzYyMCAoSHMxNCks
IGEgSE0tU01SIA0KPiBkZXZpY2UuID4gSXQgaXMgZm9ybWF0dGVkIHRvIHpvbmVkIEJUUkZT
IGJ5IGBta2ZzLmJ0cmZzYCA+IGBidHJmcyANCj4gc2NydWJgIHJlcG9ydHMgdGhlIGZvbGxv
d2luZyBlcnJvcnM6ID4gPiBTY3J1YiBzdGFydGVkOiBTYXQgRmViIDI0IA0KPiAxNTo0Mjoz
OCAyMDI0ID4gU3RhdHVzOiBmaW5pc2hlZCA+IER1cmF0aW9uOiAwOjA5OjM0ID4gVG90YWwg
dG8gc2NydWI6IA0KPiA3Ni42NEdpQiA+IFJhdGU6IDEzNi43Mk1pQi9zID4gRXJyb3Igc3Vt
bWFyeTogc3VwZXI9MiA+IENvcnJlY3RlZDogMCA+IA0KPiBVbmNvcnJlY3RhYmxlOiAwID4g
VW52ZXJpZmllZDogMCA+ID4gW1NhdCBGZWIgMjQgMTU6NDI6MzggMjAyNF0gQlRSRlMgDQo+
IGluZm8gKGRldmljZSBzZGIpOiBzY3J1Yjogc3RhcnRlZCBvbiBkZXZpZCAxID4gW1NhdCBG
ZWIgMjQgMTU6NDI6MzggDQo+IDIwMjRdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RiKTogc3Vw
ZXIgYmxvY2sgYXQgPiBwaHlzaWNhbCA2NTUzNiBkZXZpZCANCj4gMSBoYXMgYmFkIGNzdW0g
PiBbU2F0IEZlYiAyNCAxNTo0MjozOCAyMDI0XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYik6
IA0KPiBzdXBlciBibG9jayBhdCA+IHBoeXNpY2FsIDY3MTA4ODY0IGRldmlkIDEgaGFzIGJh
ZCBjc3VtID4gW1NhdCBGZWIgMjQgDQo+IDE1OjUyOjEyIDIwMjRdIEJUUkZTIGluZm8gKGRl
dmljZSBzZGIpOiBzY3J1YjogZmluaXNoZWQgb24gPiBkZXZpZCAxIA0KPiB3aXRoIHN0YXR1
czogMCA+ID4gPiBXaGF0IHdlbnQgd3Jvbmcgd2l0aCB0aGUgc3VwZXIgYmxvY2tzPw0KPiBJ
IGJlbGlldmUgaXQncyBhIGZhbHNlIGFsZXJ0Lg0KPg0KPiBBcyBmb3Igem9uZWQgZGV2aWNl
cyBidHJmcyBubyBsb25nZXIgcHV0cyBzdXBlciBibG9ja3MgYXQgZml4ZWQgcGh5c2ljYWwN
Cj4gbG9jYXRpb25zLCBidXQgSSdtIG5vdCBhbiBleHBlcnQgb24gem9uZWQgZGV0YWlsZWQu
DQpodHRwczovL2J0cmZzLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9ab25lZC1tb2RlLmh0
bWwgaXMgc3RpbGwgc2F5aW5nDQo+IEFzIHNhaWQgYWJvdmUsIHN1cGVyIGJsb2NrIGlzIGhh
bmRsZWQgaW4gYSBzcGVjaWFsIHdheS4gSW4gb3JkZXIgdG8gYmUgDQo+IGNyYXNoIHNhZmUs
IGF0IGxlYXN0IG9uZSB6b25lIGluIGEga25vd24gbG9jYXRpb24gbXVzdCBjb250YWluIGEg
dmFsaWQgDQo+IHN1cGVyYmxvY2suIFRoaXMgaXMgaW1wbGVtZW50ZWQgYXMgYSByaW5nIGJ1
ZmZlciBpbiB0d28gY29uc2VjdXRpdmUgDQo+IHpvbmVzLCBzdGFydGluZyBmcm9tIGtub3du
IG9mZnNldHMgMEIsIDUxMkdpQiBhbmQgNFRpQi4NClNob3VsZCB0aGlzIGJlIHVwZGF0ZWQ/
DQo+IEBKb2hhbm5lcyBhbmQgQG5hb2hpcm8sIG1pbmQgdG8gY2hlY2sgdGhlIHNpdHVhdGlv
bj8NCj4NCj4gVGhhbmtzLA0KPiBRdQ0KPg0KPiA+IFRoYW5rcy4gPiA+IE15IGVudmlyb25t
ZW50OiA+ICQgdW5hbWUgLXIgPiA2LjYuMTgtMS1sdHMgPiAkIGJ0cmZzIC0tdmVyc2lvbiA+
IA0KPiBidHJmcy1wcm9ncyB2Ni43LjEgPg0KDQo=
--------------W1fEIIK0Z0v3TLUprFNfpmNr
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

--------------W1fEIIK0Z0v3TLUprFNfpmNr--

--------------JA38uq7H0sUxROfc3rpkjXKi--

--------------bBet7nhQRa2BJPirTPgMpPEC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZd1U8AAKCRBLkKfpYfpB
Uw9SAP94C/sGIhldczSvWQZHGyiij6IKEKJTcdoh57lMYbaU7gEAuUoPLI3IecP8
zkoRbNAQxbrlRhXs4QTecZoc4Co7LAs=
=d4TW
-----END PGP SIGNATURE-----

--------------bBet7nhQRa2BJPirTPgMpPEC--

