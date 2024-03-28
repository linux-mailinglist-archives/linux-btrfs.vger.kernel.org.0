Return-Path: <linux-btrfs+bounces-3700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CD588FA0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1341C2B05A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93E451C3F;
	Thu, 28 Mar 2024 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="s01G+tC2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC941757
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614994; cv=none; b=JodnyfSuFDJYao1ulZBVR9FF5u4zrfzIRYOYI1NKr64ig8AabLayC8MZwYjqxAhDqzLmlu+0e+0sfmQskgiNw12KpgP6ml2FaH12a6I8iPDuuieqZ1/PvdEnlDKcevxO86mdyfEgkEvIWiGKuNZojStRgk3A0aZ4w0KRWOhouUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614994; c=relaxed/simple;
	bh=5nyZVynpnJ0l476wzz5l51GjVH/2/gsLuqo/pKSqzFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VE3h+wzAXI9QM8fh1uFVlXMm33SWK0qB6E4/XUThiDPo5EMOkwN4J+Vb53rKs9PAMb4LmOeIjkWXqGXVBlVw818dniBCaOfvloYWMk8YUh0ZOfJMiMEg/ibYL0NOIh03s5Q7Fc5IXOCpM8KQoXexwWmWgU+LLYeWnM8CpqZSCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=s01G+tC2; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1711614979;
	bh=5nyZVynpnJ0l476wzz5l51GjVH/2/gsLuqo/pKSqzFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=s01G+tC2446QgmdP/eKlRYsHlglozCzQL41S2NY5t0BuPd+iD/gKH07TTi0DAJ0cp
	 40Ebf6ug7X0vE9kDIFyYAUAl2zPWY73WtZOwSkdZNi+VWwyONqkaJLkflYEnNOWStk
	 6E+skZpFS3gcr+HDN9VdBSkQvRthciYQuk6y60bM=
X-QQ-mid: bizesmtpip2t1711614977t739h8r
X-QQ-Originating-IP: OUoksUbJfQ/qK75OzKwDK6bCLw62A63cy6eLeekWxtA=
Received: from [IPV6:240e:381:70b1:9300:f449:c ( [255.130.111.6])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Mar 2024 16:36:16 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: 7YFKcddXaggVtVjtJ4rFC1hGwbwI5eEhsybzBlC7FWAqgn9GXgRj9YqDV2Z8v
	gJ50N/I9twNJNWyX8lnKwGM8FwLnrO8m9v17WLXs8Mp+KKHgXdsGXrwmY3DaZ0HPPPO29tP
	oJi/PzMqEsN08lDpXaOCCWybt5Ec4r9mIdc/gbCSJFFTbnPwER8MubO7VGYPVjt9IY60e63
	JCAI3DAIhXC+Kke+jJje3NLr1HQA3IcjDTj/RpRB0ORZHJqOzG8XhGEeYxD37Hj38TotPaj
	Ev/VDIa86l4OlBN+diOB+NaJcB0/spwttVByNnBNlEeNuRRvQOLf8XQ+p4cLAlDX4tac+Ek
	N+z/hmlWDsPQTeiop1ya6r/wDKwaVrdl2qxGkW7
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15920724999225819099
Message-ID: <9CDE04332C1A2808+92fd6a46-6e18-47e0-b114-10a648e251b7@bupt.moe>
Date: Thu, 28 Mar 2024 16:36:13 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I/O blocked after booting
To: "Massimo B." <massimo.b@gmx.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------09wg0P9lOG0uQUEhQTBaHdes"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------09wg0P9lOG0uQUEhQTBaHdes
Content-Type: multipart/mixed; boundary="------------jcRA3V89KFX0GMSE0zzLg08S";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: "Massimo B." <massimo.b@gmx.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <92fd6a46-6e18-47e0-b114-10a648e251b7@bupt.moe>
Subject: Re: I/O blocked after booting
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
In-Reply-To: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>

--------------jcRA3V89KFX0GMSE0zzLg08S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

5ZyoIDIwMjQvMy8yMSAyMToxMywgTWFzc2ltbyBCLiDlhpnpgZM6DQo+IEhlbGxvIGV2ZXJ5
Ym9keSwNCj4NCj4gSSBoYXZlIHRoaXMgaXNzdWUgc2luY2UgeWVhcnMgb24gYWxsIG15IGRl
c2t0b3AgbWFjaGluZXMgKGJ1dCB3aXRoIGFsbW9zdA0KPiBpZGVudGljYWwgZGlzdHJpYnV0
aW9uIGFuZCBjb25maWd1cmF0aW9ucyk6DQo+DQo+IFNvbWV0aW1lcyB3aGVuIGJvb3Rpbmcg
dGhlIHN5c3RlbSwgaXQgY29tZXMgdXAgdW50aWwgdGhlIHdpbmRvdyBtYW5hZ2VyIHdpdGgN
Cj4gbG9naW4gc2NyZWVuIGFwcGVhcnMuIEJ1dCBubyBmdXJ0aGVyIGxvZ2luIGlzIHBvc3Np
YmxlLiBUcnlpbmcgdG8gbG9naW4gdmlhDQo+IHZpcnR1YWwgdGVybWluYWxzLCBTU0ggb3Ig
dHJ5aW5nIHRvIHJlYm9vdCwgaXQgYXBwZWFycyB0aGF0IGFsbCBJL08gdG8gdGhlIGJ0cmZz
DQo+IGlzIGJsb2NrZWQuIEFsc28gd2FpdGluZyBmb3IgfjIwIG1pbnV0ZXMgZG9lc24ndCBo
ZWxwIHRoZSBmaWxlc3lzdGVtIGlzDQo+IGJsb2NraW5nLg0KDQpTaW5jZSB5b3UgY2FuIGhh
dmUgbG9naW4gc2NyZWVuLCBidHJmcyBoYWQgcmVhZCBhbGwgcHJvZ3JhbXMsIHRodXMgZG9u
ZSANCmVmZmVjdGl2ZSBJTy4NCg0KV2h5IGRvIHlvdSB0aGluayBsb2dpbiBpc3N1ZSBpcyBk
dWUgdG8gYnRyZnMgSS9PPyBhbnkgbG9ncz8NCg0KPiBJIHRob3VnaHQgdGhhdCBtaWdodCBo
YXBwZW4gb24gdW5jbGVhbiBzaHV0ZG93bnMgb3Igc3R1ZmYuIEJ1dCBpdCdzIG5vdA0KPiBy
ZXByb2R1Y2libGUgYW5kIGFsc28gY2xlYW4gc2h1dGRvd25zIHNvbWV0aW1lcyBsZWFkIHRv
IHRoZSBzYW1lIGlzc3VlLg0KPg0KPiBGaXJzdCBJIHRob3VnaHQgaXQncyBzb21lIG9mIHRo
ZSBidHJmc21haW50ZW5hbmNlIGpvYnMuIFNvIGZpbmFsbHkgSSBkaXNhYmxlZA0KPiBhbGwg
b2YgdGhlbToNCj4NCj4gIyBncmVwIFBFUklPRCAvZXRjL2RlZmF1bHQvYnRyZnNtYWludGVu
YW5jZQ0KPiBCVFJGU19ERUZSQUdfUEVSSU9EPSJub25lIg0KPiBCVFJGU19CQUxBTkNFX1BF
UklPRD0ibm9uZSINCj4gQlRSRlNfU0NSVUJfUEVSSU9EPSJtb250aGx5Ig0KPiBCVFJGU19U
UklNX1BFUklPRD0ibm9uZSINCj4NCj4gTm8gc3VjY2Vzcy4NCj4NCj4gV2hhdCBJIGNhbiBj
b25maXJtLCBhZnRlciBkb2luZyBhIGZvcmNlZCByZWJvb3QgYnkgaG9seSBTWVNSUSBzZXJp
ZXMgUixFLEksUyxVLEINCj4gdGhlIG5leHQgc3RhcnR1cCBpcyBhbHdheXMgZmluZSBhbmQg
Z2V0cyBhIHdvcmtpbmcgYnRyZnMuDQo+IFRoZW4gdGhlIGZpcnN0IGxpbmUgb24gdGhlIHNj
cmVlbiBiZWZvcmUgZG9pbmcgdGhlIHJlYm9vdCBhcmU6DQo+DQo+IHN5c3JxOiBLZXlib2Fy
ZCBtb2RlIHNldCB0byBzeXN0ZW0gZGVmYXVsdA0KPiBzeXNycTogVGVybWluYXRlIEFsbCBU
YXNrcw0KPiBlbG9naW5kLWRhZW1vbls0NDgxXTogUmVjZWl2ZWQgc2lnbmFsIDE1IFtURVJN
XQ0KPg0KPiBCVFJGUyBpbmZvIChkZXZpY2UgZG0tMik6IGZpcnN0IG1vdW50IG9mIGZpbGVz
eXN0ZW0gMWQ2NzctLi4uLi4NCj4gQlRSRlMgaW5mbyAoZGV2aWNlIGRtLTIpOiB1c2luZyBj
cmMzMmMgKGNyYzMyYy1pbnRlbCBjaGVja3N1bSBhbGdvcml0aG0NCj4gQlRSRlMgaW5mbyAo
ZGV2aWNlIGRtLTIpOiBmb3JjZSB6c3RkIGNvbXByZXNzaW9uLCBsZXZlbCAxNQ0KPiBCVFJG
UyBpbmZvIChkZXZpY2UgZG0tMik6IHVzaW5nIGZyZWUgc3BhY2UgdHJlZQ0KPiBCVFJGUyB3
YXJtb21nIChkZXZpY2UgZG0tMCk6IGZhaWxlZCB0byB0cmltIDMwIGJsb2NrIGdyb3VwKHMp
LCBsYXN0IGVycm9yIC01MTINCj4gQlRSRlMgd2FybW9tZyAoZGV2aWNlIGRtLTApOiBmYWls
ZWQgdG8gdHJpbSAxIGRldmljZShzKSwgbGFzdCBlcnJvciAtNTEyDQo+DQo+IEkgZ3Vlc3Mg
dGhpcyBkbS0wIGlzIG15IG1haW4gYnRyZnMgb24gUENJZSBOVk1lLg0KPg0KPiBXaGVuIHN1
Y2Nlc3NmdWxseSBtb3VudGVkIHRoZSBtb3VudCBsb29rcyBsaWtlIHRoaXM6DQo+DQo+IC9k
ZXYvbWFwcGVyL2x1a3MtODAxLi4uIG9uIC8gdHlwZSBidHJmcyAocncsbm9hdGltZSxub2Rp
cmF0aW1lLGNvbXByZXNzLQ0KPiBmb3JjZT16c3RkOjMsc3NkLGRpc2NhcmQ9YXN5bmMsbm9h
Y2wsc3BhY2VfY2FjaGU9djIsc3Vidm9saWQ9NTI0LHN1YnZvbD0vdm9sdW1lcw0KPiAvcm9v
dCkNCj4NCj4gQ3VycmVudCBrZXJuZWwgaXMgNi42LjEzLWdlbnRvbywgdGhvdWdoIEkgZG9u
J3QgdGhpbmsgdGhhdCBpcyBpbXBvcnRhbnQgYXMgSQ0KPiBoYXZlIHRoZSBpc3N1ZSBmb3Ig
eWVhcnMgd2l0aCBhbGwgcHJldmlvdXMga2VybmVscy4NCj4gSSdtIG5vdCBvbmx5IHVzaW5n
IHRoZSBzZWxmLWNvbmZpZ3VyZWQga2VybmVsIGZyb20gZ2VudG9vLXNvdXJjZXMgYnV0IGFs
c28gYQ0KPiB1bml2ZXJzYWwgYmluYXJ5IDYuNi4xNi1nZW50b28tZGlzdC4NCj4NCj4gSSB0
aG91Z2h0LCBtYXliZSBteSBidHJiayBydW4gYnkgY3JvbiBjb3VsZCBiZSB0aGUgY3VscHJp
dC4gTG9va2luZyBhdCB0aGUNCj4gc3lzbG9ncywgYmVmb3JlIHRoZSBibG9ja2VkIEkvTyBJ
IHNlZSBzb21lIHZlcnkgbGFzdCBsaW5lcyBpbiB0aGUgbG9nLCB3aGVyZQ0KPiBidHJiayB3
YXMgc3RhcnRlZC4gUmlnaHQgYWZ0ZXIgdGhhdCB0aGUgbmV4dCBsaW5lIGlzIHRoZSBuZXh0
IGJvb3Q6DQo+DQo+IE1hciAxOSAwNzo0Mzo0MCBbY2hyb255ZF0gU3lzdGVtIGNsb2NrIHdy
b25nIGJ5IC0zLjIyNzM5NiBzZWNvbmRzDQo+IE1hciAxOSAwNzo0Mzo0MCBbY2hyb255ZF0g
U3lzdGVtIGNsb2NrIHdhcyBzdGVwcGVkIGJ5IC0zLjIyNzM5NiBzZWNvbmRzDQo+IE1hciAx
OSAwNzo0NDowMCBbZmNyb25dIHBhbV91bml4KGZjcm9uOnNlc3Npb24pOiBzZXNzaW9uIG9w
ZW5lZCBmb3IgdXNlciBjbGFtYXYodWlkPTEzMCkgYnkgKHVpZD0wKQ0KPiBNYXIgMTkgMDc6
NDQ6MDAgW2Zjcm9uXSBKb2IgJ2ZhbmdmcmlzY2ggLWMgL2V0Yy9mYW5nZnJpc2NoLmNvbmYg
cmVmcmVzaCcgc3RhcnRlZCBmb3IgdXNlciBjbGFtYXYgKHBpZCA0OTc3KQ0KPiBNYXIgMTkg
MDc6NDQ6MDAgW2Zjcm9uXSBKb2IgJ2lvbmljZSAtYyAzIHNjaGVkdG9vbCAtRCAtZSBidHJi
ayAtYyAvZXRjL2J0cmJrL2J0cmJrLmNvbmYgcnVuIGNyb24gJiYgL3Vzci9sb2NhbC9iaW4v
MXVwZGF0ZV9idHJia3NuYXBzaG90bGlua3MgLWMgL2V0Yy9idHJiay9idHJiay5jb25mIC9t
bnQvYXJjaGl2ZS8qLyogLyAodHJ1bmNhdGVkKQ0KPiBNYXIgMTkgMDc6NDQ6MDAgW2Zjcm9u
XSBKb2IgJ3J1bi1wYXJ0cyAvZXRjL2Nyb24uZGFpbHknIHN0YXJ0ZWQgZm9yIHVzZXIgc3lz
dGFiIChwaWQgNDk4NCkNCj4gTWFyIDE5IDA3OjQ0OjAwIFtmY3Jvbl0gSm9iICdydW4tcGFy
dHMgL2V0Yy9jcm9uLndlZWtseScgc3RhcnRlZCBmb3IgdXNlciBzeXN0YWIgKHBpZCA0OTg3
KQ0KPiBNYXIgMTkgMDc6NDc6MzIgW2tlcm5lbF0gTGludXggdmVyc2lvbiA2LjYuMTMtZ2Vu
dG9vIChyb290QGdlbnRvbykgKGdjYyAoR2VudG9vIDEzLjIuMV9wMjAyMzA4MjYgcDcpIDEz
LjIuMSAyMDIzMDgyNiwgR05VIGxkIChHZW50b28gMi40MCBwNykgMi40MC4wKSAjMSBTTVAg
UFJFRU1QVF9EWU5BTUlDIE1vbiBKYW4gMjIgMTE6MTE6MTUgQ0VUIDIwMjQNCj4NCj4gQWN0
dWFsbHkgYnRyYmsgd29ya3MgZmluZSB3aGVuIHRoZSBzeXN0ZW0gaXMgdXAgYW5kIHJ1bm5p
bmcsIGVpdGhlciBzdGFydGVkDQo+IG1hbnVhbGx5IG9yIGZyb20gdGhlIGNyb24gam9iLiBX
aGF0IGNvdWxkIGhhcHBlbiB0byBibG9jayBhbGwgYnRyZnMgSU8/IEhvdyBjYW4NCj4gSSBk
ZWJ1ZyB0aGF0Pw0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IE1hc3NpbW8NCj4NCg==

--------------jcRA3V89KFX0GMSE0zzLg08S--

--------------09wg0P9lOG0uQUEhQTBaHdes
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZgUr/QAKCRBLkKfpYfpB
U3PXAP4+YfI231efc9SYIwTeOcVYTWX1z9c2QY1Oh9pelLsj3AEA8y/3JLJaqdG2
G6KUAcMGDR8Bq1Z4Ib/QgqAy4Nq7pQc=
=xlSI
-----END PGP SIGNATURE-----

--------------09wg0P9lOG0uQUEhQTBaHdes--

