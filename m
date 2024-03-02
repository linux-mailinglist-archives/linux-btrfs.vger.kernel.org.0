Return-Path: <linux-btrfs+bounces-2982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C4B86F0CF
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 16:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276951F221A9
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA618624;
	Sat,  2 Mar 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lbsd.net header.i=@lbsd.net header.b="xJZZSW6D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from uk1.mailhost.iitsp.com (uk1.mailhost.iitsp.com [57.128.155.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8315182B9
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Mar 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.128.155.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392676; cv=none; b=RoqG98OJJhLmvem3f6VQ/nut1TjvJ/nHTLz+pc2xd9+KGRHz4OMcfFBHbMt2XnP6+F4noKx4DaVLLfkK6YFGbeFllUPhgmECQytEGnK1txAxwHprRW+/4/SR/XJCeoJi5/HogPiO2wSHWivM1c6DqV9mr7MutpsRG85/AtBG3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392676; c=relaxed/simple;
	bh=fUEDYWEXCN6tas3aJFbJDECY8PB/l7sRhxfsL8m8up0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=tFnP8Ne1AhwfhqlyqanK8lTJuNpymrRle0CxeRj0vUTG6Rbjs331VJiBnyqt/rGBQiZV2KgqjhwzJTDwD2YhoppQqb0EcVITyZr/M3rYbVpsr/hXtdV+V14l+2Rakp+IrF0lEZjPwEM+uJO80FSEXqiHhFwGGcY/68/YxjRXFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=LBSD.net; spf=pass smtp.mailfrom=LBSD.net; dkim=pass (1024-bit key) header.d=lbsd.net header.i=@lbsd.net header.b=xJZZSW6D; arc=none smtp.client-ip=57.128.155.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=LBSD.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=LBSD.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lbsd.net;
	s=mail; h=Content-Type:Subject:To:From:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fUEDYWEXCN6tas3aJFbJDECY8PB/l7sRhxfsL8m8up0=; b=xJZZSW6DsVqDeltHS8KWzZkZ8m
	EBJpQz5RT3rqu/nn4QYUBNj13huj4j3bxnouPeAVANN34Ox5HS8ppTHOzItDbVFBKZEo7o5usjWyH
	duP/igikSC8qccLU9sK7/Zh82k4JrxKncSvhZ4EOi4t4sGXxt14Axpcsfjji3T3RkNEg=;
Received: by uk1.mailhost.iitsp.com with esmtpsa id 1rgQrx-0000000ABj7-01fL 
	 for <linux-btrfs@vger.kernel.org>;
	Sat, 02 Mar 2024 15:01:45 +0000
Message-ID: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
Date: Sat, 2 Mar 2024 15:01:43 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nigel Kukard <nkukard@LBSD.net>
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
Subject: btrfs ontop of LVM ontop of MD RAID1 supported?
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cFM5wc0Go0uJt5i9vg56FAd3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cFM5wc0Go0uJt5i9vg56FAd3
Content-Type: multipart/mixed; boundary="------------vm8GQK1cg3Ttj7O0TnNVM295";
 protected-headers="v1"
From: Nigel Kukard <nkukard@LBSD.net>
To: linux-btrfs@vger.kernel.org
Message-ID: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
Subject: btrfs ontop of LVM ontop of MD RAID1 supported?

--------------vm8GQK1cg3Ttj7O0TnNVM295
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgdGhlcmUsDQoNCkkgaG9wZSBldmVyeW9uZSBpcyBkb2luZyBncmVhdCB0b2RheSENCg0K
SSdtIHdvbmRlcmluZyBpZiBidHJmcyBvbnRvcCBvZiBMVk0gb250b3Agb2YgTUQgUkFJRDEg
aXMgc3VwcG9ydGVkP8KgIA0KSSd2ZSBtYW5hZ2VkIHRvIHJlcHJvZHVjZSB3aXRoIDEwMCUg
YWNjdXJhY3kgc2V2ZXJlIGRhdGEgY29ycnVwdGlvbiANCnVzaW5nIHRoaXMgY29uZmlndXJh
dGlvbiBvbiA2LjYuMTkuDQoNCjIgeCAxLjkyVCBOVk1lJ3MgaW4gTUQgUkFJRDEgY29uZmln
dXJhdGlvbg0KTFZNIHZvbHVtZSBjcmVhdGVkIG9udG9wIG9mIHRoZSBNRCBSQUlEMQ0KYnRy
ZnMgZmlsZXN5c3RlbSBvbiB0aGUgTFYNCg0KSSB0aGVuIHdyaXRlIGFib3V0IDEwMC0yMDBH
IG9mIGRhdGEuIENyZWF0ZSBhIHNuYXBzaG90LiBSZWFkL3dyaXRlIHRoZSANCmZpbGUgYW5k
IGdldCB0aGVzZSBtZXNzYWdlcy4uLg0KDQpNYXIgMDIgMTE6MzQ6MDEgeHh4eCBrZXJuZWw6
IEJUUkZTIGVycm9yIChkZXZpY2UgZG0tMSk6IGJkZXYgDQovZGV2L21hcHBlci9sdm0tLXJh
aWQtaW1hZ2VzIGVycnM6IHdyIDAsIHJkIDAsIGZsdXNoIDAsIGNvcnJ1cHQgNDMsIGdlbiAw
DQpNYXIgMDIgMTE6MzQ6MDEgeHh4eCBrZXJuZWw6IEJUUkZTIHdhcm5pbmcgKGRldmljZSBk
bS0xKTogY3N1bSBmYWlsZWQgDQpyb290IDUgaW5vIDI3NCBvZmYgMTI0Nzc3MjI2MjQgY3N1
bSAweGVhOTExNDk0IGV4cGVjdGVkIGNzdW0gMHhjMjkzNDlhOCANCm1pcnJvciAxDQpNYXIg
MDIgMTE6MzQ6MDEgeHh4eCBrZXJuZWw6IEJUUkZTIGVycm9yIChkZXZpY2UgZG0tMSk6IGJk
ZXYgDQovZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzIGVycnM6IHdyIDAsIHJkIDAsIGZs
dXNoIDAsIGNvcnJ1cHQgNDQsIGdlbiAwDQoNCkl0IHNlZW1zIHRvIGJlIG1vcmUgcmVsYXRl
ZCB0byBsYXJnZXIgZmlsZXMsIGEgYnVuY2ggb2Ygc21hbGxlciBmaWxlcyBJIA0KaGF2ZSBk
aWRuJ3Qgc2VlIGFueSBjb3JydXB0aW9uIHVudGlsIGEgZmV3IGhvdXJzIGxhdGVyLiBTbmFw
c2hvdHMgYW5kIA0Kc3Vidm9sdW1lcyBkb24ndCBzZWVtIHRvIGFmZmVjdCB0aGUgcmVzdWx0
cyBpbiBhIG5vdGljZWFibGUgd2F5Lg0KDQpJJ3ZlIG1hbmFnZWQgdG8gcmVwcm9kdWNlIGl0
IG9uIDQgY29tcGxldGVseSBkaWZmZXJlbnQgc3lzdGVtcyBhcyBJIA0KZmlyc3QgdGhvdWdo
dCBpdCBtYXkgYmUgYSBoYXJkd2FyZSBpc3N1ZSwgYnV0IGl0cyBjb25zaXN0ZW50IGFjcm9z
cyANCmNvbXBsZXRlbHkgZGlmZmVyZW50IGVudGVycHJpc2UgcGxhdGZvcm1zLCBob3dldmVy
IHRoZXkgYWxsIGhhdmUgDQplbnRlcnByaXNlIE5WTWUgZGlza3MsIGJ1dCBhcmUgZGlmZmVy
ZW50IGJyYW5kcy4NCg0KVXNpbmcgZXh0NCBhbmQgY29tcGFyaW5nIGRhdGEgYWZ0ZXIgZWFj
aCBzZXQgb2Ygd3JpdGVzIGlzIGNvbnNpc3RlbnQuIA0KSXRzIGp1c3QgYnRyZnMgdGhhdCBz
ZWVtcyB0byBiZSBoYXZpbmcgYW4gaXNzdWUuDQoNCldoZW4gcnVubmluZyBhIHNjcnViLCBJ
IGdldCB0aGVzZSBtZXNzYWdlcy4uLg0KDQpNYXIgMDIgMTE6Mzk6MzggeHh4eCBrZXJuZWw6
IEJUUkZTIGluZm8gKGRldmljZSBkbS0xKTogc2NydWI6IHN0YXJ0ZWQgb24gDQpkZXZpZCAx
DQpNYXIgMDIgMTE6Mzk6MzkgeHh4eCBrZXJuZWw6IEJUUkZTIGVycm9yIChkZXZpY2UgZG0t
MSk6IHVuYWJsZSB0byBmaXh1cCANCihyZWd1bGFyKSBlcnJvciBhdCBsb2dpY2FsIDQwMzY2
ODk5MjAgb24gZGV2IA0KL2Rldi9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcyBwaHlzaWNhbCA1
MTE4ODIwMzUyDQpNYXIgMDIgMTE6Mzk6MzkgeHh4eCBrZXJuZWw6IEJUUkZTIGVycm9yIChk
ZXZpY2UgZG0tMSk6IHVuYWJsZSB0byBmaXh1cCANCihyZWd1bGFyKSBlcnJvciBhdCBsb2dp
Y2FsIDQyOTUxNjM5MDQgb24gZGV2IA0KL2Rldi9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcyBw
aHlzaWNhbCA1Mzc3Mjk0MzM2DQpNYXIgMDIgMTE6Mzk6MzkgeHh4eCBrZXJuZWw6IEJUUkZT
IHdhcm5pbmcgKGRldmljZSBkbS0xKTogY2hlY2tzdW0gZXJyb3IgDQphdCBsb2dpY2FsIDQy
OTUxNjM5MDQgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMsIHBoeXNpY2Fs
IA0KNTM3NzI5NDMzNiwgcm9vdCAyNjMsIGlub2RlPg0KTWFyIDAyIDExOjM5OjM5IHh4eHgg
a2VybmVsOiBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgDQoo
cmVndWxhcikgZXJyb3IgYXQgbG9naWNhbCA0MzA3NjE1NzQ0IG9uIGRldiANCi9kZXYvbWFw
cGVyL2x2bS0tcmFpZC1pbWFnZXMgcGh5c2ljYWwgNTM4OTc0NjE3Ng0KTWFyIDAyIDExOjM5
OjM5IHh4eHgga2VybmVsOiBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8g
Zml4dXAgDQoocmVndWxhcikgZXJyb3IgYXQgbG9naWNhbCA0NTExNzYwMzg0IG9uIGRldiAN
Ci9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgcGh5c2ljYWwgNTU5Mzg5MDgxNg0KTWFy
IDAyIDExOjM5OjQwIHh4eHgga2VybmVsOiBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1
bmFibGUgdG8gZml4dXAgDQoocmVndWxhcikgZXJyb3IgYXQgbG9naWNhbCA4Njg3Mzg2NjI0
IG9uIGRldiANCi9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgcGh5c2ljYWwgOTc2OTUx
NzA1Ng0KTWFyIDAyIDExOjM5OjQwIHh4eHgga2VybmVsOiBCVFJGUyB3YXJuaW5nIChkZXZp
Y2UgZG0tMSk6IGNoZWNrc3VtIGVycm9yIA0KYXQgbG9naWNhbCA4Njg3Mzg2NjI0IG9uIGRl
diAvZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzLCBwaHlzaWNhbCANCjk3Njk1MTcwNTYs
IHJvb3QgMjY3LCBpbm9kZT4NCk1hciAwMiAxMTozOTo0MCB4eHh4IGtlcm5lbDogQlRSRlMg
ZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVwIA0KKHJlZ3VsYXIpIGVycm9y
IGF0IGxvZ2ljYWwgODY4OTM1MjcwNCBvbiBkZXYgDQovZGV2L21hcHBlci9sdm0tLXJhaWQt
aW1hZ2VzIHBoeXNpY2FsIDk3NzE0ODMxMzYNCk1hciAwMiAxMTozOTo0MCB4eHh4IGtlcm5l
bDogQlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVwIA0KKHJlZ3Vs
YXIpIGVycm9yIGF0IGxvZ2ljYWwgODY5MDMzNTc0NCBvbiBkZXYgDQovZGV2L21hcHBlci9s
dm0tLXJhaWQtaW1hZ2VzIHBoeXNpY2FsIDk3NzI0NjYxNzYNCk1hciAwMiAxMTozOTo0MCB4
eHh4IGtlcm5lbDogQlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVw
IA0KKHJlZ3VsYXIpIGVycm9yIGF0IGxvZ2ljYWwgODY5MTk3NDE0NCBvbiBkZXYgDQovZGV2
L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzIHBoeXNpY2FsIDk3NzQxMDQ1NzYNCk1hciAwMiAx
MTozOTo0MCB4eHh4IGtlcm5lbDogQlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxl
IHRvIGZpeHVwIA0KKHJlZ3VsYXIpIGVycm9yIGF0IGxvZ2ljYWwgODY5MjIzNjI4OCBvbiBk
ZXYgDQovZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzIHBoeXNpY2FsIDk3NzQzNjY3MjAN
Ck1hciAwMiAxMTozOTo0MCB4eHh4IGtlcm5lbDogQlRSRlMgZXJyb3IgKGRldmljZSBkbS0x
KTogdW5hYmxlIHRvIGZpeHVwIA0KKHJlZ3VsYXIpIGVycm9yIGF0IGxvZ2ljYWwgODY5Mjk1
NzE4NCBvbiBkZXYgDQovZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzIHBoeXNpY2FsIDk3
NzUwODc2MTYNCk1hciAwMiAxMTozOTo0MCB4eHh4IGtlcm5lbDogQlRSRlMgZXJyb3IgKGRl
dmljZSBkbS0xKTogZml4ZWQgdXAgZXJyb3IgDQphdCBsb2dpY2FsIDg3MjM0OTY5NjAgb24g
ZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgcGh5c2ljYWwgDQo5ODA1NjI3Mzky
DQoNCkl0IGdldHMgcHJvZ3Jlc3NpdmVseSBtdWNoIHdvcnNlIG92ZXIgdGltZSB0aGUgbW9y
ZSB3cml0ZXMgdGhhdCBoYXBwZW4uIA0KU3RhcnRpbmcgYXQgYXJvdW5kIDgwMCBvciBzbyBl
cnJvcnMgbW9zdCB1bmNvcnJlY3RhYmxlIGVzY2FsYXRpbmcgaW50byANCnRoZSB0aG91c2Fu
ZHMuDQoNCkknbSB1c2luZyBkZWZhdWx0IG1vdW50IG9wdGlvbnMgZm9yIGJ0cmZzIGFuZCBB
cmNoIExpbnV4Lg0KDQoocGxlYXNlIGtpbmRseSBDQyBtZSBhcyBJJ20gbm90IHN1YnNjcmli
ZWQgdG8gdGhlIG1haWxpbmcgbGlzdCkNCg0KS2luZCByZWdhcmRzDQotTg0KDQo=

--------------vm8GQK1cg3Ttj7O0TnNVM295--

--------------cFM5wc0Go0uJt5i9vg56FAd3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT5M4N3g4xfUCNXIu76GXFSvoUHMwUCZeM/VwUDAAAAAAAKCRD6GXFSvoUHM7V2
AQD4ndeEPMGphXjGX9A3mhVmi2D3h6zG/h9j15+7Hc6y5QEAxuX1/dxJkr7nBKbu0rXmVc5GpQ/X
LBLm9z79eBqvYQY=
=H0+t
-----END PGP SIGNATURE-----

--------------cFM5wc0Go0uJt5i9vg56FAd3--

