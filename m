Return-Path: <linux-btrfs+bounces-17433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A2BB91DD
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 22:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0CF94E0452
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44241283C97;
	Sat,  4 Oct 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNDsF+lz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8619F13F
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759611334; cv=none; b=c+CD+2GOgjlUVLbEkpXpy4DRBW1VP2trZbJSyEEbL2y3D+gaCogeKTnw42WB8FSv6m7KVDuUi/5GAwoq5VAum3ina27NsXAkY9KMDDeWsBWleIhIxYq54s/nf1VLDiW5ZU315cP+WzYANeZNRd8hf5B+QSjnbyeulVRe7R+LYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759611334; c=relaxed/simple;
	bh=mub10Olz5EGUhQzJ4Ta0735OuLk+lOatk+3PfC7fg7k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=L8b0sxM/WvmOURT5vf5h7KPmb6mcEZYLp7O7r89b1grrz/+zSSh4U0by8dSHLdeu0Y3AOcS4hbakj6XtoQFiewHPfM/0uYQ6eHm7d2obK+ev1woH/cUIbaXMV927/vqyQxKLpbkR+s0aM/2iX2DPaill4RsWu4Jovz/pPg78l9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNDsF+lz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so3152057f8f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Oct 2025 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759611330; x=1760216130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfLB1qUOC/y/bVMVIeaE77YhcBH3YsBXNBWO4JUnWPo=;
        b=KNDsF+lz5HUV+3K/N/3Gi+yolbb/th4LOgAgSbiIjNWiwWRIFU/9oOV/da8KliAjck
         UZpQac5idDSB/hYC10xxAlqlfFpp3gN54iBFLjWLLpR57pApkHdvpvgy9YglFb8AjGcV
         59G33++AhcMXziWHq6pSus2Z+qfhVMwJ+zJVR7bpgWYZ1F0B1LZx3yFzh3DnWlxEUqOC
         4y0CzKOwqxkmVsRWvn9zPVAdh8l4kMr5qZrF27n6X+ljmLv+1zm3vwOmvKWx/9pdiP1c
         XdSD8o2p9yjP97ybwiCVKVqxevNd3jNCGLiZ/gSS3U2mt1UH5qbzEK379hN+AstBKI3I
         Ahuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759611330; x=1760216130;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfLB1qUOC/y/bVMVIeaE77YhcBH3YsBXNBWO4JUnWPo=;
        b=igpThBg4cISS4bHiQsvApnuh8CvBaJQka9FlkKLJA4pHrNghR5bh0MkznHB/QZnViK
         7IlL0sKvcHzgqOJDo9wNPGfIs+ouwU7Ndsks6mJFTL0JJNdW0fJGDdBN+/ftyKXX0K5N
         R+h5oTeTTORCBza1MI22hcpOfiQhQi77JLzKvhrZxB/4OmDdoKRhM/2u3h++aijaQKuO
         5L6tQSQFtTuPOW3Z4siapt0uP039VOvxZiTDvK4XTsKUBGWeF4cr/xFPEPLsJBQr3Luu
         yxlOiFRY7KcGSmQlVPAlLc13Ju9/LpFBMIWDxRFV/ixeSDWi50mmIESd43wW3NpOwY4N
         g5ug==
X-Forwarded-Encrypted: i=1; AJvYcCVnlyCHHJOzfuSX6uG7IiYdEv8wpjCaNEKg/UlcIBuqHEam74RwFZ6mvVDYKPUA92h+6cMiy7+5K0TEQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/osdrS1/ZkTSGexqk2poc5appO1zHVHIDH4eGKbh2jn2PMUbn
	Uu2XX4QkXmrH3PV+d7S+3B7IFK2q6Yj8HoR7xg05KVhHtQHmWY+cfozK8U7bf8yB8gb6AGCQiNt
	R+Xom
X-Gm-Gg: ASbGncuT+t4yAD3Hvmr3LwUsBS3dbnPEMi3bD+38R2KtHyuScgkYnuhNLHeBip0plik
	lRBH3Yo6KGY5Mr8LZIMyc8bFXUaP1B+8GrY6VmAIE74w/q3I81ApPuPBxvRgINWnBkr0sviAEY3
	yajtYRf94IZKxxe1EJ5yzaPwiJqjGKs/SNRcO1kAe6tuGlg3HjcpgY1AR5dPpuXUcpV5Nyn6pA7
	vMUwVrv86zgJK6aZaVco7iwiUVhI3xxRk1ZwjxFr9/qEhT233XIKe4CcBBKc4iOWkabVp4YD+VA
	EBBjUqDPHFFKBdYY1ZEC8LdGbBJdebiwzrj27saf61iEuNqF03WgspowGmNE4miEqLsjjQZDmEI
	WV5udZUfN8VLOTHZ8uW54niPpZeUM+ETPJIMxo0Ju0hMKaNyvzTK/nrm4fleROYE0qbY8MD/Tlp
	Y=
X-Google-Smtp-Source: AGHT+IG0fDxWjYTpo4VIi/6YYWwoA9XbwR2N9lYjXJV7JXVv5LbxJ+K3np5S75Y4/6ISeBn+w8Fzaw==
X-Received: by 2002:a05:6000:43d6:10b0:425:72f2:f872 with SMTP id ffacd0b85a97d-42572f2fa24mr1356348f8f.31.1759611329796;
        Sat, 04 Oct 2025 13:55:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02076b09sm8362994b3a.79.2025.10.04.13.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 13:55:29 -0700 (PDT)
Message-ID: <f2b72e44-9134-4cc5-99b0-fb51c2673cde@suse.com>
Date: Sun, 5 Oct 2025 07:25:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to remove an unremovable file and directory?
From: Qu Wenruo <wqu@suse.com>
To: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
 <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
 <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
 <b6273125-86fb-443b-9b2d-3430594f0152@suse.com>
Content-Language: en-US
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
In-Reply-To: <b6273125-86fb-443b-9b2d-3430594f0152@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/5 07:14, Qu Wenruo 写道:
> 
> 
> 在 2025/10/5 04:13, Henri Hyyryläinen 写道:
>> Hello again.
>>
>> It took over 3 days, but the btrfs check --repair has now completed 
>> seemingly successfully. I mostly saw output about the file being 
>> placed in lost+found and and directory size being corrected. However, 
>> there were some messages about mismatch of used bytes.
>>
>> Unfortunately it seems like the situation has gotten worse since the 
>> repair, because now I cannot mount the filesystem at all. Instead I 
>> get an error like this:
>>
>>> BTRFS error (device sdc): dev extent physical offset 19977638903808 
>>> on devid 4 doesn't have corresponding chunk
>>> BTRFS error (device sdc): failed to verify dev extents against 
>>> chunks: -117
>>> BTRFS error (device sdc): open_ctree failed: -117
>> Even if I remove that one problematic device physically from my 
>> computer, the filesystem still refuses to mount with the same error. 
>> Maybe the problems with the device replace are again showing up with 
>> the actual size of the hard drive not being used correctly? I cannot 
>> try to remove the device slack as I cannot mount the filesystem.
> 
> Nope, this is a different problem, and not related to dev replace.
> 
> Unfortunately btrfs check has not implemented any repair for that.
> 
> Overall if the dev extent is found but not corresponding chunk, it 
> should still be fine but some space unavailable.
> 
> But the kernel is overly cautious on chunk tree, as it's a very 
> important and basic functionality.
> 
> Please provide the full "btrfs check --readonly" output so that we can 
> evaluate and add the missing repair functionality.

One extra thing, at the time of the initial "btrfs check --repair", 
there is no running dev-replace/balance or whatever running?

Although those operations will be automatically paused by unmount,
btrfs check is not going to be able to handle some of those paused 
operations.
> 
> Thanks,
> Qu
> 
>>
>> I did try to run a repair again, and this time I got a bunch of 
>> messages like:
>>
>>> repair deleting extent record: key [65795546775552,169,0]
>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>> 65811674234880 root 65811674234880
>>> adding new tree backref on start 65795546775552 len 16384 parent 0 
>>> root 14499
>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>> 65791012274176 root 65791012274176
>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>> 65806385807360 root 65806385807360
>>> Repaired extent references for 65795546775552
>>> ref mismatch on [65795548233728 16384] extent item 5, found 4
> 
> That's fixing some backref mismatch, which you can ignore unless "btrfs 
> check --reaonly" later reports new problems.
> 
>> But the filesystem still refuses to mount with the exact same error. I 
>> did not let the repair run entirely as it would have likely taken 
>> another 3 days. What should I do? This time I'm not finding any good 
>> information on what to do. For now, I've started the repair again, but 
>> it doesn't exactly sound like it is even fixing anything now. Still, 
>> I'll let it continue. The output so far is:
>>
>>> [1/8] checking log skipped (none written)
>>> [2/8] checking root items
>>> Fixed 0 roots.
>>> [3/8] checking extents
>>> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
>>> chunk.
>>> super bytes used 49454738989056 mismatches actual used 49454738923520
>>> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
>>> chunk.
>>> super bytes used 49454739005440 mismatches actual used 49454738956288
>>> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
>>> chunk.
>>> super bytes used 49454739021824 mismatches actual used 49454738972672
>>> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
>>> chunk.
>>> super bytes used 49454739005440 mismatches actual used 49454738972672
>>
>>
>> If I was able to somehow remove that one logically corrupt devid from 
>> the filesystem, or somehow correct the size, that would hopefully 
>> allow me to rebuild from the raid10 data then, but I can't do those 
>> with the unmountable filesystem.
>>
>>
>> - Henri Hyyryläinen
>>
>> Qu Wenruo kirjoitti 30.9.2025 klo 0.52:
>>>
>>>
>>> 在 2025/9/30 02:41, Henri Hyyryläinen 写道:
>>>> Hello,
>>>>
>>>> I hope this is the right place to ask about a filesystem problem. 
>>>> Really shortly put, I have a file that both exists and doesn't and 
>>>> prevents the containing directory from being deleted. No matter what 
>>>> variant of rm and inode based deletion I try I get an error about 
>>>> the file not existing, and I also cannot try to read the file, but 
>>>> if I try to delete the directory I get an error that it is not empty 
>>>> (so the file kind of exists). Trying to ls the directory also gives 
>>>> a file doesn't exist error.
>>>>
>>>> Here's what btrfs check found, which I hope does better in 
>>>> illustrating the problem:
>>>>
>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>
>>>> I've tried everything I've found suggested including a full scrub, 
>>>> balance with -dusage=75 -musage=75, resetting file attributes, 
>>>> deleting through the find command, and even some repair mount flags 
>>>> that don't seem to exist for btrfs.
>>>
>>> The fs is corrupted, thus none of those will help.
>>> I'm more interested in how the corruption happened.
>>>
>>> Did you use some tools other than btrfs kernel module and btrfs-progs?
>>> Like ntfs2btrfs or winbtrfs?
>>>
>>> IIRC certain versions have some bugs related to extent tree, but 
>>> should not cause this problem.
>>>
>>>
>>> The other possibility is hardware memory bitflip, which is more 
>>> common than you thought (almostly one report per month)
>>>
>>> In that case, a full memtest is always recommended, or you will hit 
>>> all kinds of weird corruptions in the future anyway.
>>>
>>>
>>> With a full memtest proving the memory hardware is fine, then "btrfs 
>>> check --repair" should be able to fix it.
>>>
>>> Thanks,
>>> Qu
>>>
>>>
>>>> What I haven't tried is a full rebalance with no filters, but I did 
>>>> not try that yet as it would take quite a long time and if it only 
>>>> moves data blocks around without recomputing directory items, it 
>>>> doesn't seem like the right tool to fix my problem. So I'm pretty 
>>>> much stuck and to me it seems like my only option is to run btrfs 
>>>> check with the repair flag, but as that has big warnings on it I 
>>>> thought I would try asking here first (sorry if this is not the 
>>>> right experts group to ask). So is there still something I can try 
>>>> or am I finally "allowed" to use the repair command? Here's the full 
>>>> output I got from btrfs check:
>>>>
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/sdc
>>>>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>>>>> [1/8] checking log skipped (none written)
>>>>> [2/8] checking root items
>>>>> [3/8] checking extents
>>>>> [4/8] checking free space tree
>>>>> We have a space info key for a block group that doesn't exist
>>>>> [5/8] checking fs roots
>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14428 inode 25953213 errors 200, dir isize wrong
>>>>> root 14428 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14451 inode 25953213 errors 200, dir isize wrong
>>>>> root 14451 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14475 inode 25953213 errors 200, dir isize wrong
>>>>> root 14475 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14499 inode 25953213 errors 200, dir isize wrong
>>>>> root 14499 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14523 inode 25953213 errors 200, dir isize wrong
>>>>> root 14523 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14544 inode 25953213 errors 200, dir isize wrong
>>>>> root 14544 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14545 inode 25953213 errors 200, dir isize wrong
>>>>> root 14545 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14546 inode 25953213 errors 200, dir isize wrong
>>>>> root 14546 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14547 inode 25953213 errors 200, dir isize wrong
>>>>> root 14547 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14548 inode 25953213 errors 200, dir isize wrong
>>>>> root 14548 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14549 inode 25953213 errors 200, dir isize wrong
>>>>> root 14549 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> root 14550 inode 25953213 errors 200, dir isize wrong
>>>>> root 14550 inode 27166085 errors 2000, link count wrong
>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>> ERROR: errors found in fs roots
>>>>> found 49400296812544 bytes used, error(s) found
>>>>> total csum bytes: 48179330432
>>>>> total tree bytes: 65067483136
>>>>> total fs tree bytes: 12107431936
>>>>> total extent tree bytes: 3194437632
>>>>> btree space waste bytes: 4558984171
>>>>> file data blocks allocated: 76487982252032
>>>>>  referenced 60030799097856
>>>>
>>>> So hopefully if I'm reading things right, running a repair would 
>>>> delete just that one file and directory (which itself is a backup so 
>>>> I will not miss that file at all)?
>>>>
>>>> I do not have enough disk space to copy off the entire filesystem 
>>>> and rebuild from scratch, without doing something like rebalancing 
>>>> all data from raid10 to single and then removing half the disks, but 
>>>> I assume that would take at least 4 weeks to process (as I just 
>>>> replaced a disk which took like a week).
>>>>
>>>> As to what originally caused the corruption, I think it was probably 
>>>> faulty RAM, because up to to like 3 weeks ago I had one really bad 
>>>> RAM stick in my computer where a certain memory region always had 
>>>> incorrectly reading bytes. I had seen intermittent quite high csum 
>>>> errors in monthly scrubs pretty randomly, which thankfully could 
>>>> almost always be corrected so I didn't have any major problems even 
>>>> though I had like totally broken RAM in my computer for who knows 
>>>> how long. So btrfs was able to protect my data quite impressively 
>>>> from bad RAM.
>>>>
>>>> Sorry for getting a bit sidetracked there, but what should I do in 
>>>> this situation?
>>>>
>>>> - Henri Hyyryläinen
>>>>
>>>>
>>>
> 
> 


