Return-Path: <linux-btrfs+bounces-1224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4E823C50
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 07:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B14B24C8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9E200A6;
	Thu,  4 Jan 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AJjKAzYK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A71F927;
	Thu,  4 Jan 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704350555; x=1704955355; i=quwenruo.btrfs@gmx.com;
	bh=xida4jYMBmqOqXEefFj9KpfEQTtSxYYAjtuqmqphSmI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=AJjKAzYKykbZypYugkmRWSuMZ8Z2EMUp0jgQM1BWrY2P+rNfwsKfQPYb/WovdZSB
	 6dVjuctFqGqhGEvHIuBVPUgbVJTV/RqufXjds0eeOfdsaSKNC+Azi59O3FFaEW1Hm
	 Rp2mnXOa2DCZ4dRVOPBiadYZ47wPlnVor1hosRzyNCZ4z043ge45D6nmN6JC6eZuZ
	 h407avVR3H+4YM0daRzJlTPE58trRVg21/1nTsUtiGti6dNLNPXiBJ88jslHp7SR5
	 uy9Ey53UhwMuVRSSpuhNK3Sq/9CEzw06jp005srBn5eEAAkmZVEkdYA0fKuC73L83
	 +6kfA1AExe9vKjGhCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsUp-1rQX252zp1-00HKa6; Thu, 04
 Jan 2024 07:42:35 +0100
Message-ID: <d321160b-b895-4049-8ac6-4ff6ce5df7d4@gmx.com>
Date: Thu, 4 Jan 2024 17:12:25 +1030
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
In-Reply-To: <248554b4-a549-4e94-835c-3430403b746c@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CrVsbMwMt7+YQRPUOmwVq14/SXF/4aS6iv4NElSkHwvms7ll4/O
 eX37P/ub/HxExSR/zXC5y3VdXKAylUTdGxh+BK4HshhShXDVVwlBllXi2BWQeBUiMzaz7Ep
 C1C94hPv5pjdC03MEHfSaeFeAmHyr5GKNgDJ0JmtLM3/xGoiZykrAvwwkGAFfUszqj+1wHX
 weKmfAoReFjUyOl4YaAhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:16ck9G6Xcy0=;w2lX4z2ysrT18sPfv7Hmmi8ZSNo
 Dhu7UaiFK+nHDkG2WdfO3xdGnsdMxmhMRkIr7HGGNy0C3VpYCcv5W9elFq5eRzX2MhdMcgCA3
 X55yFCWzWaopj36btoDHcVbInAnfkFv3spR8YcpIxbS3MyrM9KkD0KLfnXHt406Ibiqv/vtWc
 B4eut9gP9wHV+GIr/zuMRvHR5+osQwpkjnkg+7uNDB7OMYv/q65AZsIvlq6DSKeAXav1HSOsx
 p60STJtIUZXETDIFp4DbJWfN7Ebr1CJ9MHyPW+WwrTwnN64v+FTJSVKfnQEMoYNB50h0CzJtu
 BRhtlhwLsP7F/gnDlwxThXS/Nv5/pMAmEm70CyXhAO8/eSijp27X0M5agFipfoVKun4xDFUwk
 LqExkXSoSy0Lk9LIaTwFoR2chSdTmJ8TAvnSq6iXuf6BabR8ndhBwgOS2wkrcltC5Ec9zWVqk
 GIVHjIvPLn1jE5rBcaZaaR5HeTcs5nnM5hxzu+MnznNEBnFtxZ+dBHOPSuPTfwSkBSmuBmgTm
 JhCEsiKdxebL6IyXmiSdGb5MHPKeiraoucV6deBi3KTKQW7ZYH5GnyiET0pf52+fMyx/pXtlC
 kaGD36IWeegOOsFsqdkZ7s+pFErIHFR5K8p9QYm/dKXx7v8s/oA0yarvKGA0tWhf69QZdBcLI
 Gm/HIACwb3tzHkbnfT5B2OIb4i8pQJXi/fBsTvssdsXgUVSmid4Nq+aRLvL6jwh5QSp/125ws
 jSx3HvEB4P10V3jt71lo+4aI5ANMYMBX+Ep9+WU2EqFZ9RVFty/snti5LzQzEqNfsyf5xgEWV
 wGe+X9oEzdzxmU9zHL9UKsm6fz9fFhOgIzKzWcjcjB5lUXoIfBRGEv1FWbQsn5+TBkS1Pbjs5
 36F6V0Z3dDjxS5T9z+AdasprB9r3vjHYmSM7tHPBmb76cFI3fUAC1h48V+MNhT9VNu+dCKvMC
 vxWwNt375Bhk1oaR4nuDpDgcfoc=



On 2024/1/4 17:00, Randy Dunlap wrote:
> Hi,
>
[...]
>> + *		parameter.
>> + *
>> + * @suffixes:	The suffixes which should be parsed. Use logical ORed
>> + *		memparse_suffix enum to indicate the supported suffixes.
>> + *		The suffixes are case-insensive, all 2 ^ 10 based.
>
> 		                 case-insensitive
>
>> + *		Supported ones are "KMGPTE".
>> + *		NOTE: If one suffix out of the supported one is hit, it would
>
> 		                                         ones
>
>> + *		end the parse normally, with @retptr pointed to the unsupported
>> + *		suffix.
>
> Could you explain (or give an example) of "to the unsupported suffix"?
> This isn't clear IMO.

Oh, my bad, that sentence itself is not correct.

What I really want to say is:

  If one suffix (one of "KMGPTE") is hit but that suffix is not
  specified in the @suffxies parameter, it would end the parse normally,
  with @retptr pointed to the (unsupported) suffix.

The example would be the "68k " case in the ok cases in the next patch.
We have two different cases for the same "68k" string, with different
@suffixes and different results:

	"68k ", KMGPTE -> 68 * 1024, @retptr at " ".
	"68k ", M -> 68, @retptr at 'k'.

I don't have a better expression here unfortunately, maybe the special
case is not even worthy explaining?

>
>> + *
>> + * @res:	Where to write the result.
>> + *
>> + * @retptr:	(output) Optional pointer to the next char after parse com=
pletes.
>> + *
>> + * Return 0 if any valid numberic string can be parsed, and @retptr up=
dated.
>> + * Return -INVALID if no valid number string can be found.
>> + * Return -ERANGE if the number overflows.
>> + * For minus return values, @retptr would not be updated.
>
>   * Returns:
>   * * %0 if any valid numeric string can be parsed, and @retptr is updat=
ed.
>   * * %-EINVAL if no valid number string can be found.
>   * * %-ERANGE if the number overflows.
>   * * For negative return values, @retptr is not updated.
>
>
> For *ALL* of the comments, I request/suggest that you change the "would =
be" or
> "would not be" to "is" or "is not" or whatever present tense words make =
the
> most sense.

No problem.

Thanks,
Qu

>
>
>> + */
>> +noinline int memparse_safe(const char *s, enum memparse_suffix suffixe=
s,
>> +			   unsigned long long *res, char **retptr)
>> +{
>> +	unsigned long long value;
>> +	unsigned int rv;
>> +	int shift =3D 0;
>> +	int base =3D 0;
>> +
>> +	s =3D _parse_integer_fixup_radix(s, &base);
>> +	rv =3D _parse_integer(s, base, &value);
>> +	if (rv & KSTRTOX_OVERFLOW)
>> +		return -ERANGE;
>> +	if (rv =3D=3D 0)
>> +		return -EINVAL;
>> +
>> +	s +=3D rv;
>> +	switch (*s) {
>> +	case 'K':
>> +	case 'k':
>> +		if (!(suffixes & MEMPARSE_SUFFIX_K))
>> +			break;
>> +		shift =3D 10;
>> +		break;
>> +	case 'M':
>> +	case 'm':
>> +		if (!(suffixes & MEMPARSE_SUFFIX_M))
>> +			break;
>> +		shift =3D 20;
>> +		break;
>> +	case 'G':
>> +	case 'g':
>> +		if (!(suffixes & MEMPARSE_SUFFIX_G))
>> +			break;
>> +		shift =3D 30;
>> +		break;
>> +	case 'T':
>> +	case 't':
>> +		if (!(suffixes & MEMPARSE_SUFFIX_T))
>> +			break;
>> +		shift =3D 40;
>> +		break;
>> +	case 'P':
>> +	case 'p':
>> +		if (!(suffixes & MEMPARSE_SUFFIX_P))
>> +			break;
>> +		shift =3D 50;
>> +		break;
>> +	case 'E':
>> +	case 'e':
>> +		if (!(suffixes & MEMPARSE_SUFFIX_E))
>> +			break;
>> +		shift =3D 60;
>> +		break;
>> +	}
>> +	if (shift) {
>> +		s++;
>> +		if (value >> (64 - shift))
>> +			return -ERANGE;
>> +		value <<=3D shift;
>> +	}
>> +	*res =3D value;
>> +	if (retptr)
>> +		*retptr =3D (char *)s;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(memparse_safe);
>> +
>>   /**
>>    * kstrtoull - convert a string to an unsigned long long
>>    * @s: The start of the string. The string must be null-terminated, a=
nd may also
>
> Thanks.

