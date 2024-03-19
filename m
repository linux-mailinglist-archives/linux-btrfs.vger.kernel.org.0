Return-Path: <linux-btrfs+bounces-3391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CDD87FCB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E6BB22CFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A17EEE6;
	Tue, 19 Mar 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lbsd.net header.i=@lbsd.net header.b="zt9RZQVd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from uk1.mailhost.iitsp.com (uk1.mailhost.iitsp.com [57.128.155.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DBC53379
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.128.155.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847079; cv=none; b=uKIi8apcQIu1slJIonxwHKtvx6ICMlueKdyu4x73syNKF0sKx9OTtJj2/5krM6ivCalQ01e20892t1SjN5Aii6B2xgoYBohh1+X2G+FL4Awh2G/qhA5Th1rpunIfHYBW4HGOTpn4MtezTuVnLa4jdtjiGocyWWr6sd20KcLvYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847079; c=relaxed/simple;
	bh=G0/khw/f07sue7L5OwdUgVnNfVVJMmtk60f3NH0mnO8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PE6JmiDmmDxXcMnXJvWpjsWjfjZlbJp14IRr4v25PAj05VSOuYjMHLK208DRSHow1BkC5iojwMXuNSMcy9hzvufFcJfjoZd6c4ZVI0j+DLZcG+1uQTpq5xTdYBJjDai22KQHVky3pB9k59COty0dKO0LddLnPr1hypuypDgLuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=LBSD.net; spf=pass smtp.mailfrom=LBSD.net; dkim=pass (1024-bit key) header.d=lbsd.net header.i=@lbsd.net header.b=zt9RZQVd; arc=none smtp.client-ip=57.128.155.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=LBSD.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=LBSD.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lbsd.net;
	s=mail; h=Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version
	:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Xjl1uwNWFu9glQns7vrXAF7kjaMv/UR17Sjc5bpQHHs=; b=zt9RZQVdspT3NLEmwbIj+hLJCD
	QBi4mKb6wvl7oWH9b+HVCBU1KvUlwi7RgX+E6Su5TLrTLK0HWVxIHgZm/0RyAV0GqwWBd5aV8j9yI
	gOiZ0c5RlpAHH3anXQjr4sFAWo4jPIUQpm7GyNbufCfi25S6tfB9V8uGsYb5Cl48CSlQ=;
Received: by uk1.mailhost.iitsp.com with esmtpsa id 1rmXHZ-0000000EXFo-22s7 
	;
	Tue, 19 Mar 2024 11:05:25 +0000
Message-ID: <0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net>
Date: Tue, 19 Mar 2024 11:05:24 +0000
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
 boundary="------------kGHgi2rG90ULo5NemXnVd7XQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kGHgi2rG90ULo5NemXnVd7XQ
Content-Type: multipart/mixed; boundary="------------sj2VR6hDMuGHVxxj2TeOhPsS";
 protected-headers="v1"
From: Nigel Kukard <nkukard@LBSD.net>
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net>
Subject: Re: btrfs ontop of LVM ontop of MD RAID1 supported?
References: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
 <20240302204726.6d2dcd87@nvm>
In-Reply-To: <20240302204726.6d2dcd87@nvm>

--------------sj2VR6hDMuGHVxxj2TeOhPsS
Content-Type: multipart/alternative;
 boundary="------------iqIk3voBP3Yp4mM5rBd9Fgpv"

--------------iqIk3voBP3Yp4mM5rBd9Fgpv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgdGhlcmUgUm9tYW4sDQoNCk9uIDMvMi8yNCAxNTo0NywgUm9tYW4gTWFtZWRvdiB3cm90
ZToNCj4gT24gU2F0LCAyIE1hciAyMDI0IDE1OjAxOjQzICswMDAwDQo+IE5pZ2VsIEt1a2Fy
ZDxua3VrYXJkQExCU0QubmV0PiAgd3JvdGU6DQo+DQo+PiBJJ20gd29uZGVyaW5nIGlmIGJ0
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
YnVnKS4NCj4NCj4gRG8geW91IGtub3cgYW55IGtlcm5lbCB2ZXJzaW9ucyBvciBzZXJpZXMg
d2hlcmUgdGhpcyBjb3JydXB0aW9uIGRpZCBub3QgaGFwcGVuPw0KPg0KPiBJIGFzc3VtZSB5
b3UncmUgbm90IHNheWluZyBpdCBhcHBlYXJlZCBpbiA2LjYuMTkgY29tcGFyZWQgdG8gNi42
LjE4Lg0KPg0KPiBDYW4geW91IHRyeSB0aGUgNi4xIHNlcmllcz8gT3IgbWF5YmUgYWxzbyA2
Ljg/DQo+DQo+IEkgbWFkZSBhIEJ0cmZzIG9uIHRvcCBvZiBMVk0gb24gdG9wIG9mIFJBSUQx
IG15c2VsZiBub3csIGJ1dCBvbiBjb25zdW1lciBTU0RzLg0KPiBDb3B5aW5nIHNvbWUgZmls
ZXMgdG8gaXQgbm93LCB0byBjaGVjay4gV291bGQgYmUgYWxzbyBoZWxwZnVsIGlmIHlvdSBj
YW4gZmluZA0KPiBhIHByZWNpc2Ugc2VxdWVuY2Ugb2YgY29tbWFuZHMgd2hpY2ggY2FuIHRy
aWdnZXIgdGhlIGJ1ZywgbGVzcyB2YWd1ZSB0aGFuDQo+IGNvcHkgc29tZSBmaWxlcyB0byBp
dCBhbmQgc2VlLg0KPg0KSSdtIG5vdyBhYnNvbHV0ZWx5IGNvbnZpbmNlZCB0aGlzIGlzIHNv
bWUga2luZCBvZiBhIGJ1Zy4NCg0KT3ZlciB0aGUgcGFzdCAyIHdlZWtzIEkndmUgbWlncmF0
ZWQgYSBudW1iZXIgb2YgbGlidmlydGQgcWNvdzIgZmlsZXMgDQpvdmVyIHRvIGJ0cmZzIGZp
bGVzeXN0ZW1zLCBhbmQgb24gZXZlcnkgc2luZ2xlIHN5c3RlbSB3aXRoIE5WTWUncyB3aXRo
IA0KTFZNIG9udG9wIG9mIE1EIEknbSBnZXR0aW5nIGVycm9ycyBsaWtlIHRoZSBiZWxvdy4N
Cg0KSSdtIG5vdCBzdXJlIGlmIGl0cyByZWxldmFudCwgYnV0IHRoZSBWTSdzIHJ1biB3ZWVr
bHkgVFJJTSdzIG9uIHRoZWlyIA0KZGlza3MuIFRoZSBob3N0IHN5c3RlbSBhbHNvIHJ1bnMg
d2Vla2x5IFRSSU0ncy4NCg0KVGhlIGZpcnN0IHRpbWUgSSBtZW50aW9uZWQgYWJvdmUgd2Fz
IHdpdGggbmV3IHN5c3RlbXMgSSBpbnN0YWxsZWQgb24gDQpicmFuZCBuZXcgZGlza3MuIEkn
bSBub3cgc2VlaW5nIHRoZSBzYW1lIGlzc3VlIG9uIHN5c3RlbXMgdGhhdCBhcmUgMS0yIA0K
eWVhcnMgb2xkLCBhbHNvIHdpdGggTlZNZSdzLCB3aGljaCB3ZXJlIHJ1bm5pbmcgZXh0NCBp
biB0aGUgcGFzdC4NCg0KT24gYWxsIHN5c3RlbXMgSSBkaWQgYSBjbGVhbiBMViBhbmQgY3Jl
YXRlZCB0aGUgYnRyZnMgZmlsZXN5c3RlbSB3aXRoOg0KbWtmcy5idHJmcyAtTCBpbWFnZXMg
L2Rldi9sdm0tcmFpZC9pbWFnZXMNCg0KVGhlIExWTSB2b2x1bWVzIHdlcmUgY3JlYXRlZCBu
b3JtYWxseSB3aXRoLi4NCnB2Y3JlYXRlIC9kZXYvbWQvMA0KdmdjcmVhdGUgbHZtLXJhaWQg
L2Rldi9tZC8wDQpsdmNyZWF0ZSAtLXNpemUgMVQgLS1uYW1lIGltYWdlcyBsdm0tcmFpZA0K
DQoNCkknbSBydW5uaW5nIG9uZSBzdWJ2b2x1bWUgZm9sZGVyIHBlciB2aXJ0dWFsIG1hY2hp
bmVzLiBFYWNoIGZvbGRlciANCmNvbnRhaW5zIDEtMiBmaWxlcyBvZiBiZXR3ZWVuIDI1RyBh
bmQgNTAwRyBpbiBzaXplIHdoaWNoIGFyZSBteSBxY293MiBmaWxlcy4NCg0KDQpJJ20gcnVu
bmluZyBidHJmcy1wcm9ncyB2ZXJzaW9uIDYuNy4xLTEgb24gYWxsIG1hY2hpbmVzIGFuZCBr
ZXJuZWwgDQo2LjYuMTgsIDYuNi4xOSBvciA2LjYuMjAuIEl0IHNlZW1zIHRvIG9jY3VyIG9u
IGFsbCAzIG9mIHRoZW0uDQoNCg0KTW9zdCBvZiB0aGUgTlZNZSdzIGFyZSBTYW1zdW5ncy4u
Lg0KDQpNb2RlbCBOdW1iZXI6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgU0FNU1VORyBNWlFMQjFUOUhBSlItMDAwMDcNClNlcmlhbCBOdW1iZXI6wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFM0MzlOQTBNQTAxNTky
DQpGaXJtd2FyZSBWZXJzaW9uOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBFREE1NDAyUQ0KDQoNCkhlcmUgaXMgdGhlIG91dHB1dCBpbiB0aGUgbG9ncyBydW5uaW5n
OsKgIGJ0cmZzIHNjcnViIDxzdWJ2b2x1bWU+DQoNClsxNjkzNzU0LjI3NjgzNF0gQlRSRlMg
ZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVwIChyZWd1bGFyKSANCmVycm9y
IGF0IGxvZ2ljYWwgMjE0MjI5Nzc4NDMyIG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQt
aW1hZ2VzIA0KcGh5c2ljYWwgMjE1MzExOTA4ODY0DQpbMTY5Mzc1NC40MTU1NjNdIEJUUkZT
IGVycm9yIChkZXZpY2UgZG0tMSk6IHVuYWJsZSB0byBmaXh1cCAocmVndWxhcikgDQplcnJv
ciBhdCBsb2dpY2FsIDIxNDYxMTkxODg0OCBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlk
LWltYWdlcyANCnBoeXNpY2FsIDIxNTY5NDA0OTI4MA0KWzE2OTM3NTQuODc3Mzk5XSBCVFJG
UyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIpIA0KZXJy
b3IgYXQgbG9naWNhbCAyMTY4ODk1NTY5OTIgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFp
ZC1pbWFnZXMgDQpwaHlzaWNhbCAyMTc5NzE2ODc0MjQNClsxNjkzNzU0Ljg3ODE5NV0gQlRS
RlMgd2FybmluZyAoZGV2aWNlIGRtLTEpOiBjaGVja3N1bSBlcnJvciBhdCBsb2dpY2FsIA0K
MjE2ODg5NTU2OTkyIG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzLCBwaHlz
aWNhbCAyMTc5NzE2ODc0MjQsIA0Kcm9vdCAyNTYsIGlub2RlIDI1OSwgb2Zmc2V0IDQ2MDc4
NDQzNTIsIGxlbmcNCnRoIDQwOTYsIGxpbmtzIDEgKHBhdGg6IFtyZWRhY3RlZF0pDQpbMTY5
Mzc1NS41MDM1ODJdIEJUUkZTIGVycm9yIChkZXZpY2UgZG0tMSk6IHVuYWJsZSB0byBmaXh1
cCAocmVndWxhcikgDQplcnJvciBhdCBsb2dpY2FsIDIxOTY1NTc2NjAxNiBvbiBkZXYgL2Rl
di9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcyANCnBoeXNpY2FsIDIyMDczNzg5NjQ0OA0KWzE2
OTM3NTUuNTAzNjI4XSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4
dXAgKHJlZ3VsYXIpIA0KZXJyb3IgYXQgbG9naWNhbCAyMTk2NTU3MDA0ODAgb24gZGV2IC9k
ZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgDQpwaHlzaWNhbCAyMjA3Mzc4MzA5MTINClsx
NjkzNzU1LjUwNTE0MV0gQlRSRlMgd2FybmluZyAoZGV2aWNlIGRtLTEpOiBjaGVja3N1bSBl
cnJvciBhdCBsb2dpY2FsIA0KMjE5NjU1NzAwNDgwIG9uIGRldiAvZGV2L21hcHBlci9sdm0t
LXJhaWQtaW1hZ2VzLCBwaHlzaWNhbCAyMjA3Mzc4MzA5MTIsIA0Kcm9vdCAyNTcsIGlub2Rl
IDI2MCwgb2Zmc2V0IDM1OTQ2NDE0MDgsIGxlbmcNCnRoIDQwOTYsIGxpbmtzIDEgKHBhdGg6
IFtyZWRhY3RlZF0ucWNvdzIpDQpbMTY5Mzc1NS42Mjc3MjJdIEJUUkZTIGVycm9yIChkZXZp
Y2UgZG0tMSk6IHVuYWJsZSB0byBmaXh1cCAocmVndWxhcikgDQplcnJvciBhdCBsb2dpY2Fs
IDIyMDAzNzUxMzIxNiBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcyANCnBo
eXNpY2FsIDIyMTExOTY0MzY0OA0KWzE2OTM3NTUuNjI4NTE1XSBCVFJGUyB3YXJuaW5nIChk
ZXZpY2UgZG0tMSk6IGNoZWNrc3VtIGVycm9yIGF0IGxvZ2ljYWwgDQoyMjAwMzc1MTMyMTYg
b24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMsIHBoeXNpY2FsIDIyMTExOTY0
MzY0OCwgDQpyb290IDUsIGlub2RlIDI2OSwgb2Zmc2V0IDc1NjIyMTk1MjAsIGxlbmd0aA0K
NDA5NiwgbGlua3MgMSAocGF0aDogW3JlZGFjdGVkXS9bcmVkYWN0ZWRdLnFjb3cyKQ0KWzE2
OTM3NTYuMDcyNDU3XSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4
dXAgKHJlZ3VsYXIpIA0KZXJyb3IgYXQgbG9naWNhbCAyMjIwNjUwNjU5ODQgb24gZGV2IC9k
ZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgDQpwaHlzaWNhbCAyMjMxNDcxOTY0MTYNClsx
NjkzNzYwLjQ4ODY0MV0gc2NydWJfc3RyaXBlX3JlcG9ydF9lcnJvcnM6IDEgY2FsbGJhY2tz
IHN1cHByZXNzZWQNClsxNjkzNzYwLjQ4ODY0NV0gQlRSRlMgZXJyb3IgKGRldmljZSBkbS0x
KTogdW5hYmxlIHRvIGZpeHVwIChyZWd1bGFyKSANCmVycm9yIGF0IGxvZ2ljYWwgMjM2NzYw
MDA2NjU2IG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzIA0KcGh5c2ljYWwg
MjM4OTE1ODc4OTEyDQpbMTY5Mzc2MC40ODk0NTZdIHNjcnViX3N0cmlwZV9yZXBvcnRfZXJy
b3JzOiAxIGNhbGxiYWNrcyBzdXBwcmVzc2VkDQpbMTY5Mzc2MC40ODk0ODddIEJUUkZTIHdh
cm5pbmcgKGRldmljZSBkbS0xKTogY2hlY2tzdW0gZXJyb3IgYXQgbG9naWNhbCANCjIzNjc2
MDAwNjY1NiBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcywgcGh5c2ljYWwg
MjM4OTE1ODc4OTEyLCANCnJvb3QgMjU2LCBpbm9kZSAyNTksIG9mZnNldCAyMjUyMzA4NDgw
LCBsZW5nDQp0aCA0MDk2LCBsaW5rcyAxIChwYXRoOiBbcmVkYWN0ZWRdKQ0KWzE2OTM3NjAu
NjAyMzYwXSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJl
Z3VsYXIpIA0KZXJyb3IgYXQgbG9naWNhbCAyMzcwOTYwMDk3Mjggb24gZGV2IC9kZXYvbWFw
cGVyL2x2bS0tcmFpZC1pbWFnZXMgDQpwaHlzaWNhbCAyMzkyNTE4ODE5ODQNClsxNjkzNzYw
LjgxNTc3NV0gQlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVwIChy
ZWd1bGFyKSANCmVycm9yIGF0IGxvZ2ljYWwgMjM4NDg4NTg0MTkyIG9uIGRldiAvZGV2L21h
cHBlci9sdm0tLXJhaWQtaW1hZ2VzIA0KcGh5c2ljYWwgMjQwNjQ0NDU2NDQ4DQpbMTY5Mzc2
MC44MTY1NjhdIEJUUkZTIHdhcm5pbmcgKGRldmljZSBkbS0xKTogY2hlY2tzdW0gZXJyb3Ig
YXQgbG9naWNhbCANCjIzODQ4ODU4NDE5MiBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlk
LWltYWdlcywgcGh5c2ljYWwgMjQwNjQ0NDU2NDQ4LCANCnJvb3QgMjU2LCBpbm9kZSAyNTks
IG9mZnNldCA0NTIzNjUxMDcyLCBsZW5nDQp0aCA0MDk2LCBsaW5rcyAxIChwYXRoOiBbcmVk
YWN0ZWRdKQ0KWzE2OTM3NjAuODE5OTI1XSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1
bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIpIA0KZXJyb3IgYXQgbG9naWNhbCAyMzg1MTEzOTA3
MjAgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgDQpwaHlzaWNhbCAyNDA2
NjcyNjI5NzYNClsxNjkzNzYwLjg4NzA3NF0gQlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTog
dW5hYmxlIHRvIGZpeHVwIChyZWd1bGFyKSANCmVycm9yIGF0IGxvZ2ljYWwgMjM4Nzk2NjAz
MzkyIG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzIA0KcGh5c2ljYWwgMjQw
OTUyNDc1NjQ4DQpbMTY5Mzc2MC44ODc5MDVdIEJUUkZTIHdhcm5pbmcgKGRldmljZSBkbS0x
KTogY2hlY2tzdW0gZXJyb3IgYXQgbG9naWNhbCANCjIzODc5NjYwMzM5MiBvbiBkZXYgL2Rl
di9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcywgcGh5c2ljYWwgMjQwOTUyNDc1NjQ4LCANCnJv
b3QgMjU2LCBpbm9kZSAyNTksIG9mZnNldCA0NTQ5NTk1MTM2LCBsZW5nDQp0aCA0MDk2LCBs
aW5rcyAxIChwYXRoOiBbcmVkYWN0ZWRdKQ0KWzE2OTM3NjAuOTEzOTUwXSBCVFJGUyBlcnJv
ciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIpIA0KZXJyb3IgYXQg
bG9naWNhbCAyMzg4ODkyNzEyOTYgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFn
ZXMgDQpwaHlzaWNhbCAyNDEwNDUxNDM1NTINClsxNjkzNzYwLjk5NjEwNV0gQlRSRlMgZXJy
b3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVwIChyZWd1bGFyKSANCmVycm9yIGF0
IGxvZ2ljYWwgMjM5MjMxNDM0NzUyIG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQtaW1h
Z2VzIA0KcGh5c2ljYWwgMjQxMzg3MzA3MDA4DQpbMTY5Mzc2MC45OTkxMjFdIEJUUkZTIGVy
cm9yIChkZXZpY2UgZG0tMSk6IHVuYWJsZSB0byBmaXh1cCAocmVndWxhcikgDQplcnJvciBh
dCBsb2dpY2FsIDIzOTI0MTM5NjIyNCBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlkLWlt
YWdlcyANCnBoeXNpY2FsIDI0MTM5NzI2ODQ4MA0KWzE2OTM3NjEuMDA1Njg2XSBCVFJGUyBl
cnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIpIA0KZXJyb3Ig
YXQgbG9naWNhbCAyMzkyNjY0MzA5NzYgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1p
bWFnZXMgDQpwaHlzaWNhbCAyNDE0MjIzMDMyMzINClsxNjkzNzYxLjAxMTQ3Nl0gQlRSRlMg
ZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVwIChyZWd1bGFyKSANCmVycm9y
IGF0IGxvZ2ljYWwgMjM5MzIxNDgxMjE2IG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQt
aW1hZ2VzIA0KcGh5c2ljYWwgMjQxNDc3MzUzNDcyDQpbMTY5Mzc3MS4wMzk2NjldIEJUUkZT
IGluZm8gKGRldmljZSBkbS0xKTogc2NydWI6IGZpbmlzaGVkIG9uIGRldmlkIDEgDQp3aXRo
IHN0YXR1czogMA0KDQoNCg0KDQo=
--------------iqIk3voBP3Yp4mM5rBd9Fgpv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hi there Roman,<br>
    </p>
    <div class=3D"moz-cite-prefix">On 3/2/24 15:47, Roman Mamedov wrote:<=
br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20240302204726.6d2dcd87@nvm">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Sat, 2 Mar 2024 15:01:43 =
+0000
Nigel Kukard <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:nkukard@LB=
SD.net">&lt;nkukard@LBSD.net&gt;</a> wrote:

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">I'm wondering if btrfs ont=
op of LVM ontop of MD RAID1 is supported?=C2=A0=20
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Should be absolutely supported.

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">I've managed to reproduce =
with 100% accuracy severe data corruption=20
using this configuration on 6.6.19.

2 x 1.92T NVMe's in MD RAID1 configuration
LVM volume created ontop of the MD RAID1
btrfs filesystem on the LV

I then write about 100-200G of data. Create a snapshot. Read/write the=20
file and get these messages...
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Has the MD RAID1 finished its initial sync after creation?

Have you tried waiting until it finishes and only then do thewrites to se=
e if
the corruption is still observed (of course that's in no way a "workaroun=
d",
just to see what might cause the bug).

Do you know any kernel versions or series where this corruption did not h=
appen?

I assume you're not saying it appeared in 6.6.19 compared to 6.6.18.

Can you try the 6.1 series? Or maybe also 6.8?

I made a Btrfs on top of LVM on top of RAID1 myself now, but on consumer =
SSDs.
Copying some files to it now, to check. Would be also helpful if you can =
find
a precise sequence of commands which can trigger the bug, less vague than=

copy some files to it and see.

</pre>
    </blockquote>
    <p>I'm now absolutely convinced this is some kind of a bug.</p>
    <p>Over the past 2 weeks I've migrated a number of libvirtd qcow2
      files over to btrfs filesystems, and on every single system with
      NVMe's with LVM ontop of MD I'm getting errors like the below.<br>
    </p>
    <p>I'm not sure if its relevant, but the VM's run weekly TRIM's on
      their disks. The host system also runs weekly TRIM's.</p>
    <p>The first time I mentioned above was with new systems I installed
      on brand new disks. I'm now seeing the same issue on systems that
      are 1-2 years old, also with NVMe's, which were running ext4 in
      the past.</p>
    <p>On all systems I did a clean LV and created the btrfs filesystem
      with:<br>
      mkfs.btrfs -L images /dev/lvm-raid/images</p>
    <p>The LVM volumes were created normally with..<br>
      pvcreate /dev/md/0<br>
      vgcreate lvm-raid /dev/md/0<br>
      lvcreate --size 1T --name images lvm-raid<br>
    </p>
    <p><br>
    </p>
    <p>I'm running one subvolume folder per virtual machines. Each
      folder contains 1-2 files of between 25G and 500G in size which
      are my qcow2 files.<br>
    </p>
    <p><br>
    </p>
    <p>I'm running btrfs-progs version 6.7.1-1 on all machines and
      kernel 6.6.18, 6.6.19 or 6.6.20. It seems to occur on all 3 of
      them.<br>
    </p>
    <p><br>
    </p>
    <p>Most of the NVMe's are Samsungs...</p>
    <p><span style=3D"font-family:monospace">Model
        Number:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
SAMSUNG MZQLB1T9HAJR-00007<br>
        Serial Number:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 S439NA0MA01592<br>
        Firmware Version:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EDA5402Q<br>=

      </span></p>
    <p><br>
    </p>
    <p>Here is the output in the logs running:=C2=A0 btrfs scrub
      &lt;subvolume&gt;<br>
    </p>
    [1693754.276834] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 214229778432 on dev
    /dev/mapper/lvm--raid-images physical 215311908864<br>
    [1693754.415563] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 214611918848 on dev
    /dev/mapper/lvm--raid-images physical 215694049280<br>
    [1693754.877399] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 216889556992 on dev
    /dev/mapper/lvm--raid-images physical 217971687424<br>
    [1693754.878195] BTRFS warning (device dm-1): checksum error at
    logical 216889556992 on dev /dev/mapper/lvm--raid-images, physical
    217971687424, root 256, inode 259, offset 4607844352, leng<br>
    th 4096, links 1 (path: [redacted])<br>
    [1693755.503582] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 219655766016 on dev
    /dev/mapper/lvm--raid-images physical 220737896448<br>
    [1693755.503628] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 219655700480 on dev
    /dev/mapper/lvm--raid-images physical 220737830912<br>
    [1693755.505141] BTRFS warning (device dm-1): checksum error at
    logical 219655700480 on dev /dev/mapper/lvm--raid-images, physical
    220737830912, root 257, inode 260, offset 3594641408, leng<br>
    th 4096, links 1 (path: [redacted].qcow2)<br>
    [1693755.627722] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 220037513216 on dev
    /dev/mapper/lvm--raid-images physical 221119643648<br>
    [1693755.628515] BTRFS warning (device dm-1): checksum error at
    logical 220037513216 on dev /dev/mapper/lvm--raid-images, physical
    221119643648, root 5, inode 269, offset 7562219520, length<br>
    4096, links 1 (path: [redacted]/[redacted].qcow2)<br>
    [1693756.072457] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 222065065984 on dev
    /dev/mapper/lvm--raid-images physical 223147196416<br>
    [1693760.488641] scrub_stripe_report_errors: 1 callbacks suppressed<b=
r>
    [1693760.488645] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 236760006656 on dev
    /dev/mapper/lvm--raid-images physical 238915878912<br>
    [1693760.489456] scrub_stripe_report_errors: 1 callbacks suppressed<b=
r>
    [1693760.489487] BTRFS warning (device dm-1): checksum error at
    logical 236760006656 on dev /dev/mapper/lvm--raid-images, physical
    238915878912, root 256, inode 259, offset 2252308480, leng<br>
    th 4096, links 1 (path: [redacted])<br>
    [1693760.602360] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 237096009728 on dev
    /dev/mapper/lvm--raid-images physical 239251881984<br>
    [1693760.815775] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 238488584192 on dev
    /dev/mapper/lvm--raid-images physical 240644456448<br>
    [1693760.816568] BTRFS warning (device dm-1): checksum error at
    logical 238488584192 on dev /dev/mapper/lvm--raid-images, physical
    240644456448, root 256, inode 259, offset 4523651072, leng<br>
    th 4096, links 1 (path: [redacted])<br>
    [1693760.819925] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 238511390720 on dev
    /dev/mapper/lvm--raid-images physical 240667262976<br>
    [1693760.887074] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 238796603392 on dev
    /dev/mapper/lvm--raid-images physical 240952475648<br>
    [1693760.887905] BTRFS warning (device dm-1): checksum error at
    logical 238796603392 on dev /dev/mapper/lvm--raid-images, physical
    240952475648, root 256, inode 259, offset 4549595136, leng<br>
    th 4096, links 1 (path: [redacted])<br>
    [1693760.913950] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 238889271296 on dev
    /dev/mapper/lvm--raid-images physical 241045143552<br>
    [1693760.996105] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 239231434752 on dev
    /dev/mapper/lvm--raid-images physical 241387307008<br>
    [1693760.999121] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 239241396224 on dev
    /dev/mapper/lvm--raid-images physical 241397268480<br>
    [1693761.005686] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 239266430976 on dev
    /dev/mapper/lvm--raid-images physical 241422303232<br>
    [1693761.011476] BTRFS error (device dm-1): unable to fixup
    (regular) error at logical 239321481216 on dev
    /dev/mapper/lvm--raid-images physical 241477353472<br>
    [1693771.039669] BTRFS info (device dm-1): scrub: finished on devid
    1 with status: 0<br>
    <br>
    <br>
    <br>
    <p><br>
    </p>
  </body>
</html>

--------------iqIk3voBP3Yp4mM5rBd9Fgpv--

--------------sj2VR6hDMuGHVxxj2TeOhPsS--

--------------kGHgi2rG90ULo5NemXnVd7XQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT5M4N3g4xfUCNXIu76GXFSvoUHMwUCZflxdAUDAAAAAAAKCRD6GXFSvoUHM1lR
AQDNg3DEbPlv0mn0ZBiy6QVVmqCcEax8pXamUhgEdTWsOAD/fjjV0pSxra32VVb1KxUkGu8aZabP
dTfT/k92IKowIQ0=
=DXIV
-----END PGP SIGNATURE-----

--------------kGHgi2rG90ULo5NemXnVd7XQ--

