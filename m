Return-Path: <linux-btrfs+bounces-20370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23328D0D3D7
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jan 2026 10:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CE0301B488
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jan 2026 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689FD25744D;
	Sat, 10 Jan 2026 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EJkd2Pl4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4A50097C
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Jan 2026 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768036794; cv=none; b=fzMqYbdCK0Qn6IgVsCR5oREGzdTH+MMHyY1JMFkpUerH1/kndhs+5DijSlffWVXMCjm3TLS8RtCskjfg1Xz4Xg0TVy7XRcw2tWqDkwQShdJr9QWQKRyy1sGMrLMiPIFoLyI/zkm/Vf2fbzvXeKpXRXtJL2LXlJybmUbEsavBULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768036794; c=relaxed/simple;
	bh=+ONZ/rilh3hyon7Lfg0sCsGdRG5T5N7HdvYN+S8wEkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZYCYbTBCHRFUFhnWaymvRxM6DhvYjrU896s7r83s8u+KhwV1iCL9sFwntmR9GsMxJJZ5Hp6jnSTUIB3nTf1rGHyXQZNg1u85ILzuMeB84C50S8aTOwR1jexJlg9Ack39YWaKj6VBAv98L3PqWFfLv6+pt3wpXXqC6a+lqFyGYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EJkd2Pl4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso35912065e9.1
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jan 2026 01:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768036791; x=1768641591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xWfjMGVJY8AKSWwN6ILWFZsnpXD741oCbb2826yMKck=;
        b=EJkd2Pl4Hw5FiCUuUw7sI+EqlO8V6qSjYRD0K1ajkGxyn0YpkteIabsAO6qtFToxan
         Au7k3KSjKCKO5vI+ZOmUfIqeQOFZL2FyRt9yrpKciYp3b+784TcRs+v5+OQt6FOrElkU
         GNTcNhmhmX2Z+MtDmz+S2RZa23mJGRWbvZSrna5Pr7pLsOmYLQz/5i2zd6vz64hhkV1M
         mjkhx9FW6cZrAtGb8WAv+AKWEKgGycw6vXSaBGUt2nfWScrAU0uwxRThiB7HyijmtURR
         NSJxlkoMa0U1Bwy02OF4KrK6upfi5hKpe5mnBjVjk1nAFBQOao10dlgY00/DMIvuLvEI
         O7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768036791; x=1768641591;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWfjMGVJY8AKSWwN6ILWFZsnpXD741oCbb2826yMKck=;
        b=vkMpA8OvGj1H3FErPjrPT9dinwEk2Rl9rzqadf7tOHtrBR41TWuGKxDKEVS5WyR0GF
         rOW7/igtTgmLaPctLDa2LlvNM/HI7dZNTgdZcBVG45B10KDnpJdpXVYF8kuzelOh64xM
         aSNiShQFvKd2bz5BdedgsXWUM9aCBrUJVpN0+sf+BYeg5BSMRzjq45staOy21GQJ9A5C
         QaZ0E2T/miuL7dNi7bPWlAKHUBQg0miP399c0IBaDWfdRC0pJe4LRWjBC+d4wx0/FfPA
         V5uxjKJEGitTSCgtew46rnZ6Zw2Z+Jsu50d8xmS8Q/d45nU8DIqmr0tT2C9XdQjM1Soj
         A/ng==
X-Forwarded-Encrypted: i=1; AJvYcCXK06o017YdN91hVsIE8Wdqas5nY7/GNUCAsr35qDvdRGuugeBvUkABRWAVHWzsT0tYc3MiVSifLhuDYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlC6JNiaAWV9y68bDoVUK3eoRvLHJ5V6Zydl7STSu2QH+pWL2
	SCa4p+JgfwrT2TMDfS8+Fm8F/SxX3QQpR/3qhyK9n34E1xtH7xKLmOJ58bBjRXRjwM0=
X-Gm-Gg: AY/fxX5hPfW6IRZmibW6ODSbsOoUGcx4I+0ESjRgFWDeDCndeNpuy36ipBwcoy3/pEq
	W5Wwo6+CIWfZ04mVvU/oWQq8QXvv9SEWRSgn6DCW7O0fJEOAYxs3VV69wCqKaUGZa3QwForS8rr
	yYp+GKzWZiUkreZ1mKEEJkUqPB5qmQCkE2O3yuud8F3Q7BvzLYl90GaUOjxkd0QjG007FUxAJkf
	UyjGT2Nsu1Et+Qx4vhvS+EmgyTQGQO1okCQHdjPonawMi76rFPnFa+04DoAK2i5SHMZMKMJ8GP4
	5TO4cdFuwzisvHTv4mx8O33QZU6LYFuMcRcUv9ZA6tH7w81qxRY5tasnD6q1YGnJhQvy3s8eAR5
	a2uAAVChyu/iLiaEdmBMzIZYHcu3I6MuOxm4VafxGmRujxm1F027H2Xzm1sl5PD6mrIzWvFzOF7
	CE7GbzyY605K03gfBlO3JExKsrZsy+qftgCc6MzSg=
X-Google-Smtp-Source: AGHT+IGC3M1Lh2ZVmmqLeQyDtNov4WazF3f4AGip3hLgcDe64F9PdxxmZSK+QORDfYHZAaMJMqbIbA==
X-Received: by 2002:a05:600c:3556:b0:477:63b5:6f76 with SMTP id 5b1f17b1804b1-47d84b3b3d7mr140143555e9.25.1768036790832;
        Sat, 10 Jan 2026 01:19:50 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6ae39a71sm3544980a91.0.2026.01.10.01.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 01:19:50 -0800 (PST)
Message-ID: <ca831616-d03d-40f7-a7ee-d69168e33fb3@suse.com>
Date: Sat, 10 Jan 2026 19:49:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: After BTRFS replace, array can no longer be mounted even in
 degraded mode
To: Neil Parton <njparton@gmail.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAAYHqBbwwFUD5C7SyRYmrXKYtZfx=_=hQpXrSfk=oi5Dp=QUAA@mail.gmail.com>
 <81d852f0-80a5-423a-8882-c7553f0b4820@suse.com>
 <CAAYHqBaCqPSuu2Tyx7_VLhbb=z05mu1bP5iWMcxrjbUsqHZXtQ@mail.gmail.com>
 <097c661f-5e65-4802-8ac7-b6e0f740eb52@suse.com>
 <CAAYHqBZ48Yf5cd+nNzAnvE1_wHP-0sLyxe18wcdZ_pw3Nq8Ypg@mail.gmail.com>
 <2b2fc9bf-2976-4e33-8363-347f1beaf755@suse.com>
 <CAAYHqBZgrkB9N4_kqMoU+pW8nxvOpALTEmdAS3RtQf+Y2zJGJA@mail.gmail.com>
 <0a75c922-b1a4-46fd-909e-006c4022f8cf@suse.com>
 <CAAYHqBYU=cWgxms9qbFzyzeyLXGtF-1Rum=9keN7wLnRwq=4Xw@mail.gmail.com>
 <d9a1e5b0-be3d-42e2-a090-52e30a2e86f1@suse.com>
 <CAAYHqBbw6qh7Xf+4YNV3mhP6DQthS+EuRY20Sm9Jx0PsQ2XgAw@mail.gmail.com>
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
In-Reply-To: <CAAYHqBbw6qh7Xf+4YNV3mhP6DQthS+EuRY20Sm9Jx0PsQ2XgAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/10 19:44, Neil Parton 写道:
> ok I'll run btrfs device delete missing /mnt/btrfs_raid2 then convert
> it to a RAID1 array

That can be very time consuming, thus I won't recommend for now.

> as I don't have another disk at hand
> 
> there were SMART errors on sdc, sdd was a new disk so that should be
> ok aside from maybe faulty cables which would be bad luck

If it's bad cable (more likely now), I'd stronglly recommend to solve 
the cable problem first, keep the old 3 disks array, wipe sdd so that it 
won't cause any new problem.

Then after verifying sdd is fine (e.g. reading/writing the full disk 
work without error), then replace the missing device with sdd would be 
the best solution.

Thanks,
Qu

> 
> Many thanks for your help and time with this, I'll let you know if
> anything else goes awry.
> 
> Regards
> 
> Neil
> 
> On Sat, 10 Jan 2026 at 09:09, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> 在 2026/1/10 19:29, Neil Parton 写道:
>>> I guess you use 'btrfs dev scan --forget' to removed all devices
>>> before?  I may have done yes by mistake
>>>
>>> mount -o degraded,device=/dev/sda,device=/dev/sde,device=/dev/sdf \
>>>          /dev/sda /mnt/btrfs_raid2/
>>>
>>> This mounts now but I guess ro by default?
>>
>> No it's full RW, so you can do whatever you need to repair the array,
>> e.g. by replace devid 4 with another device.
>>
>> And in that case, I don't recommend to use the sdd again. Explained below.
>>
>>> So now need to remove devid
>>> 4 somehow and then add /dev/sdd back in?
>>
>> Replace is always prefered than add-then-balance.
>>
>> But before all that, please run a memtest first if your system do not
>> have ECC memory just in case.
>>
>>
>> I guess you're replacing sdc with sdd, but the super block of sdd shows
>> it has device id 0 instead of 4, and the device uuid doesn't match the
>> expected one.
>>
>> This may mean the device doesn't properly got its super block updated
>> when dev-replace finished.
>>
>> I don't know why and can only guess, but according to your original
>> dmesg it shows both the missing device (source device sdc), and the sdd
>> have a lot of read/write errors.
>>
>> Thus it may missed several important super block updates, causing the
>> current weird situation.
>>
>> It may be the device itself or not (e.g. bad cable?) but I won't trust
>> sdc nor sdd anymore.
>>
>> Thanks,
>> Qu
>>
>>>
>>> btrfs filesystem show
>>> Label: none  uuid: 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>           Total devices 4 FS bytes used 14.80TiB
>>>           devid    3 size 18.19TiB used 7.53TiB path /dev/sdf
>>>           devid    4 size 0 used 0 path  MISSING
>>>           devid    5 size 18.19TiB used 7.53TiB path /dev/sda
>>>           devid    6 size 18.19TiB used 7.53TiB path /dev/sde
>>>
>>>
>>>
>>>
>>> On Sat, 10 Jan 2026 at 08:54, Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>>
>>>>
>>>> 在 2026/1/10 19:18, Neil Parton 写道:
>>>>> # btrfs device scan --forget /dev/sdd
>>>>> # mount -o degraded /dev/sda /mnt/btrfs_raid2/
>>>>> mount: /mnt/btrfs_raid2: can't read superblock on /dev/sda.
>>>>>           dmesg(1) may have more information after failed mount system call.
>>>>>
>>>>> dmesg | grep BTRFS
>>>>> [71195.807688] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>> devid 5 transid 1394399 /dev/sda (8:0) scanned by mount (2344953)
>>>>> [71195.813380] BTRFS info (device sda): first mount of filesystem
>>>>> 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>> [71195.813393] BTRFS info (device sda): using crc32c (crc32c-intel)
>>>>> checksum algorithm
>>>>> [71195.814450] BTRFS warning (device sda): devid 3 uuid
>>>>> 0d596b69-fb0d-4031-b4af-a301d0868b8b is missing
>>>>> [71195.814453] BTRFS warning (device sda): devid 6 uuid
>>>>> 9edaf1d3-fab7-4dce-adfb-f7875fc02b48 is missing
>>>>> [71195.850708] BTRFS warning (device sda): devid 3 uuid
>>>>> 0d596b69-fb0d-4031-b4af-a301d0868b8b is missing
>>>>> [71195.850712] BTRFS warning (device sda): devid 4 uuid
>>>>> 01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
>>>>> [71195.850713] BTRFS warning (device sda): devid 6 uuid
>>>>> 9edaf1d3-fab7-4dce-adfb-f7875fc02b48 is missing
>>>>
>>>> This is the case where no device other than sda is scanned, thus failed
>>>> to mount.
>>>>
>>>> I guess you use 'btrfs dev scan --forget' to removed all devices before?
>>>>
>>>> Anyway, try this one instead:
>>>>
>>>> # btrfs device scan --forget
>>>> # mount -o degraded,device=/dev/sda,device=/dev/sde,device=/dev/sdf \
>>>>           /mnt/btrfs_raid2/
>>>>
>>>> This will manually scan that only 3 devices, thus should get sdd excluded.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> [71195.961370] BTRFS error (device sda): failed to verify dev extents
>>>>> against chunks: -5
>>>>> [71195.966084] BTRFS error (device sda): open_ctree failed: -5
>>>>>
>>>>> # btrfs ins dump-super -f /dev/sdc
>>>>> superblock: bytenr=65536, device=/dev/sdc
>>>>> ---------------------------------------------------------
>>>>> ERROR: bad magic on superblock on /dev/sdc at 65536 (use --force to
>>>>> dump it anyway)
>>>>>
>>>>> btrfs ins dump-super -f --force /dev/sdc
>>>>> https://www.dropbox.com/scl/fi/kq8bvpvt3tnaohiyzec3l/dump_super_sdc.txt?rlkey=c1cqqsyulg15v9hlhqdh72dtb&dl=0
>>>>>
>>>>> On Sat, 10 Jan 2026 at 08:41, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> 在 2026/1/10 18:57, Neil Parton 写道:
>>>>>>> # btrfs ins dump-tree -t chunk /dev/sda
>>>>>>> https://www.dropbox.com/scl/fi/isn326on8423fxc3shwhe/dump_tree_sda.txt?rlkey=7h9nqjg53p1ad9x6f7498ewzd&dl=0
>>>>>>>
>>>>>>> # btrfs ins dump-super -f /dev/sda
>>>>>>> https://www.dropbox.com/scl/fi/pdhfwbcfn6rlgpg9ucb9d/dump_super_sda.txt?rlkey=iuc0n46vw7alx5rhbicwdagjz&dl=0
>>>>>>>
>>>>>>> # btrfs ins dump-super -f /dev/sdd
>>>>>>> https://www.dropbox.com/scl/fi/k5cu6t31hegt78lhp6qr3/dump_super_sdd.txt?rlkey=1p4f96ccshe03lr9jh0y3f5e9&dl=0
>>>>>>>
>>>>>>> # btrfs ins dump-super -f /dev/sde
>>>>>>> https://www.dropbox.com/scl/fi/tso5bi5nfyyy5x07yvkt9/dump_super_sde.txt?rlkey=kwlbrldbaczc3fmpd3vu5osta&dl=0
>>>>>>>
>>>>>>> # btrfs ins dump-super -f /dev/sdf
>>>>>>> https://www.dropbox.com/scl/fi/bhqg8fsmrmuc8hmjqxm82/dump_super_sdf.txt?rlkey=mb5xilui3t1l7hofge4osf3gu&dl=0
>>>>>>
>>>>>> Thanks a lot. This confirms a very weird situation.
>>>>>>
>>>>>> /dev/sdd is the causing of the problem. It has devid 0, resulting the
>>>>>> mount to fail.
>>>>>>
>>>>>> Furthermore, there is a missing device (devid 4), but considering your
>>>>>> profile is either RAID1C3 for metadata or RAID10, that missing device
>>>>>> can be tolerated.
>>>>>>
>>>>>> For your current situation, you need to forget sdd, not sdc.
>>>>>>
>>>>>> # btrfs device scan --forget /dev/sdd
>>>>>>
>>>>>> Then try degraded mount.
>>>>>>
>>>>>> And if possible, also dump the super block of sdc, I assume that is devid 4.
>>>>>>
>>>>>> # btrfs ins dump-super -f /dev/sdc
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> On Sat, 10 Jan 2026 at 08:20, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> 在 2026/1/10 17:40, Neil Parton 写道:
>>>>>>>>> The replace had definitely finished some hours before I pulled the old
>>>>>>>>> drive after powering down/rebooting, the message was very clear and
>>>>>>>>> reported zero errors.  The old drive is no longer picked up by btrfs
>>>>>>>>> filesystem show or a scan (old drive is currently /dev/sdc)
>>>>>>>>>
>>>>>>>>> btrfs dev scan
>>>>>>>>> Scanning for Btrfs filesystems
>>>>>>>>> registered: /dev/sdf
>>>>>>>>> registered: /dev/sdd
>>>>>>>>> registered: /dev/sde
>>>>>>>>> registered: /dev/sda
>>>>>>>>>
>>>>>>>>> mount -o degraded /dev/sda /mnt/btrfs_raid2
>>>>>>>>> mount: /mnt/btrfs_raid2: fsconfig() failed: Structure needs cleaning.
>>>>>>>>>             dmesg(1) may have more information after failed mount system call.
>>>>>>>>>
>>>>>>>>> dmesg | grep BTRFS
>>>>>>>>> [64809.643840] BTRFS info (device sdd): first mount of filesystem
>>>>>>>>> 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>>>>>> [64809.643876] BTRFS info (device sdd): using crc32c (crc32c-intel)
>>>>>>>>> checksum algorithm
>>>>>>>>> [64809.681807] BTRFS warning (device sdd): devid 4 uuid
>>>>>>>>> 01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
>>>>>>>>> [64810.765537] BTRFS info (device sdd): bdev <missing disk> errs: wr
>>>>>>>>> 84994544, rd 15567, flush 65872, corrupt 0, gen 0
>>>>>>>>> [64810.765560] BTRFS info (device sdd): bdev /dev/sdd errs: wr
>>>>>>>>> 71489901, rd 0, flush 30001, corrupt 0, gen 0
>>>>>>>>> [64810.765577] BTRFS error (device sdd): replace without active item,
>>>>>>>>> run 'device scan --forget' on the target device
>>>>>>>>> [64810.765591] BTRFS error (device sdd): failed to init dev_replace: -117
>>>>>>>>> [64810.782830] BTRFS error (device sdd): open_ctree failed: -117
>>>>>>>>>
>>>>>>>>> I've tried running ' btrfs device scan --forget' a few times but doesn't help.
>>>>>>>>>
>>>>>>>>> The output of btrfs ins dump-tree -t dev /dev/sda is saved to a text
>>>>>>>>> file you can access from here:
>>>>>>>>>
>>>>>>>>> https://www.dropbox.com/scl/fi/upsqo286j01t8y7pll111/dump.txt?rlkey=8burw4gottx35for7kaucvyh8&dl=0
>>>>>>>>
>>>>>>>> This indeed shows the dev replace is finished.
>>>>>>>>
>>>>>>>> But the kernel dmesg shows that there is still a device replacement
>>>>>>>> source device there (devid 0), and there is also dev stats for the devid 0.
>>>>>>>>
>>>>>>>> This means there is something wrong that prevents the dev-replace to
>>>>>>>> delete that device.
>>>>>>>>
>>>>>>>> Just in case, please also dump the chunk tree and super block of each
>>>>>>>> device:
>>>>>>>>
>>>>>>>> # btrfs ins dump-tree -t chunk /dev/sda
>>>>>>>>
>>>>>>>> # btrfs ins dump-super -f /dev/sda
>>>>>>>> # btrfs ins dump-super -f /dev/sdd
>>>>>>>> # btrfs ins dump-super -f /dev/sde
>>>>>>>> # btrfs ins dump-super -f /dev/sdf
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I really need to recover this array as it will take me weeks to
>>>>>>>>> re-establish it's contents and docker services.
>>>>>>>>>
>>>>>>>>> On Fri, 9 Jan 2026 at 22:47, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> 在 2026/1/9 21:22, Neil Parton 写道:
>>>>>>>>>>> Running Arch 6.12.63-1-lts, btrfs-progs v6.17.1.  RAID10c3 array of
>>>>>>>>>>> 4x20TB disks.
>>>>>>>>>>>
>>>>>>>>>>> Ran a replace command to replace a drive with errors with a new drive
>>>>>>>>>>> of equal size.  Replace appeared to finish after ~24 hours with zero
>>>>>>>>>>> errors but new array won't mount even with -o degraded and complains
>>>>>>>>>>> that it can't find devid 4 (the old drive which has been replaced but
>>>>>>>>>>> is still plugged in and recognised).
>>>>>>>>>>
>>>>>>>>>> This looks like the replace is not finished.
>>>>>>>>>>
>>>>>>>>>> As there is still a dev replace item.
>>>>>>>>>>
>>>>>>>>>> Have you tried to run "btrfs dev scan" so that btrfs can still see the
>>>>>>>>>> old device, then try mount it again with dmesg pasted?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Also it would be better to dump the dev tree so that we can check the
>>>>>>>>>> replace item:
>>>>>>>>>>
>>>>>>>>>>        # btrfs ins dump-tree -t dev /dev/sda
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I've tried 'btrfs device scan --forget /dev/sdc' on the old drive
>>>>>>>>>>> which runs very quickly and doesn't return anything.
>>>>>>>>>>>
>>>>>>>>>>> mount -o degraded /dev/sda /mnt/btrfs_raid2
>>>>>>>>>>> mount: /mnt/btrfs_raid2: fsconfig() failed: Structure needs cleaning.
>>>>>>>>>>>              dmesg(1) may have more information after failed mount system call.
>>>>>>>>>>>
>>>>>>>>>>> dmesg | grep BTRFS
>>>>>>>>>>> [    2.677754] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>>>>>>>> devid 5 transid 1394395 /dev/sda (8:0) scanned by btrfs (261)
>>>>>>>>>>> [    2.677875] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>>>>>>>> devid 6 transid 1394395 /dev/sde (8:64) scanned by btrfs (261)
>>>>>>>>>>> [    2.678016] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>>>>>>>> devid 0 transid 1394395 /dev/sdd (8:48) scanned by btrfs (261)
>>>>>>>>>>> [    2.678129] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>>>>>>>> devid 3 transid 1394395 /dev/sdf (8:80) scanned by btrfs (261)
>>>>>>>>>>> [  118.096364] BTRFS info (device sdd): first mount of filesystem
>>>>>>>>>>> 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>>>>>>>> [  118.096400] BTRFS info (device sdd): using crc32c (crc32c-intel)
>>>>>>>>>>> checksum algorithm
>>>>>>>>>>> [  118.160901] BTRFS warning (device sdd): devid 4 uuid
>>>>>>>>>>> 01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
>>>>>>>>>>> [  119.280530] BTRFS info (device sdd): bdev <missing disk> errs: wr
>>>>>>>>>>> 84994544, rd 15567, flush 65872, corrupt 0, gen 0
>>>>>>>>>>> [  119.280549] BTRFS info (device sdd): bdev /dev/sdd errs: wr
>>>>>>>>>>> 71489901, rd 0, flush 30001, corrupt 0, gen 0
>>>>>>>>>>> [  119.280562] BTRFS error (device sdd): replace without active item,
>>>>>>>>>>> run 'device scan --forget' on the target device
>>>>>>>>>>> [  119.280574] BTRFS error (device sdd): failed to init dev_replace: -117
>>>>>>>>>>> [  119.289808] BTRFS error (device sdd): open_ctree failed: -117
>>>>>>>>>>>
>>>>>>>>>>> btrfs filesystem show
>>>>>>>>>>> Label: none  uuid: 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>>>>>>>>>>>               Total devices 4 FS bytes used 14.80TiB
>>>>>>>>>>>               devid    0 size 18.19TiB used 7.54TiB path /dev/sdd
>>>>>>>>>>>               devid    3 size 18.19TiB used 7.53TiB path /dev/sdf
>>>>>>>>>>>               devid    5 size 18.19TiB used 7.53TiB path /dev/sda
>>>>>>>>>>>               devid    6 size 18.19TiB used 7.53TiB path /dev/sde
>>>>>>>>>>>
>>>>>>>>>>> I've also tried btrfs check and btrfs check --repair on one of the
>>>>>>>>>>> disks still in the array but that's not helped and I still cannot
>>>>>>>>>>> mount the array.
>>>>>>>>>>>
>>>>>>>>>>> Please can you help as although backed up I need to save this array.
>>>>>>>>>>>
>>>>>>>>>>> Many thanks
>>>>>>>>>>>
>>>>>>>>>>> Neil
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>


