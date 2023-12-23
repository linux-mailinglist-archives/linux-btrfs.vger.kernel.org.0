Return-Path: <linux-btrfs+bounces-1128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2F81D36F
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Dec 2023 10:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59E41F228CE
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Dec 2023 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C2D261;
	Sat, 23 Dec 2023 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Vs6zVM+d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB455CA56;
	Sat, 23 Dec 2023 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703325460; x=1703930260; i=quwenruo.btrfs@gmx.com;
	bh=rx3bOFolwdk/BQoY5XxMCc/2twq4gkgfH3/Z0+N7o8s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Vs6zVM+ddudSoUB8vuyQUYzhryOoO0/vOLxqW5HztUpc3U++FyXL7a2jGGfZBk+a
	 So00WgWouqJInPZRllx8hMuojubMRI0+ws4WvIjzlf6fJz25c04mDwrLRr6ez095Z
	 lDMS0sQ7Yyu7IVloBV94rFC0ggkHPVY3QFUVckFqNaw6tMX2v93Nlf12z7HEChuq3
	 Va9LJRF4oM6zjoos1W0bSt5y/M20/7qr2Hsk/6pEM5onQyGW8VJ9ICUlQBgSKRMbq
	 0YnOanInPGlAXcXBWvlDu6UVYuMDgH51FYY+64Q8SxHJLfFhXhzp7YSZE8nRNI/1H
	 PInIcpQbae+HGOqSaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.114.154]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1r1mGI2KAT-00tTdC; Sat, 23
 Dec 2023 10:57:40 +0100
Message-ID: <97b85612-16ab-4099-9a8e-426df510d7db@gmx.com>
Date: Sat, 23 Dec 2023 20:27:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] lib/strtox: introduce kstrtoull_suffix() helper
To: David Disseldorp <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Laight <David.Laight@ACULAB.COM>, linux-kernel@vger.kernel.org
References: <cover.1703030510.git.wqu@suse.com>
 <e042f40ea5cf7fa8251713d5bb7a485f42c5615b.1703030510.git.wqu@suse.com>
 <20231220163856.274f84a3@echidna>
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
In-Reply-To: <20231220163856.274f84a3@echidna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qvyyVcHYE6sfPqlm7fALmfVwPDTVSuga0ioaCQ2l6QBYagPuvdK
 RkRt2AtdR0tzIpNjtc/hodf/0XRWKVsE5netbqaOG1MlY3rkM66+N423T69bMXTnVokPpMd
 rFFS6ik5yHO7SYBWv71GQbqPKfvM71hvFTNitxsqw7YxZXDDHBz0BCOHL9YYCaQzzWN8Yuz
 QzqVZiH1Ssru4Tu4pJYCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BopI6sNVzFk=;Vqn4/qloe4HMK/k6vhI6aSDRd1h
 u/hMLcLr7tv1sDss+wioX8DEFqlCQcROw8lYbtK9nplqEx3C8BVOu4LIKLAfEcsr6gB1gLetQ
 zV/aCb6daFwqYfO3DJMiOqhFIwWPKiFa74p6RlkfSx0syOlVD1xnLE2rPKKPS9VvTW+/LCbLo
 lzV9Gbz1J0qxbceaYvcqssrECLe1P1udlLoGa3791WiFtSuYEMEJ+s8rpataNyJAv1IL6i0qd
 HaIeWl4w4sVE1stx3JW4t67SW/Z8Z2x09Zg8Bowz47F3/xTowvWQi6VKE5JJ/chImeM+mVjci
 nSiiEGzN+Yaf9aZQfUyp5Eqn9FVQiSCwKvekG1q634KNbbWny2IrNXVSz1cb507roHqw3Ii1A
 ak9kj+QTX36SJPYoV4T70ObyV5gwH76Cn2V2qgTBcuCEH5wnbTJgpM5xDh3F+V138zBvbzXbu
 0GS1ia1RzjQ/yKh68NTZka8183wluo1THxWnzK0ihyRDc2nedu5D7xDezGH3aoJ25lX7MJjEE
 EP9wRposgdSdjWRu2FiN2nEFBQZxYQhknWYuKaur3kZgNSE7ba2/KlybLTBBMmyfmFqSgxFiv
 mc/oSEx1WIDSe8PB+iBN9nK2J7iOVnWY7XCQwuOfzp8Jt0XctSYtYR3Mb81kTUOzTv1mfMab/
 NVk8lJOYF4/bcFFiZ7lNVjTiVo83M//jDlpfVnhL6YoSDec9K1b2tz5sxWp2uSe/bg5W8ooAt
 Qp78wujkmgg8jCht0u3libEPSn0F/CUO9wjV/H+0LqF3mRLibrvS2yUPM/vpOxIRAyGIhvtg8
 nhLfR8pXZwbDn3FqqagBNxbEywsPgcDlPcq9kF1NG3a++XSUtyJYuZ2LLh8O1f1+allOho/j4
 Yzavl2lY0dgOZOYz5uKFLuCFGq8JPxXgEQeTRIlljJxRNcxQMharCidaB2FhqnQdRxbn0yT3b
 DVOqXmYBKYeOYEXDbU4UC8zLevk=



On 2023/12/20 16:08, David Disseldorp wrote:
> On Wed, 20 Dec 2023 10:40:00 +1030, Qu Wenruo wrote:
>
[...]
>>
>> ----
>> Changelog:
>> v2:
>> - Use enum bitmap to describe the suffixes
>>    This gets rid of the upper/lower case problem, and enum makes it
>>    a little more readable.
>>
>> - Fix the suffix overflow detection
>>
>> - Move the left shift out of the switch block
>>
>> - Remove the "done" tag
>>    Since no tailing character can already be handled properly.
>
> nit: git am puts this changelog in the commit message when applied.
> Please use `git send-email --annotate` and put it next to the diffstat,
> so that it gets discarded.

Got it.

[...]
>> +};
>> +
>> +/*
>> + * The default suffix list would not include "E" since it's too easy t=
o overflow
>> + * and not much real world usage.
>> + */
>
> ^ this comment is a duplicate.
>
>> +#define KSTRTOULL_SUFFIX_DEFAULT (SUFFIX_K | SUFFIX_M | SUFFIX_G | SUF=
FIX_T | SUFFIX_P)
>
> I think it'd be clearer if you dropped this default and had callers
> explicitly provide the desired suffix mask.

Well, that would be long, and would be even longer as the newer naming
would be MEMPARSE_SUFFIX_*, to be more explicit on what the suffix is for.=
..

And I really want callers to choose a saner default suffix, thus here
comes the default one.

In fact, in my next version, I also found that there are some memparse()
call sites benefits from the newer suffixes (although won't for the "E"
one).
The example is the call site setup_elfcorehdr(). Where the comment only
mentions KMG, but since memparse() silently added "PE" suffixes, maybe
on some mainframes we saved some time for one or two lucky admins.

[...]
>
>
> With the above changes made, feel free to add
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Thanks for the review, but I'm afraid the newer version would be another
beast.

All the ommitted comments would be addressed a in new series.
>
> I'll leave the review of patch 2/2 up to others, as I'm still a little
> worried about sysfs trailing whitespace regressions.

That won't be a problem anymore, the new series would keep the old
@retptr behavior, thus for btrfs part it won't be changed at all.

Thanks,
Qu
>

