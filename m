Return-Path: <linux-btrfs+bounces-7350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277329590D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 01:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAD81F240C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 23:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6D81C3F1A;
	Tue, 20 Aug 2024 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IOF4h7nX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EB219E0
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194944; cv=none; b=RYB1YnYTxK9q6Lw0EYQ/+14zrNJP1ujHYzvKlA7nUhWQN7jUkWA8U2G15bGj9LImn6s7P91np1dTqtOYHgvv8RlULYcaF3i0AiU0u1h249QtVcLWAtKRhzfW9Ha8XbPQ3VNdQDqkAFJMBVzDJq0JhIcxPJ/hGF+U1cn4eNmepvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194944; c=relaxed/simple;
	bh=Ucv6tjTXGFYEnVIxKYpXzT+3nIHO+X0aq5fAzQljsvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mdQEEETojO8bRnRXlYEREjrEu7/UgBRAZfErBz3EPLgwavhVKj1bIQFlQXgcMBT4zBquK7T31k0Sopyq1TpQXNzvBVvNNU+VmTCUXyaN1cxXhsriEsnQz+3eceUAu5DkeDpEV4gTMHPzwJi0VNSwiezF0wA2Lsab044wlTvDdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IOF4h7nX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724194937; x=1724799737; i=quwenruo.btrfs@gmx.com;
	bh=Ucv6tjTXGFYEnVIxKYpXzT+3nIHO+X0aq5fAzQljsvA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IOF4h7nXgJSB7Ppfwi0TdAj3ShpUTKvztX6/sUWsYg19FnT762w5gkv+pxIdfbcL
	 OJDWn5YTVxBhvxE57qwW/2QtGTQy2u0aWWCKtVY37evfxuv1ADcoL7vDFDN4wFIT3
	 FtYlsMxJsGdluIpvpHA44BERTsXyG4eJC1ouPWxem9Z42bjLPvH+uUAWlxAxb9h6A
	 xKvqTM9Mv2iPt4YlwBe7kFk1pxo30nOdkLfzIqwtzUkEihcKQSVsn15hroM7yBIy2
	 OK48WQ5ZpeHA8ZN5k2F7RFq3lom8bqCu8F1KV3nCf/BwJUfoUs6DY9vS1mcLm8iaW
	 WVfEZyhMgfRF/1btfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMobU-1sNv3M1nAS-00LFEW; Wed, 21
 Aug 2024 01:02:16 +0200
Message-ID: <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
Date: Wed, 21 Aug 2024 08:32:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
To: Pieter P <pieter.p.dev@outlook.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WJ9fj3p6O6IDXdDCNXuEP53EBSWl9o9gS7H0SIbWKb5+ahSYzlu
 fTh28LjpQFFUdC6eVhTKJAv27AU7oYNtXeWqYHQEu1ioF3CF1mYPzGliBqu0wZT7MQJt3kF
 yAUUfs9tfvRI5vUlOp1sIVkxQr5xfIqanGGDUJecbWGp6dYUjzTMO3SJtT/1BM3Dsx6RDek
 1s+HinVXCvkwH04QL66hA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YZBmQqXZ96o=;h4QIWyedEKa+BBUKiDMq5UhX3Mn
 tCfrlEk2s5dA01CklFhr8yfOADYGSQuqcdzjD15sd5wy8qx6ImUr2OFFi5kWINttApKOTTB91
 Ar5xqAEGIIpzZWPr+4G2yCUdG5rajQ2YJSsgllwOyTDKt79spRBynec7ksIFuQ6kgAxTZvUsE
 0yMilZSixunjMmXAprMC6y9STc7iSy1WP3K+ii01SJVNFojO3h8yWhVwi0vlcs0ArPfOIfVXM
 7DWZV1YatsDOV2MaktG1TRbv9wH7NtZwTa44Err1QiBvF67PGWM8uvLZF0wR6/pWxRg+He5V2
 bKtdiKa1tsH2xr4W0VDnxz3KGNU+ZgEC1fVX7D+xIXtLuN8D4Lu1TME4PeEca6+tskVhKCMMK
 u+fY4xUIiIC7QW+ut8xRy9dzvHkshhCuk9rG9VAMc+NKcgkDSHpEM4DkWYFpJCwQm9NBvWNX+
 rfAOqYDsJP3aen3LgUZCKxST80QXjUV1t+mati8DIGmJcbEIYIlRqA+GpcnM6+VrwhGqquhvK
 cc0l03oz3F3lrSqIMFzwhbyP5DW3CAN9wj6gQeRfelwzS4c1HBiX4ZUFk5Qiy0pWbxRPTM5FA
 j39lS5SGtSArYFY8fRdV6RcxMR9EUV271wHeZBeS9XZDnirjXmsut6KJwukUHPP+jkju8gkus
 /zzvPcwpJvbddhjwZ/1TbeZn+PHuZ/o6HAiJenWCRWWSXOuLEfU1P7bnDaHYCuaPVLxmdTdlM
 saqMklhLVkROysOb5j+0KRpOu5Wr6wOEUXmKyVJUuJVgU5DoR6z1HkFk3YPHEG2jv2Q120DJO
 6FhDDd4mB1CDF0sBITbXQnMtWIX0Vk1NFXxcrpk6dcOwM=



=E5=9C=A8 2024/8/13 00:27, Pieter P =E5=86=99=E9=81=93:
> Hello,
>
> My btrfs partition suddenly went read-only three different times over
> the past couple of days. Looking at the dmesg output (see attachment),
> and then running btrfs check, it seems that a single bit is flipped
> somewhere in a btrfs bytenr (2216718336 =3D 0x84207000, 5764607545201418=
24
> =3D 0x800000084207000).
>
> I've verified that my RAM, SSD and other hardware are fine using Dell's
> preboot diagnostic tool

Unless the system is using ECC memories, I doubt if that diagnostic tool
makes any difference.

If there is already a strong indication of bitflip (and yes, it is), a
full memtest is highly recommended.
Unless the fs is pretty old and have been run on other systems before.
(aka, the corruption happened on other systems and not detected until
the file is going to be deleted).

Thanks,
Qu

> and Samsung's SSD magician full diagnostic scan.
[...]

