Return-Path: <linux-btrfs+bounces-17431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97FBB90A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 19:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1C1A34623A
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463428507B;
	Sat,  4 Oct 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THl+XZ/W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFC16132F
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759599811; cv=none; b=DCGGyhsOBsVLKm1ZWeAbgoAgc0GAcjqxn9Y/rZ4YXqNVJ0zZrsBj1rFs43TlpjAdORnfDUYL5dfqPpJ0EdKcp1dQudwwXoKexnXC9Xd+Uf3wZGVjTo4HHMV6i5wBZ51Dqdhb372x2SDE6SUbDiLhriBH85+RU5q+/dgxu8SYH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759599811; c=relaxed/simple;
	bh=tHqL6DJR29JV4yLnBQAi7/ba/cUI1IzQW+614kZSF4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ujTZvHqmEDSZ/UagW7Az0YL1nfwXyhkc+PqGs6l17FX9qqminOeI/i5M7KnSSiDMmfvP1jlio+FNor6qEBwR/jLdXxwzN/6PzqI7RRd0A3/lp285IEGhdNPR7ZdiqodZT7E3lIAlIPevdtRGJ61hkxx+JiWFkSZ5Tf7fNefIFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THl+XZ/W; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36295d53a10so29496601fa.0
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Oct 2025 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759599807; x=1760204607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBNBmpj0nqdtJsqej3IwXtv2EijXKo/lHzmKBwB4YYc=;
        b=THl+XZ/WqyCuqPsX7qU60XTIr3MKQQJNqmJTqRUA/i0IxVf6v3irXBvDUAMh45RFOl
         3zYvhW34Ddbvwx5Nq4ov047sNufMLPTTmo91VwsRSEPBq3fKirsHZyG6m4WOM7ietUjV
         hLFJ+7PXFayIj/neRURymNpjlD8HEdT0BxwFcRIhngjaE2esHVRo3qgK1a3HrJm94B13
         zkCmwBjYLUlaOZPxb7fnVncIkhH7NCNu4VWgK1Vvl8mGRK8Stjnwtzrg8jaQuG53nXWy
         XiijuXrTdEAGCvK0DE12QJwyHOYEckcxwqh/ULSiNbl6/94DebzOiP5CrkNfRU4+ul77
         1Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759599807; x=1760204607;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBNBmpj0nqdtJsqej3IwXtv2EijXKo/lHzmKBwB4YYc=;
        b=mmeIACUJ9Q1OdCESaPalmjiwSZxSVCwD0xefqqE84BYgWNkn7tTogal4nmSBedGD4D
         +I6hRpp0N9DXW9bCbLAM5TZBXDnJHLkZUKR3P5lmfROOrONw8XE1V4XpiPr3QsYIpiRt
         FNK7oQrJJd3tXqX6BTB+8ht8cANmUJ9Gvet/nM+mrJtB8OIss1cL4qcLSz/IvqNocCvW
         i0UUkTP8RndyCrhnSHWubUaf0YBAXBlPyVT4gSrc6GMXNb+s6jl+rgED1WbLAfYpWEfL
         tb6e3BSWw/aXc5MCFJnc1usgDproYI0MSdfVFl2pmWg/3zVRSf5KeqanN944BLIcD48C
         ZZPg==
X-Forwarded-Encrypted: i=1; AJvYcCWYdJGskLwOmP8ozMLxcjqGemtN9irmU8b/6CaHFFi2xXJDVa/doLJ44HqfINjnW+uTc/pO4seQmJJc+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cbcsqWz7aLxLSyEZIIMEoy/3+ugA6+ZslCKs6knZeiGP4K1v
	wkwKTdxDFAidfQQ4gm11OnMVpFCYLxH7R+GyG2L8zVY0b7Wx+/Y5znEF
X-Gm-Gg: ASbGncvnXyezyhIsL+LXvZau65ij33VZMLS+OoX92q6CLR0JVRHMeVg8/7b5zbvXORi
	dmsBX4EdwgHQcXXDGs1iKWj/YDOramv5LF2uaOeYCojxrmv0zfhMfUpC8fHyoL+l2JLHIT0LZu8
	3GRF3oJe9UvDV4ObxTeleaN2DJ79wmEx5FuBRj6g6DgvS+olEgK9WOTD8aMPRY+fwAjQtIgYAhy
	6aDasRgddrpyZdDsfGmpv+114d1tgjErDcCz9nHYP2kOoLOYFHuw5Jftt3jFE+MgQuVvbWrqDGi
	/dxLfx/EqVJU5+I+8e9e81gH7TIN33iuFfeK1HyLoRRgIOco1Kf/Rajp/88eVL5dYedvBmsp9Ei
	pdOMls1cXLpKaPMaKENgfScBEsUVnC/xPPbSz5W2YZAQ1xTB9w5I4vmY9i2QJaZedR9xS2uJBUu
	IAmRUKeu7CUWz1/7/yOUO+bFWDC1aNNVcr/Hqoss7wMO8LzE2C
X-Google-Smtp-Source: AGHT+IGPyLUS0s6zS/IPxC21xViZuOBOvuvHsC+GolsoFM1kKp7H74mZ3gvS+JkcrQ0ITf5t0O5NvQ==
X-Received: by 2002:a05:651c:1510:b0:36c:7e4f:b4c0 with SMTP id 38308e7fff4ca-374c3795b5dmr22287081fa.22.1759599806722;
        Sat, 04 Oct 2025 10:43:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:499:7600::192? (2001-14ba-499-7600--192.rev.dnainternet.fi. [2001:14ba:499:7600::192])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-373ba44822fsm25715111fa.33.2025.10.04.10.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 10:43:26 -0700 (PDT)
Message-ID: <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
Date: Sat, 4 Oct 2025 20:43:25 +0300
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
From: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>
Content-Language: en-US
In-Reply-To: <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello again.

It took over 3 days, but the btrfs check --repair has now completed 
seemingly successfully. I mostly saw output about the file being placed 
in lost+found and and directory size being corrected. However, there 
were some messages about mismatch of used bytes.

Unfortunately it seems like the situation has gotten worse since the 
repair, because now I cannot mount the filesystem at all. Instead I get 
an error like this:

> BTRFS error (device sdc): dev extent physical offset 19977638903808 on 
> devid 4 doesn't have corresponding chunk
> BTRFS error (device sdc): failed to verify dev extents against chunks: 
> -117
> BTRFS error (device sdc): open_ctree failed: -117
Even if I remove that one problematic device physically from my 
computer, the filesystem still refuses to mount with the same error. 
Maybe the problems with the device replace are again showing up with the 
actual size of the hard drive not being used correctly? I cannot try to 
remove the device slack as I cannot mount the filesystem.

I did try to run a repair again, and this time I got a bunch of messages 
like:

> repair deleting extent record: key [65795546775552,169,0]
> adding new tree backref on start 65795546775552 len 16384 parent 
> 65811674234880 root 65811674234880
> adding new tree backref on start 65795546775552 len 16384 parent 0 
> root 14499
> adding new tree backref on start 65795546775552 len 16384 parent 
> 65791012274176 root 65791012274176
> adding new tree backref on start 65795546775552 len 16384 parent 
> 65806385807360 root 65806385807360
> Repaired extent references for 65795546775552
> ref mismatch on [65795548233728 16384] extent item 5, found 4
But the filesystem still refuses to mount with the exact same error. I 
did not let the repair run entirely as it would have likely taken 
another 3 days. What should I do? This time I'm not finding any good 
information on what to do. For now, I've started the repair again, but 
it doesn't exactly sound like it is even fixing anything now. Still, 
I'll let it continue. The output so far is:

> [1/8] checking log skipped (none written)
> [2/8] checking root items
> Fixed 0 roots.
> [3/8] checking extents
> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
> chunk.
> super bytes used 49454738989056 mismatches actual used 49454738923520
> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
> chunk.
> super bytes used 49454739005440 mismatches actual used 49454738956288
> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
> chunk.
> super bytes used 49454739021824 mismatches actual used 49454738972672
> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
> chunk.
> super bytes used 49454739005440 mismatches actual used 49454738972672


If I was able to somehow remove that one logically corrupt devid from 
the filesystem, or somehow correct the size, that would hopefully allow 
me to rebuild from the raid10 data then, but I can't do those with the 
unmountable filesystem.


- Henri Hyyryläinen

Qu Wenruo kirjoitti 30.9.2025 klo 0.52:
>
>
> 在 2025/9/30 02:41, Henri Hyyryläinen 写道:
>> Hello,
>>
>> I hope this is the right place to ask about a filesystem problem. 
>> Really shortly put, I have a file that both exists and doesn't and 
>> prevents the containing directory from being deleted. No matter what 
>> variant of rm and inode based deletion I try I get an error about the 
>> file not existing, and I also cannot try to read the file, but if I 
>> try to delete the directory I get an error that it is not empty (so 
>> the file kind of exists). Trying to ls the directory also gives a 
>> file doesn't exist error.
>>
>> Here's what btrfs check found, which I hope does better in 
>> illustrating the problem:
>>
>>> root 5 inode 25953213 errors 200, dir isize wrong
>>> root 5 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>
>> I've tried everything I've found suggested including a full scrub, 
>> balance with -dusage=75 -musage=75, resetting file attributes, 
>> deleting through the find command, and even some repair mount flags 
>> that don't seem to exist for btrfs.
>
> The fs is corrupted, thus none of those will help.
> I'm more interested in how the corruption happened.
>
> Did you use some tools other than btrfs kernel module and btrfs-progs?
> Like ntfs2btrfs or winbtrfs?
>
> IIRC certain versions have some bugs related to extent tree, but 
> should not cause this problem.
>
>
> The other possibility is hardware memory bitflip, which is more common 
> than you thought (almostly one report per month)
>
> In that case, a full memtest is always recommended, or you will hit 
> all kinds of weird corruptions in the future anyway.
>
>
> With a full memtest proving the memory hardware is fine, then "btrfs 
> check --repair" should be able to fix it.
>
> Thanks,
> Qu
>
>
>> What I haven't tried is a full rebalance with no filters, but I did 
>> not try that yet as it would take quite a long time and if it only 
>> moves data blocks around without recomputing directory items, it 
>> doesn't seem like the right tool to fix my problem. So I'm pretty 
>> much stuck and to me it seems like my only option is to run btrfs 
>> check with the repair flag, but as that has big warnings on it I 
>> thought I would try asking here first (sorry if this is not the right 
>> experts group to ask). So is there still something I can try or am I 
>> finally "allowed" to use the repair command? Here's the full output I 
>> got from btrfs check:
>>
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sdc
>>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>>> [1/8] checking log skipped (none written)
>>> [2/8] checking root items
>>> [3/8] checking extents
>>> [4/8] checking free space tree
>>> We have a space info key for a block group that doesn't exist
>>> [5/8] checking fs roots
>>> root 5 inode 25953213 errors 200, dir isize wrong
>>> root 5 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14428 inode 25953213 errors 200, dir isize wrong
>>> root 14428 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14451 inode 25953213 errors 200, dir isize wrong
>>> root 14451 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14475 inode 25953213 errors 200, dir isize wrong
>>> root 14475 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14499 inode 25953213 errors 200, dir isize wrong
>>> root 14499 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14523 inode 25953213 errors 200, dir isize wrong
>>> root 14523 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14544 inode 25953213 errors 200, dir isize wrong
>>> root 14544 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14545 inode 25953213 errors 200, dir isize wrong
>>> root 14545 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14546 inode 25953213 errors 200, dir isize wrong
>>> root 14546 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14547 inode 25953213 errors 200, dir isize wrong
>>> root 14547 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14548 inode 25953213 errors 200, dir isize wrong
>>> root 14548 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14549 inode 25953213 errors 200, dir isize wrong
>>> root 14549 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> root 14550 inode 25953213 errors 200, dir isize wrong
>>> root 14550 inode 27166085 errors 2000, link count wrong
>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>> ERROR: errors found in fs roots
>>> found 49400296812544 bytes used, error(s) found
>>> total csum bytes: 48179330432
>>> total tree bytes: 65067483136
>>> total fs tree bytes: 12107431936
>>> total extent tree bytes: 3194437632
>>> btree space waste bytes: 4558984171
>>> file data blocks allocated: 76487982252032
>>>  referenced 60030799097856
>>
>> So hopefully if I'm reading things right, running a repair would 
>> delete just that one file and directory (which itself is a backup so 
>> I will not miss that file at all)?
>>
>> I do not have enough disk space to copy off the entire filesystem and 
>> rebuild from scratch, without doing something like rebalancing all 
>> data from raid10 to single and then removing half the disks, but I 
>> assume that would take at least 4 weeks to process (as I just 
>> replaced a disk which took like a week).
>>
>> As to what originally caused the corruption, I think it was probably 
>> faulty RAM, because up to to like 3 weeks ago I had one really bad 
>> RAM stick in my computer where a certain memory region always had 
>> incorrectly reading bytes. I had seen intermittent quite high csum 
>> errors in monthly scrubs pretty randomly, which thankfully could 
>> almost always be corrected so I didn't have any major problems even 
>> though I had like totally broken RAM in my computer for who knows how 
>> long. So btrfs was able to protect my data quite impressively from 
>> bad RAM.
>>
>> Sorry for getting a bit sidetracked there, but what should I do in 
>> this situation?
>>
>> - Henri Hyyryläinen
>>
>>
>

