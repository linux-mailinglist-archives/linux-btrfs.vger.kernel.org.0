Return-Path: <linux-btrfs+bounces-5579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B872901433
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 04:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA7F281DB3
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 02:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720476AD7;
	Sun,  9 Jun 2024 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="CCKHj+28"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg2.exmail.qq.com (bg2.exmail.qq.com [114.132.63.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D55234
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.63.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717899863; cv=none; b=nuNAMoh9gqhpKF6hAvOMJ3V2ORb2405nUe9ZQnf8joVoQCxiNwa18hqsPD7L4xs3pmr4Z2bTc6r2Jc+0uDX+9FPf9hMEWwRLndV9MgCPaIarUQIGrUW/FGlcIOkipqIhYws9UEtO7JAg3PJHDcgWdht182PEBE/J1oMGOr5qQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717899863; c=relaxed/simple;
	bh=5lzplKjIgDW5mTOsqe4lJv5w4OVMiVYoIABFlmpPVLc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HFHikRjMinduOSztoJLgp1H0Z+0590NE/50uTYXlrse86Un0Tn37/fRWdaas3N5Vn8rm9EeRAN/VDctEZ6XLPLMZL+1hAynyVagE1VHjrjHw8/yuQHrjiwOw9KvIX9o38aw8sBE1Qq6lq/s0XfWdKjJRici5E4T63dJmvLG4TFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=CCKHj+28; arc=none smtp.client-ip=114.132.63.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1717899851;
	bh=5lzplKjIgDW5mTOsqe4lJv5w4OVMiVYoIABFlmpPVLc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=CCKHj+284/SlFLX9+JVMjs2zBxBZq213Ef6C0hG8HAt0vHijqpUq5rXm+V1Tb2RPJ
	 OOiHcOIBpJCZenuzf2WpKhXa4j0u4+kc8o1oiIkC6vu+STxoYCOc6b3UUb1/TzwDD2
	 W+FmLBC8piXXLmsOOrH/7mOkxeSXW2gnTw6GwGDk=
X-QQ-mid: bizesmtpsz12t1717899785t6ke30
X-QQ-Originating-IP: 9Uw34blSWX9s5BJlF3W0OJgdsTxYj5U6ryxUXusDWUc=
Received: from [192.168.1.5] ( [223.150.220.201])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Sun, 09 Jun 2024 10:23:04 +0800 (CST)
X-QQ-SSF: 01100000000000E0Z000000A0000000
X-QQ-FEAT: LE7C6P2vL8TYL5+184808oolypRAo0Zs5dd2uJv2CBX9r5FTIX8ZCRMwEG1dx
	AjcX2m0VEfSlIgXi4SzkXda/0yFV505IcL7GdHSRG02MjhV7Qi0JodLiemqbZDB2RzXZaMN
	l4fo8yCPTp/uO1ou2AIUTDSAJLj15cwyONrJlQfNgMrHGZW0zFGxXewMg8qwP2T4g07qYhJ
	wCzuPxbl3gyIp9i9aAwcdEr2BORCUztDtPZn5ZxrH7uEXVdgAxtuGjYq5DKiexAA/x787o4
	Mq39LfQ8HrMz9hug9osFxGVXXSM5EMXElGVnNj5N7p6GCkL8wn4IfxZa+Sxv2DGdzkct/2e
	uHGt32jaO9oMkcluQZXhLI7LCrK5IgPDVDAuCS1
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2489831432530607047
Message-ID: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
Date: Sun, 9 Jun 2024 10:23:01 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: HAN Yuwei <hrx@bupt.moe>
Subject: [BUG] unable to mount zoned volume after force shutdown
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f3mLlVJGVNxqbkaVzZvYuG0X"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f3mLlVJGVNxqbkaVzZvYuG0X
Content-Type: multipart/mixed; boundary="------------VNSizrTsTa4mF63PbXxy4fbP";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
Subject: [BUG] unable to mount zoned volume after force shutdown

--------------VNSizrTsTa4mF63PbXxy4fbP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SSBjYW4ndCBtb3VudCB2b2x1bWUgb24gbXVsdGlwbGUgem9uZWQgZGV2aWNlIHdoaWNoIGRh
dGEgcHJvZmlsZSBpcyANCnNpbmdsZSAmIG1ldGFkYXRhIHByb2ZpbGUgaXMgcmFpZDEuDQpJ
dCBleHBlcmllbmNlZCBtdWx0aXBsZSBmb3JjZWQgc2h1dGRvd24gZHVlIHRvIGtlcm5lbCA2
LjEwIGNhbid0IA0KcHJvcGVybHkgc2h1dGRvd24gb24gbG9vbmdhcmNoLg0KDQojIGRtZXNn
DQoNClsgMTk2My42OTg3OTNdIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiBmaXJzdCBtb3Vu
dCBvZiBmaWxlc3lzdGVtIA0KYjViMmQ3ZDktOWYyNy00OTA3LWE1NTgtNzdlOGU4NmRmOTMz
DQpbIDE5NjMuNzA3ODAxXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogdXNpbmcgY3JjMzJj
IChjcmMzMmMtZ2VuZXJpYykgDQpjaGVja3N1bSBhbGdvcml0aG0NClsgMTk2My43MTU1OTdd
IEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiB1c2luZyBmcmVlLXNwYWNlLXRyZWUNClsgMTk2
NS40OTIwNjZdIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiBob3N0LW1hbmFnZWQgem9uZWQg
YmxvY2sgZGV2aWNlIA0KL2Rldi9zZGIsIDUyMTU2IHpvbmVzIG9mIDI2ODQzNTQ1NiBieXRl
cw0KWyAxOTY2Ljk1MzU5MF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYik6IGhvc3QtbWFuYWdl
ZCB6b25lZCBibG9jayBkZXZpY2UgDQovZGV2L3NkYywgNTIxNTYgem9uZXMgb2YgMjY4NDM1
NDU2IGJ5dGVzDQpbIDE5NjcuMzQ2NzU4XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogem9u
ZWQgbW9kZSBlbmFibGVkIHdpdGggem9uZSANCnNpemUgMjY4NDM1NDU2DQpbIDIwMjYuMjg3
MzU2XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYik6IHpvbmVkOiB3cml0ZSBwb2ludGVyIG9m
ZnNldCANCm1pc21hdGNoIG9mIHpvbmVzIGluIHJhaWQxIHByb2ZpbGUNClsgMjAyNi4yOTY0
NDVdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RiKTogem9uZWQ6IGZhaWxlZCB0byBsb2FkIHpv
bmUgaW5mbyANCm9mIGJnIDUzOTk4NDc2MzI4OTYNClsgMjAyNi4zMDQ1NzZdIEJUUkZTIGVy
cm9yIChkZXZpY2Ugc2RiKTogZmFpbGVkIHRvIHJlYWQgYmxvY2sgZ3JvdXBzOiAtNQ0KWyAy
MDI2LjM1MjU0N10gQlRSRlMgZXJyb3IgKGRldmljZSBzZGIpOiBvcGVuX2N0cmVlIGZhaWxl
ZA0KDQojIGJ0cmZzIGluc3BlY3QtaW50ZXJuYWwgZHVtcC1zdXBlciAvZGV2L3NkYg0Kc3Vw
ZXJibG9jazogYnl0ZW5yPTY1NTM2LCBkZXZpY2U9L2Rldi9zZGINCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KY3N1bV90eXBl
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwIChjcmMzMmMpDQpjc3VtX3NpemXCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDQNCmNzdW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAweGIyN2Q4MDMyIFttYXRjaF0NCmJ5dGVucsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNjU1MzYNCmZsYWdzwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDB4MQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKCBXUklUVEVOICkNCm1hZ2ljwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF9CSFJmU19NIFttYXRjaF0NCmZzaWTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiNWIyZDdkOS05ZjI3LTQ5MDctYTU1OC03N2U4
ZTg2ZGY5MzMNCm1ldGFkYXRhX3V1aWTCoMKgwqDCoMKgwqDCoMKgwqDCoCAwMDAwMDAwMC0w
MDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDANCmxhYmVswqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEhZV0RBVEFfWk9ORURfVEVTVA0KZ2VuZXJhdGlvbsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDgwMzcyDQpyb290wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgNTQwMDAxMzE2MDQ0OA0Kc3lzX2FycmF5X3NpemXCoMKgwqDCoMKg
wqDCoMKgwqAgMjU4DQpjaHVua19yb290X2dlbmVyYXRpb27CoMKgIDgwMzY4DQpyb290X2xl
dmVswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMA0KY2h1bmtfcm9vdMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDQ4NTI5NDE2MDI4MTYNCmNodW5rX3Jvb3RfbGV2ZWzCoMKgwqDC
oMKgwqDCoCAxDQpsb2dfcm9vdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwDQps
b2dfcm9vdF90cmFuc2lkIChkZXByZWNhdGVkKcKgwqAgMA0KbG9nX3Jvb3RfbGV2ZWzCoMKg
wqDCoMKgwqDCoMKgwqAgMA0KdG90YWxfYnl0ZXPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MjgwMDEwMzkyODYyNzINCmJ5dGVzX3VzZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAz
MzA2OTM3OTc0Nzg0DQpzZWN0b3JzaXplwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTYz
ODQNCm5vZGVzaXplwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDE2Mzg0DQpsZWFm
c2l6ZSAoZGVwcmVjYXRlZCnCoMKgIDE2Mzg0DQpzdHJpcGVzaXplwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMTYzODQNCnJvb3RfZGlywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDYNCm51bV9kZXZpY2VzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDINCmNvbXBhdF9m
bGFnc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwDQpjb21wYXRfcm9fZmxhZ3PCoMKgwqDC
oMKgwqDCoMKgIDB4Mw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKCBGUkVFX1NQQUNFX1RSRUUgfA0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZSRUVfU1BBQ0VfVFJFRV9WQUxJRCApDQpp
bmNvbXBhdF9mbGFnc8KgwqDCoMKgwqDCoMKgwqDCoCAweDEzNDENCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICggTUlYRURfQkFDS1JFRiB8DQog
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRVhU
RU5ERURfSVJFRiB8DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgU0tJTk5ZX01FVEFEQVRBIHwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOT19IT0xFUyB8DQogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgWk9ORUQgKQ0KY2FjaGVf
Z2VuZXJhdGlvbsKgwqDCoMKgwqDCoMKgIDANCnV1aWRfdHJlZV9nZW5lcmF0aW9uwqDCoMKg
IDgwMzcyDQpkZXZfaXRlbS51dWlkwqDCoMKgwqDCoMKgwqDCoMKgwqAgNzU0ZjI5MzItMzhl
NS00NmI0LTkzZDItZGQ2OTkwNzY4NzllDQpkZXZfaXRlbS5mc2lkwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYjViMmQ3ZDktOWYyNy00OTA3LWE1NTgtNzdlOGU4NmRmOTMzIFttYXRjaF0NCmRl
dl9pdGVtLnR5cGXCoMKgwqDCoMKgwqDCoMKgwqDCoCAwDQpkZXZfaXRlbS50b3RhbF9ieXRl
c8KgwqDCoCAxNDAwMDUxOTY0MzEzNg0KZGV2X2l0ZW0uYnl0ZXNfdXNlZMKgwqDCoMKgIDE4
MjM3NTA0ODgwNjQNCmRldl9pdGVtLmlvX2FsaWduwqDCoMKgwqDCoMKgIDE2Mzg0DQpkZXZf
aXRlbS5pb193aWR0aMKgwqDCoMKgwqDCoCAxNjM4NA0KZGV2X2l0ZW0uc2VjdG9yX3NpemXC
oMKgwqAgMTYzODQNCmRldl9pdGVtLmRldmlkwqDCoMKgwqDCoMKgwqDCoMKgIDENCmRldl9p
dGVtLmRldl9ncm91cMKgwqDCoMKgwqAgMA0KZGV2X2l0ZW0uc2Vla19zcGVlZMKgwqDCoMKg
IDANCmRldl9pdGVtLmJhbmR3aWR0aMKgwqDCoMKgwqAgMA0KZGV2X2l0ZW0uZ2VuZXJhdGlv
bsKgwqDCoMKgIDANCg0K

--------------VNSizrTsTa4mF63PbXxy4fbP--

--------------f3mLlVJGVNxqbkaVzZvYuG0X
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZmUSBQAKCRBLkKfpYfpB
U8iDAP43YLtWXQV0HRMBMNPpo7klp3TsG+Y3qKRf2G/eE4AucwEA2IYL0y/OQD2k
nyvlJzRayX3EzRMT/MbUOOatOPet/wY=
=QyND
-----END PGP SIGNATURE-----

--------------f3mLlVJGVNxqbkaVzZvYuG0X--

