Return-Path: <linux-btrfs+bounces-16868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CEB59FE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 19:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4939E1C054A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43A27E1B1;
	Tue, 16 Sep 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="nFaflg8d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09649242D65
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045534; cv=none; b=sHIRrxcDdyqRyCvjbONeH9ctcdWwo4u94okMlsxZnFjTNQknw0lH15aLBzMgJFbVOgVD2VCyaYMqEqZEPhjxUyYOtpjzBKqM5NCRRcwd8f4xtFObtf9FiUJIx4MXOyph6pBJAwYJCcan1/G7Z1WTRU96SSuBwLcPDH97qgpzLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045534; c=relaxed/simple;
	bh=UF6NikXGlv7Fb3ZBRbA3IiLdydza9+8i6TYsFdNCE0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uXBB7OXuwzqpcZQwPCI/cswMBLl5fBnmIe6V3RiqrK9nlD28qwESaNWSz7TLJoe9ZYNsZRTAsWd2B3ohi3xho60Mok8P/+AMG2YkJh6KpV7b5GVrcjixCf8EdasTxtBcyVdnqgByIfeiAVHhnejq/BrovqcL19Othm/m8lE5334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=nFaflg8d; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1758045521;
	bh=UF6NikXGlv7Fb3ZBRbA3IiLdydza9+8i6TYsFdNCE0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nFaflg8d7ZIAxQEuuMgEUjMcDzhXrB3G2L/TOsaKmABUzWLe7VisGhA5lxmppvNY6
	 Thr/vVHHTlDKPb6g8Zkvt91Zs8r+JJZJk3sFM6bABaDYZeHK+OcjIQeKln0E9z86sU
	 494tZXVlBfyFYEeqXUKxlrDmY80B2boUlb80caOI=
X-QQ-mid: zesmtpip3t1758045517tc426dae9
X-QQ-Originating-IP: M2bwiIvPsauTRv+Wmj3lcAQX56j47bh/oMaiei4Od5U=
Received: from [IPV6:2408:8215:5910:8ca0:5a6d: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 01:58:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17653159524582867693
Message-ID: <2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
Date: Wed, 17 Sep 2025 01:58:35 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: performance issue when using zoned.
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
 <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eZs5aqdnH0AAEvL0VqC1kGz7"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N1p/MiiOj+NxWafAI48aHXrNp39cKEeq2W0sUZRxfWvTYRZXPbKuKB23
	njaShqaquoECc+uADD5wbKF/2I9f37fjRjb8OPGoX32V5NwTQEvg1v8XyiEIfvCGM/kGH7Y
	O25PrfDfZMLllYX6Osc2gTB2bEm/GYNAn/0IIAtd1OOpwQ3M52hk3nBU0WrylR48VZRmG70
	+rJlbUlwBNA+cpKZYVCpkWwZDgdOfISDWA0/2Y4FCeWTaPBaHKC8hvvqAaX6p+q+3KtJPOY
	6smY7bczrefjFwNO66qJqlWnJxGv9sAR4F+Db9VOmY1U3IQGxIrQheijwzHa0JcQnyQWY7s
	nbgmlXotqmTwSSe/Catbe7Oz8Msq2kUCQVaTPXPSZy7MfrswRgimlaGxqZAQoYM8ty23ZM+
	kXTSJX2sycjaR8hFP6OuZEHtP0K73FQPlfx5FLNxq8HBpCbQygydzip2kMsDVOg5gsgsj0e
	1qPfFaL+2qiZ6aXxgIpiKXEPv7pjxaLBHAVymUBL88C7NYQEalngyivblAaCSoaXCMDRPL5
	Npl4ci4wtDsobO5wapPLiFh7bssOSmNJ0igrugyRY7sdn8P7jaGmwX7I15VaYH2KNyc0gGD
	ZYzD4nBTb1Wr1fkMkRb3LbS4klaj+sC6DntznF/p0SqXnXW88zgtG3MN1XnQaLuUxODYbtx
	PE801dXFck9yYWM6EnsJ2qKVctx0Mhvdk70zKrKzDukiLK+a90kb49JXu4YEQGA90WmAvbm
	5iich3JJT5BXSU1cu1AZLe4ydyIYoflYwCuxLDjeJIedgo6tJFUjbGhyeIhBXHSIYeuuJkv
	uPwgte9Z9ok/n3wvXzmT6etLydXByPVHcr6kUHx+3cpc/qFaHtEwEDSPTNpv2/2/VfDvvVR
	Lh0DeiY1E58zt7icz+Csv001/6byKx1EyuGrrCc8nsQ+zxemxkHaAXSvHSbRJcLHh3Bnk6Y
	tzqE8pTkQ07ucEdm6pcTqt9gDbk+9vwHq25cERQygN9lXGy+L5BFk/AFu
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eZs5aqdnH0AAEvL0VqC1kGz7
Content-Type: multipart/mixed; boundary="------------1oZqTqqrsFKGXvAvM31Z53Xh";
 protected-headers="v1"
From: Yuwei Han <hrx@bupt.moe>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
Subject: Re: performance issue when using zoned.
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
 <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
In-Reply-To: <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
Autocrypt-Gossip: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/

--------------1oZqTqqrsFKGXvAvM31Z53Xh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDI1LzkvMTUgMjA6NDEsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+
IE9uIDkvMTUvMjUgMTo1NiBQTSwgWXV3ZWkgSGFuIHdyb3RlOg0KPj4gSSB3aWxsIHRyeSB2
Ni4xNy1yYyBrZXJuZWwgc29vbi4NCj4gDQo+IHY2LjE3LXJjMyBjb250YWluczoNCj4gDQo+
ICAgIGJ0cmZzOiB6b25lZDogbGltaXQgYWN0aXZlIHpvbmVzIHRvIG1heF9vcGVuX3pvbmVz
DQo+IA0KPiANCj4gVGhpcyBpbiBvdXIgdGVzdGluZyBoYXMgYm9vc3RlZCBwZXJmb3JtYW5j
ZSBxdWl0ZSBhIGJpdC4NCnNhZGx5IHRoaXMgbGltaXQgY2F1c2VkIGtlcm5lbCB0byByZWpl
Y3QgbXkgbW91bnQuIEFueSBmaXggYXZhaWxhYmxlPw0KWyAgIDE4LjE4NTA2MV0gQlRSRlMg
ZXJyb3IgKGRldmljZSBzZGQpOiB6b25lZDogMzE0MTkgYWN0aXZlIHpvbmVzIG9uIA0KL2Rl
di9zZGQgZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KWyAgIDE4LjE4NTg0OF0gQlRS
RlMgZXJyb3IgKGRldmljZSBzZGQpOiB6b25lZDogZmFpbGVkIHRvIHJlYWQgZGV2aWNlIA0K
em9uZSBpbmZvOiAtNQ0KWyAgIDE4LjIxNzQwNV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGQp
OiBvcGVuX2N0cmVlIGZhaWxlZDogLTUNClsgICAxOC40NDkzNjJdIEJUUkZTIGVycm9yIChk
ZXZpY2Ugc2RjKTogem9uZWQ6IDM5MDIwIGFjdGl2ZSB6b25lcyBvbiANCi9kZXYvc2RjIGV4
Y2VlZHMgbWF4X2FjdGl2ZV96b25lcyAxMjgNClsgICAxOC40NTAwODNdIEJUUkZTIGVycm9y
IChkZXZpY2Ugc2RjKTogem9uZWQ6IGZhaWxlZCB0byByZWFkIGRldmljZSANCnpvbmUgaW5m
bzogLTUNClsgICAxOC40NjY0MDVdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjKTogb3Blbl9j
dHJlZSBmYWlsZWQ6IC01DQo=

--------------1oZqTqqrsFKGXvAvM31Z53Xh--

--------------eZs5aqdnH0AAEvL0VqC1kGz7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQ3xl0cveqzft47u2GTyL/FEVGAGAUCaMmlSwUDAAAAAAAKCRCTyL/FEVGAGGiL
AQDAgnanMbXkC4i8j4WfxYgg2xRrNom3UF9UFWwfrhB7TQD/UUCw+34ucGrmVv3PM2uJdRNsVn1o
AsXSDMzTwEwcPwc=
=HrSH
-----END PGP SIGNATURE-----

--------------eZs5aqdnH0AAEvL0VqC1kGz7--


