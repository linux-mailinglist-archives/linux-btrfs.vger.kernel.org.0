Return-Path: <linux-btrfs+bounces-11169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C62A22811
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 05:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AC01886FDB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CED13AA2A;
	Thu, 30 Jan 2025 04:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ek4ehrGs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793F20322
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738210772; cv=none; b=pg6XAs8vk9ez/pEuRP0A0QSAxDRSPz9Ja9tY5IJkbaqJR1hZ2UshaZv+PkCfqHvCCbwFn08ICD1rjjmXh/7WLNZCYsZMgtYa0lq3cSaG3jpaXiVD/uJ2HHWisM3pEZ2iSNUUcnfXRmx19VAnmy76POFq1wRgK4g0VMDceZYf6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738210772; c=relaxed/simple;
	bh=1rSPtEkWjzYW5csjqjmbALTGoRv4cbC6RcQ5u7GpRu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ibQmRWTYCJs/JELfoBP+DNQD+o9TDZIrtPsvVfuvHyoqIoyUvNmQqAto1DV7efU4Pxwe72mjM2RfZUyCVniqtn/c9p28C8PqX+cB85ciiHED31n7HaVgeGB9znaXJUbqZnDa8KSn7sywNrNHOepM/ny18I4J2vTrqidpZc6ublU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ek4ehrGs; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ab698eae2d9so79707766b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 20:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738210767; x=1738815567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+FfT7fNpDnlTCKf9dWWIkPQSb2h4T8Ctq8TO5d5w6Ig=;
        b=ek4ehrGs8332jCWq87Sqjg+50snM1/bHjQ/Sot5qdGX/iwlvUJKbHy53RXPSWHwIT5
         101Iu5QxbCtFLX1237X3D9C5jMOGMfdqB4Ml4jEXgwnlyULA6X4p77/27UAWIVEIrLg+
         ekMkNcB6T28Em+MI0PXakbBnkJcoGLUuhuuAJosjvE6OPV6khqdJlLBjlvMIuBGYbsam
         4HQDdPE421bhXrKxbB0yut3pYSfu07wz9WAbd3WKwDXQZFB+o9Hzv4RU4t1X8v62YcW/
         IKrEhGZxy+KABxzklSggJesTXSbbhZ1HeIsepdeMDgNhdILf/xdbGXFtFIdBqiY51i6o
         gt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738210767; x=1738815567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FfT7fNpDnlTCKf9dWWIkPQSb2h4T8Ctq8TO5d5w6Ig=;
        b=PuDTAJeedxN1i7x0YaiIN4jYf//y9lzIq8IQx2vsS7aM+kIIfmJzzvT/Gt8tpAwthL
         JD+hXZSi5r/X1NqKYzvqmMt2yN4Xc7leSp9OiyogYgb6aDIZtp4VxJIEOM0HRs1DVHM+
         2byurUBJh7JgNIQpo88/Cpo2fiq1PLiGhphHfLKkbyGpA91chs8rbE7kYFDqtvQk6AMo
         HNcycDaM1NaddpT4QJWCrShExuQ5b4JfFHbDvkCTjN7+s0S8iV50qykK9iaw0ATdpwuH
         0btn834ptMW9Bs3FthRfHKCnU8dX+U7uAYTrsuLhpLVcPsuPDNN9ecni1toygmXJSb/c
         PU4A==
X-Forwarded-Encrypted: i=1; AJvYcCXChRRG5iTUKjRZvdFPGSWDCoJXp7lRxkv2DP+iDxq+9yRNG5Potj+G11dRopTua80ZAjpyqxKnYRjO5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FK00wUuLOi9ooTWbvbWcEZXodzfkKB5UY1ZfPoGm/ES4Fkjs
	9tRaAzcxp+XHL76p/mRNE9m8y6yXfpFKf0c19gSm07XeCU1cyaSXEvXUikPHHti1g9RUKAzQj5+
	gXaEZhQ==
X-Gm-Gg: ASbGncsPC9E7fxzh49LWuh5fnz6us/8/a9q9FKhkfwgFiazZcGpEhYT/Dc+wuMiTF4I
	SSZXUNgM/LhIR26U/HuX4inS5tIBLL/FGeVq8bybHTnP7QdkeAnujzRJRyGw0toYqQ9TWMrWI0t
	DogTOuu7gIHIpFPblfTvN1A2uqHb5ZKODVz1Nq5q2NTXbRGaKsWH+Iq0moov7Gf1rKDsXODgv4O
	SMqIw3FETKqSgALA+6e88dqg0KrISXROly407CNF3ij+d4fN+f0DIBYE7RA01WXMll1CgLvZe2n
	erDvq5/J7r9zL6iyn3uJLU3Au7ET6AgMCTSY7E8XWX0=
X-Google-Smtp-Source: AGHT+IHjxl6Wn8nIH2LWWpy2zDP6BXzhQa7RCHI0a+iW70YjUn7KfnaT3kTEjOvXCO1vObGqe5XFCQ==
X-Received: by 2002:a17:907:7e9b:b0:aa6:993a:259f with SMTP id a640c23a62f3a-ab6cfda4271mr564561266b.40.1738210767151;
        Wed, 29 Jan 2025 20:19:27 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba38bsm356727b3a.90.2025.01.29.20.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 20:19:26 -0800 (PST)
Message-ID: <3f0d8fe5-e631-4c20-a62f-31c22f169324@suse.com>
Date: Thu, 30 Jan 2025 14:49:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree or chunk allocation
To: Nicolas Gnyra <nicolas.gnyra@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
 <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
 <ed415d61-fbb2-4a24-850f-db40052111ff@gmail.com>
 <89fb6391-a2e2-411d-abc2-864f563d680e@gmx.com>
 <4303fcdd-b417-41dc-a0a7-1e2f7e9788e6@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <4303fcdd-b417-41dc-a0a7-1e2f7e9788e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/30 14:19, Nicolas Gnyra 写道:
> Le 2025-01-29 à 18:35, Qu Wenruo a écrit :
>>
>>
>> 在 2025/1/30 06:03, Nicolas Gnyra 写道:
>>> Le 2024-12-03 à 21:50, Qu Wenruo a écrit :
>>>>
>>>>
>>>> 在 2024/12/4 10:32, Nicolas Gnyra 写道:
>>>>> Hi all,
>>>>>
>>>>> I seem to have messed up my btrfs filesystem after adding a new (3rd)
>>>>> drive and running `btrfs balance start -dconvert=raid5 -
>>>>> mconvert=raid1c3 /path/to/mount`. It ran for a while and I thought it
>>>>> had finished successfully but after a reboot it's stuck mounting as
>>>>> read-only. I seemingly am able to mount it as read/write if I add `-o
>>>>> skip_balance` but if I try to write to it, it locks up again. I 
>>>>> managed
>>>>> to run a scrub in this state but it found no errors.
>>>>>
>>>>> Kernel logs: https://pastebin.com/Cs06sNnr (drives sdb, sdc, and sdd,
>>>>> UUID dfa2779b-b7d1-4658-89f7-dabe494e67c8)
>>>>
>>>> The dmesg shows the problem very straightforward:
>>>>
>>>>    item 166 key (25870311358464 168 2113536) itemoff 10091 itemsize 50
>>>>      extent refs 1 gen 84178 flags 1
>>>>      ref#0: shared data backref parent 32399126528000 count 0 <<<
>>>>      ref#1: shared data backref parent 31808973717504 count 1
>>>>
>>>> Notice the count number, it should never be 0, as if one ref goes zero
>>>> it should be removed from the extent item.
>>>>
>>>> I believe the correct value should just be 1, and 0 -> 1 is also
>>>> possibly an indicator of hardware runtime bitflip.
>>>>
>>>> This is a new corner case we have never seen, thus I'll send a new 
>>>> patch
>>>> to handle such case in tree-checker.
>>>>
>>>>> `btrfs check`: https://pastebin.com/7SJZS3Yv
>>>>> `btrfs check --repair` (ran after a discussion in Libera Chat, 
>>>>> failed):
>>>>> https://pastebin.com/BGLSx6GM
>>>>
>>>> In theory, btrfs should be able to repair this particular error,
>>>> but the error message seems to indicate ENOSPC, meaning there is not
>>>> enough space for metadata at least.
>>>
>>> I finally had some time to try out a version of the kernel with your fix
>>> (built locally from commit 0afd22092df4d3473569c197e317f91face7e51b) and
>>> I can now see the modified error message (see new dmesg contents:
>>> https://pastebin.com/t7J5TJ0Z). Unfortunately, apart from that,
>>> behaviour seems to be identical to before. `btrfs check --repair` still
>>> fails in the exact same way. Is this expected? For some reason I had
>>> assumed your change would fix it, but I had forgotten this mention of
>>> ENOSPC so is there any chance of getting back into a writable state or
>>> should I just reformat the drives?
>>
>> For the ENOSPC problem, please provide `btrfs fi usage` output for the
>> mount fs.
>>
>> I believe with the ENOSPC problem resolved, we can let btrfs check
>> --repair to fix the problem.
>>
>> Thanks,
>> Qu
> 
> Thanks for the quick reply! Here's the output of `btrfs fi usage`:
> 
>     Overall:
>        Device size:                  21.83TiB
>        Device allocated:             12.50TiB
>        Device unallocated:            9.33TiB
>        Device missing:                  0.00B
>        Device slack:                    0.00B
>        Used:                         11.35TiB
>        Free (estimated):              6.89TiB      (min: 3.85TiB)
>        Free (statfs, df):             6.78TiB
>        Data ratio:                       1.52
>        Metadata ratio:                   2.88
>        Global reserve:              512.00MiB      (used: 0.00B)
>        Multiple profiles:                 yes      (data, metadata, system)
> 
>     Data,RAID1: Size:324.00GiB, Used:299.59GiB (92.47%)
>        /dev/sdd      324.00GiB
>        /dev/sde      324.00GiB
> 
>     Data,RAID5: Size:7.88TiB, Used:7.16TiB (90.84%)
>        /dev/sdd        3.94TiB
>        /dev/sde        3.94TiB
>        /dev/sdf        3.94TiB
> 
>     Metadata,RAID1: Size:2.00GiB, Used:73.25MiB (3.58%)
>        /dev/sdd        2.00GiB
>        /dev/sde        2.00GiB

The mixed metadata profile may be the problem.

Have you tried to convert the remaining 2GiB RAID1 metadata into RAID1C3?

Or is the problem you're hitting preventing the full conversion to RAID1C3?


Anyway, it also looks like a bug in btrfs-progs, I'll need to dig deeper 
to fix it.

Thanks,
Qu
> 
>     Metadata,RAID1C3: Size:14.00GiB, Used:8.69GiB (62.08%)
>        /dev/sdd       14.00GiB
>        /dev/sde       14.00GiB
>        /dev/sdf       14.00GiB
> 
>     System,RAID1: Size:32.00MiB, Used:48.00KiB (0.15%)
>        /dev/sdd       32.00MiB
>        /dev/sde       32.00MiB
> 
>     System,RAID1C3: Size:32.00MiB, Used:736.00KiB (2.25%)
>        /dev/sdd       32.00MiB
>        /dev/sde       32.00MiB
>        /dev/sdf       32.00MiB
> 
>     Unallocated:
>        /dev/sdd        3.00TiB
>        /dev/sde        3.00TiB
>        /dev/sdf        3.32TiB
> 
> Thanks,
> Nicolas
> 
>>>>> I'm currently running btrfs-progs v6.12 but the balance was originally
>>>>> run on v5.10.1. Is there any way to recover from this or should I just
>>>>> nuke the filesystem and restart from scratch? There's nothing super
>>>>> important on there, it's just going to be annoying to restore from a
>>>>> backup, and I thought it'd be interesting to try to figure out what
>>>>> happened here.
>>>>
>>>> Recommended to run a full memtest before doing anything, just to verify
>>>> if it's really a hardware bitflip.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Thanks!
>>>>>
>>>>
>>>
>>
> 
> 


