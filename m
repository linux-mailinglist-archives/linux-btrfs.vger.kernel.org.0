Return-Path: <linux-btrfs+bounces-2984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C3B86F112
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 17:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889AB1C20C28
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538FD1947E;
	Sat,  2 Mar 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lbsd.net header.i=@lbsd.net header.b="R+SHdhd+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from uk1.mailhost.iitsp.com (uk1.mailhost.iitsp.com [57.128.155.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02317578
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Mar 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.128.155.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395789; cv=none; b=aADfyrZ9kf7VbSOt2CY2qGVx6BYI9T8LtNDcq+tXP6IuFh+PtRwfs6v0WTMjsffoJCLp6ksqJ1dQlCJjSOezvELg7ssZ/FbX4JGirfrzmgo36pwt7WOirBJd023IxJRzD0eydnmO98O3+OfygxT7F7CyfRc8EBZ5326LIzTZq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395789; c=relaxed/simple;
	bh=ICYUnZ/Ip0xzg8v8DJx6TncqmqqsthCkpqzaJJpiP2Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xaz7oXoeAueb+l39PBHNTJdaNalKSXwU34mceQ3TPaJ2Ny2XyCnAq003t8oVIRAXZKxdFvvEUHUXVhUtaLsPlpKnfsrQnGqWxwZ2xckcmXwAge+VybOxGUHuG0QNKiNYq55EZEjw1yPZ+QJac+0HWQKLhdmHy4Cp1p/Is+U+L+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=LBSD.net; spf=pass smtp.mailfrom=LBSD.net; dkim=pass (1024-bit key) header.d=lbsd.net header.i=@lbsd.net header.b=R+SHdhd+; arc=none smtp.client-ip=57.128.155.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=LBSD.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=LBSD.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lbsd.net;
	s=mail; h=Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version
	:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ICYUnZ/Ip0xzg8v8DJx6TncqmqqsthCkpqzaJJpiP2Q=; b=R+SHdhd+DP1Jft9usqkkvUTtwX
	yQHCvJaIziUhlDeQIytW+ADqNTQD5gHliCFTodSe13Tae9pXrqIOcHmkLGiK4h0ruldn32Abgx4BY
	L0pEwzbw1cwGTVn5W4Ai64aMsGOm+o8NHxhWCNjfRGox51zbtTgtyuxbCkeHjyC8yg8Y=;
Received: by uk1.mailhost.iitsp.com with esmtpsa id 1rgRvj-0000000AchP-36G1 
	;
	Sat, 02 Mar 2024 16:09:43 +0000
Message-ID: <70c07873-b87b-4e0d-8a2e-e2ac90ec861e@LBSD.net>
Date: Sat, 2 Mar 2024 16:09:42 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs ontop of LVM ontop of MD RAID1 supported?
Content-Language: en-US
To: Roman Mamedov <rm@romanrm.net>
References: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
 <20240302204726.6d2dcd87@nvm>
From: Nigel Kukard <nkukard@LBSD.net>
In-Reply-To: <20240302204726.6d2dcd87@nvm>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FAvSPBcQ5biQEM4arASYo5Nm"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FAvSPBcQ5biQEM4arASYo5Nm
Content-Type: multipart/mixed; boundary="------------ah4edJ6b9LxhM0LmrInbKO1V";
 protected-headers="v1"
From: Nigel Kukard <nkukard@LBSD.net>
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <70c07873-b87b-4e0d-8a2e-e2ac90ec861e@LBSD.net>
Subject: Re: btrfs ontop of LVM ontop of MD RAID1 supported?
References: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
 <20240302204726.6d2dcd87@nvm>
In-Reply-To: <20240302204726.6d2dcd87@nvm>

--------------ah4edJ6b9LxhM0LmrInbKO1V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgdGhlcmUgUm9tYW4sDQoNCk9uIDMvMi8yNCAxNTo0NywgUm9tYW4gTWFtZWRvdiB3cm90
ZToNCj4gT24gU2F0LCAyIE1hciAyMDI0IDE1OjAxOjQzICswMDAwDQo+IE5pZ2VsIEt1a2Fy
ZCA8bmt1a2FyZEBMQlNELm5ldD4gd3JvdGU6DQo+DQo+PiBJJ20gd29uZGVyaW5nIGlmIGJ0
cmZzIG9udG9wIG9mIExWTSBvbnRvcCBvZiBNRCBSQUlEMSBpcyBzdXBwb3J0ZWQ/DQo+IFNo
b3VsZCBiZSBhYnNvbHV0ZWx5IHN1cHBvcnRlZC4NCj4NCj4+IEkndmUgbWFuYWdlZCB0byBy
ZXByb2R1Y2Ugd2l0aCAxMDAlIGFjY3VyYWN5IHNldmVyZSBkYXRhIGNvcnJ1cHRpb24NCj4+
IHVzaW5nIHRoaXMgY29uZmlndXJhdGlvbiBvbiA2LjYuMTkuDQo+Pg0KPj4gMiB4IDEuOTJU
IE5WTWUncyBpbiBNRCBSQUlEMSBjb25maWd1cmF0aW9uDQo+PiBMVk0gdm9sdW1lIGNyZWF0
ZWQgb250b3Agb2YgdGhlIE1EIFJBSUQxDQo+PiBidHJmcyBmaWxlc3lzdGVtIG9uIHRoZSBM
Vg0KPj4NCj4+IEkgdGhlbiB3cml0ZSBhYm91dCAxMDAtMjAwRyBvZiBkYXRhLiBDcmVhdGUg
YSBzbmFwc2hvdC4gUmVhZC93cml0ZSB0aGUNCj4+IGZpbGUgYW5kIGdldCB0aGVzZSBtZXNz
YWdlcy4uLg0KPiBIYXMgdGhlIE1EIFJBSUQxIGZpbmlzaGVkIGl0cyBpbml0aWFsIHN5bmMg
YWZ0ZXIgY3JlYXRpb24/DQo+DQo+IEhhdmUgeW91IHRyaWVkIHdhaXRpbmcgdW50aWwgaXQg
ZmluaXNoZXMgYW5kIG9ubHkgdGhlbiBkbyB0aGV3cml0ZXMgdG8gc2VlIGlmDQo+IHRoZSBj
b3JydXB0aW9uIGlzIHN0aWxsIG9ic2VydmVkIChvZiBjb3Vyc2UgdGhhdCdzIGluIG5vIHdh
eSBhICJ3b3JrYXJvdW5kIiwNCj4ganVzdCB0byBzZWUgd2hhdCBtaWdodCBjYXVzZSB0aGUg
YnVnKS4NCg0KU3luYyBjb21wbGV0ZWQgb24gYWxsIDQgc3lzdGVtcyBJIHRlc3RlZCBvbiBi
ZWZvcmUgY3JlYXRpbmcgdGhlIExWTSANCnZvbHVtZSBhbmQgZmlsZXN5c3RlbS4NCg0KDQo+
DQo+IERvIHlvdSBrbm93IGFueSBrZXJuZWwgdmVyc2lvbnMgb3Igc2VyaWVzIHdoZXJlIHRo
aXMgY29ycnVwdGlvbiBkaWQgbm90IGhhcHBlbj8NCj4NCj4gSSBhc3N1bWUgeW91J3JlIG5v
dCBzYXlpbmcgaXQgYXBwZWFyZWQgaW4gNi42LjE5IGNvbXBhcmVkIHRvIDYuNi4xOC4NCg0K
U2FkbHksIHRoaXMgaXMgdGhlIGZpcnN0IHRpbWUgSSdtIHRlc3RpbmcgdGhpcyBzcGVjaWZp
YyBzZXR1cC4gVGhlc2UgYXJlIA0KcHJvZHVjdGlvbiBzeXN0ZW1zLCBzbyBjaGFuZ2luZyBr
ZXJuZWwgdmVyc2lvbiBpcyBhIGJpdCB0cmlja3kuDQoNCkxldCBtZSB0cnkgcmVwcm9kdWNl
IGl0IG9uIGFub3RoZXIgYml0IG9mIGhhcmR3YXJlLCBJJ2xsIHJldmVydCBiYWNrLg0KDQoN
Cj4NCj4gQ2FuIHlvdSB0cnkgdGhlIDYuMSBzZXJpZXM/IE9yIG1heWJlIGFsc28gNi44Pw0K
DQpTdXJlLCBsZXQgbWUgc2VlIGlmIEkgY2FuIHNldCBzb21ldGhpbmcgdXAgYW5kIHJlcHJv
ZHVjZSBpdCwgdGhlbiB3ZSBjYW4gDQp0ZXN0IGRpZmZlcmVudCBrZXJuZWwgdmVyc2lvbnMg
YW5kIHN0YXJ0IGJpc2VjdGluZy4NCg0KDQo+IEkgbWFkZSBhIEJ0cmZzIG9uIHRvcCBvZiBM
Vk0gb24gdG9wIG9mIFJBSUQxIG15c2VsZiBub3csIGJ1dCBvbiBjb25zdW1lciBTU0RzLg0K
PiBDb3B5aW5nIHNvbWUgZmlsZXMgdG8gaXQgbm93LCB0byBjaGVjay4gV291bGQgYmUgYWxz
byBoZWxwZnVsIGlmIHlvdSBjYW4gZmluZA0KPiBhIHByZWNpc2Ugc2VxdWVuY2Ugb2YgY29t
bWFuZHMgd2hpY2ggY2FuIHRyaWdnZXIgdGhlIGJ1ZywgbGVzcyB2YWd1ZSB0aGFuDQo+IGNv
cHkgc29tZSBmaWxlcyB0byBpdCBhbmQgc2VlLg0KDQpTdXJlIHRoaW5nLiBMZXQgbWUgc2Vl
IGlmIEkgY2FuIHRyaW0gdGhpbmdzIGRvd24gYW5kIGdldCBhIHNpbXBsZSANCnNlcXVlbmNl
IG9mIGNvbW1hbmRzIHRvIG1ha2UgdGhpbmdzIGVhc2llci4NCg0KLU4NCg0K

--------------ah4edJ6b9LxhM0LmrInbKO1V--

--------------FAvSPBcQ5biQEM4arASYo5Nm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT5M4N3g4xfUCNXIu76GXFSvoUHMwUCZeNPRgUDAAAAAAAKCRD6GXFSvoUHM3mG
AP42oUMq1EkdDgs83zVpnmAfkie/d8yX1K1JD5RGWI4/XQD+Jp1KdhfEmJSyfcTCsN3VXOlsm2Ii
8C5XVyFmZ1T3lAA=
=/4cT
-----END PGP SIGNATURE-----

--------------FAvSPBcQ5biQEM4arASYo5Nm--

