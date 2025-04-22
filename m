Return-Path: <linux-btrfs+bounces-13252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43448A97893
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 23:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8D31B60F6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680501E5B85;
	Tue, 22 Apr 2025 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZbmDtJs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E38262FEF
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357550; cv=none; b=cyHfTjoLaDs7ufYM9o0vxUzTTE6P0WG5WwmgAniSxrfzJ3MKLYHoxqCHApjfEGdUIHtPCljL9DGWcjdaZGiz6Fet7a69+kIN3XGSNSRVOYk9LHsZjAp2xwfTa+1tONP64/5OEm0vm6pb+VrIGLUvMaoVReoUGi3bWZX1WpYedNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357550; c=relaxed/simple;
	bh=BPVJStyJ1Bq7fH4KHt20mm2t2KneJ9lbxjr8Xi4HJfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tKVR+UxPzzA3Oa5SgGi2qbwHUmmpvZ+JJLUIS0poNw3YC5WQlNCbRdQ6+nFC8jQk38y82kxZ+o0qleajvs/l3Lh9lcPahDi5fMPKwcKbkM0KT0e6jmzwZiE+lXPs2cqiGletnHYc/XfII0Jno3f340bHSwW9M6yiXJ2ZIvXZM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZbmDtJs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so10208748a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745357547; x=1745962347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJN3eUrdHnrX60Pq4jqBf2Gz8X1LKKpHLZ/u31nFUaY=;
        b=bZbmDtJsNE5QI1Udi5j73zIKRfIPhuxnb+5hrP/FNZW/DfIjmP0FmzNw3k8WMux5gT
         zMzcM4t1sQKZEukfs6wpuzWMC0v/6nQlJPxdlcbvXA7BYMRwrOmqbn4MWF/zdGQM6aiW
         eikwgN0jj1SCaSB27x+XQId8BRaYubOXjitia5JQHlXRRNbjg7fN8gUB/PnU1xEJfbv/
         XXGMhobIT7cDJZpCEI8izT95oVB+88Sr8UhxN872tIm2oRiMju20k+nL2UU7uyTe+ozN
         yg/AwdSHWsrFa21IodWnubeEfE3j7x/OZrDhoIh9CEoklyyKMLUyy2D/1DzyJMGcsJk9
         BTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745357547; x=1745962347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJN3eUrdHnrX60Pq4jqBf2Gz8X1LKKpHLZ/u31nFUaY=;
        b=Kat4oQdjnxTKWAVaNXG1LjIdpAhGJqSFlJjbc94NEIaRLZn/rBrvVdbLy6BhlPGg+D
         ckvNB1q5IB6sgeBI/32I7dLKHahE3yt9vTvnWgYPeFSVNalu7Qy0K6Ess/Q7Z+aAc+QZ
         Jkv5OEVQwZpuB4CZRoRW8VuN81Zd/4fKJDFJ6jow+TS7ajFBlW2/kYXGnDOiEjdH07mh
         nvYQMg+yS4gPOmyAgXEXEqNOrlQSfDS8rD8ZOIZ4R/Q5UX5lL9VNIP1UACfKYUKvSkeL
         wHE9iXC7/OUC+L0OxyfhHIENv06JEFmdI/Mt3dINAt0xnwFaBB0DcpS8L59m4kPGd4ZN
         LOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZCN2wuyPEpK8wJvC55twj9IXswcqLeocPAcg36HPEdTDig286NLM77ruc3bpweDw5qDuWFbeKKPIDnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70j45VqEn3NCK8gagiwIsjBBz8G2fNxv2xliM5Q7/XRQe6orT
	lw985HHT/4MPV7LHGsobpePm91sFWLqboBtvD6f3LYkEIM0uksFCtuxBgRSw
X-Gm-Gg: ASbGncscEVtjvPobN4eSOohJoOnLFWJLFFOeFU5mTlkYpjb/FjPZECmAPi002b6UH83
	57EPygXJvcPKuzE9/iPJXzfkFQ0CzwMc3Xlcds9K/n6Lk0LFEWTXMUn6M/PdSeJKbs1Bk/VCZNv
	ARBsRMqqhjBQkIfu6pmnUhcCuzvy9SjKoESI8NxTeNuUpozIm+V0x50lSGKtlby9HaiOgxOoDqI
	o2tgvghF3y/iZVs3kmgAkPW31gSI/ZlSkQocf81x47Nxwnm0hZ88XtQ+ttH1mNrh1zyoi9ts1xZ
	tITpIl8ofo/RgtplRHyKP8tR3F5ajAj9dBuy87A9WZ/Kj3Lbk0DnCYaWH9X84ofF9+kTGlJbUPC
	xoamZxAQpPBg2fX8hLj0b79lW2AjvS7GP/MAt4+zSQveAZGXXp5bAFXGRx+CLCQ==
X-Google-Smtp-Source: AGHT+IFWHfneTxzuCHifs60kXgLWwgwApaKWZLU6YXBxe1G3sF4h0DmVW9pVZg7IO9X+qecPrFGiCA==
X-Received: by 2002:a05:6402:2803:b0:5e7:b02b:381f with SMTP id 4fb4d7f45d1cf-5f6285f43f8mr13744206a12.30.1745357547104;
        Tue, 22 Apr 2025 14:32:27 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:b659:462b:65fc:82fd? (2a02-a466-68ed-1-b659-462b-65fc-82fd.fixed6.kpn.net. [2a02:a466:68ed:1:b659:462b:65fc:82fd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef426c4sm701213866b.131.2025.04.22.14.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 14:32:26 -0700 (PDT)
Message-ID: <cdf268c1-b031-488e-a2f3-d68cc88f4d16@gmail.com>
Date: Tue, 22 Apr 2025 23:32:26 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <c9694b5c-b75c-4d58-8a36-12c46ee816bb@gmx.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <c9694b5c-b75c-4d58-8a36-12c46ee816bb@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Op 21-04-2025 om 00:00 schreef Qu Wenruo:
> 
> 
> 在 2025/4/21 07:15, Ferry Toth 写道:
>> The following is originally done by Yocto's bitbake, but when I try 
>> manually it reproduces.
>>
>> I create a new fs on  a file using -r as ordinary user, then btrfs 
>> check the file (before or after mounting makes no difference), also as 
>> an ordinary user.
>>
>> The fs has 1000's of errors, I cut most because it seems the same type 
>> of errors. The files system is unrepaired bootable, but can be 
>> repaired using --repair, in which 1000's of files are moved to 
>> lost+found.
>>
>> The below was mkfs on a non-existing file, but writing to 16GB dduped 
>> file (rootfs is 1.4GB) makes no difference. Neither does dropping -- 
>> shrink, -m or -n.
>>
>> Also, writing the file to an actual disk and then check the disk gives 
>> the same errors.
>>
>> What could this be?
>>
>> ferry@delfion:~/tmp/edison/edison-scarthgap$ mkfs.btrfs -n 4096 -- 
>> shrink -M -v -r /home/ferry/tmp/edison-intel/my/edison-morty/out/ 
>> linux64/build/ tmp/work/edison-poky-linux/edison-image/1.0/rootfs 
>> edison-image- edison.rootfs.btrfs
>> btrfs-progs v6.6.3
>> See https://btrfs.readthedocs.io for more information.
>>
>> ERROR: zoned: unable to stat edison-image-edison.rootfs.btrfs
>> NOTE: several default settings have changed in version 5.15, please 
>> make sure
>>        this does not affect your deployments:
>>        - DUP for metadata (-m dup)
>>        - enabled no-holes (-O no-holes)
>>        - enabled free-space-tree (-R free-space-tree)
>>
>> Rootdir from: /home/ferry/tmp/edison-intel/my/edison-morty/out/ 
>> linux64/ build/tmp/work/edison-poky-linux/edison-image/1.0/rootfs
>>    Shrink:           yes
>> Label:              (null)
>> UUID:               c2ecfaca-168a-401b-a12a-e73694d7485a
>> Node size:          4096
>> Sector size:        4096
>> Filesystem size:    1.43GiB
>> Block group profiles:
>>    Data+Metadata:    single            1.42GiB
>>    System:           single            4.00MiB
>> SSD detected:       no
>> Zoned device:       no
>> Incompat features:  mixed-bg, extref, skinny-metadata, no-holes, free- 
>> space-tree
>> Runtime features:   free-space-tree
>> Checksum:           crc32c
>> Number of devices:  1
>> Devices:
>>     ID        SIZE  PATH
>>      1     1.43GiB  edison-image-edison.rootfs.btrfs
>>
>> ferry@delfion:~/tmp/edison/edison-scarthgap$ btrfs check edison-image- 
>> edison.rootfs.btrfs
>> Opening filesystem to check...
>> Checking filesystem on edison-image-edison.rootfs.btrfs
>> UUID: c2ecfaca-168a-401b-a12a-e73694d7485a
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space tree
>> [4/7] checking fs roots
>> root 5 inode 252551099 errors 2000, link count wrong
>>          unresolved ref dir 260778488 index 2 namelen 11 name 
>> COPYING.MIT filetype 1 errors 0
> 
> Looks like exactly the nlink bugs related to --rootdir option.
> 
> And that's fixed in v6.10 first, by the commit c6464d3f99ed ("btrfs- 
> progs: mkfs: rework how we traverse rootdir"), then further improved in 
> v6.12 with the commit ef1157473372 ("btrfs-progs: mkfs: add hard link 
> support for --rootdir").
> 
> 
> So in short, if the directory contains hardlinks out of the directory, 
> then you have to use btrfs-progs newer than v6.12.

Hi Qu I am confirming v6.12 resolves this issue. Afaik Yocto uses 
reflinks. I'm guessing that generates the same issue?

As a work around for people on Ubuntu Noble (20.04 LTS) with btrfs-progs 
version 6.6.3-1.1build2, installing the package from Plucky (no other 
dependencies) with version 6.12-1build1 solves this issue.

Yocto users on Scarthgap (5.0 LTS) with version 6.7.1 may copy the 
recipe meta/recipes-devtools/btrfs-tools/btrfs-tools_6.13.bb from 
walnascar or 6.14 from master. If they are building additional tools 
that use headers from this package like btrfs-compsize these may break.
> Thanks,
> Qu


