Return-Path: <linux-btrfs+bounces-4927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE2B8C3AB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 06:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC0FB20C1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 04:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F8145FE4;
	Mon, 13 May 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="rTx3ZQ4o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843C282EB
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715574204; cv=none; b=R4VwWgOrfZ7xYJDc80Ifnv1XVLkbouEfm85M7vMzXiHSEbH6yvR0IOuBgqbBTPDyC3UAiWCd2biLrgXT6+SEBjfNhAm+B3Kb1OUnxF1XBhKySZv9hRKYxaM9KUAGg7PES/aeZpyiqagSZgy51rTsPyjAgpi8X2qYXMBl4nU3q4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715574204; c=relaxed/simple;
	bh=UoTS4hCm+7zJOU1FDWrFpXhVNSme5KzCHMXiiuoQDfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fZQ6YowcKioOz9VHo499s8O7DzMOO9tXmChsXuvaYlcQPOXWRl41DG9bIMs4K4KaZEhcqyQcZXRVmojrfGz7UaWiv03I8b9nhogRk+WZJeMUilXYWGH1kOw3pSoZvkCOpCVtCycoVa+xvqSMtC3dPtuGQ2oQNeaHY8NsxYYmlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=rTx3ZQ4o; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1715574199;
	bh=UoTS4hCm+7zJOU1FDWrFpXhVNSme5KzCHMXiiuoQDfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=rTx3ZQ4oUp5yVvVx++gTpT4/yv1K/RYnGwn59EsXR1irC7WH2rEqZqIaPz0QyudH9
	 vrg+mc8vmlbSUSVgequVwYdfsJZHPsTEtrs3SxGRwCJjiLbL797TzcTElh9EzXRiJY
	 Of8N4/3VhsR6xrRwW/kd9yMdqadSU2Kdlz9mRljM=
X-QQ-mid: bizesmtpsz2t1715573969t2io7hn
X-QQ-Originating-IP: q0i6nvWoGRG3i86uFv4VI4C40wZLJHz2f/20vkbjeWw=
Received: from [192.168.1.5] ( [223.150.233.37])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 12:19:28 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: 7w+M6dcZAuZzUMl4Xcu8U6/4pPPp4ATsh1FpxFPcnINnfRbE88cD/9Lr6p3he
	ttVbHXhBCnggNdgOxMfZX1PrafYF4tuIrO/Im7nKsffxO0UPH65oRDA972QGjGgxFcIsPjF
	yQVYJTihaQNpT/MttaOPiUREGLcT2GSB6yUU9FdD7CkpytoR2pm5UxMwm1F5sDvE4vR2A7V
	ajuQwmh62kvyev7v94zDTkc6k0Mns5dT84hxMNLYqrAhsp5x60cz79zThCwUiYYQ9R+iEo2
	Nnaf6ZWE2Diif+vmeyenChk0+VBtmKjzdiV/dDr3iiJttgzMXELzXqe3MklZv/IQm6Yklhp
	RRfIhPjMFd/vXHABHTR8RvWF0kkZImHnc/n4udSSEXwFWDV8u4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16621573303568883950
Message-ID: <6B5555BE532EFFBF+03c904d1-3111-40d6-9266-8c02c35b6cd4@bupt.moe>
Date: Mon, 13 May 2024 12:19:29 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: snapshots of subvolumes recursivly?
To: linux-btrfs@vger.kernel.org
References: <20240512203921.GA83909@tik.uni-stuttgart.de>
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <20240512203921.GA83909@tik.uni-stuttgart.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DBam2pzww905lWzB3AO0eKfp"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DBam2pzww905lWzB3AO0eKfp
Content-Type: multipart/mixed; boundary="------------5hmJMhK24zWnomDVsELX3Hlq";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: linux-btrfs@vger.kernel.org
Message-ID: <03c904d1-3111-40d6-9266-8c02c35b6cd4@bupt.moe>
Subject: Re: snapshots of subvolumes recursivly?
References: <20240512203921.GA83909@tik.uni-stuttgart.de>
In-Reply-To: <20240512203921.GA83909@tik.uni-stuttgart.de>

--------------5hmJMhK24zWnomDVsELX3Hlq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

5ZyoIDIwMjQvNS8xMyA0OjM5LCBVbGxpIEhvcmxhY2hlciDlhpnpgZM6DQo+IEkgaGF2ZSBh
c2tlZCBhIHNpbWlsYXIgcXVlc3Rpb24gMjAxOS0wNy0wNSwgYnV0IG1heWJlIG1lYW53aGls
ZSB0aGVyZSBpcyBhDQo+IHNvbHV0aW9uLi4uDQo+DQo+IEkgd2FudCB0byBiYWNrdXAgYnRy
ZnMgZmlsZXN5c3RlbXMgd2l0aCBJQk0gU3BlY3RydW0gUHJvdGVjdCBhbmQgcmVzdGljLA0K
PiBib3RoIGFyZSBmaWxlIGJhc2VkLg0KPg0KPiBDb3B5aW5nIGZpbGVzIHdoaWNoIGFyZSBp
biB3cml0ZS1vcGVuIHN0YXRlIHdpbGwgbGVhZCB0byBmaWxlIGNvcnJ1cHRpb24uDQo+IFRo
ZXJlZm9yZSBteSBpZGVhIGlzOiBjcmVhdGUgYSBzbmFwc2hvdCBhbmQgcnVuIHRoZSBiYWNr
dXAgb24gdGhlIHNuYXBzaG90Lg0KWW91IGNvdWxkIHVzZSAiYnRyZnMgc2VuZCIgdG8gc2Vu
ZCB3aG9sZSBzbmFwc2hvdCBpbnN0ZWFkIG9mIGZpbGUuDQo+IFRoZSBwcm9ibGVtIG5vdyBp
czogc29tZSBvZiB0aGUgYnRyZnMgZmlsZXN5c3RlbXMgaGF2ZSBzdWJ2b2x1bWVzIGFuZA0K
PiBldmVuIHN1Yi1zdWJ2b2x1bWVzLg0KPg0KPiBXaGVuIEkgY3JlYXRlIGEgc25hcHNob3Qg
aXQgZG9lcyBub3QgY29udGFpbiBzdWJ2b2x1bWVzLiBFeGFtcGxlOg0KPg0KPiByb290QGZl
eDovbG9jYWwvdGVzdCMgYnRyZnMgc3Vidm9sdW1lIGxpc3QgLg0KPiBJRCAzNTAgZ2VuIDYw
NzU5NDcgdG9wIGxldmVsIDUgcGF0aCBob21lDQo+IElEIDYyNTMwIGdlbiA2MDc1OTA0IHRv
cCBsZXZlbCA1IHBhdGggdGVzdA0KPiBJRCA2MjUzMSBnZW4gNjA3NTg5NCB0b3AgbGV2ZWwg
NjI1MzAgcGF0aCBzdjENCj4gSUQgNjI1MzIgZ2VuIDYwNzU4OTUgdG9wIGxldmVsIDYyNTMw
IHBhdGggc3YyDQo+IElEIDYyNTMzIGdlbiA2MDc1ODk0IHRvcCBsZXZlbCA2MjUzMSBwYXRo
IHN2MS9zdjFfMQ0KPiBJRCA2MjUzNCBnZW4gNjA3NTg5NCB0b3AgbGV2ZWwgNjI1MzEgcGF0
aCBzdjEvc3YxXzINCj4NCj4gcm9vdEBmZXg6L2xvY2FsL3Rlc3QjIGxsIC1SDQo+IGRyd3hy
LXhyLXggIHJvb3QgICAgIHJvb3QgICAgICAgICAgICAgICAgICAgICAgIC0gMjAyNC0wNS0x
MiAyMDo0MjowMiAgc3YxDQo+IGRyd3hyLXhyLXggIHJvb3QgICAgIHJvb3QgICAgICAgICAg
ICAgICAgICAgICAgIC0gMjAyNC0wNS0xMiAyMDo0MjoxMCAgc3YxL3N2MV8xDQo+IC1ydy1y
LS1yLS0gIHJvb3QgICAgIHJvb3QgICAgICAgICAgICAgICAgICAgICAgMjAgMjAyNC0wNS0x
MiAyMDo0MjoxMCAgc3YxL3N2MV8xL3p6DQo+IGRyd3hyLXhyLXggIHJvb3QgICAgIHJvb3Qg
ICAgICAgICAgICAgICAgICAgICAgIC0gMjAyNC0wNS0xMiAyMDo0MjoxNyAgc3YxL3N2MV8y
DQo+IC1ydy1yLS1yLS0gIHJvb3QgICAgIHJvb3QgICAgICAgICAgICAgICAgICAgICAgMjAg
MjAyNC0wNS0xMiAyMDo0MjoxNyAgc3YxL3N2MV8yL3p6DQo+IC1ydy1yLS1yLS0gIHJvb3Qg
ICAgIHJvb3QgICAgICAgICAgICAgICAgICAgICAgMjAgMjAyNC0wNS0xMiAyMDo0MjowMiAg
c3YxL3p6DQo+IGRyd3hyLXhyLXggIHJvb3QgICAgIHJvb3QgICAgICAgICAgICAgICAgICAg
ICAgIC0gMjAyNC0wNS0xMiAyMDo0MjoyNSAgc3YyDQo+IC1ydy1yLS1yLS0gIHJvb3QgICAg
IHJvb3QgICAgICAgICAgICAgICAgICAgICAgMjAgMjAyNC0wNS0xMiAyMDo0MjoyNSAgc3Yy
L3p6DQo+IC1ydy1yLS1yLS0gIHJvb3QgICAgIHJvb3QgICAgICAgICAgICAgICAgICAgICAg
MjAgMjAyNC0wNS0xMiAyMDo0MDo1OCAgenoNCj4NCj4gcm9vdEBmZXg6L2xvY2FsL3Rlc3Qj
IGJ0cmZzIHN1YiBzbmFwIC4gYmFja3VwDQo+IENyZWF0ZSBhIHNuYXBzaG90IG9mICcuJyBp
biAnLi9iYWNrdXAnDQo+DQo+IHJvb3RAZmV4Oi9sb2NhbC90ZXN0IyBsbCAtUiBiYWNrdXAN
Cj4gZHJ3eHIteHIteCAgcm9vdCAgICAgcm9vdCAgICAgICAgICAgICAgICAgICAgICAgLSAy
MDI0LTA1LTEyIDIwOjQwOjU4ICBiYWNrdXANCj4gZHJ3eHIteHIteCAgcm9vdCAgICAgcm9v
dCAgICAgICAgICAgICAgICAgICAgICAgLSAyMDI0LTA1LTEyIDIwOjQ3OjU4ICBiYWNrdXAv
c3YxDQo+IGRyd3hyLXhyLXggIHJvb3QgICAgIHJvb3QgICAgICAgICAgICAgICAgICAgICAg
IC0gMjAyNC0wNS0xMiAyMDo0Nzo1OCAgYmFja3VwL3N2Mg0KPiAtcnctci0tci0tICByb290
ICAgICByb290ICAgICAgICAgICAgICAgICAgICAgIDIwIDIwMjQtMDUtMTIgMjA6NDA6NTgg
IGJhY2t1cC96eg0KPg0KPiByb290QGZleDovbG9jYWwvdGVzdCMgYnRyZnMgc3Vidm9sdW1l
IGxpc3QgLg0KPiBJRCAzNTAgZ2VuIDYwNzU5NDcgdG9wIGxldmVsIDUgcGF0aCBob21lDQo+
IElEIDYyNTMwIGdlbiA2MDc1OTA0IHRvcCBsZXZlbCA1IHBhdGggdGVzdA0KPiBJRCA2MjUz
MSBnZW4gNjA3NTg5NCB0b3AgbGV2ZWwgNjI1MzAgcGF0aCBzdjENCj4gSUQgNjI1MzIgZ2Vu
IDYwNzU4OTUgdG9wIGxldmVsIDYyNTMwIHBhdGggc3YyDQo+IElEIDYyNTMzIGdlbiA2MDc1
ODk0IHRvcCBsZXZlbCA2MjUzMSBwYXRoIHN2MS9zdjFfMQ0KPiBJRCA2MjUzNCBnZW4gNjA3
NTg5NCB0b3AgbGV2ZWwgNjI1MzEgcGF0aCBzdjEvc3YxXzINCj4gSUQgNjI1MzUgZ2VuIDYw
NzU5MDMgdG9wIGxldmVsIDYyNTMwIHBhdGggYmFja3VwDQo+DQo+IEFzIHlvdSBzZWU6IHRo
ZSBzbmFwc2hvdCAvbG9jYWwvdGVzdC9iYWNrdXAgZG9lcyBub3QgY29udGFpbiB0aGUgc3Yq
DQo+IHN1YnZvbHVtZXMsIG9ubHkgZW1wdHkgZGlyZWN0b3JpZXMgYmFja3VwL3N2MSBiYWNr
dXAvc3YyDQo+DQo+IEkgY291bGQgd3JpdGUgYSBzY3JpcHQgd2hpY2ggY3JlYXRlcyBzbmFw
c2hvdHMgb2YgdGhlIHN1YnZvbHVtZXMNCj4gKHJlY3Vyc2l2bHkpLCBidXQgbWF5YmUgdGhl
cmUgaXMgYWxyZWFkeSBzdWNoIGEgcHJvZ3JhbT8NCj4gT3IgYW5vdGhlciBzb2x1dGlvbiBm
b3IgdGhpcyBwcm9ibGVtPw0KDQogRnJvbSB3aGF0IEkgdW5kZXJzdGFuZCwgc3Vidm9sdW1l
IGNyZWF0ZWQgYSB3YXkgdG8gc3BsaXQgeW91ciAic25hcHNob3QgDQp6b25lIiBmb3IgYmV0
dGVyIGRhdGEgbWFuYWdlbWVudChlLmcuIHlvdSBjYW4gc25hcHNob3QgLyB3aXRob3V0IA0K
aW5jbHVkaW5nIC9ob21lIG9yIC92YXIpLiBUaGlzIGlzIGludGVudGVkLg0KDQpTbyBpZiB5
b3Ugd2FudCB0byBiYWNrdXAgc3YxIHN2Miwgd2h5IHlvdSBjcmVhdGVkIHN1YnZvbHVtZSBp
biB0aGUgZmlyc3QgDQpwbGFjZT8NCg0KSEFOIFl1d2VpDQoNCg==

--------------5hmJMhK24zWnomDVsELX3Hlq--

--------------DBam2pzww905lWzB3AO0eKfp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZkGU0QAKCRBLkKfpYfpB
U+eIAP0c/HXzOgx1zK3DTo3uIVkSU/96RIWfGOVMlXd4nimplgEAnpSepWwspftR
2zstP29jN7XMBwoQkc1Mhh8vEqHXqwo=
=/u8t
-----END PGP SIGNATURE-----

--------------DBam2pzww905lWzB3AO0eKfp--

