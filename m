Return-Path: <linux-btrfs+bounces-13253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0979A979ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 00:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88807188D160
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47326C3BC;
	Tue, 22 Apr 2025 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KvT9Done"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5225CC68
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359246; cv=none; b=G/CVi2bhftAyA+1OQDQnQNeKEBXCeRrWButWFeoKl7ntGRsSlezGvfynY2YObv1TKYR25dfY4EupZs2lSLC0e2dy2zgnKCTVGIazABtTm1k7SWHBxi+gQ/gMTqWevbW4AIExhyRLFI76sxDpozNhPZBUAmw65CAVlyToPkzr+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359246; c=relaxed/simple;
	bh=Pwwg0FYbnhq2g9+hZq7ba7KOGvno+fAkvBDW5EAAIgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kgzHlbvaVtWYZq37gtfQ7ebxZlwzF2QyTl3s3cNeLnfxJIa94V6wwNBJuOlntPdbExPSJcxHGbGdlKtmne4bER07050A9pPbydbwN85tLk68aFZwwN22UjFgCGqCiQglvjLWeUu3u8Gsot6limAIX4O80O5qWFpUYfX8No+WMsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KvT9Done; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so6189752a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745359242; x=1745964042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UM7VoOungAtUQhFLWEJqo8wxz9+I6QGQBiMR8TtG4zg=;
        b=KvT9Done2B726am3aDccF+GFn26qmdyb+Hw/3tAuacPGeIMj8CGokhwDi/9lcnS8Jw
         0Gx+SCHfHMUyHyLrf0cDxT+O+1sZdJqTrRGuGy4zuIrIy0fNUNkJeETdoywKLaucyguc
         TTJssXyiPdgfZiNY3Bzoh51LgSqFUTem0I881uaHo3bz2g80JIdqW7lTRhgjnxbeBYiL
         2mtI7UvU3P58G2xg6ymAl693VyWAyGeiV/V4/0vFT/5yqxGRJCi/TblvO2mfqYsu5UQK
         iubZf37lDewightxqAznVU4F+lyMeNShe5Qy57arjrJcK7rAedZOVLBLczBLo7HAB2FI
         Aj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359242; x=1745964042;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UM7VoOungAtUQhFLWEJqo8wxz9+I6QGQBiMR8TtG4zg=;
        b=Opb3eyIujTbs3OAHMo1rrp8YOylq9sGkGlR8lDiqfVVeYZWME0lI87f9wVkgwtzmZ8
         I08zkbxcdn5qm8bZ4ay5qpFFPXs+vz7A02ZUpMWqLe80On7NG63I6wGopWVbtXc+qXB3
         C88tkHPla9t8NjzNBK8kGFvAC5myxO++yRh6nd8VMLBFLmFT/9B+udZMhvJ6/kvBg6bl
         CmQrNR0j42bOCWnh5JKEXgFC3yF35VTXUEKM0B9R/VqO2Ye7+RyEYGRojuKDuOAyHx0c
         IrM2TwjHxtIUc/yI2QcEMdqAC8vc7c4PvXApR9LsJEx1BdpgxdhvDtz5ZXFkjg8/+WT2
         hgfw==
X-Forwarded-Encrypted: i=1; AJvYcCUH8FzKGAmjaUlUjoauU/BnhuDzLIKVuG+KNnlc680FFmCA/6t05CsZJci6aB6RswnnTY0SFizM/3xoQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzicVtsE4f2xdCv4GsGIbsglQ/2IFb4JhEC2RBb7mgyX0m1hMO1
	3HNbEm7r3M9NwdJtF6JOQelFPT4yVwXx5Ot/IzgADG1Rn7y1W5ODWaaa3t/yNjwoCPYXuTnFOqp
	Y
X-Gm-Gg: ASbGncvGXm+SUl1FK42rB6rQ+c3z0UX0C7PFJxcbHH0moveiYtlFrIqurf1yHS4HgyQ
	MHAZtG628eaZ/ksiBBeiTGl12LJe4F533GB3iZ1wboBylHYk0hYKamWXxGXh33X51dfvO2/q/R7
	tcbARM/zo/DbI1zjvRmOD7yTCNyu4+oalI+8z6W3w7Fp6j260LpSRa5DyR73AqWBgnfPONI9czr
	J/rUjdlwaMoaioGSiJWcBgTYXYVDDpX/a9JohYmIBo7VnnyAfz7pli5z3etSykEvFRg4rKuaTRZ
	lngiB2PeE7gsT3oDQGH2Z2yhQy24o2T0CyhdM91nAje/Srg65PMPtqipuQr4Ol7MnC6A
X-Google-Smtp-Source: AGHT+IF4EnmyEPKKtmDc1XmvrAfNTPkk2dpQyNAmnsrFGYRDjkV1J4/EbnqgsAEdHDm+xXyEbo4unA==
X-Received: by 2002:a17:907:1c16:b0:ac2:a473:4186 with SMTP id a640c23a62f3a-acb74bb4366mr1365527166b.34.1745359241752;
        Tue, 22 Apr 2025 15:00:41 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309e0ccf2d2sm124562a91.34.2025.04.22.15.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 15:00:41 -0700 (PDT)
Message-ID: <aee691cc-4536-40a7-8d98-b31040e0b1d6@suse.com>
Date: Wed, 23 Apr 2025 07:30:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
To: Ferry Toth <fntoth@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <c9694b5c-b75c-4d58-8a36-12c46ee816bb@gmx.com>
 <cdf268c1-b031-488e-a2f3-d68cc88f4d16@gmail.com>
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
In-Reply-To: <cdf268c1-b031-488e-a2f3-d68cc88f4d16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/23 07:02, Ferry Toth 写道:
> Hi,
> 
> Op 21-04-2025 om 00:00 schreef Qu Wenruo:
>>
>>
>> 在 2025/4/21 07:15, Ferry Toth 写道:
>>> The following is originally done by Yocto's bitbake, but when I try 
>>> manually it reproduces.
>>>
>>> I create a new fs on  a file using -r as ordinary user, then btrfs 
>>> check the file (before or after mounting makes no difference), also 
>>> as an ordinary user.
>>>
>>> The fs has 1000's of errors, I cut most because it seems the same 
>>> type of errors. The files system is unrepaired bootable, but can be 
>>> repaired using --repair, in which 1000's of files are moved to 
>>> lost+found.
>>>
>>> The below was mkfs on a non-existing file, but writing to 16GB dduped 
>>> file (rootfs is 1.4GB) makes no difference. Neither does dropping -- 
>>> shrink, -m or -n.
>>>
>>> Also, writing the file to an actual disk and then check the disk 
>>> gives the same errors.
>>>
>>> What could this be?
>>>
>>> ferry@delfion:~/tmp/edison/edison-scarthgap$ mkfs.btrfs -n 4096 -- 
>>> shrink -M -v -r /home/ferry/tmp/edison-intel/my/edison-morty/out/ 
>>> linux64/build/ tmp/work/edison-poky-linux/edison-image/1.0/rootfs 
>>> edison-image- edison.rootfs.btrfs
>>> btrfs-progs v6.6.3
>>> See https://btrfs.readthedocs.io for more information.
>>>
>>> ERROR: zoned: unable to stat edison-image-edison.rootfs.btrfs
>>> NOTE: several default settings have changed in version 5.15, please 
>>> make sure
>>>        this does not affect your deployments:
>>>        - DUP for metadata (-m dup)
>>>        - enabled no-holes (-O no-holes)
>>>        - enabled free-space-tree (-R free-space-tree)
>>>
>>> Rootdir from: /home/ferry/tmp/edison-intel/my/edison-morty/out/ 
>>> linux64/ build/tmp/work/edison-poky-linux/edison-image/1.0/rootfs
>>>    Shrink:           yes
>>> Label:              (null)
>>> UUID:               c2ecfaca-168a-401b-a12a-e73694d7485a
>>> Node size:          4096
>>> Sector size:        4096
>>> Filesystem size:    1.43GiB
>>> Block group profiles:
>>>    Data+Metadata:    single            1.42GiB
>>>    System:           single            4.00MiB
>>> SSD detected:       no
>>> Zoned device:       no
>>> Incompat features:  mixed-bg, extref, skinny-metadata, no-holes, 
>>> free- space-tree
>>> Runtime features:   free-space-tree
>>> Checksum:           crc32c
>>> Number of devices:  1
>>> Devices:
>>>     ID        SIZE  PATH
>>>      1     1.43GiB  edison-image-edison.rootfs.btrfs
>>>
>>> ferry@delfion:~/tmp/edison/edison-scarthgap$ btrfs check edison- 
>>> image- edison.rootfs.btrfs
>>> Opening filesystem to check...
>>> Checking filesystem on edison-image-edison.rootfs.btrfs
>>> UUID: c2ecfaca-168a-401b-a12a-e73694d7485a
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space tree
>>> [4/7] checking fs roots
>>> root 5 inode 252551099 errors 2000, link count wrong
>>>          unresolved ref dir 260778488 index 2 namelen 11 name 
>>> COPYING.MIT filetype 1 errors 0
>>
>> Looks like exactly the nlink bugs related to --rootdir option.
>>
>> And that's fixed in v6.10 first, by the commit c6464d3f99ed ("btrfs- 
>> progs: mkfs: rework how we traverse rootdir"), then further improved 
>> in v6.12 with the commit ef1157473372 ("btrfs-progs: mkfs: add hard 
>> link support for --rootdir").
>>
>>
>> So in short, if the directory contains hardlinks out of the directory, 
>> then you have to use btrfs-progs newer than v6.12.
> 
> Hi Qu I am confirming v6.12 resolves this issue. Afaik Yocto uses 
> reflinks. I'm guessing that generates the same issue?

Reflink should not cause the problem, shared extents (reflinks) are not 
longer shared inside the new btrfs.

E.g. if two inodes shares the same data extent, it will be created as 
two data extents, one for each inode.
Thus it will cause extra space usage.


It's only the hard links causing problems, as older progs directly uses 
the st_nlink reported from the host fs, but it's very possible that, 
some hard links are not inside the rootdir, thus causing missing nlinks 
inside the created btrfs.

> 
> As a work around for people on Ubuntu Noble (20.04 LTS) with btrfs-progs 
> version 6.6.3-1.1build2, installing the package from Plucky (no other 
> dependencies) with version 6.12-1build1 solves this issue.

Sorry we didn't notice the bug early enough, thus the fixes are only 
landed into v6.12, and we do not maintain backports for older progs.

Thus I'm afraid Yocto or similar projects have to require a much newer 
progs instead.

Thanks,
Qu

> 
> Yocto users on Scarthgap (5.0 LTS) with version 6.7.1 may copy the 
> recipe meta/recipes-devtools/btrfs-tools/btrfs-tools_6.13.bb from 
> walnascar or 6.14 from master. If they are building additional tools 
> that use headers from this package like btrfs-compsize these may break.
>> Thanks,
>> Qu
> 
> 


