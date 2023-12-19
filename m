Return-Path: <linux-btrfs+bounces-1064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E881921F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF21C251B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57E3AC30;
	Tue, 19 Dec 2023 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bVs8GYgG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9823D0A3;
	Tue, 19 Dec 2023 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703020686; x=1703625486; i=quwenruo.btrfs@gmx.com;
	bh=FViu1lMsV+9j+T3nfKE2SFnPEUF8k9aoZeyz9v5+1OY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bVs8GYgGO3yMra5t/9n/QOijZnedp02DM4AYU9gHt3tIxtoLfigf6hrnN0dwIjPn
	 ZVYwnFvDrxKgxXCHyLOHS7+OMjVZaU+DBfHIAOxz5JOb0hcslRkYrekMSeT96i5c7
	 /kdzXDazebhDLW/AR3fU8x2qJnYEK/EgIXOKLIQQCgOuS+S1o9JA11JLyVhitBcrm
	 3vDM5XpJT0dVE8uhPzcreGlQSUwMjNN12X5QtIFFhi09mNIYg7CAisj05YxODfZgZ
	 8b3meOFzfrkAiUXspv45wLMQURWP4nbcQnbxXdvgtWkPYcsMGLJ9xY7brVFj84211
	 zAJCEC3RFGXT4PHnMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([115.64.109.135]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1rgThk2zlR-00QmoA; Tue, 19
 Dec 2023 22:18:06 +0100
Message-ID: <4fbcab63-347f-4cef-ad35-686844c983ed@gmx.com>
Date: Wed, 20 Dec 2023 07:47:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
To: David Laight <David.Laight@ACULAB.COM>, 'David Disseldorp'
 <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1702628925.git.wqu@suse.com>
 <11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
 <20231218235946.32ab7a69@echidna>
 <8095c6ae5f8d412d8e6ff95707961a08@AcuMS.aculab.com>
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
In-Reply-To: <8095c6ae5f8d412d8e6ff95707961a08@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HICvyFMXfPaUDJN83pc9YiVEgbF7mfJsGXcIKpn86ogTudmZY5W
 nOHNAopMIJv9F9ysupIj6bk9Oo5vh7ZGInOAgxtYKZ7EoroHKzFJPE8NbvQvwcoVMckohgD
 eJOJ3QosqxgC3H445qjHbQd9V3jf8OzoDA2PZ9/SWG2WVvohdfEhS+9dMptGK0G3nvLFW05
 qkTu/1ijnExIbNkvAraGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GNFMC7xY/eo=;+/M6ZtrlKHgbG9jx1/Xz1D7jeHP
 /8tCszuOVhKnTyWkb8WvBol2QJI90wtrtFqwR3YwqscLSypQCHEIq0MeXDFWiMOBYtJQ6tL/c
 RAr/lBzRKeN0+ucatXqSrK24a+HeCRagO46Chnbg7Hs8dtxBIBlcDiwKLiWyXHDKgQHHwCMiu
 h57ilzZvVzMdBfK4FXedpY0S6k41TNZHPJvMVztI8zhEDOlW2J294sVz0QSq85NWInZp8of/Z
 +4wpJ9sw8hwXm735YdDCW77q0PHlEARPuZ45ETwDzueUkc0/hacasJrSC27P9VxmSTzDC9bgg
 9tM21Rk4Au75CqN3Pk0dxHpq/HFaoMfPI0D6OpL8aMaUZ3/0SS+4qW9M+WP1wPCbfhgZL3pZI
 1AxqkT+UR4HoENlWTETQQS7BkUckqbPb/wc9jxA97KJmuxx046yc6DRLzQpLlIafdLeq7WeDt
 5anm0lYQyf5bPXUbx6eD/3sy2UJmU8udxBjpKTL9h3DpOUQorpcebe0SGgKKRwIaC3VMn/tXG
 rN96NfoMCHTiPCsL5QW2DGN9S2tgpRWNCZGijKR+4KyvT07oYT7/EHntFDsfFkA8Qn58swoRM
 3+zzXPYW6h23ew4EDIAOnmqvWsnMMGaxT77oH+TX2YkaQhg9a1Evb89urIZaDnDpiQc/Td32P
 HW0mAIaC0/FczMTqOTD8vnI8JEqciCmfevKv9tn7zU/7t49SRaJizgqw4laJfvEArAQq8nWae
 Wei0TJ/mMDE1NNkkphtFpJBdvCD/nloPrKZYZNN98k9Xn35QmObW1OySLlAujGoijQaRh6oUP
 9Z8jyvuNRObXiMrOueiUDwBqn/9cDcx6FJRMOlFmTMoYZDy8HeRKobbkm8S4f1ltQXL2ApK1T
 8js/PjovzFBvAcZ8Qui4KsNWbFa/mRAQr4zxa6lce2nBN/JbCmjMiaDjAGG1az0KnrEcQz5NK
 wSVfE2irIXtnRK5OPEpWgET6iIw=



On 2023/12/20 03:12, David Laight wrote:
> From: David Disseldorp
>> Sent: 18 December 2023 13:00
>>
>> On Fri, 15 Dec 2023 19:09:23 +1030, Qu Wenruo wrote:
>>
>>> Just as mentioned in the comment of memparse(), the simple_stroull()
>>> usage can lead to overflow all by itself.
>>>
>>> Furthermore, the suffix calculation is also super overflow prone becau=
se
>>> that some suffix like "E" itself would eat 60bits, leaving only 4 bits
>>> available.
>>>
>>> And that suffix "E" can also lead to confusion since it's using the sa=
me
>>> char of hex Ox'E'.
>>>
>>> One simple example to expose all the problem is to use memparse() on
>>> "25E".
>>> The correct value should be 28823037615171174400, but the suffix E mak=
es
>>> it super simple to overflow, resulting the incorrect value
>>> 10376293541461622784 (9E).
>
> Some more bikeshed paint :-)
> ...
>>> +	ret =3D _kstrtoull(s, base, &init_value, &endptr);
>>> +	/* Either already overflow or no number string at all. */
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	final_value =3D init_value;
>>> +	/* No suffixes. */
>>> +	if (!*endptr)
>>> +		goto done;
>
> How about:
> 	suffix =3D *endptr;
> 	if (!strchr(suffixes, suffix))
> 		return -ENIVAL;
> 	shift =3D strcspn("KkMmGgTtPp", suffix)/2 * 10 + 10;

This means the caller has to provide the suffix string in this
particular order.
For default suffix list it's not that hard as it's already defined as a
macro.

But for those call sites which needs "E", wrongly located "Ee" can screw
up the whole process.

> 	if (shift > 50)
> 		return -EINVAL;
> 	if (value >> (64 - shift))
> 		return -EOVERFLOW;
> 	value <<=3D shift;
>
> Although purists might want to multiply by 1000 not 1024.
> And SI multipliers are all upper-case - except k.
>
> ...
>>> +	/* Overflow check. */
>>> +	if (final_value < init_value)
>>> +		return -EOVERFLOW;
>
> That is just plain wrong.

Indeed, I just found a very simple example to prove it wrong, 4 bit
binary 0110, left shift 2, result is 1000, still larger than the
original one.

Thanks,
Qu
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK=
1 1PT, UK
> Registration No: 1397386 (Wales)
>
>

