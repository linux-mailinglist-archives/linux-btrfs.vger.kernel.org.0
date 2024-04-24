Return-Path: <linux-btrfs+bounces-4505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA2A8B0144
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 07:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2797C284288
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 05:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624E2156873;
	Wed, 24 Apr 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="hA48lR2H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EA13CFAD
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 05:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937613; cv=none; b=j6jm9I0Faq93gt2Rhq9uZ6RWbEtXGwVAP9BhNBdhwnZTZOVPAs/1aOJuc61JjtAk4+t95PAE2raaSzgujtDMPLlpBsT3iF6fZRAuAUpBUvCHU5PfffYs+wmrY3nTjfma/c3w7pnHdllOWuFR4nO0j0b7OkcSLAtWaIPWCXlg7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937613; c=relaxed/simple;
	bh=s9w40z+nhCV+GkEhIzmpgP24Dql2UVDimlAle4gJD8Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mk4qdlzDmOIJ87GkQpd64X6eFv4sfZx/vhi3nEA80YnrSL2uMYDxHocBdL6U0jI77+YeChBg3gFRtnZsQRA16dRmHyabYSFx9Q/ovpV5QRpC+PELsamK4ua/Xx0AtKnDyN3zfMlXHSYxSNPjanqiY34Qt1oSqS3NzA0UVUruM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=hA48lR2H; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1713937607;
	bh=s9w40z+nhCV+GkEhIzmpgP24Dql2UVDimlAle4gJD8Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=hA48lR2HtT/B123vQlEGVBfPcWl6j1gdj0wZsoNx8Hth7Dt0SxAPnVN/6FtdQmYi7
	 TSulocymFsqbr99sJz6oZblN5aDK2rUHEIyiabuuFS1IIgIQaxMznl481GsB7bo20i
	 yvAyh2fzXVlaSEHewkKtBrLJvPxdlnQrRiGqdq/k=
X-QQ-mid: bizesmtpsz4t1713937525t3hf8z3
X-QQ-Originating-IP: sAbFFudxh9pWL5osy3p8EP98KBRzPlhpxszgCJeXtTI=
Received: from [192.168.1.5] ( [223.150.241.123])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 13:45:24 +0800 (CST)
X-QQ-SSF: 01100000000000E0Z000000A0000000
X-QQ-FEAT: FgQwkxey2E5MRptkTBMX/XhWzeyJIHB3kLcgw/YRdItky5r+OT4HXpiYqMN8x
	83AGOcllWuSIoadozf0o2vmVJykS2MmSTiPR4d4UdytrlUD4RAZo5hxv8EWTqHnDT18zz7j
	QB0Dwr8fFIuQJFRMwUQRAj08izBdjhCAWZfps0qdZSE6eGoO1JGWnatAAolgobffwNQxhpd
	ZnUzW/d4jfVcHppx/bVZ8Y/v5/YNRm9mbRwufAuo96eGbpAZyGfSpJ6bVpbBrJbFGE2rWJI
	u1ALAmknSW9ovcB13MsRsSg52hzkqrIS4F91TxjRPs5320EZNd5e1LzmMcKOfBPYtiQczc7
	1ooMsDJztSJ2Mi4XiEna94jrtw0ffc6pw3842Di
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16391282065916029165
Message-ID: <46FCC719DD77BA7B+fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
Date: Wed, 24 Apr 2024 13:45:24 +0800
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
Subject: mkfs.btrfs enabled RST by default casuing unable to mount on stable
 kernel
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------h6ogTsg4JfTQpsObi12nGc25"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------h6ogTsg4JfTQpsObi12nGc25
Content-Type: multipart/mixed; boundary="------------OWzfONlEtoFnJQt0OeU2SjYI";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
Subject: mkfs.btrfs enabled RST by default casuing unable to mount on stable
 kernel

--------------OWzfONlEtoFnJQt0OeU2SjYI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksIGFsbC4NCg0KSSBoYXZlIGZvdW5kIGluY29tcGF0aWJpbGl0eSBpc3N1ZSBvbiBidHJm
cy1wcm9nICYga2VybmVsLiBidHJmcy1wcm9ncyANCmlzIHY2LjcuMSwga2VybmVsIGlzIDYu
Ny41LWFvc2MtbWFpbi4NCg0KVXNpbmcgdGhpcyBjb21tYW5kIHRvIGNyZWF0ZSBidHJmcyB2
b2x1bWU6DQojIG1rZnMuYnRyZnMgLWYgLWQgcmFpZDEwIC1tIHJhaWQxYzQgLXMgMTZrIC1M
IEhZV0RBVEFfWk9ORURfVEVTVCANCi9kZXYvc2RiIC9kZXYvc2RjIC9kZXYvc2RkIC9kZXYv
c2RlDQoNCldoZW4gbW91bnRpbmcsIGRtZXNnIHNhaWQ6DQpbwqAgMzI5LjA3MTQwM10gQlRS
RlMgaW5mbyAoZGV2aWNlIHNkYik6IGZpcnN0IG1vdW50IG9mIGZpbGVzeXN0ZW0gDQo3YjRm
MmNhNi1lZmUzLTQ4ZDktODFmNi1iYTY1YTAwZGI4NWUNClvCoCAzMjkuMDgwNDIyXSBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RiKTogdXNpbmcgY3JjMzJjIChjcmMzMmMtZ2VuZXJpYykgDQpj
aGVja3N1bSBhbGdvcml0aG0NClvCoCAzMjkuMDg4MjIyXSBCVFJGUyBpbmZvIChkZXZpY2Ug
c2RiKTogdXNpbmcgZnJlZSBzcGFjZSB0cmVlDQpbwqAgMzI5LjA5MzY3M10gQlRSRlMgZXJy
b3IgKGRldmljZSBzZGIpOiBjYW5ub3QgbW91bnQgYmVjYXVzZSBvZiB1bmtub3duIA0KaW5j
b21wYXQgZmVhdHVyZXMgKDB4NWI0MSkNClvCoCAzMjkuMTAyNDQyXSBCVFJGUyBlcnJvciAo
ZGV2aWNlIHNkYik6IG9wZW5fY3RyZWUgZmFpbGVkDQoNCmR1bXAtc3VwZXIgc2FpZDoNClsu
Li5dDQppbmNvbXBhdF9mbGFnc8KgwqDCoMKgwqDCoMKgwqDCoCAweDViNDENCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICggTUlYRURfQkFDS1JF
RiB8DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgRVhURU5ERURfSVJFRiB8DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgU0tJTk5ZX01FVEFEQVRBIHwNCiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOT19IT0xFUyB8DQogwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUkFJRDFDMzQg
fA0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFpPTkVEIHwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBSQUlEX1NUUklQRV9UUkVFICkNClsuLi5dDQoNCg0KUkFJRF9TVFJJUEVfVFJF
RSBuZWVkIENPTkZJR19CVFJGU19ERUJVRyB0byBiZSBzdXBwb3J0ZWQgYW5kIHRoaXMgDQpm
ZWF0dXJlIGZsYWcgaXMgZGlzYWJsZWQgb24gbW9zdCBkaXN0cmlidXRpb25zLiBJIGhvcGUg
UlNUIGNhbiBiZSANCmRpc2FibGVkIGJ5IGRlZmF1bHQgb24gYnRyZnMtcHJvZ3MuDQoNCkhB
TiBZdXdlaQ0KDQo=

--------------OWzfONlEtoFnJQt0OeU2SjYI--

--------------h6ogTsg4JfTQpsObi12nGc25
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZiicdAAKCRBLkKfpYfpB
Uz7EAP9cKNvd3dOBzmd9DcxZhgtPPVvD6UAN4KOgE+t0gBqmFQD/XC08w7W60SHW
M/2XCgL78K2xlwaB0LBj5io2MrAUjAg=
=TK1y
-----END PGP SIGNATURE-----

--------------h6ogTsg4JfTQpsObi12nGc25--


