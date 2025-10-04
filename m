Return-Path: <linux-btrfs+bounces-17432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B1BB91D1
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 22:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 965F5346E12
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2C28507D;
	Sat,  4 Oct 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DO9rg/7Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF1283C97
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759610710; cv=none; b=EhM/QIOgJcJQCDfxZ74w+HlKRp+X/S93az9rmBDV4272ecZRpeY/IlBXV2FoCiftufYz4R96449F6D3ZUW0g/wh4CF5BPTaHBKLs+pwmIHP+0GSN9RePHJL25GpSKmB0aQLoQZDhAeKrR0YoNgxwg8mlGlfZ3qgMkjMnnRU1bdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759610710; c=relaxed/simple;
	bh=DqAIgGusedyEYRxFu078NmRMbjsZtcs5bxyRk8oTdaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fzWy+W98fCuIoXbO3xFrU/aClWIKKLmtpDDMr67abbv5IqfYY4Opri8ZenjSoc+x9BeoJBU+CEgNQIJLXzwV4NOCF9rF8sj3ocb7X8I4OErjjKBPH5Bz5Z7stjAu+4ElZzAY1v1ukjwW7S2WzrHq2KeIEDc0Hox7O+AIizgD9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DO9rg/7Z; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so3126665f8f.3
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Oct 2025 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759610704; x=1760215504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1emWE9fFvCMATzqOPtbNZpMdJZ0BhfTe4TzSBNGgoSM=;
        b=DO9rg/7ZLw4LfRIn8rQFXtTF0BTjN8c2OoudfGOZS1zfGOVMaUgMOFVtD6fF7+HslR
         lVsjpMGWl95fXo7P0f/jwB74uO2/HtOTA8l9V5ZlRGqB2TJkvBHnoOri1WPeGiHeDnRp
         cIRzYkWE+uTu6tg+JM48Bni8asA8FaxJQNSALembw/9mef1kxpIDndwrFGATnD/sHReo
         Q12a9eQ5hFQsFxs4LHgqIx772SJilthQaTElJYGhd85NjvIVswo/yiW5Akv9uVAk+1hr
         XUe4OadNT6RqfyezAREnVbRyoWuxZqihNoxZ29FV1sLuKrWdTiXQxEdUYvNj5FyYdJTi
         SLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759610704; x=1760215504;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1emWE9fFvCMATzqOPtbNZpMdJZ0BhfTe4TzSBNGgoSM=;
        b=w8nOQjcletdTasKQ0XRPsC5GFW0ufyb7IDz++wRYh4iUCMI9E2uLUMyU4FdlFuB1or
         eO2h9kFyjhXpmBBzclBxrWnFLaR8e71aEV0aGyo7ME8ORbbVRdf8m3fHEBfQH/ktWqkE
         ZTw568hIFwfmrcfQ/I8/nLNgFc0Y7m8NxlB/lMrlowJlEBOYvuOE+bsb+1GrPl6Bw2O8
         +PSxX4P+5sXuPK1Tv4dOofqn4yz3JKWtunSZUuqFqRaJbaznkvPEftuj9Fo0jgM15tmB
         3mFZYtPspGB2XTD/gx655ZJgk5eVZUr6VOsToxcFgk7VHnr0nh9pq83XatmSy9D5WvJH
         hTgA==
X-Forwarded-Encrypted: i=1; AJvYcCXutB4LmszeJnEwEFFT0OM2r5xVeAe3rEP+a9VBFCy3Qu6+maXWhla4Cgjok8bw+vq2tSMfhm3TDSVnqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmoqG2l5h/nVixa1QgcpvMS/+eALIzBIOkNwVs7QJVBgBRCC8W
	RuP3bkau9QMkAeO8kOeUTIXa1t+7HF3mrwbiqAgl11VhN6kqA4TE1ZyO1uKA9QwCqdE=
X-Gm-Gg: ASbGncuz/IJjjLIqLL98MJN6HjZqt6VMwllEKP9RKNX6KoWccUpc8w65ul6/Lz8xRNd
	pcPsoi4swrRYaexW6AdXIKr4Eh+5AEOh+BC5Wt/SqUiu2MnhmkUo4Nwnh8v/ttSZH8qyQKC+t1/
	Sqv/C6QefOreHtcYvlcRiohQojQ7EGcc1e7COO+F8pxw86nGkrQNv0EyYgkpHxwECFGKA4PFe3S
	Qi9JfTCAkV4hL8jX3DkKw5SrzBq02yGSOOAE0ekNqbtzs7UbZ3NoOmFLUi2tTjAzl603j6PYiFQ
	n8gQuP8w2ePXBV97I4obxSsPoJcbAfJG/pjbhWPGpmEjYgIBUEdcPh1CDSlC3MSGjnAKgIhK2fa
	E5lRQur18aKuPJ7PJFOvQ+sxmEJBv4cZg8EVSrC2mvuQQWGVnFEIdLV2TlNEGvfC/YoV7Zzk5PH
	EUR35dNhqUHA==
X-Google-Smtp-Source: AGHT+IE98iW3JKgh8AJOMbI7GaKvYJshYaMK/yh3s6sx/AVNkCcpyonH0TgGyqBo/2SUkSGOXI67zA==
X-Received: by 2002:a05:6000:2504:b0:3ec:df5a:90d with SMTP id ffacd0b85a97d-425671c5331mr4869274f8f.60.1759610704342;
        Sat, 04 Oct 2025 13:45:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff258esm11843830a91.15.2025.10.04.13.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 13:45:03 -0700 (PDT)
Message-ID: <b6273125-86fb-443b-9b2d-3430594f0152@suse.com>
Date: Sun, 5 Oct 2025 07:14:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to remove an unremovable file and directory?
To: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
 <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
 <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
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
In-Reply-To: <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/5 04:13, Henri Hyyryläinen 写道:
> Hello again.
> 
> It took over 3 days, but the btrfs check --repair has now completed 
> seemingly successfully. I mostly saw output about the file being placed 
> in lost+found and and directory size being corrected. However, there 
> were some messages about mismatch of used bytes.
> 
> Unfortunately it seems like the situation has gotten worse since the 
> repair, because now I cannot mount the filesystem at all. Instead I get 
> an error like this:
> 
>> BTRFS error (device sdc): dev extent physical offset 19977638903808 on 
>> devid 4 doesn't have corresponding chunk
>> BTRFS error (device sdc): failed to verify dev extents against chunks: 
>> -117
>> BTRFS error (device sdc): open_ctree failed: -117
> Even if I remove that one problematic device physically from my 
> computer, the filesystem still refuses to mount with the same error. 
> Maybe the problems with the device replace are again showing up with the 
> actual size of the hard drive not being used correctly? I cannot try to 
> remove the device slack as I cannot mount the filesystem.

Nope, this is a different problem, and not related to dev replace.

Unfortunately btrfs check has not implemented any repair for that.

Overall if the dev extent is found but not corresponding chunk, it 
should still be fine but some space unavailable.

But the kernel is overly cautious on chunk tree, as it's a very 
important and basic functionality.

Please provide the full "btrfs check --readonly" output so that we can 
evaluate and add the missing repair functionality.

Thanks,
Qu

> 
> I did try to run a repair again, and this time I got a bunch of messages 
> like:
> 
>> repair deleting extent record: key [65795546775552,169,0]
>> adding new tree backref on start 65795546775552 len 16384 parent 
>> 65811674234880 root 65811674234880
>> adding new tree backref on start 65795546775552 len 16384 parent 0 
>> root 14499
>> adding new tree backref on start 65795546775552 len 16384 parent 
>> 65791012274176 root 65791012274176
>> adding new tree backref on start 65795546775552 len 16384 parent 
>> 65806385807360 root 65806385807360
>> Repaired extent references for 65795546775552
>> ref mismatch on [65795548233728 16384] extent item 5, found 4

That's fixing some backref mismatch, which you can ignore unless "btrfs 
check --reaonly" later reports new problems.

> But the filesystem still refuses to mount with the exact same error. I 
> did not let the repair run entirely as it would have likely taken 
> another 3 days. What should I do? This time I'm not finding any good 
> information on what to do. For now, I've started the repair again, but 
> it doesn't exactly sound like it is even fixing anything now. Still, 
> I'll let it continue. The output so far is:
> 
>> [1/8] checking log skipped (none written)
>> [2/8] checking root items
>> Fixed 0 roots.
>> [3/8] checking extents
>> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
>> chunk.
>> super bytes used 49454738989056 mismatches actual used 49454738923520
>> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
>> chunk.
>> super bytes used 49454739005440 mismatches actual used 49454738956288
>> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
>> chunk.
>> super bytes used 49454739021824 mismatches actual used 49454738972672
>> Device extent[4, 19977638903808, 1073741824] didn't find the relative 
>> chunk.
>> super bytes used 49454739005440 mismatches actual used 49454738972672
> 
> 
> If I was able to somehow remove that one logically corrupt devid from 
> the filesystem, or somehow correct the size, that would hopefully allow 
> me to rebuild from the raid10 data then, but I can't do those with the 
> unmountable filesystem.
> 
> 
> - Henri Hyyryläinen
> 
> Qu Wenruo kirjoitti 30.9.2025 klo 0.52:
>>
>>
>> 在 2025/9/30 02:41, Henri Hyyryläinen 写道:
>>> Hello,
>>>
>>> I hope this is the right place to ask about a filesystem problem. 
>>> Really shortly put, I have a file that both exists and doesn't and 
>>> prevents the containing directory from being deleted. No matter what 
>>> variant of rm and inode based deletion I try I get an error about the 
>>> file not existing, and I also cannot try to read the file, but if I 
>>> try to delete the directory I get an error that it is not empty (so 
>>> the file kind of exists). Trying to ls the directory also gives a 
>>> file doesn't exist error.
>>>
>>> Here's what btrfs check found, which I hope does better in 
>>> illustrating the problem:
>>>
>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>
>>> I've tried everything I've found suggested including a full scrub, 
>>> balance with -dusage=75 -musage=75, resetting file attributes, 
>>> deleting through the find command, and even some repair mount flags 
>>> that don't seem to exist for btrfs.
>>
>> The fs is corrupted, thus none of those will help.
>> I'm more interested in how the corruption happened.
>>
>> Did you use some tools other than btrfs kernel module and btrfs-progs?
>> Like ntfs2btrfs or winbtrfs?
>>
>> IIRC certain versions have some bugs related to extent tree, but 
>> should not cause this problem.
>>
>>
>> The other possibility is hardware memory bitflip, which is more common 
>> than you thought (almostly one report per month)
>>
>> In that case, a full memtest is always recommended, or you will hit 
>> all kinds of weird corruptions in the future anyway.
>>
>>
>> With a full memtest proving the memory hardware is fine, then "btrfs 
>> check --repair" should be able to fix it.
>>
>> Thanks,
>> Qu
>>
>>
>>> What I haven't tried is a full rebalance with no filters, but I did 
>>> not try that yet as it would take quite a long time and if it only 
>>> moves data blocks around without recomputing directory items, it 
>>> doesn't seem like the right tool to fix my problem. So I'm pretty 
>>> much stuck and to me it seems like my only option is to run btrfs 
>>> check with the repair flag, but as that has big warnings on it I 
>>> thought I would try asking here first (sorry if this is not the right 
>>> experts group to ask). So is there still something I can try or am I 
>>> finally "allowed" to use the repair command? Here's the full output I 
>>> got from btrfs check:
>>>
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/sdc
>>>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>>>> [1/8] checking log skipped (none written)
>>>> [2/8] checking root items
>>>> [3/8] checking extents
>>>> [4/8] checking free space tree
>>>> We have a space info key for a block group that doesn't exist
>>>> [5/8] checking fs roots
>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14428 inode 25953213 errors 200, dir isize wrong
>>>> root 14428 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14451 inode 25953213 errors 200, dir isize wrong
>>>> root 14451 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14475 inode 25953213 errors 200, dir isize wrong
>>>> root 14475 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14499 inode 25953213 errors 200, dir isize wrong
>>>> root 14499 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14523 inode 25953213 errors 200, dir isize wrong
>>>> root 14523 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14544 inode 25953213 errors 200, dir isize wrong
>>>> root 14544 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14545 inode 25953213 errors 200, dir isize wrong
>>>> root 14545 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14546 inode 25953213 errors 200, dir isize wrong
>>>> root 14546 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14547 inode 25953213 errors 200, dir isize wrong
>>>> root 14547 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14548 inode 25953213 errors 200, dir isize wrong
>>>> root 14548 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14549 inode 25953213 errors 200, dir isize wrong
>>>> root 14549 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> root 14550 inode 25953213 errors 200, dir isize wrong
>>>> root 14550 inode 27166085 errors 2000, link count wrong
>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>> ERROR: errors found in fs roots
>>>> found 49400296812544 bytes used, error(s) found
>>>> total csum bytes: 48179330432
>>>> total tree bytes: 65067483136
>>>> total fs tree bytes: 12107431936
>>>> total extent tree bytes: 3194437632
>>>> btree space waste bytes: 4558984171
>>>> file data blocks allocated: 76487982252032
>>>>  referenced 60030799097856
>>>
>>> So hopefully if I'm reading things right, running a repair would 
>>> delete just that one file and directory (which itself is a backup so 
>>> I will not miss that file at all)?
>>>
>>> I do not have enough disk space to copy off the entire filesystem and 
>>> rebuild from scratch, without doing something like rebalancing all 
>>> data from raid10 to single and then removing half the disks, but I 
>>> assume that would take at least 4 weeks to process (as I just 
>>> replaced a disk which took like a week).
>>>
>>> As to what originally caused the corruption, I think it was probably 
>>> faulty RAM, because up to to like 3 weeks ago I had one really bad 
>>> RAM stick in my computer where a certain memory region always had 
>>> incorrectly reading bytes. I had seen intermittent quite high csum 
>>> errors in monthly scrubs pretty randomly, which thankfully could 
>>> almost always be corrected so I didn't have any major problems even 
>>> though I had like totally broken RAM in my computer for who knows how 
>>> long. So btrfs was able to protect my data quite impressively from 
>>> bad RAM.
>>>
>>> Sorry for getting a bit sidetracked there, but what should I do in 
>>> this situation?
>>>
>>> - Henri Hyyryläinen
>>>
>>>
>>


