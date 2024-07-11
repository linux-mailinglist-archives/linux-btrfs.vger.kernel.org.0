Return-Path: <linux-btrfs+bounces-6350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F7092DEE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 05:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D037B1F218AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 03:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1310C383B0;
	Thu, 11 Jul 2024 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="o26zsVBi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC3374DD
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 03:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669689; cv=none; b=Csosvqc03qjEdS0zupRe9DdxMPzHIL4HIXOIfC6+o3jFja7rfYQmeLKdZoFhJA76qtVMRODXNXwXLZiflPqaGV53vrrMRd9XMzduxeN/vXyLPKLPIDAn+/3/oQW1NPxOy6YKKglCkCnmWYpPYDhT0x0bbS/5Hg/bWKGYXtiAN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669689; c=relaxed/simple;
	bh=JFt5Ihmox4GYnbdJ5ygYlf8YtqpHyaWk9nIRhsjNuyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u7UHoSwxihnqTqX3092sqIoxzFD98Ab1EGDKtF2H3acN+crsq+7Y8YRrjkgJ+jEMgGC0zDRbZrHuMdnvkyXGEjHgCTFG2KUlsPDb9O3rZiPFYEFVAZ2S3nSWK+Pilg53b+mrkkjnl9um9tCj4AZ7F8CiU0+oiomvGdFv/fut70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=o26zsVBi; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720669683; x=1721274483; i=quwenruo.btrfs@gmx.com;
	bh=TIYa0twU9/Zk+YDf986BzDldanp8mGY18LTrn1Tm71E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o26zsVBiKUV+PCnRqSyolt30bXjcgGXKvFX9AvYI9Zxud2hoYSHV6fLd+5r+SjHb
	 uVdMbsSqpqGu4lfA8lghYt16g/nZmDLY/nDDf5D5JAlIZTHvlblhRxJo1sZEn+Chr
	 WrkV5JCXfsAR/wLLS/kx0gdC2dQnhdau0e/tNazLgznWWEMnxTCHSwaoyb2pMZ9pw
	 qDbgipmdVht0xs2U2ZmuaMzD28R2smbs5TUtb0EhQoYWg9sHNQpbyNqYFAtilTu42
	 S5snPQjM2YvftSLir7O8SdpIDabbIlA3Q4MFstoJwt5K3eghoh6wvcZbd39+wFGSR
	 j1DpL/FCwq1pgeP2Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpav-1rxPJ71u3T-00mewa; Thu, 11
 Jul 2024 05:48:02 +0200
Message-ID: <ad3498e5-d41a-40ce-be73-c5d9de4f85a1@gmx.com>
Date: Thu, 11 Jul 2024 13:17:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-progs: btrfs dev usa as non-root is wrong and should just
 abort
To: Russell Coker <russell@coker.com.au>, linux-btrfs@vger.kernel.org
References: <2159193.PIDvDuAF1L@cupcakke>
 <96677547-0177-4226-92bd-174c167269b3@gmx.com> <4914581.rnE6jSC6OK@cupcakke>
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
In-Reply-To: <4914581.rnE6jSC6OK@cupcakke>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DKfnvLKhh5PSYFnmDp4gmRwiyE8p+LmMVQr3w03yY2w8smAraM0
 Xb4I2aVei4UXB8KswiGIqArssrT312B077Eycg4H1ThY5+GaM++AKcU2Vvhowvl8xHkvMuZ
 8oqKSNUWai0yeK1/p2zdfBBrmpg7p/wT5yWn2A1uyQkmQdQCR3tTqjmKoOs4nSyjmbkIVh2
 m+BACaENbYwMuiJqnabnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nZ9e+B4zsgU=;/vpvpw/e+9ys2J/3ZQpoCfpEnvu
 aXDU57WIZIKKVjlsEtjDhW63479jQwTYM0qYUxgzcni2pBJ0U1NbNFH+wvtwbtsf5rhfb6+x2
 SoECrT5W5xnqKSfjhMB/AISI3/dm3F45UsZIrPGYanrooQB4HrnvCFqK4mgMdvnDcY30wtV5b
 vKxVPDHGf7xxsIvma6M35Qdb/lJ9zvWDiBNSspAh5VLrYGrJyMYQm82sZlVQPpcQ+JaQ7UK2V
 LiiFpgZlasfUl6ooP0QVVz8s4gebUXFtHabwI8kGt6I8ppS43XZdMRKQWYHPMb9CnRVTGmNca
 s4/KdEqco60/INrSBW/Pts8TBVUVXj7u6ZVja50Y8f4RqIxABa4cKQIjT9iV2Eyz2GOamb5G1
 JcI26wyr3CsfJP5wDz7ok1M0hixxFCu0h1J17KOjxeCjgNGZbqA9Pzjftdnt1LgWW3SrO5F1B
 hSF5PA4QPxsraTNuqNAsRF9OEx5j9qtZi8WmNoRMfaa/EuZg43Fn3QcoDCFrAWeFaWqBW5lnT
 ZT+EEdyNsBONFhMWU4XHv21bu32PcGeREAHzK7urdDSLpWdSSD4VFRPPVT/Ce6rsyTkudjSs5
 jgASF84ivgBbkLOoSrwkHhkN+gFudomNYssQUSbpG5pt+po3Db+38nk/LgJsXX6vWNEHFUUrU
 hR6YqkIQACvJdS2ZBfpXwL6m3xwUfU3Q4btQcLg/idzL11y87HLjlaBpSev/FVXqb2j18dybG
 o0xHv+PPS5h/OFf7EHU4xhnkMYLYn88De2kb7hZZ5Ny06lqe90+p1snoHhp6gXKwxUhpW+irA
 YGcrIZDMy+e3KE6XCKF9I/xg==



=E5=9C=A8 2024/7/11 13:12, Russell Coker =E5=86=99=E9=81=93:
> On Thursday, 11 July 2024 07:13:25 AEST Qu Wenruo wrote:
>> =E5=9C=A8 2024/7/10 21:22, Russell Coker =E5=86=99=E9=81=93:
>>> Below is the difference between running btrfs dev usa as root and non-=
root
>>> on a laptop with kernel 6.8.12-amd64.  When run as non-root it gets
>>> everything wrong and in my tests I have never been able to see it give
>>> nay accurate data as non-root.  I think it should just abort with an
>>> error in that situation, there's no point in giving a wrong answer.
>>>
>>> # btrfs dev usa /
>>> /dev/mapper/root, ID: 1
>>>
>>>      Device size:           476.37GiB
>>>      Device slack:            1.50KiB
>>>      Data,single:           216.01GiB
>>>      Metadata,DUP:            6.00GiB
>>>      System,DUP:             64.00MiB
>>>      Unallocated:           254.29GiB
>>>
>>> $ btrfs dev usa /
>>> WARNING: cannot read detailed chunk info, per-device usage will not be
>>> shown, run as root
>>> /dev/mapper/root, ID: 1
>>>
>>>      Device size:           952.73MiB
>>>      Device slack:           16.00EiB
>>>      Unallocated:           476.37GiB
>>
>> Mind to post the raw result?
>>
>> The 16EiB output definitely means something wrong.
>>
>> So far the result looks like btrfs-progs is interpret the result wrong
>> with some offset of the result.
>>
>> In my case, non-root call of "btrfs dev usage" always shows the slack a=
s
>> 0, and unallocated as N/A, so the 16EiB looks like some shift.
>
> # btrfs dev usa -b /
> /dev/mapper/root, ID: 1
>     Device size:          511493395968

The device size is 4K aligned.

I guess it's some older fs? As newer mkfs would always round down to the
sector size.


>     Device slack:               1536
>     Data,single:          231936622592
>     Metadata,DUP:         6442450944
>     System,DUP:             67108864
>     Unallocated:          273047212032
>
> $ btrfs dev usa -b /
> WARNING: cannot read detailed chunk info, per-device usage will not be s=
hown,
> run as root
> /dev/mapper/root, ID: 1
>     Device size:           999010539
>     Device slack:         18446743563215167723
>     Unallocated:          511493394432
>
>> And what's the version of the btrfs-progs?
>
> The Debian package version is 6.6.3-1.2+b1.
>

It may be easier to debug by trying a newer version of btrfs-progs.

And since I'm not sure if it's the unalignment causing problems, you may
want to resize the fs by:

# btrfs device resize -1M <mnt>

Then resize to max (which should always align the fs correctly):

# btrfs device resize max <mnt>

And then check if the size is aligned to 4K and if the problem has changed=
.

Thanks,
Qu

