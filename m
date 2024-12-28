Return-Path: <linux-btrfs+bounces-10650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6B9FD907
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2024 06:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BE9163184
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2024 05:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACC4207F;
	Sat, 28 Dec 2024 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="qyY/hPYM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA208101C8
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Dec 2024 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735363950; cv=none; b=KQQhF0wZ1P6cvJs2NUUbk2ZFE6t0s1S2DLZH+8FaFuNUsSHeWVXsr+Zd+e51L+0sBn5LjNeBXyWnAWCeYZNwTmpGhdoC4BLcLyGUPCOx5o/CYlyhmzxoELq00+s+C/XMxn2T6YqnoBQNoPJzIIptqJRA7gNxKmY99/hQht35j2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735363950; c=relaxed/simple;
	bh=AddROLLf+lF+Hpoi0ymRG6lXX65NgQzLkp92Sn+zMxc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Erxp4IzGWQ76ttndv+DLVlVKuBBtYKwN9t934b1YNF7pBOrGOUdGlU1YpvADcHi6X0QicuEi5k28eUffzrippSbSp3yWNOaVN2b8T5WSQZTSQ4mREQOpPF/dizea6H0ZUGVlhHSiDnsWrmdoz6m0NIfNxRUjYHXvu/42PKENVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=qyY/hPYM; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1735363934;
	bh=AddROLLf+lF+Hpoi0ymRG6lXX65NgQzLkp92Sn+zMxc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=qyY/hPYM3t+/8aSRBH3TRnvgZeqfX+9pbJaEO2q+KgkOQ90PtG/edrwB2AXhSCPYo
	 s+mADn4KymoZDhNO7RPfa8dk7jerHzkbRVfTIorlQYLB0mOn5+iP1o7Juz2sVDRlmg
	 av5EtHej/94s88NMw8ZhDiv2AyAfUcqUT4MS67Og=
X-QQ-mid: bizesmtp89t1735363933txvfbmg4
X-QQ-Originating-IP: T73IjzO2uTf8n7CxzF1Qo44iYqWPSyx2lI2guuF4D2E=
Received: from [192.168.0.108] ( [222.175.67.174])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Dec 2024 13:32:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7213832546719183613
Message-ID: <94E509D5953F22B3+df796186-1d22-4701-94ba-0070860786c2@bupt.moe>
Date: Sat, 28 Dec 2024 13:31:55 +0800
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
Subject: can't mkfs on zoned device after adding and removing it from another
 volume.
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ILnixLgHxpoqHFntFdNfTAJF"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OBVPLYbCWbNvTEo6ZnmlYJ/WW+7gRtEgxUHZh0Vr6hJMxm/BMjQlPi33
	htJr65IT+bWT+nWPVylvy5PrTM5bBIHTLqJp+WulFf+lgHQDT5EqSACp3NrVgxNPO9HzMy5
	J5SZx0DGmKDIbI1qgKXDbmgjuN0VeHd6cywoQRkV8kCQrbBAUpR31vrAPQreD5/IpNgNMLm
	WZ9gGTTuTonx3Q9UtxoHuy9l+sp2aus8MmTbqk19bGyVkCi7pcYEJtVIQ0WLsoOv93+OuMm
	oSPd3ZRoYx4cwVlOjZyDbWZ/i1ZsJxpd/H2O8FQE4nlouvwjgTBhvj2o4xWMl3SjSuxfYYK
	mobMI+DkFzLmHnVLEjoyM+LX+8ucPSoHnjwgdzZFfPLnv/kxWEENa1VK6Ap93ah34iR3DbK
	3lbUupwW62Z/lTCacOThdrB3+5hgwMfYZ9RGWia/Std5HgeKP6q+LJCKH2GwC2raPLHP3Lw
	JJuPaZzFLgGU7iDfIlq0q6AmEQpF6RyipzjOGiGvZUb9F3ukF47zilKFFSMNnc1yPiMMXqW
	Fw7feRwNJSmnCytW4dKLtE6CmN4RKURzaWzmlGwOg/J58u+AcoYbK9EGjmF6gMsRKQZPgMO
	7xW9EeiMhJqKkWPJBKpuqpPbqTlIkhMqg1+VnQ+XLS7yG+g8tSWFS3f4GPVB/rxRTrZCCor
	UNeD6xtYPcRnzsTu6+LhcAuL06LdRvpbrTzsFqQyfEyhRUz2JyOVmiM0aR+316Ba5sM0O5/
	BaGAagf7cIrwPRTu1+sJCU9IKA0PSH/QE/1l/X5CtwopRnlJiAuIwg+JKoYGHyqK9y2jDSJ
	shX8aySIz9PJmEDhKpxpB3ZCWh50h2NRJLJIqv45ZYhtWSp/HO+W2xMdQzIJ7NBz3nhYEDk
	9x5iVoJb/k2pYGk8pVAy1Ywr7C9wmmg271VMR09jnO4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ILnixLgHxpoqHFntFdNfTAJF
Content-Type: multipart/mixed; boundary="------------5SSVtM7vzIzz3beYUEPuMDJk";
 protected-headers="v1"
From: Yuwei Han <hrx@bupt.moe>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <df796186-1d22-4701-94ba-0070860786c2@bupt.moe>
Subject: can't mkfs on zoned device after adding and removing it from another
 volume.

--------------5SSVtM7vzIzz3beYUEPuMDJk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQpSZWNlbnRseSBJIGhhdmUgZXhwZXJpZW5jZWQgRU5PU1BDIG9uIHpvbmVkIGRldmlj
ZSAoV0RDIEhDNjIwKSB3aGVuIA0KZGVmcmFnaW5nLCBTbyBJIGFkZGVkIGFub3RoZXIgZGV2
aWNlIGFuZCByZWJhbGFuY2VkIHRvIHNvbHZlIGl0LCB0aGVuIA0KcmVtb3ZlZCBpdCBmcm9t
IHZvbHVtZS4NCkFmdGVyIHRoYXQgSSBmb3VuZCB0aGF0IEkgY2FuJ3QgbWtmcy5idHJmcyBv
biB0aGlzIHNwYXJlIGRldmljZSwgc2F5aW5nIA0KaXQgaXMgbW91bnRlZC4NCg0KIyBta2Zz
LmJ0cmZzIC1zIDRrIC1mIC9kZXYvc2RjDQpidHJmcy1wcm9ncyB2Ni4xMg0KU2VlIGh0dHBz
Oi8vYnRyZnMucmVhZHRoZWRvY3MuaW8gZm9yIG1vcmUgaW5mb3JtYXRpb24uDQoNCkVSUk9S
OiAvZGV2L3NkYyBpcyBtb3VudGVkDQoNCnVuYW1lIC1hOkxpbnV4IGFvc2MzYTYgNi4xMS4x
MC1hb3NjLW1haW4gIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBTdW4gRGVjIA0KMSAxMToyNjoz
MiBVVEMgMjAyNCBsb29uZ2FyY2g2NCBHTlUvTGludXgNCg0KDQpIQU4gWXV3ZWkNCg==

--------------5SSVtM7vzIzz3beYUEPuMDJk--

--------------ILnixLgHxpoqHFntFdNfTAJF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZ2+NSwAKCRBLkKfpYfpB
U4U1AP9n3f9Z+09iOP/K2141PdZ7cAUJQmcRm4AsbhRU7m1U+AD+IcymSRH9T+NJ
MyDBjLHUAKAR8FLweKk1o55tLQpL/w4=
=5nqj
-----END PGP SIGNATURE-----

--------------ILnixLgHxpoqHFntFdNfTAJF--


