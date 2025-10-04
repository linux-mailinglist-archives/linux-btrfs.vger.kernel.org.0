Return-Path: <linux-btrfs+bounces-17434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D550FBB9223
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 23:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C9FE346604
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B121885A;
	Sat,  4 Oct 2025 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBqm0hC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139448634F
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759614807; cv=none; b=CwnjY59EcpSIKQa/BuGHo5+YvPWGHdqtyF4azxR4KM1fFAA6cCbbawhQuDaAv36dpRR+bTsGSSANHrNN9xPeCco8WNrlEzBApYQRMX1SnuO702IYXGIjIg0k4U9yBiHC9pYSUnKyvnZRneEcrDTtjjqntlCc0lH+PT6ucyrRBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759614807; c=relaxed/simple;
	bh=y+5XWIF64g6TEFshsu2T8M8WHGn4xSZc34/vkMFDLCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oOyZPwCncVHDxEcgBK9Ldjuyuig3+lOm5XAmKECoQbv7PeZpO9gAXLo4kKYmp20KZxYp+7IQseSBQn2L1BIp2oZwfwlHnneQXza/SowukO4Vct91VitC0LbnHxrGt91zLY+5JeApoRKNQ47QnGGxYIIDVz2ZrxmIVVWNlFhyUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBqm0hC0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-363f137bbf8so34267581fa.2
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Oct 2025 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759614803; x=1760219603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBZ8vvz/fgUXS5oxmE84cygrkTpW0jMYHj9C/Lv6q7Y=;
        b=LBqm0hC09mWpiQ99fKf+In0AhT4zY2ZqcV0LAc+OeVMeaBE3gm45z0mVr4YUAsTnep
         YajyqG+zOyyC/Jwygc/CPZTRJSnv6FhUBDVsn1NOG3wlto1Uxiwxwyq4Ac6yyjYsV2Mf
         HysncyM6nPG04pqqEEVKR2e1AXxbtQxpv8tH8q+NUtabyDHbNtq6DF0jcmgyjIKvPxsN
         V7nWUPoQ6SltH9oKqJrbqIk6PrSaxnibHL2Y+zkuU4jdROVYhZhe5+wbo2TmX7vzBlOU
         cR4Jh+n5jm6WwMSH2ZzoudX6uoT5J3868HbJY92HYaof1GnLkhYc3Rpb05t9VTSqXv/S
         KMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759614803; x=1760219603;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBZ8vvz/fgUXS5oxmE84cygrkTpW0jMYHj9C/Lv6q7Y=;
        b=Z2dSw0r0TToRE07pSQz7EJqx5KOHkANPh0s5qTwUew5TYSEVd4vqyvNGIOgCYGuP2g
         dlMfZAnjCT96dEclQtMFQdFkyUbGZ61F4GEdrjToy1O5tx8hRN5oJOOhXpqp0fdg3XTT
         3xeb+yuFsn1VNlDzyPfb1z4Kq0/G+bfYkKKvhrH0kaHtv72cexXqKAFs+o+EnyPawg9x
         /EYeEI9x1MorjXtLFAlzcCC/Dowd1keTjTknRB7LzfOoL48nUBXZnGYcxOwL3y0gJYWZ
         8zeGNSrjb/qHWQI8ZB25HKVFL29DADKMH2xnaF0UDIUL9Y/+kRkL72pHw7dfbULG7KhK
         ypzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPH2snunYW89pKB+Qfv45H/Si4+Jb8xxZwCdn4x6wny7Ju4cM2xtMRoTv3AfnjakDObZoQGF1wVxTQjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhBm1yQi+OmP00WH5r2bL8WG68A04YqMERB1lX03w3/J034AB
	FaaAfeLrlulThZxS1g0IP4aWXDGvcbQ8/24CA8mMzXWra8OFFtpKpFy3
X-Gm-Gg: ASbGncuKnfDlZwaBW29FGNIYXlOaIYuS1wKxUi+Vj3VtmRkXk0pAGgwekV9pFAmuXQX
	4JlTQU0qMZsHd2Sz6wV/H1zd8Xd+IbJ4D7fVmMCMTNZTerQkNFP4QMs8kbDICR+T1qkUQG6n5Nl
	JEDy7Yyubh0Ntx3XO8bQz1F55zaxDnDqnbawN4TBFQFalnCgANAtWLgdLLCp9mfTV/c6koQqFLV
	qfRHQKOya+5QUx0NU2L2cdXuLKSvqi3E9MVyosC+x/YMXxf9TnPi3pE/k1rHiGytZ6kO25AyvMI
	Ky5eW8aPUDxaVOaU0gkcNTJur0ve4IwgayP3kkIEYCCRTRn6W4VLTJc8C8t8WEKEvPPoKSDdJmz
	kRkv2XMoxFZOAFBObl17ortxI29pSz8xwNF7E/I5RJh/nIvUZMGFX7YyNbKrOB3h4EbuZzwA75l
	tGcGd9j/nmoaqC2TdQh/gbL0e1oGwo+wzRJeDNQA==
X-Google-Smtp-Source: AGHT+IGpkUa86AzCiPeZzZCSZSga9aVPgWfgFp7sTxLhkl11+XIWZBanunt6cqizzn/C06ha7Z5FRA==
X-Received: by 2002:a2e:bc88:0:b0:337:ed76:7067 with SMTP id 38308e7fff4ca-374c38874b0mr22103731fa.39.1759614802640;
        Sat, 04 Oct 2025 14:53:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:499:7600::192? (2001-14ba-499-7600--192.rev.dnainternet.fi. [2001:14ba:499:7600::192])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-373ba4d1829sm27233591fa.56.2025.10.04.14.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 14:53:22 -0700 (PDT)
Message-ID: <afea5a6c-96a6-4928-aa63-275a6c8f8030@gmail.com>
Date: Sun, 5 Oct 2025 00:53:20 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to remove an unremovable file and directory?
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
 <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
 <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
 <b6273125-86fb-443b-9b2d-3430594f0152@suse.com>
 <f2b72e44-9134-4cc5-99b0-fb51c2673cde@suse.com>
From: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>
Content-Language: en-US
In-Reply-To: <f2b72e44-9134-4cc5-99b0-fb51c2673cde@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> One extra thing, at the time of the initial "btrfs check --repair", 
> there is no running dev-replace/balance or whatever running?
>
> Although those operations will be automatically paused by unmount,
> btrfs check is not going to be able to handle some of those paused 
> operations. 

Is there a way for me to check that without mounting the filesystem? As 
far as I could find, none of the balance / scrub commands allow working 
on an unmounted filesystem. So I couldn't find out if I had any in 
canceled state.

Though, I'm pretty sure I let the last scrub and balance operation I 
tried to fully complete before starting using the check and repair 
commands. But I'm not absolutely certain that I didn't try one of those 
a last time and didn't let it fully complete.

I'll start that "btrfs check --readonly" command now. And I'll report 
back once it is done (hopefully by the morning in my timezone).

- Henri Hyyryläinen

Qu Wenruo kirjoitti 4.10.2025 klo 23.55:
>
>
> 在 2025/10/5 07:14, Qu Wenruo 写道:
>>
>>
>> 在 2025/10/5 04:13, Henri Hyyryläinen 写道:
>>> Hello again.
>>>
>>> It took over 3 days, but the btrfs check --repair has now completed 
>>> seemingly successfully. I mostly saw output about the file being 
>>> placed in lost+found and and directory size being corrected. 
>>> However, there were some messages about mismatch of used bytes.
>>>
>>> Unfortunately it seems like the situation has gotten worse since the 
>>> repair, because now I cannot mount the filesystem at all. Instead I 
>>> get an error like this:
>>>
>>>> BTRFS error (device sdc): dev extent physical offset 19977638903808 
>>>> on devid 4 doesn't have corresponding chunk
>>>> BTRFS error (device sdc): failed to verify dev extents against 
>>>> chunks: -117
>>>> BTRFS error (device sdc): open_ctree failed: -117
>>> Even if I remove that one problematic device physically from my 
>>> computer, the filesystem still refuses to mount with the same error. 
>>> Maybe the problems with the device replace are again showing up with 
>>> the actual size of the hard drive not being used correctly? I cannot 
>>> try to remove the device slack as I cannot mount the filesystem.
>>
>> Nope, this is a different problem, and not related to dev replace.
>>
>> Unfortunately btrfs check has not implemented any repair for that.
>>
>> Overall if the dev extent is found but not corresponding chunk, it 
>> should still be fine but some space unavailable.
>>
>> But the kernel is overly cautious on chunk tree, as it's a very 
>> important and basic functionality.
>>
>> Please provide the full "btrfs check --readonly" output so that we 
>> can evaluate and add the missing repair functionality.
>
> One extra thing, at the time of the initial "btrfs check --repair", 
> there is no running dev-replace/balance or whatever running?
>
> Although those operations will be automatically paused by unmount,
> btrfs check is not going to be able to handle some of those paused 
> operations.
>>
>> Thanks,
>> Qu
>>
>>>
>>> I did try to run a repair again, and this time I got a bunch of 
>>> messages like:
>>>
>>>> repair deleting extent record: key [65795546775552,169,0]
>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>> 65811674234880 root 65811674234880
>>>> adding new tree backref on start 65795546775552 len 16384 parent 0 
>>>> root 14499
>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>> 65791012274176 root 65791012274176
>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>> 65806385807360 root 65806385807360
>>>> Repaired extent references for 65795546775552
>>>> ref mismatch on [65795548233728 16384] extent item 5, found 4
>>
>> That's fixing some backref mismatch, which you can ignore unless 
>> "btrfs check --reaonly" later reports new problems.
>>
>>> But the filesystem still refuses to mount with the exact same error. 
>>> I did not let the repair run entirely as it would have likely taken 
>>> another 3 days. What should I do? This time I'm not finding any good 
>>> information on what to do. For now, I've started the repair again, 
>>> but it doesn't exactly sound like it is even fixing anything now. 
>>> Still, I'll let it continue. The output so far is:
>>>
>>>> [1/8] checking log skipped (none written)
>>>> [2/8] checking root items
>>>> Fixed 0 roots.
>>>> [3/8] checking extents
>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>> relative chunk.
>>>> super bytes used 49454738989056 mismatches actual used 49454738923520
>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>> relative chunk.
>>>> super bytes used 49454739005440 mismatches actual used 49454738956288
>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>> relative chunk.
>>>> super bytes used 49454739021824 mismatches actual used 49454738972672
>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>> relative chunk.
>>>> super bytes used 49454739005440 mismatches actual used 49454738972672
>>>
>>>
>>> If I was able to somehow remove that one logically corrupt devid 
>>> from the filesystem, or somehow correct the size, that would 
>>> hopefully allow me to rebuild from the raid10 data then, but I can't 
>>> do those with the unmountable filesystem.
>>>
>>>
>>> - Henri Hyyryläinen
>>>
>>> Qu Wenruo kirjoitti 30.9.2025 klo 0.52:
>>>>
>>>>
>>>> 在 2025/9/30 02:41, Henri Hyyryläinen 写道:
>>>>> Hello,
>>>>>
>>>>> I hope this is the right place to ask about a filesystem problem. 
>>>>> Really shortly put, I have a file that both exists and doesn't and 
>>>>> prevents the containing directory from being deleted. No matter 
>>>>> what variant of rm and inode based deletion I try I get an error 
>>>>> about the file not existing, and I also cannot try to read the 
>>>>> file, but if I try to delete the directory I get an error that it 
>>>>> is not empty (so the file kind of exists). Trying to ls the 
>>>>> directory also gives a file doesn't exist error.
>>>>>
>>>>> Here's what btrfs check found, which I hope does better in 
>>>>> illustrating the problem:
>>>>>
>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>
>>>>> I've tried everything I've found suggested including a full scrub, 
>>>>> balance with -dusage=75 -musage=75, resetting file attributes, 
>>>>> deleting through the find command, and even some repair mount 
>>>>> flags that don't seem to exist for btrfs.
>>>>
>>>> The fs is corrupted, thus none of those will help.
>>>> I'm more interested in how the corruption happened.
>>>>
>>>> Did you use some tools other than btrfs kernel module and btrfs-progs?
>>>> Like ntfs2btrfs or winbtrfs?
>>>>
>>>> IIRC certain versions have some bugs related to extent tree, but 
>>>> should not cause this problem.
>>>>
>>>>
>>>> The other possibility is hardware memory bitflip, which is more 
>>>> common than you thought (almostly one report per month)
>>>>
>>>> In that case, a full memtest is always recommended, or you will hit 
>>>> all kinds of weird corruptions in the future anyway.
>>>>
>>>>
>>>> With a full memtest proving the memory hardware is fine, then 
>>>> "btrfs check --repair" should be able to fix it.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>
>>>>> What I haven't tried is a full rebalance with no filters, but I 
>>>>> did not try that yet as it would take quite a long time and if it 
>>>>> only moves data blocks around without recomputing directory items, 
>>>>> it doesn't seem like the right tool to fix my problem. So I'm 
>>>>> pretty much stuck and to me it seems like my only option is to run 
>>>>> btrfs check with the repair flag, but as that has big warnings on 
>>>>> it I thought I would try asking here first (sorry if this is not 
>>>>> the right experts group to ask). So is there still something I can 
>>>>> try or am I finally "allowed" to use the repair command? Here's 
>>>>> the full output I got from btrfs check:
>>>>>
>>>>>> Opening filesystem to check...
>>>>>> Checking filesystem on /dev/sdc
>>>>>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>>>>>> [1/8] checking log skipped (none written)
>>>>>> [2/8] checking root items
>>>>>> [3/8] checking extents
>>>>>> [4/8] checking free space tree
>>>>>> We have a space info key for a block group that doesn't exist
>>>>>> [5/8] checking fs roots
>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14428 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14428 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14451 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14451 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14475 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14475 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14499 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14499 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14523 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14523 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14544 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14544 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14545 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14545 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14546 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14546 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14547 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14547 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14548 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14548 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14549 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14549 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> root 14550 inode 25953213 errors 200, dir isize wrong
>>>>>> root 14550 inode 27166085 errors 2000, link count wrong
>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>> ERROR: errors found in fs roots
>>>>>> found 49400296812544 bytes used, error(s) found
>>>>>> total csum bytes: 48179330432
>>>>>> total tree bytes: 65067483136
>>>>>> total fs tree bytes: 12107431936
>>>>>> total extent tree bytes: 3194437632
>>>>>> btree space waste bytes: 4558984171
>>>>>> file data blocks allocated: 76487982252032
>>>>>>  referenced 60030799097856
>>>>>
>>>>> So hopefully if I'm reading things right, running a repair would 
>>>>> delete just that one file and directory (which itself is a backup 
>>>>> so I will not miss that file at all)?
>>>>>
>>>>> I do not have enough disk space to copy off the entire filesystem 
>>>>> and rebuild from scratch, without doing something like rebalancing 
>>>>> all data from raid10 to single and then removing half the disks, 
>>>>> but I assume that would take at least 4 weeks to process (as I 
>>>>> just replaced a disk which took like a week).
>>>>>
>>>>> As to what originally caused the corruption, I think it was 
>>>>> probably faulty RAM, because up to to like 3 weeks ago I had one 
>>>>> really bad RAM stick in my computer where a certain memory region 
>>>>> always had incorrectly reading bytes. I had seen intermittent 
>>>>> quite high csum errors in monthly scrubs pretty randomly, which 
>>>>> thankfully could almost always be corrected so I didn't have any 
>>>>> major problems even though I had like totally broken RAM in my 
>>>>> computer for who knows how long. So btrfs was able to protect my 
>>>>> data quite impressively from bad RAM.
>>>>>
>>>>> Sorry for getting a bit sidetracked there, but what should I do in 
>>>>> this situation?
>>>>>
>>>>> - Henri Hyyryläinen
>>>>>
>>>>>
>>>>
>>
>>
>

