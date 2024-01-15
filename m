Return-Path: <linux-btrfs+bounces-1444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D4F82D3E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 06:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01A11F2153E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 05:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3051257A;
	Mon, 15 Jan 2024 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZE4M85OZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F923A2;
	Mon, 15 Jan 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705296442; x=1705901242; i=quwenruo.btrfs@gmx.com;
	bh=9D/2WGZqXmPkWznCliR0JPHXsHIvP7mg/1wpCuxjeWY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ZE4M85OZyBHvWAFdzNdsLtNbUVt1Su9kCpI6hJzcSTU3wlELs+HW5CJOj4Y+a3Cv
	 1VWXef+HP7kibLhDZwhz2/g3AaMptRDp2RK5VmK0lyIyM6npYudqZiRh2Y8AI4B1k
	 Ez49fwkDKORrxaOJn7+zj3hD3a8NyTxQtYj//KDcuQm8I/fLc8/wtu4+H2MOHSLLR
	 W2X3+UNQRUl6dFuFODWNaHnVFZtIbW2dq6Lo9rhig2Q9YeGx0pCnbzeoaKLSqC58m
	 /6vDD8Wy/5jZv0AK3O3YRitj22ZKAM+N12X3rYr0yvJ0hAb7yXXLwIflxiQEb8zpb
	 /mCplB+Oz86IDJvs2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbg4-1rhtNl2H8e-00Kxkm; Mon, 15
 Jan 2024 06:27:22 +0100
Message-ID: <848c719c-daa2-403a-b7eb-f172b4236dc1@gmx.com>
Date: Mon, 15 Jan 2024 15:57:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] kstrtox: introduce a safer version of memparse()
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM, ddiss@suse.de,
 geert@linux-m68k.org
References: <cover.1704422015.git.wqu@suse.com>
 <f972b96cad42e49235d90b863038a080acc0059e.1704422015.git.wqu@suse.com>
 <64def21a-2727-455b-9e35-e2a56d2f1625@infradead.org>
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
In-Reply-To: <64def21a-2727-455b-9e35-e2a56d2f1625@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5CmCsA2KrGFN1660ZZ6Fw5boWVfnwNgEfD8SQxdTe95sR24pJ5U
 cwMVFyeCdgZolIokIjCzCmrTrcYDHH+6rq36CbDiqjXVwYhT6RfjeDTVvrTVUDAeVvGMDoz
 KCRa38c5559YZ6eASfEF9o2gLb5c2jY4HpCJ3swk3yaJHnTThsdObMCqZsy37fX5RjCR5iq
 7hDjDUTu2QU+BsEH+XW8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wAWENv8Y+4Q=;d5JEhPuh1tIsRx9RgKwpd658CC5
 WYe5v5Dc50tM0ygydYabpys81qyokGhgNHbfPeULdtGSaLe7nHR5t+pyDXDIVJEd0Dd+zTiCo
 cM9ES7ENPY+T/niaEVRODo75md3g/iLpiGSbUbLPuMT08xfMTYgiJYsUr4XBnhfvRjNHjUOMF
 0Ag37SsncU9rZF4WC1BDPL8H5ZJlIp9DUlojUJ2hLpLli88pOpDRoYEYhYOqqLlFGNLvAcPKQ
 /u1BzIj5Ob/t82hVWuTCSeo8EDErsFIlT2Xp+t5wEIe6hEyeHyrQAHckqEHsx5B2+w/vLnQ1u
 WboT+mB5G/HgiPyMS/DU6Bk8FjWdDBgqlupv3fNJr869oa/nvFIe3Bi3WW5fNGq4VGkxErN5X
 ZJ+ffBQCdB5RxDWJN3pEVSnaM0kjA1ZU0/JbU5bAyINovn4oS2Su4i86OLwHvu6cbQxRcfMrb
 3dZMRmB4wA2FLFCeus+9Qlu3isMBc+SQq+an4uLlNgnExmXw/yRoZTEG8+VQFqmFMakS8yo+p
 3Sl2mmYzrEh/c85h9DXie6i1+RQpDfCRWJgrvILx2lNIdlA8nkQS6Mde8pUwJhz4cjN1JHKqf
 N9vHRwvJp9dNnTxKL8ys2VNiKN8PkWjuOyp+BKDg2Z/gVJj1qiey/SLXPjQ2UfCx+KLEzgSOK
 BYbhyIomNg6LSyBzzkpeqmiX3kJOCiaIKd3PYvrlSN3gFWjiZtWQ5epET3whNoUNcyFKVjgvv
 2UlIHOxkVjHcIQcDL6AdWI8b7p4sGcDP5bRof4B+1pN4Zyf2dySTOWHokAiAYU9sDnIbSpvFG
 HBYTj8YLtl6RVyxr7zE7XjXjo6w41Xx788LpPC3TNnWeEatoNISdCRNQBSMdtUOh3FXsAbC4g
 olm3nk9Iodiz41u0GhKwSYUywb6NwdhrcscMIqY6iRd+2AL3BUtbQbNqh6jXgqeLzJW7MtNpX
 UREzenhHDipJbdFx3AOS0WmkQmM=



On 2024/1/15 14:57, Randy Dunlap wrote:
[...]
>> @@ -113,6 +113,105 @@ static int _kstrtoull(const char *s, unsigned int=
 base, unsigned long long *res)
>>   	return 0;
>>   }
>>
>> +/**
>> + * memparse_safe - convert a string to an unsigned long long, safer ve=
rsion of
>> + * memparse()
>> + *
>> + * @s:		The start of the string. Must be null-terminated.
>
> Unless I misunderstand, this is the biggest problem that I see with
> memparse_safe(): "Must be null-terminated".
> memparse() does not have that requirement.

This is just an extra safety requirement.

In reality, memparse_safe() would end at the either the first
unsupported suffix after the valid numeric string (including '\0'),
or won't be updated if any error is hit (either no valid string at all,
or some overflow happened).

For most if not all call sites, the string passed in is already
null-terminated.

>
> And how is @retptr updated if the string is null-terminated?

E.g "123456G\0", in this case if suffix "G" is allowed, then @retptr
would be updated to '\0'.

Or another example "123456\0", @retptr would still be updated to '\0'.

>
> If the "Must be null-terminated." is correct, it requires that every use=
r/caller
> first determine the end of the number (how? space and/or any special cha=
racter
> or any alphabetic character that is not in KMGTPE? Then save that ending=
 char,
> change it to NUL, call memparse_safe(), then restore the saved char?

There are already test cases like "86k \0" (note all strings in the test
case is all null terminated), which would lead to a success parse, with
@retptr updated to ' ' (if suffix K is specified) or 'k' (if suffix K is
not specified).

So the behavior is still the same.
It may be my expression too confusing.

Any recommendation for the comments?

Thanks,
Qu

>
> I'm hoping that the documentation is not correct...
>
>> + *		The base is determined automatically, if it starts with "0x"
>> + *		the base is 16, if it starts with "0" the base is 8, otherwise
>> + *		the base is 10.
>> + *		After a valid number string, there can be at most one
>> + *		case-insensitive suffix character, specified by the @suffixes
>> + *		parameter.
>> + *
>> + * @suffixes:	The suffixes which should be handled. Use logical ORed
>> + *		memparse_suffix enum to indicate the supported suffixes.
>> + *		The suffixes are case-insensitive, all 2 ^ 10 based.
>> + *		Supported ones are "KMGPTE".
>> + *		If one suffix (one of "KMGPTE") is hit but that suffix is
>> + *		not specified in the @suffxies parameter, it ends the parse
>> + *		normally, with @retptr pointed to the (unsupported) suffix.
>> + *		E.g. "68k" with suffxies "M" returns 68 decimal, @retptr
>> + *		updated to 'k'.
>> + *
>> + * @res:	Where to write the result.
>> + *
>> + * @retptr:	(output) Optional pointer to the next char after parse com=
pletes.
>> + *
>> + * Returns:
>> + * * %0 if any valid numeric string can be parsed, and @retptr is upda=
ted.
>> + * * %-EINVAL if no valid number string can be found.
>> + * * %-ERANGE if the number overflows.
>> + * * For negative return values, @retptr is not updated.
>> + */
>> +noinline int memparse_safe(const char *s, enum memparse_suffix suffixe=
s,
>> +			   unsigned long long *res, char **retptr)
>> +{
>
> Thanks.

