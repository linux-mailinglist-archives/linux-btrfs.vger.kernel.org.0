Return-Path: <linux-btrfs+bounces-17285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97006BABF82
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 10:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E716B310
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B652F39AB;
	Tue, 30 Sep 2025 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODGDKqH9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757A24167A
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220038; cv=none; b=QRyntEe6YYy9P95m3fYAVLTyvaZVUa5m7QnLLFuns0M8vIvc6hf8yX8GkaZ2U+cwdbloWaJ21IjwJWx/EQuyD695ggkuaR3G3f25o9VZqQd1L34pcaswTNvYLHwtgifQVCmJaplcksS0y1PqOAm/kfHDPRyaaK8nmNm5WuHQePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220038; c=relaxed/simple;
	bh=ZNNpIFKqHDCLqZoPMLC4QE6268gi0mKVBcLT1UykzoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HTFdOkYrGizALW5vWgPbgqFIZ+pEGNVHK6EogGBzRMJTX+wP5Q/LRUxfPKfiEdLs7om8pNpxY3FUuXdcPAxOeYlTTOUOC6DmyFgsni4NMDolkIDj23ndZV4xw6W6IjaLCA4m5joTIuOn3HpxUTxtKggAxKQUzNeuxm+s/HMFed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODGDKqH9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso4148222e87.2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759220035; x=1759824835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1w6aiajec0GVQWSiV8ufA0pK5ZRySA+re18pWexqBM=;
        b=ODGDKqH9AWjwkJbn1XDfRbSROj+IBVIwTKLbuD15iWBqbpwNQKiH0X/JBQkEEots9I
         ZSs314IPu1hwq2P0EKMvAncdUiYREKqohby5TcGTzdHjvnTdGZguF42ZDThLuD8mijWb
         I68hX4xOuzSrPeVh72clRQiONaEa3rKtYXGLq168AugmbqBsd5olwThkxyMuxWhnj9Uc
         SzUyj5Ay0mKij7Reo7sMXjrXOTm6J2bOy0O7Oj0/8nX+wdx3JNwTGeaWW8x32XtzxEmb
         lfXtFEqHRMvlVz2TBnGzXRUh6WMOGQmF4HlaQrJafxAMIhxVQHWU9ecJQB2fdTQxMu2e
         x1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220035; x=1759824835;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1w6aiajec0GVQWSiV8ufA0pK5ZRySA+re18pWexqBM=;
        b=vzLK4v3TNTqzfy0AZ1US4rBjU8qNccQg5ObeNP3wW4fIilhy/Ov75N4xw8/vxH5g2i
         W9hPS3ft+wy2pTrbGSMMoW1SewdLHYOdX77Rkp4YUtiKk6FeJSpeKuryvYf7Qx6h1NVE
         bpb/GWcc2c1ryEaMNm6r9XCyz0zcPtsxsjo/ehBnLnme7evi7GxQKwBGYz3ecJDFiWF/
         MFiSzLL09O7CwhgOSQNfH1noyBaHyt/EOLF5MFbFYI9Fak36nsrtz0SeNeDEfBMLpaZr
         k+5ZrFGxWGHe5HnT7VcOFtpXT92Tsk14G9Ldub/ySZb/lvjJl3T89zNIRNoq7r7YNPIJ
         khXA==
X-Forwarded-Encrypted: i=1; AJvYcCVbjqxt8ZhrcZ55rtldMmh3Z9hYIB5kSy6rtYPdPtEjFocxPzu+sWlI/EDpvhx/dXZ1mrfgoRmjPDQk8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQuggHBja/ecJ2N8e9F/0jtqLLqNvGLlnL6MX/MqrmbNbMbCN
	grsM9Nl6GT9VX+xpx202B+wDFqhmD2CZK1JCZfasF1OCI+a2wo5BEAGk
X-Gm-Gg: ASbGncuYeoJkbVlW/H3LNRb1jZuGdO7OkTxUqF97E3VCYI5WFY821Cb4gzcDO/Xho3Q
	kcvNTKQJSmy7Y73wyRA4RUD/vxiAwWDgzSutmhb+0NsgUwmZiTp5/e3dgPBDMpXYdC9QbWAsBsv
	tzr4gyo98WEcWvLBI8+fwhK/h2aFx+1m+FhVEJgz3dAbR7EqJaDHDDlApWArDGWalGLNherADAP
	9GG4WMt76ZyEB20aLZ9GXrnT2IWViWt/k6TeV8y1vo2UlBfLuEI+cdNlv+v6zeR1GNUG1olJdEY
	R17s/iFkhvCtfpoYdn815p3pKHQ5MsAcc0Mwjv6ohZI5Mdxe+yw998o7nFoUp7ZhWi+0ogXHigm
	cV5fHJMGuqg6yx3xzVnH78WhEdQ19KXvGz6wjvpuqkaXJkz02APSR0UgQsjTVJYHiVXIF+FNMIB
	kYj2uZUewlIyj9BrJkAKSAHwzJRnISRN09TSlDO5apvYK0O4uV
X-Google-Smtp-Source: AGHT+IGzX2CoYJT7nEm4ovRDNSuvKzVHjwTnhGDPdO0Rs32PINo6GDYEVx7z/+nbP/2iRAUhsVteDQ==
X-Received: by 2002:a05:6512:61a8:b0:57a:8bb8:2a25 with SMTP id 2adb3069b0e04-582d2f2494bmr5143367e87.26.1759220034156;
        Tue, 30 Sep 2025 01:13:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:499:7600::192? (2001-14ba-499-7600--192.rev.dnainternet.fi. [2001:14ba:499:7600::192])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5883f066d4asm1223750e87.96.2025.09.30.01.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:13:53 -0700 (PDT)
Message-ID: <9761713e-8733-48a8-b636-af15529064dd@gmail.com>
Date: Tue, 30 Sep 2025 11:13:52 +0300
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

Thank you for the reply.

> The fs is corrupted, thus none of those will help.
> I'm more interested in how the corruption happened.
>
> Did you use some tools other than btrfs kernel module and btrfs-progs?
> Like ntfs2btrfs or winbtrfs?
>
> IIRC certain versions have some bugs related to extent tree, but 
> should not cause this problem. 

I did not use those tools. I only have Fedora 42 installed on this computer.

> The other possibility is hardware memory bitflip, which is more common 
> than you thought (almostly one report per month)
>
> In that case, a full memtest is always recommended, or you will hit 
> all kinds of weird corruptions in the future anyway. 

Yes, that seems the most likely explanation. I switched my motherboard, 
RAM, and CPU a few weeks ago, and when building a new setup out of  the 
old components and 3 different drives (including one brand new NVME SSD) 
I noticed that each time I ran a btrfs scrub on any of those I got a 
bunch of csum errors. I initially thought that maybe the drives or 
something were faulty, but when I ran memtest it discovered very quickly 
a faulty single RAM stick. That RAM had been in my main system in a 
faulty state for months probably at least. The different computer I 
built from the old parts immediately stopped failing scrubs when I 
removed the faulty RAM stick.

So yeah, I think the corruption would have been caused by that RAM 
stick. I have now completely different RAM in my system and I've run the 
same memtest multiple times and it has not found any problem, so I think 
I have now fully good RAM and won't have the same corruption issue again.

One potentially relevant detail is that I replaced one of my disks just 
before I discovered the corruption with a bigger hard drive (at this 
point I had already swapped my RAM so there shouldn't be memory 
corruption problems during the replace). I started a btrfs replace 
operation, but I had a scrub running which was then canceled. That 
cancel for some reason also canceled the replace operation. When I 
noticed that I then restarted the replace and then let it run to 
completion (though I think the replace got canceled twice as I didn't 
realize after the first one what canceled it, so I needed to restart the 
replace multiple times). After completing the replace command without an 
error message I shut down my computer and removed the replaced drive. 
Upon booting my filesystem could not mount without the degraded flag. 
Somehow the replace had copied the right amount of data to the new 
drive, but for some reason the old drive was still marked as used. I had 
to then do a btrfs remove on that device which took a really long time 
but eventually succeeded as it seemingly had to rebuild the missing 
drive from raid data (even though all of the necessary data should have 
been copied already). So it seems like the btrfs replace operation 
doesn't fully work correctly if it is interrupted.

That could be a relevant detail, but as my filesystem only had one 
corrupt folder I somewhat doubt that as I would expect a lot more things 
to have gone wrong if the replace messed up the data. So to me that 
seems only like a minor bug in the replace operation, but one that did 
not cause this corruption.

> With a full memtest proving the memory hardware is fine, then "btrfs 
> check --repair" should be able to fix it. 

Yes, my RAM should be totally fine now.

Thanks, I will try running that repair tonight, and hoping everything is 
then fine.


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

