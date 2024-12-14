Return-Path: <linux-btrfs+bounces-10376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76459F2076
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 19:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8681679AC
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 18:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512381B4F3F;
	Sat, 14 Dec 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdWr81ix"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF31AF0C6
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202077; cv=none; b=WOdikACU0ze9UP3wvTT1rZQHg0glOkpNy9dpZEi02M330ry4HptJ/vuMsymi+II2Yv9MC1Q9MVT7HGOiyH9/Ob3tfFVpPdZIXZUohV2Qn+MBSKeoE249OHkxLnYZ+LDehkJhYXxtBaifS8ak5I0XnchLe79Q5CQ1x3YJ1Z6uMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202077; c=relaxed/simple;
	bh=+IMaXtL2MgAIg31j8vIxlNZU+zeS7bCqefIG/2ob5EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IIfOsdkyBsalsvWv9WsteVY96OQp1+6n0GOcFONLjHCHcC9AVzEpQP3e+FZHPM5uJFikhdfN5xbkFvtZpXygsH+S5j+nn6DNRRAgOvlEzzBMcvMc1UgFeBjSRPQmv68u/UB1n0ZfRiusUEZ6HXDb5NZ0B2h45HzpgsXLEKhQcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdWr81ix; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54021daa6cbso3252669e87.0
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 10:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734202073; x=1734806873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lznrpgNlzI6XFnh8Wb+UyVM5cwTF2tryejELq+hEnLM=;
        b=jdWr81ixOVBfPG5sk4p0CpOEXfzlnMPPqKn/msT6ZNGsKyKp1/0e3CbQXtzVLi6SN7
         XcJIuw/B84kjLu9k3NVQeaYMiNnkctE9J6/iI4P2m4n7VMv1yz5NcrnfRqqUOblPYEUW
         RJGbqVYjwWj5cNiSyALHRegzQijXk6b1VMTp1Tct5AZvDescpIMOFt4XM2pKKtOtipsQ
         xvjYCK0S+15FGPtPRnlIH30SiH9qMUYnG/ms+tvw2V69W9yQ56xlmGIN0/3mymG0qvTT
         8isE8EO3zRQsBW6hsQRt3PHtglcIxXL75Z4J9cXxfnoidTU5jGIXVlsOm1m8XWJeyWM4
         3XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734202073; x=1734806873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lznrpgNlzI6XFnh8Wb+UyVM5cwTF2tryejELq+hEnLM=;
        b=upq5IW6vhNOqyXlzLa2L7ccYBjSE9jIi6I4iPjb/6BxxDuqSM4nEjVOWS1jGbFrUS/
         s17LnlBSasNmj5M+vtA4QGCFq00Q2gNXpKip0KkZHQvWru1V+BsRYN43Webv7AV9DtMI
         CUBfx0BHMPu3MFx0f/sxy8FS9TfmdmAnfLqpBAqEvc9PJC/GvblJ2dbkrIjkkWED3X4l
         4+BcmKzWP+MPhdiqNOdJ7pIH9MgmIVXgEl35i7XHtWXVJT/Kq44IvWCoGDON5OzI9y7U
         k9qwFn77pDhjO6czTcB52uOxyBkcGyIxHpJ5syeZ1+zmPUINVv6iglgOm7PkkAuw7BQo
         3HNA==
X-Forwarded-Encrypted: i=1; AJvYcCXvTFDu+sPSilv7/7oOn3cjYp8TmowqELj3H6VRI3+mV8NMGJtKJt5kMVzFJ7nurugSZPnCrMchxoWFxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEoCbsvIsW4NL79NAl3sBdlYh/pG9n2jpK1Ze2Z6b1tcyE+MSE
	qTUfEuYZv1lf1KkjbU7GwIgz3bqKuE6mPOTjQP4EMFkRD69ND3G6qpPD6w==
X-Gm-Gg: ASbGnctLuIOPXw8EGlj1xMDDK/P4LvZgJFqriLRjmBuHD7mfShUeoIjNbb9zMcfmgLP
	q6XiBHHvMMWpJlpbFe3qWo/f0JEJyctjArpqp0rFfbLf7r7yJ66cinGJi/8vzD1uSPTs7FWFs/v
	HL/aR05BdhTlPcthauYdlMTzcOS7YsfCmRA0wzj64J2jCRA2ndJfEp/L9aLhrdZzzlTfjItM5t1
	DQ4jRYfFXD90eJEIPvJJTCcYbnLSUfcPdArllAbRW3mape2rKUszW+V/+UB4VpnbKWKpqovsg64
	bqKEMqAM8D1yrQg7XHRoLUfH8WKZ
X-Google-Smtp-Source: AGHT+IE+dWQG/forxPO7KvtlaVFNNS9/KYCKBhixd7F1aJAiF5WXSXvcBRYAQbt3KT3gOjxnzoZpQQ==
X-Received: by 2002:a05:6512:2809:b0:53e:1ba2:ee19 with SMTP id 2adb3069b0e04-54090553ba6mr2096160e87.20.1734202072961;
        Sat, 14 Dec 2024 10:47:52 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3d9b:22c9:a65:6ea2:7914? ([2a00:1370:8180:3d9b:22c9:a65:6ea2:7914])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f27fsm288525e87.3.2024.12.14.10.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 10:47:52 -0800 (PST)
Message-ID: <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
Date: Sat, 14 Dec 2024 21:47:47 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Leszek Dubiel <leszek@dubiel.pl>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

14.12.2024 20:55, Leszek Dubiel wrote:
> 
> 
> My system is almost full:
> 
> 
> root@zefir:~# df -h
> 
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sdb2       8.2T  7.9T  256G  97% /
> 
> 
> 
> 
> root@zefir:~# btrfs fi df /
> 
> Data, RAID1: total=8.08TiB, used=7.84TiB
> System, RAID1: total=32.00MiB, used=1.47MiB
> Metadata, RAID1: total=44.00GiB, used=36.26GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> 
> 
> I have 256 GB free space, but almost no unallocated space:
> 
> 
> root@zefir:~# btrfs dev usa /
> /dev/sdb2, ID: 1
>      Device size:             5.43TiB
>      Device slack:              0.00B
>      Data,RAID1:              5.38TiB
>      Metadata,RAID1:         31.00GiB
>      System,RAID1:           32.00MiB
>      Unallocated:            11.00GiB
> 
> /dev/sdc2, ID: 2
>      Device size:             5.43TiB
>      Device slack:              0.00B
>      Data,RAID1:              5.39TiB
>      Metadata,RAID1:         22.00GiB
>      Unallocated:            10.03GiB
> 
> /dev/sda3, ID: 3
>      Device size:             5.43TiB
>      Device slack:              0.00B
>      Data,RAID1:              5.38TiB
>      Metadata,RAID1:         35.00GiB
>      System,RAID1:           32.00MiB
>      Unallocated:            11.00GiB
> 
> 
> 

Show

btrfs filesystem usage -T

> 
> I've been running whole day
> 
>             btrfs balance start -dusage=xxx,limit=8 /
> 
> with increasing numbers of xxx, until I reached dusage=90:
> 
> 
> root@zefir:~# btrfs bala start -dusage=20,limit=8 /
> Done, had to relocate 0 out of 8319 chunks
> 
> root@zefir:~# btrfs bala start -dusage=50,limit=8 /
> Done, had to relocate 0 out of 8319 chunks
> 
> root@zefir:~# btrfs bala start -dusage=80,limit=8 /
> Done, had to relocate 0 out of 8319 chunks
> 
> root@zefir:~# btrfs bala start -dusage=90,limit=8 /
> 
> 
> 
> 
> 
> I was running with -dusage=90 (90%) whole day, but
> unallocated space didn't increase.
> 
> On logs i can see:
> 
> 2024-12-09T08:46:13.001188+01:00 zefir kernel: [431476.446252] BTRFS
> info (device sda2): balance: start -dusage=90,limit=8
> 2024-12-09T08:46:13.013180+01:00 zefir kernel: [431476.458060] BTRFS
> info (device sda2): relocating block group 34750669520896 flags data|raid1
> 2024-12-09T08:46:40.389168+01:00 zefir kernel: [431503.832191] BTRFS
> info (device sda2): found 6 extents, stage: move data extents
> 2024-12-09T08:46:44.193216+01:00 zefir kernel: [431507.636729] BTRFS
> info (device sda2): found 6 extents, stage: update data pointers
> 2024-12-09T08:46:47.113166+01:00 zefir kernel: [431510.558009] BTRFS
> info (device sda2): relocating block group 34748522037248 flags data|raid1
> 2024-12-09T08:47:22.241196+01:00 zefir kernel: [431545.684216] BTRFS
> info (device sda2): found 11 extents, stage: move data extents
> 2024-12-09T08:47:23.933198+01:00 zefir kernel: [431547.378516] BTRFS
> info (device sda2): found 11 extents, stage: update data pointers
> 2024-12-09T08:47:25.137176+01:00 zefir kernel: [431548.582508] BTRFS
> info (device sda2): relocating block group 34731342168064 flags data|raid1
> 2024-12-09T08:48:01.897151+01:00 zefir kernel: [431585.342544] BTRFS
> info (device sda2): found 8 extents, stage: move data extents
> 2024-12-09T08:48:07.949185+01:00 zefir kernel: [431591.393774] BTRFS
> info (device sda2): found 8 extents, stage: update data pointers
> 2024-12-09T08:48:10.169177+01:00 zefir kernel: [431593.614676] BTRFS
> info (device sda2): relocating block group 34723825975296 flags data|raid1
> 2024-12-09T08:48:33.781190+01:00 zefir kernel: [431617.225031] BTRFS
> info (device sda2): found 10 extents, stage: move data extents
> 2024-12-09T08:48:44.353165+01:00 zefir kernel: [431627.799342] BTRFS
> info (device sda2): found 10 extents, stage: update data pointers
> 2024-12-09T08:48:47.453174+01:00 zefir kernel: [431630.899246] BTRFS
> info (device sda2): relocating block group 34721678491648 flags data|raid1
> 
> But unallocated space didn't increase.
> 
> 

Why did you expect it to increase? To free space balance need to pack 
more extents into less chunks. In your case chunks are near to full and 
extents are relatively large, so chunks simply may not have enough free 
space to accommodate more extents. You just move extents around.

> 
> 
> 
> So I started to play with metadata optimization, that is with musage.
> 
> 
> 
> When I put limit=0, no blocks are reallocated.
> When I put limit=1 or limit=2 always one block is reallocated.
> When I put limit greater then no blocks are reallocated.
> 
> 
> See the test:
> 
> root@zefir:~# for lim in 0 1 2 3 4 5 6; do echo "lim=$lim"; for f in
> $(seq 5); do btrfs bala start -musage=30,limit=$lim /; done; done
> lim=0
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> lim=1
> Done, had to relocate 1 out of 8318 chunks
> Done, had to relocate 1 out of 8318 chunks
> Done, had to relocate 1 out of 8318 chunks
> Done, had to relocate 1 out of 8318 chunks
> Done, had to relocate 1 out of 8318 chunks
> lim=2
> Done, had to relocate 1 out of 8318 chunks
> Done, had to relocate 1 out of 8318 chunks
> Done, had to relocate 1 out of 8318 chunks
> Done, had to relocate 1 out of 8318 chunks
> Done, had to relocate 1 out of 8318 chunks
> lim=3
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> lim=4
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> lim=5
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> lim=6
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> Done, had to relocate 0 out of 8318 chunks
> 
> 
> 
> 
> root@zefir:~# btrfs bala start -musage=30,limit=1 /
> Done, had to relocate 1 out of 8318 chunks
> 
> root@zefir:~# dmesg -T | tail
> [Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: start
> -musage=30,limit=6 -susage=30,limit=6
> [Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: ended with
> status: 0
> [Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: start
> -musage=30,limit=6 -susage=30,limit=6
> [Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: ended with
> status: 0
> [Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: start
> -musage=30,limit=6 -susage=30,limit=6
> [Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: ended with
> status: 0
> [Sat Dec 14 18:50:42 2024] BTRFS info (device sdb2): balance: start
> -musage=30,limit=1 -susage=30,limit=1
> [Sat Dec 14 18:50:42 2024] BTRFS info (device sdb2): relocating block
> group 38091650760704 flags system|raid1
> [Sat Dec 14 18:50:43 2024] BTRFS info (device sdb2): found 91 extents,
> stage: move data extents
> [Sat Dec 14 18:50:44 2024] BTRFS info (device sdb2): balance: ended with
> status: 0
> 
> 
> 
> 
> During those all operations level of Unallocated space is not increasing.

Relocating one chunk simply moves extents from this chunk to another 
location. It does not free any chunk. You can only get more unallocated 
space when you are able to pack extents from two (or more) chunks into 
one chunk. Which is only possible if chunks are filled to 50%.

> What should i do next?
> 
> 

It looks like your filesystem is simply full. Do you have reasons to 
believe that it is not true?

