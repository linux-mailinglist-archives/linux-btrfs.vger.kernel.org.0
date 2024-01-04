Return-Path: <linux-btrfs+bounces-1226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B944823C69
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 07:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DDB1F25CA4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746801EB23;
	Thu,  4 Jan 2024 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="T7Fr1reo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4491DFE2;
	Thu,  4 Jan 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704351359; x=1704956159; i=quwenruo.btrfs@gmx.com;
	bh=bwRDFZTy8m2tgf1UYUKCFU4jo51LQ2iAkFgT4ySTugY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=T7Fr1reovbIZxjU5nKxetQt1PgXUM8OTBoNHwWYHrdYDRMsHdUerpQVj4oWyXWc6
	 LmQYNSMqMdsp3BDRIRK3G/lp41xgyF/KDfTETN/S93m0SMUQCAFTym0WXc8u5L1ey
	 L8PN7Wyq/dbtBXk3b7amRyUvu/Z+FPjUNMm6HJu0QrgBJ7Jnw4qFLQodgerPXEIpx
	 fPeqAYTUX+LITbfwkHY6FIg2/NFKnkqvYMk/bXqk6lHVxYr0PlFzTeQr3cUsnnBMx
	 8T7B5FJsNmI8BDawu5N+c2w9liRuUHmhj6yPSp3ZeCmBX21Y9T4TqEG9eCBK6CVnb
	 pRanutzufVfhRk4h3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhD6g-1qhFrI2iKQ-00eK7N; Thu, 04
 Jan 2024 07:55:59 +0100
Message-ID: <1dbb1cd1-15fa-401f-8356-474c85a46f3b@gmx.com>
Date: Thu, 4 Jan 2024 17:25:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] kstrtox: introduce a safer version of memparse()
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM, ddiss@suse.de,
 geert@linux-m68k.org
References: <cover.1704324320.git.wqu@suse.com>
 <4960b36916d55e22be08fe1689b81e0eefb47578.1704324320.git.wqu@suse.com>
 <248554b4-a549-4e94-835c-3430403b746c@infradead.org>
 <d321160b-b895-4049-8ac6-4ff6ce5df7d4@gmx.com>
 <bd4f25a9-9584-42bc-bde8-b9ca82cbc1c5@infradead.org>
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
In-Reply-To: <bd4f25a9-9584-42bc-bde8-b9ca82cbc1c5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gW8VfbMIOiQne3LvjF2zIH057HBs4Dzxzg0KifxWszMamt7Ys9/
 25BTfYgH3xpQ4mVs5uMRlBqyaBf5FbyIkC9DOXSfZg488drnlkeC7jAssqz7lQBr3GhQxyz
 QJAhC8rLBUw84OXJHkLavhI9uEYUrnsCsWEJ2YkI2JppwJkDxkII/7KfUNNpfM12XB5JPkM
 yGmBoRKUyNQZmZviKxqXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UuFQ44Yon7Q=;UgjXq6aH4SKAbrQwJLzE9bukEHC
 5UsRb09kc7hGjxIjXMUZCsVPZAhmgRhIzeq4KyOx63aqXGjKCaMWz6ZGduZN3BsAlMCh46lxv
 yIZ2bNooSzwCd1uk6OuBrDj0Hw7QvXso7/tO7M91he5jN04pU9FerMzX6EBQxZAP49ep6mQP3
 TAOwgScy4hTtmep977OcX1loEnzbmilGpw8G/gHgbJzZFME36lLd2nDGrIRTq8e2Ag94/6ZKK
 xPz2YyvhiXWUmYcmh3zkarrK1lSTDXk49NJ9TnLU2NRT+Tr7fX/rRsWG7TY6NRRIwysLimirt
 ON+69ywtA+zYBpiIE+UR7V33TCbezbuk3f3PYbHbeRRWBegPchJ7xlXR1i4cDIXhefugKwcWp
 AwXGlLWOMua74gkcuJ5jy+tgZZbnREwnILW8jNu/vDJOlJSMP+bh1sRf24/UPWoUGYVI4EsEf
 BJrZCJizwIWs/6FZNDPJ3beqZ3g+avP5KbOxQVwFpYJP2zdRZ3PmDhbKjEnJQpu3Z0jp8YEHF
 l3KD5ort8gds/g/kugE9F6sAcQkH2xtoK5C/Htsg/XnIFIrZk583NgeNu1QllK67AmTW/6Ns1
 rJMp2r8dgbCnMgdVaczTxpCn2bPLkWyd3ZMM3w1UtaKRDsZdHQeURCqf2R96P48G+3ey+78lR
 RNmlC9Zw4V128PgmSF5cxmvrLyJsQNawIhURyMEXmEGstoiCRvyJYA1gNjQ9JKINk4lSC3hS1
 FbeBCDlGp8hTWtsJeKRjdOMlCDAbH4dLNLutljG2uB0RPuuhMgJkHUQAqYYoApxY2gREvI+LA
 wuGh+BUkrp4gD0nXx4zrBWPJJMIIv8G2T5TD9us5ji5Wpb3kta0qAgcRaZPD/F+K2u0IugRex
 3fah5NqLMmigB40TUpGwj3hV4iZgmadpraRq0MB78r/JCS2pm9FTRUGEdtDJYTdKUqfUqdt2U
 sXN0xB3KPeDQNccWOP/Wn1xROWw=



On 2024/1/4 17:20, Randy Dunlap wrote:
>
>
> On 1/3/24 22:42, Qu Wenruo wrote:
>>
>>
>> On 2024/1/4 17:00, Randy Dunlap wrote:
>>> Hi,
>>>
>> [...]
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parameter.
>>>> + *
>>>> + * @suffixes:=C2=A0=C2=A0=C2=A0 The suffixes which should be parsed.=
 Use logical ORed
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memparse_suffix enum to=
 indicate the supported suffixes.
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The suffixes are case-i=
nsensive, all 2 ^ 10 based.
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case-insensitive
>>>
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported ones are "KMG=
PTE".
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NOTE: If one suffix out=
 of the supported one is hit, it would
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ones
>>>
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end the parse normally,=
 with @retptr pointed to the unsupported
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suffix.
>>>
>>> Could you explain (or give an example) of "to the unsupported suffix"?
>>> This isn't clear IMO.
>>
>> Oh, my bad, that sentence itself is not correct.
>>
>> What I really want to say is:
>>
>>  =C2=A0If one suffix (one of "KMGPTE") is hit but that suffix is not
>>  =C2=A0specified in the @suffxies parameter, it would end the parse nor=
mally,
>>  =C2=A0with @retptr pointed to the (unsupported) suffix.
>
> (corrected ^^^)
>
>> The example would be the "68k " case in the ok cases in the next patch.
>> We have two different cases for the same "68k" string, with different
>> @suffixes and different results:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0"68k ", KMGPTE -> 68 * 1024, @retptr at " ".
>>  =C2=A0=C2=A0=C2=A0=C2=A0"68k ", M -> 68, @retptr at 'k'.
>>
>> I don't have a better expression here unfortunately, maybe the special
>> case is not even worthy explaining?
>>
>
> No, the corrected paragraph above is good. (s/would end/ends/)
>
> Except for one thing: the examples here terminate on a space character,
> but the function kernel-doc says "null-terminated":

Oh, all the strings used here and in the test cases are all "\0" ended.
Just to make it a little more readable (and easier to type), the tailing
"\0" is not explicitly showed.

That extra ' ' in the "68k \0" case is just to make sure the @retptr is
properly updated.

For all the other existing ok cases for memparse_safe() (those without
extra tailing chars), the @retptr points to the tailing NUL '\0'.

Thanks,
Qu

>
> +/**
> + * memparse_safe - convert a string to an unsigned long long, safer ver=
sion of
> + * memparse()
> + *
> + * @s:		The start of the string. Must be null-terminated.
>
>
>
>
>>>
>>>> + *
>>>> + * @res:=C2=A0=C2=A0=C2=A0 Where to write the result.
>>>> + *
>>>> + * @retptr:=C2=A0=C2=A0=C2=A0 (output) Optional pointer to the next =
char after parse completes.
>>>> + *
>>>> + * Return 0 if any valid numberic string can be parsed, and @retptr =
updated.
>>>> + * Return -INVALID if no valid number string can be found.
>>>> + * Return -ERANGE if the number overflows.
>>>> + * For minus return values, @retptr would not be updated.
>>>
>>>  =C2=A0 * Returns:
>>>  =C2=A0 * * %0 if any valid numeric string can be parsed, and @retptr =
is updated.
>>>  =C2=A0 * * %-EINVAL if no valid number string can be found.
>>>  =C2=A0 * * %-ERANGE if the number overflows.
>>>  =C2=A0 * * For negative return values, @retptr is not updated.
>>>
>>>
>>> For *ALL* of the comments, I request/suggest that you change the "woul=
d be" or
>>> "would not be" to "is" or "is not" or whatever present tense words mak=
e the
>>> most sense.
>>
>> No problem.
>
>

