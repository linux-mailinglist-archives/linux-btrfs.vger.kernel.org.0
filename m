Return-Path: <linux-btrfs+bounces-19065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645EC634CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 10:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E1AFB28C24
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC0323AB87;
	Mon, 17 Nov 2025 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="MbZlmH+C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF226529A
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372669; cv=none; b=d5/lJ6HxDC38T+VXJ6u7kKVDgfkg9W81n8OtEAa0+RcGptU549Yu9ANIvv3rxHfVpQvWI0eZqsGSy0aoU6CiMgbM1/ECNVGwrEH7+8geqioP582o9h194zEtUx7Hg/J2GeSSqHRaqPzHpR6SQczChlp3U/gG0Xi3RNhHtumCj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372669; c=relaxed/simple;
	bh=hhgopnVDKdk/joG8YoKIM8jHCeo3dN7iCCN1TOOow/4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sYboMkc2ORsJ/trcIYXBkNWAKBnXDARB/ohegXXrTnKr1taJLQikCJjLsSJod4higuHMJ3nLjW7sQq88km3CXZzGfbRv8K1270vNXqr01UapPL/DOcie2xXnTaFvhWBYX2hzYpmFWW9ZzqVTga/AJl0BSqGo5NX+K3pt5S4Yg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=MbZlmH+C; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1763372150; bh=hhgopnVDKdk/joG8YoKIM8jHCeo3dN7iCCN1TOOow/4=;
	h=Date:To:From:Subject:From:To:CC:Subject;
	b=MbZlmH+Ct6iqCaylBshcbGRRfd+fp2l8yED+D4TuGJTqUCoKGPtUAV+810qwryE+S
	 pNjek1VdtG8Gpziji4aiK2vtLOzK84aJ/jq5hJwKV76qKCS+LQbcDsYaZMSkDuEcJC
	 0IZDsiIec0dM/5ZTl0PBQ18anWOq3WG4TuNloKj91Hf4YCQx2Qjf9WMg/MxO1jw+/W
	 BXyNiDnyjv1Uqzl7+rR63/YBirvP3U17x9gmUyb3ZDe/IeCcN3TSdRIUGLUBAsrOpt
	 ppRamI9VAMsxFt0mg+seqAv/IpgQ3oapTvN4R+uKqvcoYK2+gds04ZJbQc4ji2UI5m
	 cozpgUA167Heg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4d92ft4ngYzPjjn
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 10:35:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.11.39.36
Received: from [10.11.39.36] (un36yhaj.vpn.rrze.uni-erlangen.de [10.11.39.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+w+xilMGO+NeUpBybRnba6r7N7uEq+aCk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4d92fq5shhzPk2C
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 10:35:47 +0100 (CET)
Message-ID: <7e9c5666-645d-4b4f-9608-a521353c54b0@fau.de>
Date: Mon, 17 Nov 2025 10:35:48 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
From: Robin Seidl <robin.seidl@fau.de>
Subject: Troubles translating root tree's logical to physical address
Autocrypt: addr=robin.seidl@fau.de; keydata=
 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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Svx0W6F8sOuiySYGTQwIB9dc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Svx0W6F8sOuiySYGTQwIB9dc
Content-Type: multipart/mixed; boundary="------------0g7D0DWhtl9Bog7ZEwpJtyI0";
 protected-headers="v1"
Message-ID: <7e9c5666-645d-4b4f-9608-a521353c54b0@fau.de>
Date: Mon, 17 Nov 2025 10:35:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
From: Robin Seidl <robin.seidl@fau.de>
Subject: Troubles translating root tree's logical to physical address
Autocrypt: addr=robin.seidl@fau.de; keydata=
 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

--------------0g7D0DWhtl9Bog7ZEwpJtyI0
Content-Type: multipart/mixed; boundary="------------TgDe6mG0v4cJHd6cWK0kBdHw"

--------------TgDe6mG0v4cJHd6cWK0kBdHw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQpJJ20gY3VycmVudGx5IHdvcmtpbmcgb24gcmVhZGluZyB0aGUgQlRSRlMgc3Ry
dWN0dXJlcyB3aXRob3V0IG1vdW50aW5nIA0KdGhlIGZpbGVzeXN0ZW0uIEkgYW0gbm93IGhh
dmluZyB0cm91YmxlcyB0cmFuc2xhdGluZyB0aGUgcm9vdCB0cmVlIHJvb3QgDQphZGRyZXNz
IHRvIGEgcGh5c2ljYWwgYWRkcmVzczoNCg0KSSBkaWQgdGhlIHRlc3RzIG9uIGEgZnJlc2hs
eSBjcmVhdGVkIGZpbGVzeXN0ZW0uDQpBdCAweDEwMDAwIHRoZSBzdXBlcmJsb2NrIGJlZ2lu
cy4NCkF0IDB4MTAwNTAgdGhlIHU2NCBsb2dpY2FsIGFkZHJlc3Mgb2YgdGhlIHJvb3QgdHJl
ZSByb290IGJlZ2lucy4gSXQgaXMgDQoweDFkNGMwMDAuDQpBdCAweDEwMGEwIHRoZSB1MzIg
c2l6ZSBvZiB0aGUgY2h1bmsgYXJyYXkgYmVnaW5zLiBJdCBpcyAweDgxLg0KQXQgMHgxMDMy
YiB0aGUgc3lzX2NodW5rX2FycmF5IHN0YXJ0cy4NCiDCoCDCoCAweDEwMzJiIHRvIDB4MTAz
M2MgaXMgdGhlIGJ0cmZzX2tleS4gVGhlIGNodW5rcyBsb2dpY2FsIHN0YXJ0ICh1NjQgDQph
dCAweDEwMzM0KSBpcyAweDE1MDAwMDANCiDCoCDCoCAweDEwMzNjIHRvIDB4MTAzNmMgaXMg
dGhlIGJ0cmZzX2NodW5rLiBUaGUgY2h1bmtzIGxlbmd0aCAodTY0IGF0IA0KMHgxMDMzYykg
aXMgMHg4MDAwMDAuDQogwqAgwqAgMHgxMDM2YyB0byAweDEwMzdkIGlzIHRoZSBidHJmc19z
dHJpcGUuDQoNCldoZW4gdGhlIGxvZ2ljYWwgc3RhcnQgb2YgdGhlIGNodW5rIGlzIDB4MTUw
MDAwMCBhbmQgdGhlIGxlbmd0aCBpcyANCjB4ODAwMDAwLCB0aGVuIHRoZSBsb2dpY2FsIGVu
ZCBvZiB0aGUgY2h1bmsgaXMgMHgxZDAwMDAwLiBUaGlzIGltcGxpZXMgDQp0aGF0IHRoZSBy
b290IHRyZWUgcm9vdCBhZGRkcmVzcyAweDFkNGMwMDAgaXMgb3V0c2lkZSBvZiB0aGUgZmly
c3QgYW5kIA0Kb25seSBjaHVuay4gV2hhdCBhbSBJIG1pc3NpbmcgaGVyZSwgaG93IGRvIEkg
dHJhbnNsYXRlIHRoZSBsb2dpY2FsIA0KYWRkcmVzcyBvZiB0aGUgcm9vdCB0cmVlIHJvb3Qg
aW50byBpdHMgcGh5c2ljYWwgY291bnRlcnBhcnQ/DQoNCkJlc3QgcmVnYXJkcw0KUm9iaW4N
Cg0KUFM6IEluIHRoZSB3aWtpIA0KKGh0dHBzOi8vYnRyZnMucmVhZHRoZWRvY3MuaW8vZW4v
bGF0ZXN0L2Rldi9Pbi1kaXNrLWZvcm1hdC5odG1sI3N1cGVyYmxvY2spIA0KdGhlcmUgaXMg
YSB0eXBvIHJlZ2FyZGluZyB0aGUgc3RhcnQgb2YgdGhlIHN5c19jaHVua19hcnJheSBhcyBp
dCBjbGFpbXMgDQppdCBzdGFydHMgYXQgMHgxMDAyYi4NCg0K
--------------TgDe6mG0v4cJHd6cWK0kBdHw
Content-Type: application/pgp-keys; name="OpenPGP_0xC6947C0B7355DAF5.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC6947C0B7355DAF5.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D=3D
=3DlY2C
-----END PGP PUBLIC KEY BLOCK-----

--------------TgDe6mG0v4cJHd6cWK0kBdHw--

--------------0g7D0DWhtl9Bog7ZEwpJtyI0--

--------------Svx0W6F8sOuiySYGTQwIB9dc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcPwVL7FrpUYhw4oixpR8C3NV2vUFAmka7HQFAwAAAAAACgkQxpR8C3NV2vXl
lw/8D5KlFpVUZht5o86mREv0uClbAhii2j/2j8mrTqGpvJWxtIFVGDEs5/QT5qA+GOWfWni0155R
sZQ7ra1TidZhokRb4PiXo7Sc6QJ6iW4P6nCnBxpv8e9oWcdHR6hAZtMCL63CLbWh1hYEH2JJCnmg
z4oc0uL4HnnccNWuiOv9++8UbMaE9vFo/ovXxyBApj3wlMeQTg5+R7ud8gXJ12bbvXya+ZUb8gTj
sWv+HTFyoAtVJN73Qmej+QlRWM/v9D23e/QQWC8TjKzSqIdnN2HyXPVOBQUvtPd+xeqA81Y4673c
EpwgZ9vMRH8VRaSSDd/L/jK1RK9w9zUzj60/9tnITrF6+e3Z2gWfUXuC08H8dYLvHMp4iILgjx8O
li4jTF3U6ZWkK8Txl//NdPmMTA6JZkVUA0ycyUhnOtpasCRwbvoIiWJsBqXcsO0liJF0gzhNFo9l
Ju/UYUKDhfLrJ/eDaKisSA41u0sIrJJWM1F4oms32mMj+lahczkkDOUOGKENF9kzP7M2OmkxJi/k
Xe3fFIEgW6f65nwXJmCVWaRfJnFjtf2GFphtcO2hyAYG+6B2BrQcDR/uMGoWSsPMY7e3jEuWQWxA
E9oPYeh0FYpHMrSpyJBCsarwv1XByzxc2XVwamp+NPsop/lPvKP8eTtOrkk+ZWUVNPqc2GmBwHs4
0Gw=
=oR6p
-----END PGP SIGNATURE-----

--------------Svx0W6F8sOuiySYGTQwIB9dc--

