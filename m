Return-Path: <linux-btrfs+bounces-14343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4039AC97D0
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 00:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D90504CA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0A2882A2;
	Fri, 30 May 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="dWkUKMhL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DD2222C2
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748644927; cv=none; b=BgSYJHXuy12Vu2CpPmecAcrPfUGiW+Xnm1pRUwhqHVZzxB5+hQtgtSmVo15vif/FA8KEVgXtiCYld9v1+mxPLTZAd1dVu2tIcki/2z6I+zaQJ5ilWjmrhbHtM9RDLEzRibLf2M1fdHEAkwOxc11Km2/mSAU5+04YO78d6iaILQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748644927; c=relaxed/simple;
	bh=mYe5iMU86irkYVNCD9IxWI7fUn6BtvHm6PspFVg8qAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L3RVO2rrAlB6bQk8He27/BqXSvVcc6G+wqN1ZlmCaOK0fNbKIR5wJIcT6vo4pdbcB8vf6rdVGlU6Jc/FnR8KyMw7aVh1+vKzx2boAmvtaEpLUJ2Gd4j0sxTIgWmmToF7WWbK45OS8Xhj/RQF13qtMwh7XV+n+e3k1Dn9Ctiy4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=dWkUKMhL; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Message-ID: <a1c1a92b-79b7-4032-a967-57d17d0e2026@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1748644920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mYe5iMU86irkYVNCD9IxWI7fUn6BtvHm6PspFVg8qAg=;
	b=dWkUKMhLGMxgx4PXSWIiiLwjAUbkmGHDz694KTD5cd0nesUkOe1escTSgLNTzaNVBOlxW5
	JSl4ZxJdT9ItaYW1hHvNRSQLTo5uMHxoJdpPpGI4oH/ysWts2ELbOBxy86iAD5+kJVs7y9
	zNdxiGcOaDS3yelJ7Kf7P/GirZMYs1zrRE/fS364y0aNdY8qkRY05vWy76Z5GoG2UdcPWW
	X5wxeUD1QDox8zFhsvy6gaEoo78t5hu8IBsWsIt4QScUCJwojfK9hJgzt5kwVGutpK1lcX
	rvdt1K6BsZjI/Rr3gfKI21mNDAWYz9wSUHmz8ekbXV6ri7ih8rR8zbPQ4auDWw==
Date: Fri, 30 May 2025 18:41:55 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Why does defragmenting break reflinks?
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <9d74d71f-b65d-4f06-adb3-18f7698edb8a@velocifyer.com>
 <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
In-Reply-To: <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JxPMq29G8N1nNGUBrs4cpdTn"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JxPMq29G8N1nNGUBrs4cpdTn
Content-Type: multipart/mixed; boundary="------------On8ZGygTr6d0sY3kP4IxKwxS";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <a1c1a92b-79b7-4032-a967-57d17d0e2026@velocifyer.com>
Subject: Re: Why does defragmenting break reflinks?
References: <9d74d71f-b65d-4f06-adb3-18f7698edb8a@velocifyer.com>
 <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
In-Reply-To: <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>

--------------On8ZGygTr6d0sY3kP4IxKwxS
Content-Type: multipart/mixed; boundary="------------98u8KvuOnK5YCokwggMegDdO"

--------------98u8KvuOnK5YCokwggMegDdO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8yOS8yNSAyMDoyNywgUXUgV2VucnVvIHdyb3RlOg0KPg0KPg0KPiDlnKggMjAyNS81
LzMwIDA5OjIyLCDwnZWN8J2VlvCdlZ3wnZWg8J2VlPCdlZrwnZWX8J2VqvCdlZbwnZWjIOWG
memBkzoNCj4+IEJUUkZTLUZJTEVTWVNURU0oOCkgc2F5cyAiZGVmcmFnbWVudGluZyB3aXRo
wqAgTGludXgga2VybmVsIHZlcnNpb25zIDwgDQo+PiAzLjkgb3Ig4omlIDMuMTQtcmMyIGFz
IHdlbGwgYXMgd2l0aCBMaW51eCBzdGFibGUga2VybmVsIHZlcnNpb25zIOKJpSANCj4+IDMu
MTAuMzEsIOKJpSAzLjEyLjEyIG9yIOKJpSAzLjEzLjQgd2lsbCBicmVhayB1cCB0aGUgcmVm
bGlua3Mgb2YgQ09XIGRhdGEgDQo+PiAoZm9yIGV4YW1wbGUgZmlsZXMgY29waWVkIHdpdGgg
Y3AgLS1yZWZsaW5rLCBzbmFwc2hvdHMgb3IgDQo+PiBkZS1kdXBsaWNhdGVkIGRhdGEpLiIg
V2h5IGRvZXMgZGVmcmFnbWVudGluZyBub3QgcHJlc2VydmUgcmVmbGlua3MgDQo+PiBhbmQg
d2h5IHdhcyBpdCByZW1vdmVkPw0KPj4NCj4NCj4gRGVmcmFnIG1lYW5zIHRvIHJlLWRpcnR5
IHRoZSBkYXRhLCBhbmQgd3JpdGUgdGhlbSBiYWNrIGFnYWluLCB3aGljaCANCj4gd2lsbCBj
YXVzZSBDT1cuDQo+IEFuZCBieSBuYXR1cmUgdGhpcyBicmVha3MgcmVmbGlua2VkIGRhdGEg
ZXh0ZW50cy4NCg0KQnV0IHdoeSBkaWQgaXQgcHJldml1c2x5IG5vdCBicmVhayByZWZsaW5r
cz8NCg0KLS0gDQpHZW9yZ2UgdHJ1bHksIPCdlY3wnZWW8J2VnfCdlaDwnZWU8J2VmvCdlZfw
nZWq8J2VlvCdlaMgSW1wcm92ZSB5b3VyIHdpZmkgcmVjZXB0aW9uIGZvciBmcmVlIA0KPGh0
dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9TFk4V2k3WFJYQ0E+SG9tZSBhbG9uZSBh
bnklIHdvcmxkIA0KPGh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9SU1zdEZJS1pM
cEk+cmVjb3JkIHNldCBieSANCvCdlY3wnZWW8J2VnfCdlaDwnZWU8J2VmvCdlZfwnZWq8J2V
lvCdlaMgDQo8aHR0cHM6Ly93d3cuc3BlZWRydW4uY29tL2hvbWVfYWxvbmVfbmVzL3J1bnMv
enBrcTk3OHk+IFRoaXMgZW1haWwgZG9lcyANCm5vdCBjb25zdGl0dXRlIGEgbGVnYWxseSBi
aW5kaW5nIGNvbnRyYWN0DQo=
--------------98u8KvuOnK5YCokwggMegDdO
Content-Type: application/pgp-keys; name="OpenPGP_0x634EBF8740C748BE.asc"
Content-Disposition: attachment; filename="OpenPGP_0x634EBF8740C748BE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mx
aYk/dyrNJlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8E
ExYIADcWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgH
BRUICQoLBRYCAwEAAAoJEGNOv4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78Z
qEwGegVCRerWry8RAQC3MJUOiyQ062Ol/3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44
BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/yXp135G4fhWjJH7VQkPIFo8/M
sZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dAx0i+BQJoKkSFBQkF
o5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9SpvhlveEFpUMP
aQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ=3D=3D
=3DtVgn
-----END PGP PUBLIC KEY BLOCK-----

--------------98u8KvuOnK5YCokwggMegDdO--

--------------On8ZGygTr6d0sY3kP4IxKwxS--

--------------JxPMq29G8N1nNGUBrs4cpdTn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaDo0MwUDAAAAAAAKCRBjTr+HQMdIvpKW
AP9ThG04700xtEaIR+n7xjQTXRwOm9t5+1mRlPZ0Rh6kCgD+J5jEmiU8V7ynYfNtap2hwBeG77vs
UpvwejGKKmDNsAE=
=P1g2
-----END PGP SIGNATURE-----

--------------JxPMq29G8N1nNGUBrs4cpdTn--

