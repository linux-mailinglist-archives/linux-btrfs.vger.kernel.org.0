Return-Path: <linux-btrfs+bounces-1039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27360817B6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924621F21D2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBE67204D;
	Mon, 18 Dec 2023 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UD6QOVXm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FD071450;
	Mon, 18 Dec 2023 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702929175; x=1703533975; i=quwenruo.btrfs@gmx.com;
	bh=A9vOEdNXA+RTh6Hw7H93/1mPcxxWI0jQPWHGe06FFBI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=UD6QOVXmBD26IRUI1EzefgnhSvRnJkc371Af9z5AVrpNYsBrSK0Zkmo6ydr6IWPE
	 l7t/BvYKInYkH6rrpnrEzOagrYY9lcjw+UaEtCO7ci+8CREcFjAD9+78Um04RdQTq
	 0Dtqd3MdEOxd5dP0SzxjaP5tBzZCjffFugHcqtJ44/9YQzYGzcmDR+uEiKZSNXxWP
	 HTycNbIOXFdGpFPDUTQX0rYelpbd6PsPMuhOlsgZExvBWodjkHklIE83EzwEoFKej
	 FhrtdT4d8duumZDAmWhoyet+rUTRlb2/u05A8sMPZTrd0Lp+nhtNzBHWnN2QnGgTF
	 BrTXw9lKomnVCyq0Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.108.148]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8ob6-1rCU2S0qwQ-015p9G; Mon, 18
 Dec 2023 20:52:54 +0100
Message-ID: <3ca2a681-79c1-4478-b17f-3128a7018b2d@gmx.com>
Date: Tue, 19 Dec 2023 06:22:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
To: David Disseldorp <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <cover.1702628925.git.wqu@suse.com>
 <11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
 <20231218235946.32ab7a69@echidna>
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
In-Reply-To: <20231218235946.32ab7a69@echidna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I+c8Kc9OiMMdaAHGaBUZ0eLli9zuEU3t092r7fawYoLirdEhs8A
 Fto7K3+7dks0Kzf7fIujDxkzg6Gh8rQFP+BKzCVt/EWoPRKwnalAGU4n12Zp5658aFeXN6n
 ZpkCUA0e1rxyv8RuIqqrDr9cybzPgv7r4u7M3kSCM20ZbZx/3gRWM810PH176INqb9J8MSO
 E8d9x/Ol76h3mIzialg0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3VwJOFl0Eew=;+WQ3z8Ye2zb3Zp/+/9aWxzUlDDa
 N4izoiVtMNpIAKAE3RpIQQ1CbcRBksam1gAPbwp8LyClXZc3D+jveSXbF+PFyRVStzDNAfxPy
 kvNBCk4VWpajreg/3koPnbgC9i/rV0Ppub/1FvNUEzVO9Gtdyb+iiNLU8DMvO3Ue43kSMY/ll
 DjFiDKUPvuBA4C2SWGVrDik1GJ/odksVa1igrYQ55c5TGaHwlpQFIpgXKZKa/bcNRrMh0Elti
 mYsRsh1XD6Rybh4cp3CowvjiY2tfwKJS1UHXtBpYTAAKEa8bUhico2NhgzlWCe9RQ225EFnXI
 IbM0mAcRVQB/Wl97CZpmLrRo3F//Ch1hJL8t5pfcB7zTMJQj6B1q+Zhjmi+6RDBkT0tomFdpf
 w3H1CZvtBgkbKYs9SqPYZMZ1JMIcnm6YUlFB8hBQ270rqwghxPLzWLRX/VG5NV/mFJUNQ81vB
 RJWzOvB+5FnJpCDDYr5/rdpyXYl5H6hjN1eXYuAm2DQ1PrqzDZ2FuR2oAMcpFLV5oVuCqlDgn
 8OuvBfxIFVQtgcrVzPCToioprbMeBfgHTUg3+l9OWZYTY4DuKDq4vu+9RFoMcuU0Pofst+eh+
 YLqJpBuQd/vxFv4hI8Np3dqknIAjlBzlXskuVcdLfvY/rc7nXbXbuRnkjiRqCkyIUMIe3lWb/
 HuoNa2W9cYYLLVCo6exadIlOPbb8SWICdXdPpma9ExJBUzZ2C+zsoJrdYYxdyVPrTlMdZNT+1
 7zeJQIq6N0Hy9BSzvFTjCAzSUEOm7uD89P0efeozmfTIz7fg2V4yYJJbpvX0eeU/FEc0WLhaM
 rTuaNMmwcYewozpdYcZiniYsr69vyAFC41en7zyIEL3x+SsQjua/i1nO2ypKCHKj0gTiYEmX4
 guHG6KWM4tJY1FZBXKdNOAij1/xSeYsCWWtZ626l+yN6ZtVmMEO9sHCU+oFxeiznVbvABjyr8
 dVW6VVE8X5YGDIAhFASuB7x2dj8=



On 2023/12/18 23:29, David Disseldorp wrote:
> Hi Qu,
>
> On Fri, 15 Dec 2023 19:09:23 +1030, Qu Wenruo wrote:
>
[...]
>> +/**
>> + * kstrtoull_suffix - convert a string to ull with suffixes support
>> + * @s: The start of the string. The string must be null-terminated, an=
d may also
>> + *  include a single newline before its terminating null.
>> + * @base: The number base to use. The maximum supported base is 16. If=
 base is
>> + *  given as 0, then the base of the string is automatically detected =
with the
>> + *  conventional semantics - If it begins with 0x the number will be p=
arsed as a
>> + *  hexadecimal (case insensitive), if it otherwise begins with 0, it =
will be
>> + *  parsed as an octal number. Otherwise it will be parsed as a decima=
l.
>> + * @res: Where to write the result of the conversion on success.
>> + * @suffixes: A string of acceptable suffixes, must be provided. Or ca=
ller
>> + *  should use kstrtoull() directly.
>
> The suffixes parameter seems a bit cumbersome; callers need to provide
> both upper and lower cases, and unsupported characters aren't checked
> for. However, I can't think of any better suggestions at this stage.
>

Initially I went bitmap for the prefixes, but it's not any better.

Firstly where the bitmap should start. If we go bit 0 for "K", then the
code would introduce some difference between the bit number and left
shift (bit 0, left shift 10), which may be a little confusing.

If we go bit 1 for "K", the bit and left shift it much better, but bit 0
behavior would be left untouched.

Finally the bitmap itself is not that straightforward.

The limitation of providing both upper and lower case is due to the fact
that we don't have a case insensitive version of strchr().
But I think it's not that to fix, just convert them all to lower or
upper case, then do the strchr().

Would accepting both cases for the suffixes be good enough?

>> + *
>> + *
>> + * Return 0 on success.
>> + *
>> + * Return -ERANGE on overflow or -EINVAL if invalid chars found.
>> + * Return value must be checked.
>> + */
>> +int kstrtoull_suffix(const char *s, unsigned int base, unsigned long l=
ong *res,
>> +		     const char *suffixes)
>> +{
>> +	unsigned long long init_value;
>> +	unsigned long long final_value;
>> +	char *endptr;
>> +	int ret;
>> +
>> +	ret =3D _kstrtoull(s, base, &init_value, &endptr);
>> +	/* Either already overflow or no number string at all. */
>> +	if (ret < 0)
>> +		return ret;
>> +	final_value =3D init_value;
>> +	/* No suffixes. */
>> +	if (!*endptr)
>> +		goto done;
>> +
>> +	switch (*endptr) {
>> +	case 'K':
>> +	case 'k':
>> +		if (!strchr(suffixes, *endptr))
>> +			return -EINVAL;
>> +		final_value <<=3D 10;
>> +		endptr++;
>> +		break;
>> +	case 'M':
>> +	case 'm':
>> +		if (!strchr(suffixes, *endptr))
>> +			return -EINVAL;
>> +		final_value <<=3D 20;
>> +		endptr++;
>> +		break;
>> +	case 'G':
>> +	case 'g':
>> +		if (!strchr(suffixes, *endptr))
>> +			return -EINVAL;
>> +		final_value <<=3D 30;
>> +		endptr++;
>> +		break;
>> +	case 'T':
>> +	case 't':
>> +		if (!strchr(suffixes, *endptr))
>> +			return -EINVAL;
>> +		final_value <<=3D 40;
>> +		endptr++;
>> +		break;
>> +	case 'P':
>> +	case 'p':
>> +		if (!strchr(suffixes, *endptr))
>> +			return -EINVAL;
>> +		final_value <<=3D 50;
>> +		endptr++;
>> +		break;
>> +	case 'E':
>> +	case 'e':
>> +		if (!strchr(suffixes, *endptr))
>> +			return -EINVAL;
>> +		final_value <<=3D 60;
>> +		endptr++;
>> +		break;
>> +	}
>> +	if (*endptr =3D=3D '\n')
>
> Nit: the per-case logic could be simplified to a single "shift_val =3D X=
"
> if you initialise and handle !shift_val.

Indeed, thanks for the hint!

Thanks,
Qu
>
>> +		endptr++;
>> +	if (*endptr)
>> +		return -EINVAL;
>> +
>> +	/* Overflow check. */
>> +	if (final_value < init_value)
>> +		return -EOVERFLOW;
>> +done:
>> +	*res =3D final_value;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(kstrtoull_suffix);
>> +
>>   /**
>>    * kstrtoll - convert a string to a long long
>>    * @s: The start of the string. The string must be null-terminated, a=
nd may also
>> @@ -159,7 +262,7 @@ int kstrtoll(const char *s, unsigned int base, long=
 long *res)
>>   	int rv;
>>
>>   	if (s[0] =3D=3D '-') {
>> -		rv =3D _kstrtoull(s + 1, base, &tmp);
>> +		rv =3D _kstrtoull(s + 1, base, &tmp, NULL);
>>   		if (rv < 0)
>>   			return rv;
>>   		if ((long long)-tmp > 0)
>
>
>

