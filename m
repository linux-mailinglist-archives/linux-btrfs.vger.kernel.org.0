Return-Path: <linux-btrfs+bounces-17275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A268BAAAB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 23:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFDF1C2206
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 21:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D6A2522A1;
	Mon, 29 Sep 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CRhjx88g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1F21FF28
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759182728; cv=none; b=PDITeZMGW6ISbsPr9D78MiGfBd6EbAomPIVDTE/xmy3JQ7FIha7DmQ0qEtGMHO18YbQma2+XW3qmwQ6nCNh/ZCD5SO/WgU+5CK8V2rMP7F9aVQfmirfApJONxjEceh+hXFWugwoLl2wGgECHsfNRrJJazzYTiuXmsA8TBGYTEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759182728; c=relaxed/simple;
	bh=8PSkQepvGWLh7Wwx7W8sEaOqIjpEPXjSNn/7dWBcfNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yx2IoX+qw+/PaR9+9+kwJcMQmtV+t3dPp3KSGm3whrZ4VZaVTEBgpQ/Kje4rQ7wbD4rKsCx8OKJVA+inbHVcRMWc4iWsqEq50jFNLFccUnS7WMfgFiX6jMpk9dO2ZNW6OTZvNhulelfdN+mOtszoYBVTbiYW5vCbZkIrwViVxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CRhjx88g; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso28764145e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759182725; x=1759787525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mcq+vIOAE9agSbCG9fwPsvC3IhMI/ybOyf1mboTdQg=;
        b=CRhjx88gcKpdyT1uSGv7KWGLPDlBqKD5TTsTZv4OjBfW6hsAqyIOk+6p7WVpgkpCRU
         NtVJcxXYYo1Uw365BPjg4Tj9FZaCvWu76cmO6CB4nfVXKPpptsR6S2MyqrsjWJ+zj3tV
         G3ntTpBLdeD+3V+aILEN+TiAX7oCWpnEVoA4Llu2CUAzwBvwUEbmGPKBkmMkb0Xwke6V
         FkPLXJ/aUilEh+yk+f3ODujuui438aarI8K6qZ0Tpj4A7z9XGK3PYBpdATCrhctFHPuT
         6FXeeTpparrnMc13/vluW3A5F3LXnCHjw4sPYQ+9JqGfIqWkHdq8yHRHCiC69zcLACwC
         g6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759182725; x=1759787525;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Mcq+vIOAE9agSbCG9fwPsvC3IhMI/ybOyf1mboTdQg=;
        b=JJyPXxPYup6TU/0dvaLavW5XkBbbcMZ+jE9xT/8KxR5LrcXRbHIL2IoubQEHGV85SL
         M9UUEQSYlnFuwxkReinLlg1LvlOuyz+DJplRRb1JCHBJaoDgrgTXG5KRm48fzldJU0lA
         3EXOk4fxKoEq3HJnhzvQsFzdkh9l2keu6eMJEhlTavdKCrtlUs3izeu5BCr5xSm9Y7Y8
         i1K8X4Z50LEp/gYaWnyWUgx9oDxsaoXVRxRH5L1OyfjulI14D7ESiJJoNHtp2ZVCrUxL
         2R4YIIe6p/xgcSZUYif03Bjtd+XObOLdE6zKhOx4iui0o3BTtYfDCN/OveumXYV3w+0F
         DZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxX7gwUnCV0RQhtqylM1E8+f2KTFC+khgWIt8yg6lXx5yuHVTDuX1aERYboAvdHkXjaICk1Zi2f8IW+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrjFsTeiTuspB2+Kn7YNHW/9YYQoB8a6kBGH8zL61aJXJUY2qH
	po000knZ2rtcWdzb61yv7myqhcygHH3z/GYxLL/YbDgj0g02Ey0GhtLMKAgWKnLxuezPwFYq1Bi
	i8PAs
X-Gm-Gg: ASbGncta+6/iLNdNuNjh96yA1RbS5sOU9qOyAZ568Ubym9JwHSnkQDGlqbsQFoG+BFz
	xY++7mDY4jdftNhc23WmtIB5bAunpE2NleghB+x06r+JClQrD6EqYThWESGH3xaB7JEqG78Kex5
	H10aNPgg/Kp6f+jLJ/XWZsnPDTZLsK9b+5L6wmofn9rzMgLtSciQ9154Y6q8bdHOQllQoFJiGrI
	r/8V1+vfBv3khRrj9g8wBQMCLA25o4/10SXBLwK+P8EukBRXe3rjJtBbadcu5eDSruqxprFHQwq
	aWxVLUM/S7fsFSiyFDbYY/HVZzUf/GA6nDFaWUMnh37fk7Y7W4HpAOOaLfHQEbM5X/25A5IbRZV
	mcxo2mvUcwN5VFRWiq2nObbGtUykI/wtIwi8chd0liEjIgs2BEcs=
X-Google-Smtp-Source: AGHT+IHLlEtO2EZdt+a6MCFyEm0U2cLI6uXWAGwKETVKxkpY4Tmu23VUU3xhA3YzKOsyLSoOEkPyfg==
X-Received: by 2002:a5d:5cce:0:b0:414:6fe6:8fc1 with SMTP id ffacd0b85a97d-4146fe69376mr8455360f8f.17.1759182724587;
        Mon, 29 Sep 2025 14:52:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27f1c1af2d5sm102273895ad.58.2025.09.29.14.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 14:52:04 -0700 (PDT)
Message-ID: <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
Date: Tue, 30 Sep 2025 07:22:00 +0930
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
In-Reply-To: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/30 02:41, Henri Hyyryläinen 写道:
> Hello,
> 
> I hope this is the right place to ask about a filesystem problem. Really 
> shortly put, I have a file that both exists and doesn't and prevents the 
> containing directory from being deleted. No matter what variant of rm 
> and inode based deletion I try I get an error about the file not 
> existing, and I also cannot try to read the file, but if I try to delete 
> the directory I get an error that it is not empty (so the file kind of 
> exists). Trying to ls the directory also gives a file doesn't exist error.
> 
> Here's what btrfs check found, which I hope does better in illustrating 
> the problem:
> 
>> root 5 inode 25953213 errors 200, dir isize wrong
>> root 5 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> 
> I've tried everything I've found suggested including a full scrub, 
> balance with -dusage=75 -musage=75, resetting file attributes, deleting 
> through the find command, and even some repair mount flags that don't 
> seem to exist for btrfs.

The fs is corrupted, thus none of those will help.
I'm more interested in how the corruption happened.

Did you use some tools other than btrfs kernel module and btrfs-progs?
Like ntfs2btrfs or winbtrfs?

IIRC certain versions have some bugs related to extent tree, but should 
not cause this problem.


The other possibility is hardware memory bitflip, which is more common 
than you thought (almostly one report per month)

In that case, a full memtest is always recommended, or you will hit all 
kinds of weird corruptions in the future anyway.


With a full memtest proving the memory hardware is fine, then "btrfs 
check --repair" should be able to fix it.

Thanks,
Qu


> What I haven't tried is a full rebalance with 
> no filters, but I did not try that yet as it would take quite a long 
> time and if it only moves data blocks around without recomputing 
> directory items, it doesn't seem like the right tool to fix my problem. 
> So I'm pretty much stuck and to me it seems like my only option is to 
> run btrfs check with the repair flag, but as that has big warnings on it 
> I thought I would try asking here first (sorry if this is not the right 
> experts group to ask). So is there still something I can try or am I 
> finally "allowed" to use the repair command? Here's the full output I 
> got from btrfs check:
> 
>> Opening filesystem to check...
>> Checking filesystem on /dev/sdc
>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>> [1/8] checking log skipped (none written)
>> [2/8] checking root items
>> [3/8] checking extents
>> [4/8] checking free space tree
>> We have a space info key for a block group that doesn't exist
>> [5/8] checking fs roots
>> root 5 inode 25953213 errors 200, dir isize wrong
>> root 5 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14428 inode 25953213 errors 200, dir isize wrong
>> root 14428 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14451 inode 25953213 errors 200, dir isize wrong
>> root 14451 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14475 inode 25953213 errors 200, dir isize wrong
>> root 14475 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14499 inode 25953213 errors 200, dir isize wrong
>> root 14499 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14523 inode 25953213 errors 200, dir isize wrong
>> root 14523 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14544 inode 25953213 errors 200, dir isize wrong
>> root 14544 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14545 inode 25953213 errors 200, dir isize wrong
>> root 14545 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14546 inode 25953213 errors 200, dir isize wrong
>> root 14546 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14547 inode 25953213 errors 200, dir isize wrong
>> root 14547 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14548 inode 25953213 errors 200, dir isize wrong
>> root 14548 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14549 inode 25953213 errors 200, dir isize wrong
>> root 14549 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> root 14550 inode 25953213 errors 200, dir isize wrong
>> root 14550 inode 27166085 errors 2000, link count wrong
>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>> ERROR: errors found in fs roots
>> found 49400296812544 bytes used, error(s) found
>> total csum bytes: 48179330432
>> total tree bytes: 65067483136
>> total fs tree bytes: 12107431936
>> total extent tree bytes: 3194437632
>> btree space waste bytes: 4558984171
>> file data blocks allocated: 76487982252032
>>  referenced 60030799097856
> 
> So hopefully if I'm reading things right, running a repair would delete 
> just that one file and directory (which itself is a backup so I will not 
> miss that file at all)?
> 
> I do not have enough disk space to copy off the entire filesystem and 
> rebuild from scratch, without doing something like rebalancing all data 
> from raid10 to single and then removing half the disks, but I assume 
> that would take at least 4 weeks to process (as I just replaced a disk 
> which took like a week).
> 
> As to what originally caused the corruption, I think it was probably 
> faulty RAM, because up to to like 3 weeks ago I had one really bad RAM 
> stick in my computer where a certain memory region always had 
> incorrectly reading bytes. I had seen intermittent quite high csum 
> errors in monthly scrubs pretty randomly, which thankfully could almost 
> always be corrected so I didn't have any major problems even though I 
> had like totally broken RAM in my computer for who knows how long. So 
> btrfs was able to protect my data quite impressively from bad RAM.
> 
> Sorry for getting a bit sidetracked there, but what should I do in this 
> situation?
> 
> - Henri Hyyryläinen
> 
> 


