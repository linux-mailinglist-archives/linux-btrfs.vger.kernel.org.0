Return-Path: <linux-btrfs+bounces-10212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278B9EBF2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 00:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6292D161136
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 23:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED91F1936;
	Tue, 10 Dec 2024 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="fD/7mcye"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C02451E6
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872531; cv=none; b=l3K1tmASkln5cvCJed7RZrNuN0gAfWqKwBcdqjWbeM3o2RQFKpNfjHvgmpdEMo5OYCRZUsQ/gZBgcRdFX4ar6n0A92XlhPXtHg2vvoRDqsr3AGlErLLo/R4xFUSBXqsGRfsQv342Dke1fw1vHJGOJX45oPCrVpNTL/x2sOGN2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872531; c=relaxed/simple;
	bh=u4Il9+xxGicXDHqjmrzJsvT+nzVB5mzs4G3HfHr9Rd0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=g2oRnKS1LR6bg6ws7OQVZGbqvVdWSKYNNLOpZ21hafcmMR2hqH2pdKtnHCssdPYT7mYxXOCEuYPAHhUzi0IX3q9yYi8qR60GnleVP/5n3jtvHq6ux7iOgJM/8mX8gGVOcFnzIOVvq3fhRk8Afa0hnQ3duI2q57ZXIvm59zRbDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=fD/7mcye; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1733872516;
	bh=u4Il9+xxGicXDHqjmrzJsvT+nzVB5mzs4G3HfHr9Rd0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=fD/7mcyeLncZ7wc2mktB0cVlHVh/nm82QCsVtaLzcNALtDwl/NcEFzCUT9OWn7ZpS
	 oLrIcc4cjwVKSJfgJ45n/WyM02a39oRoXyd3QDL+ld5tSZqtEteAIVSFAdvf2vRCPx
	 H3TZoxuuX06TpvcJMtOCLbQa4T6ZuSpCDqMY58wQ=
X-QQ-mid: bizesmtp86t1733872515t7f9ezrv
X-QQ-Originating-IP: isZrETbNWZaN1KFBH7mwR64awOXKYDO9fKxxfx56Taw=
Received: from [192.168.0.108] ( [222.175.67.174])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 07:15:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5262294328133391497
Message-ID: <A7749CD52DC078B3+add53c37-c637-4676-ae77-90df2e3a0348@bupt.moe>
Date: Wed, 11 Dec 2024 07:14:51 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Yuwei Han <hrx@bupt.moe>
Subject: [BUG?] extremely poor performance on zoned after bulk write
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UP1sac9cPOVexMX2RXAk2I8q"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MO50cSY1dexwL/fCD9+fQmTDmFBMpVuK0WJM1ZZWP+tY4FDd/DDrKFam
	ty/suBCpDIIt5EG/NwrPZ3xclOYV3Fr1Id2wpkNf/Nk613bpBpmfwUCKlXAEwdGMMQBQnQp
	LTdFGYPMoyE7jC+LXCcsSZE5ngFhoGLrZ4AxutF3yuSTDrAik8Vp60s18UmSU8F8HK8iIDQ
	jODjrr8lzcY1nT8tOFB50iSY+J2SpDz5R/mBee6yb5N7V/pJ08iXJN0KxMOAybzajZxEJH4
	AtA3BMFDUOAeufc4PgE0vsuKO5iehlPDMeApVKEbce6yCag3gAT8jYpcRqriRaaxUahEe8z
	pq47G3k0vTG+tBsk5D4zjsvkFOBdKmjUyWfCg5DSzVllKf6uX7auj2kOF6iYOgnxf6+9HNW
	uIMBCD2iLaB8iX5uZgvuv4sZNEmvpIoGmiRPUPrRfyR2mWafsTftqBBq6V1mbJu8/mnVREe
	Hlv6vJipEforR5vKfEAmEDYmQrqFP8V8p5DsfGX6HL/vLcMTsbhR8monV7CRa/j/4QeVQPZ
	22w/Q9Fzya2HEG3iK4xB80UtYIEyUiwBZIJFya/dRgNnnfXG3TevHbOY+7a/2DYgPGx/NMX
	+Pe4t8vcKvd/NyzXfDoZ9c5qB2//XMBP63kQJfYGvA+TkTBPuHtmj/MkxqTkoZqpVPxpxXB
	e9ntvRzGFeO5XK32PjV9JgPShAfnpb0YVwdNLyrp7V6XMG86o4rWW/l81np/OL63RzUXRng
	RDXWd1NG0AGcoYBmyo76Vw8XM5ajqgm2k77RayIjLST5dDPxCMioahaAX73N+jHpVWrWE23
	XPDPy8lVsNzMNy8WBdYNxpxA7Iu0CFLJ5B9/teEM92jiK19l3k8nmqnLh2NFjT9j0CaZSxu
	99BFBPpuLKWsPYcnQ61bOdpZM0nj2VG5JmlgxT7zPyZPXiH25ITQ+9zXzM60GwC5pW6vGG0
	LRhf3btXXQqgsmA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UP1sac9cPOVexMX2RXAk2I8q
Content-Type: multipart/mixed; boundary="------------0zO1iei9rGoSJJXylMSg8skx";
 protected-headers="v1"
From: Yuwei Han <hrx@bupt.moe>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <add53c37-c637-4676-ae77-90df2e3a0348@bupt.moe>
Subject: [BUG?] extremely poor performance on zoned after bulk write

--------------0zO1iei9rGoSJJXylMSg8skx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQpJIGhhdmUgYSB6b25lZCBidHJmcyBvbiBITS1TTVIgZHJpdmVzLiBJIGhhdmUgY29w
aWVkIGEgYnVsayBvZiBmaWxlcyANCihhcm91bmQgM1RpQikgdG8gaXQgYW5kIHN0YXJ0ZWQg
cmVjaGVjayAocWJpdHRvcnJlbnQpIG9uIHRoZW0gd2hpY2ggDQppbnRyb2R1Y2VkIGh1Z2Ug
cmVhZCBvcGVyYXRpb24uIFdoZW4gaXQgd2FzIHJlYWRpbmcsIEkgZm91bmQgdGhhdCANCm1l
dGFkYXRhIG9wZXJhdGlvbnMgKGxpa2UgbHMsY2hvd24pIGFyZSBleHRyZW1lbHkgc2xvdyBi
dXQgY2FuIGJlIGZpbmlzaGVkLg0KZG1lc2cgc2hvd3MgdGhpczoNCg0KWy4uLl0NCls2MTQz
NjcuMTIzMjgzXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogcmVjbGFpbWluZyBjaHVuayAz
MTM3NTAwNDUzMjczNiANCndpdGggMSUgdXNlZCA5OCUgdW51c2FibGUNCls2MTQzNjcuMTMx
OTg5XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogcmVsb2NhdGluZyBibG9jayBncm91cCAN
CjMxMzc1MDA0NTMyNzM2IGZsYWdzIG1ldGFkYXRhfGR1cA0KWzYxNDM5My4wOTkwOTZdIEJU
UkZTIGluZm8gKGRldmljZSBzZGEpOiBmb3VuZCAyODEgZXh0ZW50cywgc3RhZ2U6IG1vdmUg
DQpkYXRhIGV4dGVudHMNCls2MTQzOTQuNzAyMTkyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2Rh
KTogcmVjbGFpbWluZyBjaHVuayAzMTM3NDczNjA5NzI4MCANCndpdGggMTIlIHVzZWQgODcl
IHVudXNhYmxlDQpbNjE0Mzk0LjcxMDk2Ml0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6IHJl
bG9jYXRpbmcgYmxvY2sgZ3JvdXAgDQozMTM3NDczNjA5NzI4MCBmbGFncyBtZXRhZGF0YXxk
dXANCls2MTQ0NTcuNzgzMDEwXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogZm91bmQgMjEw
NCBleHRlbnRzLCBzdGFnZTogbW92ZSANCmRhdGEgZXh0ZW50cw0KWzYxNDQ3NS4zMTk1MTZd
IEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiByZWNsYWltaW5nIGNodW5rIDI2NTg4ODAwMzUy
MjU2IA0Kd2l0aCAyMyUgdXNlZCA3NiUgdW51c2FibGUNCls2MTQ0NzUuMzI4Mjg4XSBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RhKTogcmVsb2NhdGluZyBibG9jayBncm91cCANCjI2NTg4ODAw
MzUyMjU2IGZsYWdzIG1ldGFkYXRhfGR1cA0KWzYxNDU4Mi41MzgwNzRdIEJUUkZTIGluZm8g
KGRldmljZSBzZGEpOiBmb3VuZCAzOTEwIGV4dGVudHMsIHN0YWdlOiBtb3ZlIA0KZGF0YSBl
eHRlbnRzDQpbNjE0NTkyLjY0NjI2NV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6IHJlY2xh
aW1pbmcgY2h1bmsgMzEzNzI1ODg2MTM2MzIgDQp3aXRoIDIwJSB1c2VkIDc5JSB1bnVzYWJs
ZQ0KWzYxNDU5Mi42NTUwNDVdIEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiByZWxvY2F0aW5n
IGJsb2NrIGdyb3VwIA0KMzEzNzI1ODg2MTM2MzIgZmxhZ3MgbWV0YWRhdGF8ZHVwDQpbNjE0
OTIyLjA2ODU1NF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6IGZvdW5kIDMzMTUgZXh0ZW50
cywgc3RhZ2U6IG1vdmUgDQpkYXRhIGV4dGVudHMNCls2MTQ5NzIuMDY0NzMxXSBCVFJGUyBp
bmZvIChkZXZpY2Ugc2RhKTogcmVjbGFpbWluZyBjaHVuayAzMTM3Njg4MzU4MDkyOCANCndp
dGggMiUgdXNlZCA5NyUgdW51c2FibGUNCls2MTQ5NzIuMDczNDE4XSBCVFJGUyBpbmZvIChk
ZXZpY2Ugc2RhKTogcmVsb2NhdGluZyBibG9jayBncm91cCANCjMxMzc2ODgzNTgwOTI4IGZs
YWdzIG1ldGFkYXRhfGR1cA0KWzYxNTAwMC45NjU3OTldIEJUUkZTIGluZm8gKGRldmljZSBz
ZGEpOiBmb3VuZCAzNjYgZXh0ZW50cywgc3RhZ2U6IG1vdmUgDQpkYXRhIGV4dGVudHMNCls2
MTUwMDEuOTMxODc0XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogcmVjbGFpbWluZyBjaHVu
ayAzMTM3Nzk1NzMyMjc1MiANCndpdGggMjElIHVzZWQgNzglIHVudXNhYmxlDQpbNjE1MDAx
Ljk0MDY4Ml0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6IHJlbG9jYXRpbmcgYmxvY2sgZ3Jv
dXAgDQozMTM3Nzk1NzMyMjc1MiBmbGFncyBtZXRhZGF0YXxkdXANCls2MTUzMTguOTExMjE1
XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogZm91bmQgMzQ3OSBleHRlbnRzLCBzdGFnZTog
bW92ZSANCmRhdGEgZXh0ZW50cw0KWy4uLl0NCg0KYW5kIGxvdHMgb2YgdGhpcy4gYnV0IGl0
IHNlZW1zIGFsd2F5cyBkb2luZyB0aGlzLg0KYnRyZnMgZmkgdXNhZ2UgL2RhdGExOg0KdmVy
YWxsOg0KICAgICBEZXZpY2Ugc2l6ZToJCSAgMTIuNzNUaUINCiAgICAgRGV2aWNlIGFsbG9j
YXRlZDoJCSAgMTEuMDVUaUINCiAgICAgRGV2aWNlIHVuYWxsb2NhdGVkOgkJICAgMS42OVRp
Qg0KICAgICBEZXZpY2UgbWlzc2luZzoJCSAgICAgMC4wMEINCiAgICAgRGV2aWNlIHNsYWNr
OgkJICAgICAwLjAwQg0KICAgICBEZXZpY2Ugem9uZSB1bnVzYWJsZToJIDEwOS45N0dpQg0K
ICAgICBEZXZpY2Ugem9uZSBzaXplOgkJIDI1Ni4wME1pQg0KICAgICBVc2VkOgkJCSAgMTAu
OTJUaUINCiAgICAgRnJlZSAoZXN0aW1hdGVkKToJCSAgIDEuNzhUaUIJKG1pbjogOTU3LjY0
R2lCKQ0KICAgICBGcmVlIChzdGF0ZnMsIGRmKToJCSAgIDEuNzhUaUINCiAgICAgRGF0YSBy
YXRpbzoJCQkgICAgICAxLjAwDQogICAgIE1ldGFkYXRhIHJhdGlvOgkJICAgICAgMi4wMA0K
ICAgICBHbG9iYWwgcmVzZXJ2ZToJCSA1MTIuMDBNaUIJKHVzZWQ6IDgwLjAwS2lCKQ0KICAg
ICBNdWx0aXBsZSBwcm9maWxlczoJCSAgICAgICAgbm8NCg0KRGF0YSxzaW5nbGU6IFNpemU6
MTEuMDBUaUIsIFVzZWQ6MTAuOTFUaUIgKDk5LjE2JSkNCiAgICAvZGV2L3NkYQkgIDExLjAw
VGlCDQoNCk1ldGFkYXRhLERVUDogU2l6ZToyMS43NUdpQiwgVXNlZDo1LjU4R2lCICgyNS42
NSUpDQogICAgL2Rldi9zZGEJICA0My41MEdpQg0KDQpTeXN0ZW0sRFVQOiBTaXplOjI1Ni4w
ME1pQiwgVXNlZDo0LjY3TWlCICgxLjgyJSkNCiAgICAvZGV2L3NkYQkgNTEyLjAwTWlCDQoN
ClVuYWxsb2NhdGVkOg0KICAgIC9kZXYvc2RhCSAgIDEuNjlUaUINCg0KVXNlZCBtZXRhZGF0
YSBpcyBhbHNvIGFyb3VuZCAyNSUgbm90IGluY3JlYXNpbmcuDQoNCmtlcm5lbCB2ZXJzaW9u
IHN0cmluZzogTGludXggYW9zYzNhNiA2LjExLjEwLWFvc2MtbWFpbiAjMSBTTVAgDQpQUkVF
TVBUX0RZTkFNSUMgU3VuIERlYyAgMSAxMToyNjozMiBVVEMgMjAyNCBsb29uZ2FyY2g2NCBH
TlUvTGludXgNCg0K

--------------0zO1iei9rGoSJJXylMSg8skx--

--------------UP1sac9cPOVexMX2RXAk2I8q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZ1jLbAAKCRBLkKfpYfpB
UxnUAQDw5yv2BGzjY1JauI/007ZqLCNl4mw5SnopZP7i53c7rQEA31oYX4rSK6zP
pctWIjqNZNuKibffD2Y3omzGFcfqwgw=
=Qu5W
-----END PGP SIGNATURE-----

--------------UP1sac9cPOVexMX2RXAk2I8q--


