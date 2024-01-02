Return-Path: <linux-btrfs+bounces-1195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0568222BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 21:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977412841C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E38168B6;
	Tue,  2 Jan 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="A259hMUY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA4168A4;
	Tue,  2 Jan 2024 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704228943; x=1704833743; i=quwenruo.btrfs@gmx.com;
	bh=gMHU+YJ/gkegHphYhhSdY57QJmZ7UfevcmljOKNvk84=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=A259hMUY6mlOGHZpcbVMQjPdNDRa86L6+nB4+k7XLTCx7EF5ny208dr5wkigGuai
	 ckO/q8sLEjTr9W5+X9nhuJwkRtsEe1Dq7VxWxfZFam3VjUpTC+bVCOQDjP+ko43yn
	 24qrSzNKDXzK1tIJRJCuaTq67sqnie2vZQrMVHbEEIG4ezIuHQaL29gdt8bZfkOqw
	 5t5oOtVZGqp8++9dpuehQO2q1orjriWTUZYZYsUsK1MuXLGfCIaXgQfkNlhm438mO
	 lL5KbjNOzsbnEIIt/oajXFGMklt5mwBrkjrt5JfpXzBxCqLSUeX2peBT+51ljx4R+
	 YTWYtrV7+IgmoR3nAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1rj7Dj2JDN-00XLzI; Tue, 02
 Jan 2024 21:55:43 +0100
Message-ID: <756ac3e8-3d68-40fe-a7d4-1cf6ac77185e@gmx.com>
Date: Wed, 3 Jan 2024 07:25:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] kstrtox: add unit tests for memparse_safe()
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@aculab.com, ddiss@suse.de
References: <cover.1704168510.git.wqu@suse.com>
 <a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
 <CAMuHMdWXRid2hyvMLcQ6f+M1fxBZUPdeSN=3e=-xXNSce4gsJg@mail.gmail.com>
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
In-Reply-To: <CAMuHMdWXRid2hyvMLcQ6f+M1fxBZUPdeSN=3e=-xXNSce4gsJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UmyXHuFoSVhnuT83cFdKK3fd5FHyo1ASrWsEVOMNHuB/hEzFIVk
 4+RA+m49jyEGT62Ja+lu3T+9Oco2BCQSLjpSKnt8R2KNcIYqLPSbEc2vcCWTHtmq3noA1QA
 IF3q4ljyfXLrhkwTz6NrKoxS/0ymL9GBqSYPL6hIVVcCBxispvDgV6//cKt9S4mjpAeaVXx
 yzeNZu1LWgo14kxTqQ0pQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mnR9ez2d0gc=;40hSjPfhcb1LEjj8XRXYIVAvC/s
 yRhPSbTzyIEaZz/4hmQ2xa94yi26O8BiiaDLZPny9EuKTYi8QYyE93cdqWVhtAjR99RpSSrVz
 QgaDbie+gezPujC6gK1Isp8LjrE3PSAazGYBAukmlOe9P3fstlCSTJocNLN6Jpoy9taq/+IIG
 TU6LAuo2ounE3KZydF2T2WjibgGYfeC9Eha/dFIcYQNYstomLQl8oTNClTnssvaRAPgt//NUo
 cf4Q8GMBpQ0cC9wU6fIdSUEGc0uTub9vF+7/10q61HZqb3zLOK/0mh1qoNiyzcM3u79Q5C4xn
 DRcUEzUVk4knE/Rm2SbnylXsbdDdovHvFg+uPlqq+ZoirFCOG32sglymxvDo+PJgdg8C+je56
 1qFjqmnWY3V6DFqSkhyoUdoazjYqNLreqkfXse+bKhL1pnxSU5Tg0rVo/FUsvwpA28LsYdOqp
 dfvi94xhihy80yr4q10Wsdlj9EDBQH5Y0bvS+bAdJAvtnQSfiptb0nX2Usd+3QDkzYVvB1GiN
 erEHW4Q7W+1RFy01zbHIMZ1PG0NqB1L6AY7PjAqvGyjs8vc1YnZrOC/U8vWTxNdjip1NQqHDO
 dr6YHvRdlRAH0Vvq+OXNw5SWambflonG57Dq/JodnGUvazBnqip/yoEMAZzvbRoCTGPYymGVY
 fGynHvbSjQLLhBT6t/vxptb7k4oTjgseskJRtTz6fwdDnim8M90aBV/nIgYYtHuw8ByRWMBGE
 yU0jER45J0obr3TNmg05TTVz9PMV93AcDMQmZZa4lgK2GHWFC3qE0kEzFrBAJXrVTMq8f2qBl
 vvjfYHGuLTclhMueFdX8B7fsh49KUlhiUrk3U4+hRCqm4LYMosKHJXHno7xe5TNDWTIOFNUcK
 g3t77sLHkzFAme09MVHzQtuOdcHix1ZhOV5zV5pJrIyVIbV8EzRf9gyV+fo9AyegQLBqZODp7
 dz63cFM9wpuPVR8WW14ZuLX82zw=



On 2024/1/2 23:53, Geert Uytterhoeven wrote:
> Hi Qu,
>
> On Tue, Jan 2, 2024 at 5:13=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>> The new tests cases for memparse_safe() include:
>>
>> - The existing test cases for kstrtoull()
>>    Including all the 3 bases (8, 10, 16), and all the ok and failure
>>    cases.
>>    Although there are something we need to verify specific for
>>    memparse_safe():
>>
>>    * @retptr and @value are not modified for failure cases
>>
>>    * return value are correct for failure cases
>>
>>    * @retptr is correct for the good cases
>>
>> - New test cases
>>    Not only testing the result value, but also the @retptr, including:
>>
>>    * good cases with extra tailing chars, but without valid prefix
>>      The @retptr should point to the first char after a valid string.
>>      3 cases for all the 3 bases.
>>
>>    * good cases with extra tailing chars, with valid prefix
>>      5 cases for all the suffixes.
>>
>>    * bad cases without any number but stray suffix
>>      Should be rejected with -EINVAL
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Thanks for your patch!
>
>> --- a/lib/test-kstrtox.c
>> +++ b/lib/test-kstrtox.c
>> @@ -268,6 +268,237 @@ static void __init test_kstrtoll_ok(void)
>>          TEST_OK(kstrtoll, long long, "%lld", test_ll_ok);
>>   }
>>
>> +/*
>> + * The special pattern to make sure the result is not modified for err=
or cases.
>> + */
>> +#define ULL_PATTERN            (0xefefefef7a7a7a7aULL)
>> +#if BITS_PER_LONG =3D=3D 32
>> +#define POINTER_PATTERN                (0xefef7a7a7aUL)
>
> This pattern needs 40 bits to fit, so it doesn't fit in a 32-bit
> unsigned long or pointer.  Probably you wanted to use 0xef7a7a7aUL
> instead?

My bad, one extra byte...

>
>> +#else
>> +#define POINTER_PATTERN                (ULL_PATTERN)
>> +#endif
>
> Shouldn't a simple cast to uintptr_t work fine for both 32-bit and
> 64-bit systems:
>
>      #define POINTER_PATTERN  ((uintptr_t)ULL_PATTERN)
>
> Or even better, incorporate the cast to a pointer:
>
>      #define POINTER_PATTERN  ((void *)(uintptr_t)ULL_PATTERN)

The problem is reported by sparse, which warns about that ULL_PATTERN
converted to a pointer would lose its width:

lib/test-kstrtox.c:339:40: sparse: sparse: cast truncates bits from
constant value (efefefef7a7a7a7a becomes 7a7a7a7a)

I'm not sure if using uiintptr_t would solve it, thus I go the macro to
switch the value to avoid the static checker's warning.

I tried to check how other locations handles patterned pointer value,
like CONFIG_INIT_STACK_ALL_PATTERN, but they're either relying on the
compiler or just memset().

Any better idea to solve the problem in a better way?

Thanks,
Qu

>
> so you can drop the extra cast when assigning/comparing retptr below.
>
>> +
>> +/* Want to include "E" suffix for full coverage. */
>> +#define MEMPARSE_TEST_SUFFIX   (MEMPARSE_SUFFIX_K | MEMPARSE_SUFFIX_M =
|\
>> +                                MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T =
|\
>> +                                MEMPARSE_SUFFIX_P | MEMPARSE_SUFFIX_E)
>> +
>> +static void __init test_memparse_safe_fail(void)
>> +{
>
> [...]
>
>> +       for_each_test(i, tests) {
>> +               const struct memparse_test_fail *t =3D &tests[i];
>> +               unsigned long long tmp =3D ULL_PATTERN;
>> +               char *retptr =3D (char *)POINTER_PATTERN;
>> +               int ret;
>
> [...]
>
> +               if (retptr !=3D (char *)POINTER_PATTERN)
>
> Gr{oetje,eeting}s,
>
>                          Geert
>

