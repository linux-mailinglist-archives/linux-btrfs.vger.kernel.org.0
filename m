Return-Path: <linux-btrfs+bounces-1501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC2F82FECB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 03:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43761F21D4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 02:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFD01C11;
	Wed, 17 Jan 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LMGWha6N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB215CC
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458382; cv=none; b=omX5ZXF6faCafa7Y2gQ5w8mvZAvplYX0TXPsjKWb47QaC/I0dyfkO72T/qdO7p4zsRqe0kNcrPqL2DrXcufNTYeSfUDguoAkl6vz4uqGiXcmiZlSYsq+Bg/8khfUUGurBXyGM7FEVKQDrpPPYuIBb2IjN2SzJhMULdvU5zCyBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458382; c=relaxed/simple;
	bh=zmcebiIEIvMASitbu8HY5Ki2gfMON+Nsxi7iwClRliI=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=Vh+kNIjNFmtyw6FOyH0uCDKu+kRyiIWh3qqgdtRGpj8uvBPFrtULXLgVyCRy27ibXgP/k8tEaFG/Y58+1jnS9MXhwblG3MLhYQrGVztEKu95C5PJGUHaCP8ipIMwIgV2DPElnmuBQLaZE0ySXcfrM4wdpIbfgEIGoXRSy1nCSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LMGWha6N; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705458376; x=1706063176; i=quwenruo.btrfs@gmx.com;
	bh=zmcebiIEIvMASitbu8HY5Ki2gfMON+Nsxi7iwClRliI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LMGWha6NfLBerbtmfnzhisXeC6aSyzu0YRD/5Hg09yrObQIUhtxs6etVUxUHz3so
	 DbCWDMaEOudaWD/Rp5+gLjNL1+4wF9cgIS/GRAdO47jmUOlGdJjmwK7b/pJzG9gDf
	 qkdr4F3QD2Cc7d3c0Z2qkD58SJ35fBoU/Ua2dDZGWJfn+rXsuZ/TovZCNaTz/DoPM
	 45PBQowxsAZAN9TLPNVdfflkt9Xm6+X1Th0rk2I9QB21VADFytjGZE8CVpXn+4Erf
	 ZAOy/zeAMUnMZ911gOoIaoYPnbHt1ryHtyEH4c5Ur97YbZAtNE9WaUhdEafO2V2cJ
	 pETGlXtNa/3RGjzvsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTqg-1rbUsT2mBS-00WWVb; Wed, 17
 Jan 2024 03:26:16 +0100
Message-ID: <7a0ed26a-1db7-4eb5-9522-afb21f557db9@gmx.com>
Date: Wed, 17 Jan 2024 12:56:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs-progs: convert/ext2: new debug environment
 variable to finetune transaction size
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1705135055.git.wqu@suse.com>
 <4c2f12dc417a192f4acfd804831401aadeeb9c42.1705135055.git.wqu@suse.com>
 <20240116183152.GC31555@twin.jikos.cz>
 <8d987075-18be-4866-80da-03415b6da7ff@suse.com>
 <20240117010806.GI31555@twin.jikos.cz>
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
In-Reply-To: <20240117010806.GI31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UZajEM8aoTaKcKs8NfTZeecLzXtCcqQSYALiVl+NGa09SLx/VGY
 1AA/jtJXbumTl3RzYEHDwFgX2wrKcsWmMLjHV+3QWuG0Xu5rGVw1w7rkxq8oH+jvRzsU6f5
 DEgtU5pM0P+YAEvDcsEgALY3QLkIkGOnzszQTxdn7qIh/3Fzz59KZHClAeEACjDCGo/X3e/
 xXQoWzSkTFzLRkXK3lckw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pKgC9wjluO0=;+1t1QZGrV3Gc4ZgAuSHuOYaYqVS
 B+8pn3BqTpb47z69lcmF7h/hgoYlOYmn4xNFssaufbKCFg3WxiFVJf9ub6rgUFXwRvGjXWQmN
 tgsyVwqcW2DnGC2LrfuAPHe9O/IB4FCp9Wpo+wgBUTUvtN6IkpD7w7p7TKZquqLPs47vegckF
 5GDzHti4yK6xGkdfm52sr9hpIzspcULX/VSCOSg/xDO6EMyE8DIgA74CzZjQa6Q5+DdB8Z2Xg
 /V1bY/8FzdV76WdmvW4baww0nOR1bUIGBZ2e/MmGQRLegb13bESMxisDs5VR3KPru8olviXf2
 t3X/e1Q05PxG1X6JM9dNMdCKIfJJIjrVwVmgPNHYpv/vXgBbLX0Rp08GbfV6ztbg9ui1a+utT
 3Y8SE3AWp4GMPcdf0q7Y5vROj47TDXBoxIYZMxGIz7A7Cje06qZIG3vQB2ydQaKorR1uCWYXD
 iIK0b+UlV+FqYPpHOJFSDJVqqjEpBCvVc5iEYBJvc/cnE+0ePmU0otmix6oBfxIi9jsS2uJyZ
 e5eXXstf15LrmmMryMCMGpiAO6hgV5MuD6Em3R96x+77HGcr8cVDiRf6rWJE0j/QVuU1K3pO3
 2o1X76VQj4J+DCA3pFeSYcordtCohPbGru90e3a9C6kkTcBx2TtQEijGzUJs4IRVkKkXsqzJ6
 a8ss1gqv6FtV6FotBOJew+wAP4TammO+VEHgC2S4SKmgnpKJ8GkUY9eYuCwgeKBnD817EzfmS
 j37RMKflM0hYtGpiOlvelyZXLZg1P7A6MwDzUdOFO8WNFCs088DVhvqabbm1d5YuNc/XlhALV
 fwzcnaNuXqQR6oBVzS5btft5DSxm1MTRCzwHJ8mJKwjahGS9Z3+G0NRXVAZUoC2LUYoNpH0CW
 OuTSpv8thu76hIrZL7/MH5raE+sQLEuGF5rgio9D76fAHQsppvRM4YrH83TZ5bS1L/hYlMJ/2
 AyK75lVOGOYkOEv9xbsZ015tR7A=



On 2024/1/17 11:38, David Sterba wrote:
> On Wed, Jan 17, 2024 at 06:50:11AM +1030, Qu Wenruo wrote:
>> On 2024/1/17 05:01, David Sterba wrote:
>>> On Sat, Jan 13, 2024 at 07:15:29PM +1030, Qu Wenruo wrote:
>>>> Since we got a recent bug report about tree-checker triggered for lar=
ge
>>>> fs conversion, we need a properly way to trigger the problem for test
>>>> case purpose.
>>>>
>>>> To trigger that bug, we need to meet several conditions:
>>>>
>>>> - We need to read some tree blocks which has half-backed inodes
>>>> - We need a large enough enough fs to generate more tree blocks than
>>>>     our cache.
>>>>
>>>>     For our existing test cases, firstly the fs is not that large, th=
us
>>>>     we may even go just one transaction to generate all the inodes.
>>>>
>>>>     Secondly we have a global cache for tree blocks, which means a lo=
t of
>>>>     written tree blocks are still in the cache, thus won't trigger
>>>>     tree-checker.
>>>>
>>>> To make the problem much easier for our existing test case to expose,
>>>> this patch would introduce a debug environment variable:
>>>> BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD.
>>>>
>>>> This would affects the threshold for the transaction size, setting it=
 to
>>>> a much smaller value would make the bug much easier to trigger.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    common/utils.c        | 62 +++++++++++++++++++++++++++++++++++++++=
++++
>>>>    common/utils.h        |  1 +
>>>>    convert/source-ext2.c |  9 ++++++-
>>>>    3 files changed, 71 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/common/utils.c b/common/utils.c
>>>> index 62f0e3f48b39..e6070791f5cc 100644
>>>> --- a/common/utils.c
>>>> +++ b/common/utils.c
>>>> @@ -956,6 +956,68 @@ u8 rand_u8(void)
>>>>    	return (u8)(rand_u32());
>>>>    }
>>>>
>>>> +/*
>>>> + * Parse a u64 value from an environment variable.
>>>> + *
>>>> + * Supports unit suffixes "KMGTP", the suffix is always 2 ** 10 base=
d.
>>>> + * With proper overflow detection.
>>>> + *
>>>> + * The string must end with '\0', anything unexpected non-suffix str=
ing,
>>>> + * including space, would lead to -EINVAL and no value updated.
>>>> + */
>>>> +int get_env_u64(const char *env_name, u64 *value_ret)
>>>
>>> There already is a function for parsing sizes parse_size_from_string()
>>> in common/parse-utils.c.
>>
>> Unfortunately that's not suitable.
>>
>> We don't want a invalid string to fully blow up the program, as the
>> existing parser would call exit(1), especially we only need it for a
>> debug environmental variable.
>
> I see.
>
>> Should I change the existing one to provide better error handling?
>> (Which means around 16 call sites update), or is there some better solu=
tion?
>
> Yeah, the parsers used for command line arguments are fine to exit as
> error handling but generic helper should not do that. There's
> arg_strotu64, so I'd keep the arg_ prefix for helpers that will exit on
> error.
>
> Looking at parse_size_from_string, it should return int or bool and the
> value will be in parameter. This is cleaner than using errno for that.
>
And I can take it one step further, make arg_* helper to utilize the
proper parser version (which would return an int to indicate error), and
call exit(1) to error out.

By this, we can share the code and still keep the behavior.

Although it would mean I have to change the call sites.

I'll craft a proper series for the conversion/cleanup.

Thanks,
Qu

