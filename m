Return-Path: <linux-btrfs+bounces-17268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168DBAA1BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 19:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562411921C80
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18F230B506;
	Mon, 29 Sep 2025 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv5N+nQJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8C272810
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759165908; cv=none; b=ETYw1LdWh20KOiIDFfpw5DQYQm+5BvGRlBl5EDB9u+qZp32s9T0mrCD3WywhMccOsaZ30+v8CrAZ+QiKk2TBTipTUVuJieX9vsJYjvdHhY4WSMOm8udQHSaxRV/QkOX5BTr0RSGDckHThnSVjoWizq7cFC/5affwHSIYcMDjQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759165908; c=relaxed/simple;
	bh=k3tnMwJqz0zZ78jdKUo9exnCrx1AUHYB6BV4NcxdVhg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SrfiFUCclVvGi1qdo/qEeCATosGRvjpqgix185SxQjbLRQQvIFjPF23fCxTqWR6e2tU/xgSSrtIUlJ6Qr9u+HFmMmqnSUM8uW6cAgffxltXR7u2+Q8nYiQX8jXytn/Rh2uXP36jmCKLatr/1EhMkAvwi4cgW1nV7Apy3C67B+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv5N+nQJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57ea78e0618so4931823e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759165904; x=1759770704; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:content-language:from:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP1n+mA924/7K/GmzU7TcaDs4d6+oXNaLl6XZDA0aNY=;
        b=iv5N+nQJIJstOxCBxd4+2M9Z1DWAR1HlBWRb9V9iJFKX+figebtniRLUoMh7klITLm
         mWPL2u/XfXItTWU4dNZQY1MUsow6ugOFegCwqakf+djf6VIX3hv2oFI9CV1M5ER97bFG
         tmnaqWi1B5HhXCNAl1flHAp0ncSno2ZqMKzR7jMqeOkmh744iImvkLOGBAB4ll36k99J
         RQiMfPDGj9lj6cJYb44eFYEadYye6MH5S3kNP2eKpP2+1GqfgsRUv07OmzmFcA7ARGD4
         46CcznRPQbWwf0P5d4wa314ktxrW/0YCKOXHMf/zHAy/+OYzYqUaOQfaOHwluz2ZxFU3
         f4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759165904; x=1759770704;
        h=content-transfer-encoding:subject:content-language:from:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qP1n+mA924/7K/GmzU7TcaDs4d6+oXNaLl6XZDA0aNY=;
        b=FNiqcXBVMMRWN1wTdo4sUdq/Ol/bZSE7LMN9vmvClsuJx+4K12euAv/VHqmILPAgYE
         l3SmXi/71SDRVamD4m7ixbOLGnUVpsfzCo5d8FxtZDaatkTD0QAyNS/nZS8jyEqNOCOU
         6qW1w0oLN5bC8S0sDQk0wnLSYIO8L65Dc22BNPtE/Lzal836KRMKhOXf701/aD/SXIR8
         B81PMXTvwZmLO2mIQgkYfeTXfaycPIUJF8ArzcEgBGB+MoRaV04XBwGhUESP5uyJqcoM
         RErHWXE8bVHPvFGSO3P3ht/TFZaeLh4AwoN8Qv/S10lfi0avZRmsGH0WWALgnXLMdgH9
         ij3g==
X-Gm-Message-State: AOJu0Yx6XX9fvEevTcIX5k1jEEDH0w6A+U2a+1pX082G92i3FLyvA1ff
	iLuIIz4GntUnvDKhm/HwIMvu5i9RpihFafhf+U/G2Opz1t++3tRsU/H8m66AIA==
X-Gm-Gg: ASbGncvmNXjexSYBNUmhrv/Xc5BjA/9TmZA3SWr431o2VkOgeRinOr76q89NlNfcrJ5
	Swbz+n0sW+Ntygi3/nQP2l/TAw4E2ORDd/dvCxaZRZHXiuNpkEDsn3CYUdmIpCE5eNdEjGpvw1v
	z6ej7JFiODedQNNF2qwPvJ7JcRr4LMPsC+jGhRiYrSwYiTkzQOeiJzxH1UqS8lV9L3OdH82z6Jv
	0p5EvRjHOHYlDGAHk8uyyip8nqF7eeQEaZRVe8p+iI14AMMp5X2oF5p0/t0CCWbAOBaWOJDgtx+
	R/MWBhiMgbXGS0+m2KcU5vSBSFDwpeP3yrKOLyLCaG8lwFoUPHNSTUR8KqlxJt1cD5t6ABvIo+8
	BBCjh5i+WoNARW6E9WA/NtcHKA4YCs0TbXEA7y1rjVLMXKFS+7WspfMlXq2kACJkYf+ynS2IN3Z
	wnB3T+FXcaS7bx78obywPum9fU
X-Google-Smtp-Source: AGHT+IGdYqphNyQ1I28kYEVZvr9/Uzz+Srczp7dm5wkukLMyh2/AWxw2xVv/+CD5ED9OFi/4yw/P/g==
X-Received: by 2002:ac2:4f0e:0:b0:55f:4ac2:a595 with SMTP id 2adb3069b0e04-582d0c284e2mr6060740e87.16.1759165903180;
        Mon, 29 Sep 2025 10:11:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:499:7600::198? (2001-14ba-499-7600--198.rev.dnainternet.fi. [2001:14ba:499:7600::198])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58313dd67c4sm4274920e87.55.2025.09.29.10.11.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 10:11:41 -0700 (PDT)
Message-ID: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
Date: Mon, 29 Sep 2025 20:11:40 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
From: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>
Content-Language: en-US
Subject: How to remove an unremovable file and directory?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I hope this is the right place to ask about a filesystem problem. Really 
shortly put, I have a file that both exists and doesn't and prevents the 
containing directory from being deleted. No matter what variant of rm 
and inode based deletion I try I get an error about the file not 
existing, and I also cannot try to read the file, but if I try to delete 
the directory I get an error that it is not empty (so the file kind of 
exists). Trying to ls the directory also gives a file doesn't exist error.

Here's what btrfs check found, which I hope does better in illustrating 
the problem:

> root 5 inode 25953213 errors 200, dir isize wrong
> root 5 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item

I've tried everything I've found suggested including a full scrub, 
balance with -dusage=75 -musage=75, resetting file attributes, deleting 
through the find command, and even some repair mount flags that don't 
seem to exist for btrfs. What I haven't tried is a full rebalance with 
no filters, but I did not try that yet as it would take quite a long 
time and if it only moves data blocks around without recomputing 
directory items, it doesn't seem like the right tool to fix my problem. 
So I'm pretty much stuck and to me it seems like my only option is to 
run btrfs check with the repair flag, but as that has big warnings on it 
I thought I would try asking here first (sorry if this is not the right 
experts group to ask). So is there still something I can try or am I 
finally "allowed" to use the repair command? Here's the full output I 
got from btrfs check:

> Opening filesystem to check...
> Checking filesystem on /dev/sdc
> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space tree
> We have a space info key for a block group that doesn't exist
> [5/8] checking fs roots
> root 5 inode 25953213 errors 200, dir isize wrong
> root 5 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14428 inode 25953213 errors 200, dir isize wrong
> root 14428 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14451 inode 25953213 errors 200, dir isize wrong
> root 14451 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14475 inode 25953213 errors 200, dir isize wrong
> root 14475 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14499 inode 25953213 errors 200, dir isize wrong
> root 14499 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14523 inode 25953213 errors 200, dir isize wrong
> root 14523 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14544 inode 25953213 errors 200, dir isize wrong
> root 14544 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14545 inode 25953213 errors 200, dir isize wrong
> root 14545 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14546 inode 25953213 errors 200, dir isize wrong
> root 14546 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14547 inode 25953213 errors 200, dir isize wrong
> root 14547 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14548 inode 25953213 errors 200, dir isize wrong
> root 14548 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14549 inode 25953213 errors 200, dir isize wrong
> root 14549 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> root 14550 inode 25953213 errors 200, dir isize wrong
> root 14550 inode 27166085 errors 2000, link count wrong
>         unresolved ref dir 25953213 index 7 namelen 33 name 
> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
> ERROR: errors found in fs roots
> found 49400296812544 bytes used, error(s) found
> total csum bytes: 48179330432
> total tree bytes: 65067483136
> total fs tree bytes: 12107431936
> total extent tree bytes: 3194437632
> btree space waste bytes: 4558984171
> file data blocks allocated: 76487982252032
>  referenced 60030799097856

So hopefully if I'm reading things right, running a repair would delete 
just that one file and directory (which itself is a backup so I will not 
miss that file at all)?

I do not have enough disk space to copy off the entire filesystem and 
rebuild from scratch, without doing something like rebalancing all data 
from raid10 to single and then removing half the disks, but I assume 
that would take at least 4 weeks to process (as I just replaced a disk 
which took like a week).

As to what originally caused the corruption, I think it was probably 
faulty RAM, because up to to like 3 weeks ago I had one really bad RAM 
stick in my computer where a certain memory region always had 
incorrectly reading bytes. I had seen intermittent quite high csum 
errors in monthly scrubs pretty randomly, which thankfully could almost 
always be corrected so I didn't have any major problems even though I 
had like totally broken RAM in my computer for who knows how long. So 
btrfs was able to protect my data quite impressively from bad RAM.

Sorry for getting a bit sidetracked there, but what should I do in this 
situation?

- Henri Hyyryläinen


