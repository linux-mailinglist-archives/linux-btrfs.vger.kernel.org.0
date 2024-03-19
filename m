Return-Path: <linux-btrfs+bounces-3393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933287FED2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D381B2843AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3980055;
	Tue, 19 Mar 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lbsd.net header.i=@lbsd.net header.b="OrWvDoYi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from uk1.mailhost.iitsp.com (uk1.mailhost.iitsp.com [57.128.155.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249FA7FBD5
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.128.155.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854822; cv=none; b=TydDFDoIlhIhp4p6e6awolHiAekj8Uz8E4L63f0eqO9pDyw5veSAVjpvOIleb9Uxg7kjKN1/uaj6yW7rSOEQhAK8XlqZjsQbuaCTNN/qveYEvvWrjB4KuSL1fKCI0aWamuEL/LYrSe91o3D2OOJaR7d2JL6eWZxYB2tzasnhQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854822; c=relaxed/simple;
	bh=8F43Ms/vZVnjqGB1q6SD07S3vOah6sFgyoECmUcDizw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WKNhDfYZ8sVDoSjtHaQY+IcCpAlydB52wfPv0sLErVDn1ljtzWoYrQCQ2ED1IIzZGcBVVmeU3C01xU/yIl/QXJhEl9kC367D6XSFM4xS5B3GGqGP7FLXj8fK4kAnqiGmtrBNk1L9xgTJo773Oht+l220ZLuqCPGCApuFZcn3xa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=LBSD.net; spf=pass smtp.mailfrom=LBSD.net; dkim=pass (1024-bit key) header.d=lbsd.net header.i=@lbsd.net header.b=OrWvDoYi; arc=none smtp.client-ip=57.128.155.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=LBSD.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=LBSD.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lbsd.net;
	s=mail; h=Content-Type:In-Reply-To:References:To:From:Subject:Cc:MIME-Version
	:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5n7/jL6U8xN0727rXVomX4Rmf65hxA4ahFsrXSElXrc=; b=OrWvDoYiLO13KvrCTwDgZG3IbY
	9SEr9dZgSzpnWOPKg0QgR01T+wQ8S9C23+M55jLhVWqf0b6TgHsDtLUabmx0IUkvfYxXEfJCgzmZd
	1958AnssBVqXS92vzH+/g9uLzZtDQferRWpyaYOSpuX1lxHvwdhWLLdj9md6NVe4kewE=;
Received: by uk1.mailhost.iitsp.com with esmtpsa id 1rmZUU-0000000FYms-1Q9l 
	;
	Tue, 19 Mar 2024 13:26:54 +0000
Message-ID: <5d1afc78-0808-4b41-a51b-3a2a247b10ed@LBSD.net>
Date: Tue, 19 Mar 2024 13:26:52 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs ontop of LVM ontop of MD RAID1 supported?
Content-Language: en-US
From: Nigel Kukard <nkukard@LBSD.net>
To: Roman Mamedov <rm@romanrm.net>
References: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
 <20240302204726.6d2dcd87@nvm> <0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net>
In-Reply-To: <0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YB4E5dtWBzlq33j0iGcOD0L0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YB4E5dtWBzlq33j0iGcOD0L0
Content-Type: multipart/mixed; boundary="------------Xb0SyiIZTlwenbQYnIJad3mQ";
 protected-headers="v1"
From: Nigel Kukard <nkukard@LBSD.net>
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <5d1afc78-0808-4b41-a51b-3a2a247b10ed@LBSD.net>
Subject: Re: btrfs ontop of LVM ontop of MD RAID1 supported?
References: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
 <20240302204726.6d2dcd87@nvm> <0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net>
In-Reply-To: <0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net>

--------------Xb0SyiIZTlwenbQYnIJad3mQ
Content-Type: multipart/alternative;
 boundary="------------XN0yUqZC2CAAIl30VQ2Y4jWo"

--------------XN0yUqZC2CAAIl30VQ2Y4jWo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgdGhlcmUsDQoNCk9uIDMvMTkvMjQgMTE6MDUsIE5pZ2VsIEt1a2FyZCB3cm90ZToNCj4N
Cj4gSGkgdGhlcmUgUm9tYW4sDQo+DQo+IE9uIDMvMi8yNCAxNTo0NywgUm9tYW4gTWFtZWRv
diB3cm90ZToNCj4+IE9uIFNhdCwgMiBNYXIgMjAyNCAxNTowMTo0MyArMDAwMA0KPj4gTmln
ZWwgS3VrYXJkPG5rdWthcmRATEJTRC5uZXQ+ICB3cm90ZToNCj4+DQo+Pj4gSSdtIHdvbmRl
cmluZyBpZiBidHJmcyBvbnRvcCBvZiBMVk0gb250b3Agb2YgTUQgUkFJRDEgaXMgc3VwcG9y
dGVkPw0KPj4gU2hvdWxkIGJlIGFic29sdXRlbHkgc3VwcG9ydGVkLg0KPj4NCj4+PiBJJ3Zl
IG1hbmFnZWQgdG8gcmVwcm9kdWNlIHdpdGggMTAwJSBhY2N1cmFjeSBzZXZlcmUgZGF0YSBj
b3JydXB0aW9uDQo+Pj4gdXNpbmcgdGhpcyBjb25maWd1cmF0aW9uIG9uIDYuNi4xOS4NCj4+
Pg0KPj4+IDIgeCAxLjkyVCBOVk1lJ3MgaW4gTUQgUkFJRDEgY29uZmlndXJhdGlvbg0KPj4+
IExWTSB2b2x1bWUgY3JlYXRlZCBvbnRvcCBvZiB0aGUgTUQgUkFJRDENCj4+PiBidHJmcyBm
aWxlc3lzdGVtIG9uIHRoZSBMVg0KPj4+DQo+Pj4gSSB0aGVuIHdyaXRlIGFib3V0IDEwMC0y
MDBHIG9mIGRhdGEuIENyZWF0ZSBhIHNuYXBzaG90LiBSZWFkL3dyaXRlIHRoZQ0KPj4+IGZp
bGUgYW5kIGdldCB0aGVzZSBtZXNzYWdlcy4uLg0KPj4gSGFzIHRoZSBNRCBSQUlEMSBmaW5p
c2hlZCBpdHMgaW5pdGlhbCBzeW5jIGFmdGVyIGNyZWF0aW9uPw0KDQpDb3JyZWN0LiBJdCBk
b2Vzbid0IHNlZW0gdG8gbWFrZSBhIGRpZmZlcmVuY2UgaWYgc3luYydkIG9yIG5vdC4gSSB0
cmllZCANCml0IG9uIGEgbmV3IHN5c3RlbSBhYm91dCBhIHdlZWsgYWdvIGFuZCBpdCB0b29r
IGEgNSBkYXlzIHRvIG1hbmlmZXN0IG9uIA0KdGhhdCBzeXN0ZW0uDQoNCk9uIHRoaXMgc3lz
dGVtIEkgY29waWVkIG1vcmUgZGF0YSB0aGFuIHRoZSBmaXJzdCA0IHN5c3RlbXMgdG8gdHJ5
IA0KcmVwcm9kdWNlIHRoZSBpc3N1ZSwgd2hpY2ggaXMgd2hlbiBJIHRob3VnaHQgbWF5YmUg
YWxsIDQgc3lzdGVtcyBJIA0Kb3JpZ2luYWxseSBoYWQgdGhlIHByb2JsZW0gb24gaGFkIGEg
c2ltaWxhciBpc3N1ZS4NCg0KQnV0IGFmdGVyIDUgZGF5cyBJIHN0YXJ0ZWQgbm90aWNpbmcg
bWVzc2FnZXMgaW4gdGhlIGxvZy4NCg0KDQo+Pg0KPj4gSGF2ZSB5b3UgdHJpZWQgd2FpdGlu
ZyB1bnRpbCBpdCBmaW5pc2hlcyBhbmQgb25seSB0aGVuIGRvIHRoZXdyaXRlcyB0byBzZWUg
aWYNCj4+IHRoZSBjb3JydXB0aW9uIGlzIHN0aWxsIG9ic2VydmVkIChvZiBjb3Vyc2UgdGhh
dCdzIGluIG5vIHdheSBhICJ3b3JrYXJvdW5kIiwNCj4+IGp1c3QgdG8gc2VlIHdoYXQgbWln
aHQgY2F1c2UgdGhlIGJ1ZykuDQoNClllcCwgdGhhdCBkb2Vzbid0IHNlZW0gdG8gYmUgdGhl
IHByb2JsZW0uDQoNCg0KPj4NCj4+IERvIHlvdSBrbm93IGFueSBrZXJuZWwgdmVyc2lvbnMg
b3Igc2VyaWVzIHdoZXJlIHRoaXMgY29ycnVwdGlvbiBkaWQgbm90IGhhcHBlbj8NCg0KSSBi
ZWxpZXZlIGZyb20gbXkgbG9nIHNlYXJjaGluZyB0aGVzZSBpc3N1ZXMgb25seSBvY2N1cnJl
ZCBhZnRlciANCnVwZGF0aW5nIGZyb20gNi4xLjU2IHRvIDYuNi4xOC4gVGhhdCdzIHRoZSBt
b3N0IEkndmUgYmVlbiBhYmxlIHRvIG5hcnJvdyANCml0IGRvd24gc28gZmFyLg0KDQoNCj4+
DQo+PiBJIGFzc3VtZSB5b3UncmUgbm90IHNheWluZyBpdCBhcHBlYXJlZCBpbiA2LjYuMTkg
Y29tcGFyZWQgdG8gNi42LjE4Lg0KDQpNeSBrZXJuZWwganVtcHMgd2VyZSBhbGwgZnJvbSA2
LjEuNTYgdG8gNi42LjE4LzYuNi4xOS4NCg0KDQo+Pg0KPj4gQ2FuIHlvdSB0cnkgdGhlIDYu
MSBzZXJpZXM/IE9yIG1heWJlIGFsc28gNi44Pw0KDQpJJ20gbm90IHNlZWluZyBhbnkgZXJy
b3JzIGluIG15IGxvZ3MgZnJvbSA2LjEuNTYuDQoNCg0KPj4NCj4+IEkgbWFkZSBhIEJ0cmZz
IG9uIHRvcCBvZiBMVk0gb24gdG9wIG9mIFJBSUQxIG15c2VsZiBub3csIGJ1dCBvbiBjb25z
dW1lciBTU0RzLg0KPj4gQ29weWluZyBzb21lIGZpbGVzIHRvIGl0IG5vdywgdG8gY2hlY2su
IFdvdWxkIGJlIGFsc28gaGVscGZ1bCBpZiB5b3UgY2FuIGZpbmQNCj4+IGEgcHJlY2lzZSBz
ZXF1ZW5jZSBvZiBjb21tYW5kcyB3aGljaCBjYW4gdHJpZ2dlciB0aGUgYnVnLCBsZXNzIHZh
Z3VlIHRoYW4NCj4+IGNvcHkgc29tZSBmaWxlcyB0byBpdCBhbmQgc2VlLg0KDQpZZWEsIGFm
dGVyIHRoZSBmaXJzdCA0IHN5c3RlbXMgdGhhdCBhbG1vc3QgaW1tZWRpYXRlbHkgbWFuaWZl
c3RlZCB3aXRoaW4gDQoxLTI0IGhvdXJzLCBzdWJzZXF1ZW50IHRyaWVzIHRvIHRyeSByZXBy
b2R1Y2UgaXQgd2VyZSB1bnN1Y2Nlc3NmdWwuDQoNCkkgdHJpZWQgU1NEJ3MgaW4gbXkgbGFi
IG9mIGEgc2ltaWxhciBzaXplLCAxLjkyMFRiIHRvIG5vIGF2YWlsLCBJIHdhcyANCnVuYWJs
ZSB0byByZXByb2R1Y2UuDQoNCkkgaGF2ZSBzaW5jZSB0aGVuIHByb3Zpc2lvbmVkIG11bHRp
cGxlIG5ldyBzZXJ2ZXJzIHdpdGggTlZNZSdzIGFuZCB0aGV5IA0KaGF2ZSBhbGwgbWFuaWZl
c3RlZCB0aGUgaXNzdWUgd2l0aGluIDUgb3Igc28gZGF5cy4NCg0KSSBob3BlIHRoaXMgaGVs
cHMgYXQgbGVhc3QgYSBsaXR0bGUuIEl0IHNlZW1zIGhhcmQgdG8gcmVwcm9kdWNlIA0KaW50
ZW50aW9uYWxseS4NCg0KLU4NCg0KDQo+Pg0KPiBJJ20gbm93IGFic29sdXRlbHkgY29udmlu
Y2VkIHRoaXMgaXMgc29tZSBraW5kIG9mIGEgYnVnLg0KPg0KPiBPdmVyIHRoZSBwYXN0IDIg
d2Vla3MgSSd2ZSBtaWdyYXRlZCBhIG51bWJlciBvZiBsaWJ2aXJ0ZCBxY293MiBmaWxlcyAN
Cj4gb3ZlciB0byBidHJmcyBmaWxlc3lzdGVtcywgYW5kIG9uIGV2ZXJ5IHNpbmdsZSBzeXN0
ZW0gd2l0aCBOVk1lJ3Mgd2l0aCANCj4gTFZNIG9udG9wIG9mIE1EIEknbSBnZXR0aW5nIGVy
cm9ycyBsaWtlIHRoZSBiZWxvdy4NCj4NCj4gSSdtIG5vdCBzdXJlIGlmIGl0cyByZWxldmFu
dCwgYnV0IHRoZSBWTSdzIHJ1biB3ZWVrbHkgVFJJTSdzIG9uIHRoZWlyIA0KPiBkaXNrcy4g
VGhlIGhvc3Qgc3lzdGVtIGFsc28gcnVucyB3ZWVrbHkgVFJJTSdzLg0KPg0KPiBUaGUgZmly
c3QgdGltZSBJIG1lbnRpb25lZCBhYm92ZSB3YXMgd2l0aCBuZXcgc3lzdGVtcyBJIGluc3Rh
bGxlZCBvbiANCj4gYnJhbmQgbmV3IGRpc2tzLiBJJ20gbm93IHNlZWluZyB0aGUgc2FtZSBp
c3N1ZSBvbiBzeXN0ZW1zIHRoYXQgYXJlIDEtMiANCj4geWVhcnMgb2xkLCBhbHNvIHdpdGgg
TlZNZSdzLCB3aGljaCB3ZXJlIHJ1bm5pbmcgZXh0NCBpbiB0aGUgcGFzdC4NCj4NCj4gT24g
YWxsIHN5c3RlbXMgSSBkaWQgYSBjbGVhbiBMViBhbmQgY3JlYXRlZCB0aGUgYnRyZnMgZmls
ZXN5c3RlbSB3aXRoOg0KPiBta2ZzLmJ0cmZzIC1MIGltYWdlcyAvZGV2L2x2bS1yYWlkL2lt
YWdlcw0KPg0KPiBUaGUgTFZNIHZvbHVtZXMgd2VyZSBjcmVhdGVkIG5vcm1hbGx5IHdpdGgu
Lg0KPiBwdmNyZWF0ZSAvZGV2L21kLzANCj4gdmdjcmVhdGUgbHZtLXJhaWQgL2Rldi9tZC8w
DQo+IGx2Y3JlYXRlIC0tc2l6ZSAxVCAtLW5hbWUgaW1hZ2VzIGx2bS1yYWlkDQo+DQo+DQo+
IEknbSBydW5uaW5nIG9uZSBzdWJ2b2x1bWUgZm9sZGVyIHBlciB2aXJ0dWFsIG1hY2hpbmVz
LiBFYWNoIGZvbGRlciANCj4gY29udGFpbnMgMS0yIGZpbGVzIG9mIGJldHdlZW4gMjVHIGFu
ZCA1MDBHIGluIHNpemUgd2hpY2ggYXJlIG15IHFjb3cyIA0KPiBmaWxlcy4NCj4NCj4NCj4g
SSdtIHJ1bm5pbmcgYnRyZnMtcHJvZ3MgdmVyc2lvbiA2LjcuMS0xIG9uIGFsbCBtYWNoaW5l
cyBhbmQga2VybmVsIA0KPiA2LjYuMTgsIDYuNi4xOSBvciA2LjYuMjAuIEl0IHNlZW1zIHRv
IG9jY3VyIG9uIGFsbCAzIG9mIHRoZW0uDQo+DQo+DQo+IE1vc3Qgb2YgdGhlIE5WTWUncyBh
cmUgU2Ftc3VuZ3MuLi4NCj4NCj4gTW9kZWwgTnVtYmVyOsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNBTVNVTkcgTVpRTEIxVDlIQUpSLTAwMDA3DQo+
IFNlcmlhbCBOdW1iZXI6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFM0MzlOQTBNQTAxNTkyDQo+IEZpcm13YXJlIFZlcnNpb246wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVEQTU0MDJRDQo+DQo+DQo+IEhlcmUgaXMgdGhlIG91
dHB1dCBpbiB0aGUgbG9ncyBydW5uaW5nOsKgIGJ0cmZzIHNjcnViIDxzdWJ2b2x1bWU+DQo+
DQo+IFsxNjkzNzU0LjI3NjgzNF0gQlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxl
IHRvIGZpeHVwIChyZWd1bGFyKSANCj4gZXJyb3IgYXQgbG9naWNhbCAyMTQyMjk3Nzg0MzIg
b24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgDQo+IHBoeXNpY2FsIDIxNTMx
MTkwODg2NA0KPiBbMTY5Mzc1NC40MTU1NjNdIEJUUkZTIGVycm9yIChkZXZpY2UgZG0tMSk6
IHVuYWJsZSB0byBmaXh1cCAocmVndWxhcikgDQo+IGVycm9yIGF0IGxvZ2ljYWwgMjE0NjEx
OTE4ODQ4IG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzIA0KPiBwaHlzaWNh
bCAyMTU2OTQwNDkyODANCj4gWzE2OTM3NTQuODc3Mzk5XSBCVFJGUyBlcnJvciAoZGV2aWNl
IGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIpIA0KPiBlcnJvciBhdCBsb2dpY2Fs
IDIxNjg4OTU1Njk5MiBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcyANCj4g
cGh5c2ljYWwgMjE3OTcxNjg3NDI0DQo+IFsxNjkzNzU0Ljg3ODE5NV0gQlRSRlMgd2Fybmlu
ZyAoZGV2aWNlIGRtLTEpOiBjaGVja3N1bSBlcnJvciBhdCANCj4gbG9naWNhbCAyMTY4ODk1
NTY5OTIgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMsIHBoeXNpY2FsIA0K
PiAyMTc5NzE2ODc0MjQsIHJvb3QgMjU2LCBpbm9kZSAyNTksIG9mZnNldCA0NjA3ODQ0MzUy
LCBsZW5nDQo+IHRoIDQwOTYsIGxpbmtzIDEgKHBhdGg6IFtyZWRhY3RlZF0pDQo+IFsxNjkz
NzU1LjUwMzU4Ml0gQlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVw
IChyZWd1bGFyKSANCj4gZXJyb3IgYXQgbG9naWNhbCAyMTk2NTU3NjYwMTYgb24gZGV2IC9k
ZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgDQo+IHBoeXNpY2FsIDIyMDczNzg5NjQ0OA0K
PiBbMTY5Mzc1NS41MDM2MjhdIEJUUkZTIGVycm9yIChkZXZpY2UgZG0tMSk6IHVuYWJsZSB0
byBmaXh1cCAocmVndWxhcikgDQo+IGVycm9yIGF0IGxvZ2ljYWwgMjE5NjU1NzAwNDgwIG9u
IGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzIA0KPiBwaHlzaWNhbCAyMjA3Mzc4
MzA5MTINCj4gWzE2OTM3NTUuNTA1MTQxXSBCVFJGUyB3YXJuaW5nIChkZXZpY2UgZG0tMSk6
IGNoZWNrc3VtIGVycm9yIGF0IA0KPiBsb2dpY2FsIDIxOTY1NTcwMDQ4MCBvbiBkZXYgL2Rl
di9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcywgcGh5c2ljYWwgDQo+IDIyMDczNzgzMDkxMiwg
cm9vdCAyNTcsIGlub2RlIDI2MCwgb2Zmc2V0IDM1OTQ2NDE0MDgsIGxlbmcNCj4gdGggNDA5
NiwgbGlua3MgMSAocGF0aDogW3JlZGFjdGVkXS5xY293MikNCj4gWzE2OTM3NTUuNjI3NzIy
XSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIp
IA0KPiBlcnJvciBhdCBsb2dpY2FsIDIyMDAzNzUxMzIxNiBvbiBkZXYgL2Rldi9tYXBwZXIv
bHZtLS1yYWlkLWltYWdlcyANCj4gcGh5c2ljYWwgMjIxMTE5NjQzNjQ4DQo+IFsxNjkzNzU1
LjYyODUxNV0gQlRSRlMgd2FybmluZyAoZGV2aWNlIGRtLTEpOiBjaGVja3N1bSBlcnJvciBh
dCANCj4gbG9naWNhbCAyMjAwMzc1MTMyMTYgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFp
ZC1pbWFnZXMsIHBoeXNpY2FsIA0KPiAyMjExMTk2NDM2NDgsIHJvb3QgNSwgaW5vZGUgMjY5
LCBvZmZzZXQgNzU2MjIxOTUyMCwgbGVuZ3RoDQo+IDQwOTYsIGxpbmtzIDEgKHBhdGg6IFty
ZWRhY3RlZF0vW3JlZGFjdGVkXS5xY293MikNCj4gWzE2OTM3NTYuMDcyNDU3XSBCVFJGUyBl
cnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIpIA0KPiBlcnJv
ciBhdCBsb2dpY2FsIDIyMjA2NTA2NTk4NCBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlk
LWltYWdlcyANCj4gcGh5c2ljYWwgMjIzMTQ3MTk2NDE2DQo+IFsxNjkzNzYwLjQ4ODY0MV0g
c2NydWJfc3RyaXBlX3JlcG9ydF9lcnJvcnM6IDEgY2FsbGJhY2tzIHN1cHByZXNzZWQNCj4g
WzE2OTM3NjAuNDg4NjQ1XSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8g
Zml4dXAgKHJlZ3VsYXIpIA0KPiBlcnJvciBhdCBsb2dpY2FsIDIzNjc2MDAwNjY1NiBvbiBk
ZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcyANCj4gcGh5c2ljYWwgMjM4OTE1ODc4
OTEyDQo+IFsxNjkzNzYwLjQ4OTQ1Nl0gc2NydWJfc3RyaXBlX3JlcG9ydF9lcnJvcnM6IDEg
Y2FsbGJhY2tzIHN1cHByZXNzZWQNCj4gWzE2OTM3NjAuNDg5NDg3XSBCVFJGUyB3YXJuaW5n
IChkZXZpY2UgZG0tMSk6IGNoZWNrc3VtIGVycm9yIGF0IA0KPiBsb2dpY2FsIDIzNjc2MDAw
NjY1NiBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcywgcGh5c2ljYWwgDQo+
IDIzODkxNTg3ODkxMiwgcm9vdCAyNTYsIGlub2RlIDI1OSwgb2Zmc2V0IDIyNTIzMDg0ODAs
IGxlbmcNCj4gdGggNDA5NiwgbGlua3MgMSAocGF0aDogW3JlZGFjdGVkXSkNCj4gWzE2OTM3
NjAuNjAyMzYwXSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAg
KHJlZ3VsYXIpIA0KPiBlcnJvciBhdCBsb2dpY2FsIDIzNzA5NjAwOTcyOCBvbiBkZXYgL2Rl
di9tYXBwZXIvbHZtLS1yYWlkLWltYWdlcyANCj4gcGh5c2ljYWwgMjM5MjUxODgxOTg0DQo+
IFsxNjkzNzYwLjgxNTc3NV0gQlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRv
IGZpeHVwIChyZWd1bGFyKSANCj4gZXJyb3IgYXQgbG9naWNhbCAyMzg0ODg1ODQxOTIgb24g
ZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgDQo+IHBoeXNpY2FsIDI0MDY0NDQ1
NjQ0OA0KPiBbMTY5Mzc2MC44MTY1NjhdIEJUUkZTIHdhcm5pbmcgKGRldmljZSBkbS0xKTog
Y2hlY2tzdW0gZXJyb3IgYXQgDQo+IGxvZ2ljYWwgMjM4NDg4NTg0MTkyIG9uIGRldiAvZGV2
L21hcHBlci9sdm0tLXJhaWQtaW1hZ2VzLCBwaHlzaWNhbCANCj4gMjQwNjQ0NDU2NDQ4LCBy
b290IDI1NiwgaW5vZGUgMjU5LCBvZmZzZXQgNDUyMzY1MTA3MiwgbGVuZw0KPiB0aCA0MDk2
LCBsaW5rcyAxIChwYXRoOiBbcmVkYWN0ZWRdKQ0KPiBbMTY5Mzc2MC44MTk5MjVdIEJUUkZT
IGVycm9yIChkZXZpY2UgZG0tMSk6IHVuYWJsZSB0byBmaXh1cCAocmVndWxhcikgDQo+IGVy
cm9yIGF0IGxvZ2ljYWwgMjM4NTExMzkwNzIwIG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJh
aWQtaW1hZ2VzIA0KPiBwaHlzaWNhbCAyNDA2NjcyNjI5NzYNCj4gWzE2OTM3NjAuODg3MDc0
XSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIp
IA0KPiBlcnJvciBhdCBsb2dpY2FsIDIzODc5NjYwMzM5MiBvbiBkZXYgL2Rldi9tYXBwZXIv
bHZtLS1yYWlkLWltYWdlcyANCj4gcGh5c2ljYWwgMjQwOTUyNDc1NjQ4DQo+IFsxNjkzNzYw
Ljg4NzkwNV0gQlRSRlMgd2FybmluZyAoZGV2aWNlIGRtLTEpOiBjaGVja3N1bSBlcnJvciBh
dCANCj4gbG9naWNhbCAyMzg3OTY2MDMzOTIgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFp
ZC1pbWFnZXMsIHBoeXNpY2FsIA0KPiAyNDA5NTI0NzU2NDgsIHJvb3QgMjU2LCBpbm9kZSAy
NTksIG9mZnNldCA0NTQ5NTk1MTM2LCBsZW5nDQo+IHRoIDQwOTYsIGxpbmtzIDEgKHBhdGg6
IFtyZWRhY3RlZF0pDQo+IFsxNjkzNzYwLjkxMzk1MF0gQlRSRlMgZXJyb3IgKGRldmljZSBk
bS0xKTogdW5hYmxlIHRvIGZpeHVwIChyZWd1bGFyKSANCj4gZXJyb3IgYXQgbG9naWNhbCAy
Mzg4ODkyNzEyOTYgb24gZGV2IC9kZXYvbWFwcGVyL2x2bS0tcmFpZC1pbWFnZXMgDQo+IHBo
eXNpY2FsIDI0MTA0NTE0MzU1Mg0KPiBbMTY5Mzc2MC45OTYxMDVdIEJUUkZTIGVycm9yIChk
ZXZpY2UgZG0tMSk6IHVuYWJsZSB0byBmaXh1cCAocmVndWxhcikgDQo+IGVycm9yIGF0IGxv
Z2ljYWwgMjM5MjMxNDM0NzUyIG9uIGRldiAvZGV2L21hcHBlci9sdm0tLXJhaWQtaW1hZ2Vz
IA0KPiBwaHlzaWNhbCAyNDEzODczMDcwMDgNCj4gWzE2OTM3NjAuOTk5MTIxXSBCVFJGUyBl
cnJvciAoZGV2aWNlIGRtLTEpOiB1bmFibGUgdG8gZml4dXAgKHJlZ3VsYXIpIA0KPiBlcnJv
ciBhdCBsb2dpY2FsIDIzOTI0MTM5NjIyNCBvbiBkZXYgL2Rldi9tYXBwZXIvbHZtLS1yYWlk
LWltYWdlcyANCj4gcGh5c2ljYWwgMjQxMzk3MjY4NDgwDQo+IFsxNjkzNzYxLjAwNTY4Nl0g
QlRSRlMgZXJyb3IgKGRldmljZSBkbS0xKTogdW5hYmxlIHRvIGZpeHVwIChyZWd1bGFyKSAN
Cj4gZXJyb3IgYXQgbG9naWNhbCAyMzkyNjY0MzA5NzYgb24gZGV2IC9kZXYvbWFwcGVyL2x2
bS0tcmFpZC1pbWFnZXMgDQo+IHBoeXNpY2FsIDI0MTQyMjMwMzIzMg0KPiBbMTY5Mzc2MS4w
MTE0NzZdIEJUUkZTIGVycm9yIChkZXZpY2UgZG0tMSk6IHVuYWJsZSB0byBmaXh1cCAocmVn
dWxhcikgDQo+IGVycm9yIGF0IGxvZ2ljYWwgMjM5MzIxNDgxMjE2IG9uIGRldiAvZGV2L21h
cHBlci9sdm0tLXJhaWQtaW1hZ2VzIA0KPiBwaHlzaWNhbCAyNDE0NzczNTM0NzINCj4gWzE2
OTM3NzEuMDM5NjY5XSBCVFJGUyBpbmZvIChkZXZpY2UgZG0tMSk6IHNjcnViOiBmaW5pc2hl
ZCBvbiBkZXZpZCAxIA0KPiB3aXRoIHN0YXR1czogMA0KPg0KPg0KPg0KPg0K
--------------XN0yUqZC2CAAIl30VQ2Y4jWo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hi there,</p>
    <div class=3D"moz-cite-prefix">On 3/19/24 11:05, Nigel Kukard wrote:<=
br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DU=
TF-8">
      <p>Hi there Roman,<br>
      </p>
      <div class=3D"moz-cite-prefix">On 3/2/24 15:47, Roman Mamedov wrote=
:<br>
      </div>
      <blockquote type=3D"cite" cite=3D"mid:20240302204726.6d2dcd87@nvm">=

        <pre class=3D"moz-quote-pre" wrap=3D"">On Sat, 2 Mar 2024 15:01:4=
3 +0000
Nigel Kukard <a class=3D"moz-txt-link-rfc2396E"
        href=3D"mailto:nkukard@LBSD.net" moz-do-not-send=3D"true">&lt;nku=
kard@LBSD.net&gt;</a> wrote:

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">I'm wondering if btrfs o=
ntop of LVM ontop of MD RAID1 is supported?=C2=A0=20
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Should be absolutely suppo=
rted.

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">I've managed to reproduc=
e with 100% accuracy severe data corruption=20
using this configuration on 6.6.19.

2 x 1.92T NVMe's in MD RAID1 configuration
LVM volume created ontop of the MD RAID1
btrfs filesystem on the LV

I then write about 100-200G of data. Create a snapshot. Read/write the=20
file and get these messages...
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Has the MD RAID1 finished =
its initial sync after creation?</pre>
      </blockquote>
    </blockquote>
    <p>Correct. It doesn't seem to make a difference if sync'd or not. I
      tried it on a new system about a week ago and it took a 5 days to
      manifest on that system.</p>
    <p>On this system I copied more data than the first 4 systems to try
      reproduce the issue, which is when I thought maybe all 4 systems I
      originally had the problem on had a similar issue.</p>
    <p>But after 5 days I started noticing messages in the log.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net">
      <blockquote type=3D"cite" cite=3D"mid:20240302204726.6d2dcd87@nvm">=

        <pre class=3D"moz-quote-pre" wrap=3D"">

Have you tried waiting until it finishes and only then do thewrites to se=
e if
the corruption is still observed (of course that's in no way a "workaroun=
d",
just to see what might cause the bug).</pre>
      </blockquote>
    </blockquote>
    <p>Yep, that doesn't seem to be the problem.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net">
      <blockquote type=3D"cite" cite=3D"mid:20240302204726.6d2dcd87@nvm">=

        <pre class=3D"moz-quote-pre" wrap=3D"">

Do you know any kernel versions or series where this corruption did not h=
appen?</pre>
      </blockquote>
    </blockquote>
    <p>I believe from my log searching these issues only occurred after
      updating from 6.1.56 to 6.6.18. That's the most I've been able to
      narrow it down so far.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net">
      <blockquote type=3D"cite" cite=3D"mid:20240302204726.6d2dcd87@nvm">=

        <pre class=3D"moz-quote-pre" wrap=3D"">

I assume you're not saying it appeared in 6.6.19 compared to 6.6.18.</pre=
>
      </blockquote>
    </blockquote>
    <p>My kernel jumps were all from 6.1.56 to 6.6.18/6.6.19.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net">
      <blockquote type=3D"cite" cite=3D"mid:20240302204726.6d2dcd87@nvm">=

        <pre class=3D"moz-quote-pre" wrap=3D"">

Can you try the 6.1 series? Or maybe also 6.8?</pre>
      </blockquote>
    </blockquote>
    <p>I'm not seeing any errors in my logs from 6.1.56.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net">
      <blockquote type=3D"cite" cite=3D"mid:20240302204726.6d2dcd87@nvm">=

        <pre class=3D"moz-quote-pre" wrap=3D"">

I made a Btrfs on top of LVM on top of RAID1 myself now, but on consumer =
SSDs.
Copying some files to it now, to check. Would be also helpful if you can =
find
a precise sequence of commands which can trigger the bug, less vague than=

copy some files to it and see.</pre>
      </blockquote>
    </blockquote>
    <p>Yea, after the first 4 systems that almost immediately manifested
      within 1-24 hours, subsequent tries to try reproduce it were
      unsuccessful.</p>
    <p>I tried SSD's in my lab of a similar size, 1.920Tb to no avail, I
      was unable to reproduce.</p>
    <p>I have since then provisioned multiple new servers with NVMe's
      and they have all manifested the issue within 5 or so days.</p>
    <p>I hope this helps at least a little. It seems hard to reproduce
      intentionally.</p>
    <p>-N<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:0f3a5c83-c734-4154-a43c-19bea5b1c2e4@LBSD.net">
      <blockquote type=3D"cite" cite=3D"mid:20240302204726.6d2dcd87@nvm">=

        <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      </blockquote>
      <p>I'm now absolutely convinced this is some kind of a bug.</p>
      <p>Over the past 2 weeks I've migrated a number of libvirtd qcow2
        files over to btrfs filesystems, and on every single system with
        NVMe's with LVM ontop of MD I'm getting errors like the below.<br=
>
      </p>
      <p>I'm not sure if its relevant, but the VM's run weekly TRIM's on
        their disks. The host system also runs weekly TRIM's.</p>
      <p>The first time I mentioned above was with new systems I
        installed on brand new disks. I'm now seeing the same issue on
        systems that are 1-2 years old, also with NVMe's, which were
        running ext4 in the past.</p>
      <p>On all systems I did a clean LV and created the btrfs
        filesystem with:<br>
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
          Number:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
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
      [1693760.488641] scrub_stripe_report_errors: 1 callbacks
      suppressed<br>
      [1693760.488645] BTRFS error (device dm-1): unable to fixup
      (regular) error at logical 236760006656 on dev
      /dev/mapper/lvm--raid-images physical 238915878912<br>
      [1693760.489456] scrub_stripe_report_errors: 1 callbacks
      suppressed<br>
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
      [1693771.039669] BTRFS info (device dm-1): scrub: finished on
      devid 1 with status: 0<br>
      <br>
      <br>
      <br>
      <p><br>
      </p>
    </blockquote>
  </body>
</html>

--------------XN0yUqZC2CAAIl30VQ2Y4jWo--

--------------Xb0SyiIZTlwenbQYnIJad3mQ--

--------------YB4E5dtWBzlq33j0iGcOD0L0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT5M4N3g4xfUCNXIu76GXFSvoUHMwUCZfmSnQUDAAAAAAAKCRD6GXFSvoUHM3VI
AQDISuuNIJFFACQEtZAahR9cjZ4xfIqTU7lspJXV+VSkfgEAobZ+u6+GldGzIz0Ozw5ZaHmM9E0I
g4KaY4Tx5D7tNw8=
=Ok+3
-----END PGP SIGNATURE-----

--------------YB4E5dtWBzlq33j0iGcOD0L0--

