Return-Path: <linux-btrfs+bounces-5608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8B69021E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 14:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860BE1C20EB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4680BFF;
	Mon, 10 Jun 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="iP1q9R1Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0E80BFC
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023677; cv=none; b=fGu1enbhYPo9wwwtLdYgxPqns7Tw5MBpFF/+GvWTqKt6g9DGmXuUF905IPDgNkrmZ1wKWLu+P1d6tG9wPZpUxMDofvANoiGmd2jZ2qsNtXqe1XpRrELhOPUl+zL94HHZ2KoriP5bYtZGDRJ4s3zzDXjTBj1PkIbf7B7SAqedIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023677; c=relaxed/simple;
	bh=ir7LfmZOtObJs0LizOl0RE1krowLaW1Jn5pgNrW7+dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eskhEvBibWMLOkcQMIbNQutXkDs55JqzQXcwUHAr2v45+COqglToaR3eFKvGug2riUmw6mdYoJeIKr4dD/Q6zhH1GRoefK7OtKs35qTM0RbpQnHjHvtpk/ZefQ4MHIhsJVPE6XjbeLLzgUh6xz2NCPdojBZtgHHUgZyToR7gs4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=iP1q9R1Z; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1718023663;
	bh=ir7LfmZOtObJs0LizOl0RE1krowLaW1Jn5pgNrW7+dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iP1q9R1Zx/jKfwkAiFYLuuJ3qwn8Szmg8sO0RMn4aD3lb2xmxXBdDJEMOhw+6dFxS
	 Q+57it+zdKLC2caR2ZG8sV63NCxOYhnFUSRiiJXsnAdzCwjjaVlYn08bfiX1Gl/JoR
	 Icd6sY+VwQNT3EzvG4/r0VKT02CeDoN0gpBsBjzY=
X-QQ-mid: bizesmtp86t1718023661tbkihy3b
X-QQ-Originating-IP: H+3K2vM1/8es7nDZ/oCwv12I3fUFYC7NZThpD7EjqUE=
Received: from [192.168.1.5] ( [223.150.220.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Jun 2024 20:47:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12239958338360141999
Message-ID: <2112398B543F8373+1a8c3746-b3f1-436a-97b1-debe2682cbf1@bupt.moe>
Date: Mon, 10 Jun 2024 20:47:37 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] unable to mount zoned volume after force shutdown
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
References: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
 <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4ba9l15bXR0sGYjxTKb7bxDM"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4ba9l15bXR0sGYjxTKb7bxDM
Content-Type: multipart/mixed; boundary="------------PyweOBrsOjXoAPFFFtpaor0f";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
Message-ID: <1a8c3746-b3f1-436a-97b1-debe2682cbf1@bupt.moe>
Subject: Re: [BUG] unable to mount zoned volume after force shutdown
References: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
 <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>
In-Reply-To: <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>

--------------PyweOBrsOjXoAPFFFtpaor0f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQrlnKggMjAyNC82LzEwIDE2OjUzLCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPiBP
biAwOS4wNi4yNCAwNDoyNCwgSEFOIFl1d2VpIHdyb3RlOg0KPj4gSSBjYW4ndCBtb3VudCB2
b2x1bWUgb24gbXVsdGlwbGUgem9uZWQgZGV2aWNlIHdoaWNoIGRhdGEgcHJvZmlsZSBpcw0K
Pj4gc2luZ2xlICYgbWV0YWRhdGEgcHJvZmlsZSBpcyByYWlkMS4NCj4+IEl0IGV4cGVyaWVu
Y2VkIG11bHRpcGxlIGZvcmNlZCBzaHV0ZG93biBkdWUgdG8ga2VybmVsIDYuMTAgY2FuJ3QN
Cj4+IHByb3Blcmx5IHNodXRkb3duIG9uIGxvb25nYXJjaC4NCj4+DQo+PiAjIGRtZXNnDQo+
Pg0KPj4gWyAxOTYzLjY5ODc5M10gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYik6IGZpcnN0IG1v
dW50IG9mIGZpbGVzeXN0ZW0NCj4+IGI1YjJkN2Q5LTlmMjctNDkwNy1hNTU4LTc3ZThlODZk
ZjkzMw0KPj4gWyAxOTYzLjcwNzgwMV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYik6IHVzaW5n
IGNyYzMyYyAoY3JjMzJjLWdlbmVyaWMpDQo+PiBjaGVja3N1bSBhbGdvcml0aG0NCj4+IFsg
MTk2My43MTU1OTddIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiB1c2luZyBmcmVlLXNwYWNl
LXRyZWUNCj4+IFsgMTk2NS40OTIwNjZdIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiBob3N0
LW1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlDQo+PiAvZGV2L3NkYiwgNTIxNTYgem9uZXMg
b2YgMjY4NDM1NDU2IGJ5dGVzDQo+PiBbIDE5NjYuOTUzNTkwXSBCVFJGUyBpbmZvIChkZXZp
Y2Ugc2RiKTogaG9zdC1tYW5hZ2VkIHpvbmVkIGJsb2NrIGRldmljZQ0KPj4gL2Rldi9zZGMs
IDUyMTU2IHpvbmVzIG9mIDI2ODQzNTQ1NiBieXRlcw0KPj4gWyAxOTY3LjM0Njc1OF0gQlRS
RlMgaW5mbyAoZGV2aWNlIHNkYik6IHpvbmVkIG1vZGUgZW5hYmxlZCB3aXRoIHpvbmUNCj4+
IHNpemUgMjY4NDM1NDU2DQo+PiBbIDIwMjYuMjg3MzU2XSBCVFJGUyBlcnJvciAoZGV2aWNl
IHNkYik6IHpvbmVkOiB3cml0ZSBwb2ludGVyIG9mZnNldA0KPj4gbWlzbWF0Y2ggb2Ygem9u
ZXMgaW4gcmFpZDEgcHJvZmlsZQ0KPj4gWyAyMDI2LjI5NjQ0NV0gQlRSRlMgZXJyb3IgKGRl
dmljZSBzZGIpOiB6b25lZDogZmFpbGVkIHRvIGxvYWQgem9uZSBpbmZvDQo+PiBvZiBiZyA1
Mzk5ODQ3NjMyODk2DQo+PiBbIDIwMjYuMzA0NTc2XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNk
Yik6IGZhaWxlZCB0byByZWFkIGJsb2NrIGdyb3VwczogLTUNCj4+IFsgMjAyNi4zNTI1NDdd
IEJUUkZTIGVycm9yIChkZXZpY2Ugc2RiKTogb3Blbl9jdHJlZSBmYWlsZWQNCj4+DQo+IENh
biB5b3UgY2hlY2sgdGhlIHdyaXRlIHBvaW50ZXJzIGZvciB0aGUgem9uZXMgbWFwcGluZyB0
byB0aGlzIGJsb2NrIGdyb3VwPw0KPg0KPiB0aGF0IHNob3VsZCBiZQ0KPiBibGt6b25lIHJl
cG9ydCAtYyAxIC1vIDB4Mjc0QTAwMDAwIC9kZXYvc2RiDQojIGJsa3pvbmUgcmVwb3J0IC1j
IDEgLW8gMHgyNzRBMDAwMDAgL2Rldi9zZGINCnN0YXJ0OiAweDI3NGEwMDAwMCwgbGVuIDB4
MDgwMDAwLCBjYXAgMHgwODAwMDAsIHdwdHIgMHgwMDAwMDAgcmVzZXQ6MCANCm5vbi1zZXE6
MCwgemNvbmQ6IDEoZW0pIFt0eXBlOiAyKFNFUV9XUklURV9SRVFVSVJFRCldDQojIGJsa3pv
bmUgcmVwb3J0IC1jIDEgLW8gMHgyNzRBMDAwMDAgL2Rldi9zZGMNCnN0YXJ0OiAweDI3NGEw
MDAwMCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgwODAwMDAsIHdwdHIgMHgwMDAwMDAgcmVzZXQ6
MCANCm5vbi1zZXE6MCwgemNvbmQ6IDEoZW0pIFt0eXBlOiAyKFNFUV9XUklURV9SRVFVSVJF
RCldDQoNCkZZSSwNCiMgYnRyZnMgaW5zcGVjdC1pbnRlcm5hbCBkdW1wLXRyZWUgL2Rldi9z
ZGJ8Z3JlcCAtQSAxMCAtQiAxMCA1Mzk5ODQ3NjMyODk2DQogwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlvX2FsaWduIDY1NTM2IGlvX3dpZHRoIDY1NTM2IHNlY3Rvcl9zaXpl
IDE2Mzg0DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9zdHJpcGVzIDEg
c3ViX3N0cmlwZXMgMQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RyaXBlIDAgZGV2aWQgMSBvZmZzZXQgMTgxOTE4NzA4NTMxMg0KIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3V1aWQgNzU0
ZjI5MzItMzhlNS00NmI0LTkzZDItZGQ2OTkwNzY4NzllDQogwqDCoMKgwqDCoMKgwqAgaXRl
bSAxMDQga2V5IChGSVJTVF9DSFVOS19UUkVFIENIVU5LX0lURU0gNTM5OTU3OTE5NzQ0MCkg
DQppdGVtb2ZmIDc4NTEgaXRlbXNpemUgODANCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbGVuZ3RoIDI2ODQzNTQ1NiBvd25lciAyIHN0cmlwZV9sZW4gNjU1MzYgdHlwZSBE
QVRBfHNpbmdsZQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb19hbGlnbiA2
NTUzNiBpb193aWR0aCA2NTUzNiBzZWN0b3Jfc2l6ZSAxNjM4NA0KIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBudW1fc3RyaXBlcyAxIHN1Yl9zdHJpcGVzIDENCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmlwZSAwIGRldmlk
IDIgb2Zmc2V0IDE4MTk0NTU1MjA3NjgNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRldl91dWlkIGVlNjY5Yjg1LWY2NDEtNGQ2YS05YTY2LWRh
MTM5MDdkNTViMg0KIMKgwqDCoMKgwqDCoMKgIGl0ZW0gMTA1IGtleSAoRklSU1RfQ0hVTktf
VFJFRSBDSFVOS19JVEVNIDUzOTk4NDc2MzI4OTYpIA0KaXRlbW9mZiA3NzM5IGl0ZW1zaXpl
IDExMg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZW5ndGggMjY4NDM1NDU2
IG93bmVyIDIgc3RyaXBlX2xlbiA2NTUzNiB0eXBlIA0KTUVUQURBVEF8UkFJRDENCiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9fYWxpZ24gNjU1MzYgaW9fd2lkdGggNjU1
MzYgc2VjdG9yX3NpemUgMTYzODQNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bnVtX3N0cmlwZXMgMiBzdWJfc3RyaXBlcyAxDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJpcGUgMCBkZXZpZCAxIG9mZnNldCAxODE5NDU1
NTIwNzY4DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXZfdXVpZCA3NTRmMjkzMi0zOGU1LTQ2YjQtOTNkMi1kZDY5OTA3Njg3OWUNCiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmlwZSAxIGRl
dmlkIDIgb2Zmc2V0IDE4MTk3MjM5NTYyMjQNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl91dWlkIGVlNjY5Yjg1LWY2NDEtNGQ2YS05YTY2
LWRhMTM5MDdkNTViMg0KIMKgwqDCoMKgwqDCoMKgIGl0ZW0gMTA2IGtleSAoRklSU1RfQ0hV
TktfVFJFRSBDSFVOS19JVEVNIDU0MDAxMTYwNjgzNTIpIA0KaXRlbW9mZiA3NjU5IGl0ZW1z
aXplIDgwDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxlbmd0aCAyNjg0MzU0
NTYgb3duZXIgMiBzdHJpcGVfbGVuIDY1NTM2IHR5cGUgREFUQXxzaW5nbGUNCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9fYWxpZ24gNjU1MzYgaW9fd2lkdGggNjU1MzYg
c2VjdG9yX3NpemUgMTYzODQNCg0KPiBhbmQgZm9yIHRoZSBvdGhlciBkZXZpY2UgYXMgd2Vs
bA0KPg0KPiBUaGFua3MsDQo+IAlKb2hhbm5lcw0K

--------------PyweOBrsOjXoAPFFFtpaor0f--

--------------4ba9l15bXR0sGYjxTKb7bxDM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZmb16QAKCRBLkKfpYfpB
U63RAP475CNGH77YqD8V41Zm8qO6TtApAvZDpcSHH3TX/Ji8pgD8CpLX0iWo1OPU
znX2m2Sh21+fKJl/zTXbVaEgYerZkgQ=
=1ONu
-----END PGP SIGNATURE-----

--------------4ba9l15bXR0sGYjxTKb7bxDM--

