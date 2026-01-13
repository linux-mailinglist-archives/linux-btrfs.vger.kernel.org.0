Return-Path: <linux-btrfs+bounces-20467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD618D1B2D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747E23023546
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF26536AB71;
	Tue, 13 Jan 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZwMCmVZr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FD2FBDFF
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335562; cv=none; b=Op7ZKE0jLNyEuuzVqLnczcnRRDTvpzqrugDAnBxXXP0Lo6041uNpZSLcQ9x2DX+CqjH7ul9C+xV8z132XMGq6EN6JonVnQnSiv/GNYbQzHiydIcTQ5wirv6tmZALhAjb3xV4HDmPFpuPLqDNU0tKTd2LePrwR263gBjFShB7ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335562; c=relaxed/simple;
	bh=BewaKuyL4vy7jonRTEUfkr4y5So2rGrx6taSvyvC2r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0c8M6cmMQmiOyhNI+q0wwo7XmlniXGNjlmmq3tSm9EvuTAi368MrlwMca3nDxX+oLmMBMTiZLtRwoMoSS8WnBkWpxT8Go/64NSZnNCF0BdF2Se1ReyzG43UHiFtQ2otOO5qsluOs/LsSmMGGNG/Eq3r8/03cgBPdAnnyKyAAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZwMCmVZr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47774d3536dso1858785e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 12:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768335559; x=1768940359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c0tEI8sTF6THmKP493qCDx6Zi23ZmotMCMO32eXZu8A=;
        b=ZwMCmVZrP5rv957DjorqRKeT9FNV+a70w9uRuMxxmKB0EyPHCuk0t1+OPbED/tQKOn
         vvk6TyRRBdY18v5Yt+VSiu4w3UjzXOqYcog7LjbhPYn6E5NOhWDVPQhG5GXl3FOspHqE
         nqcultOcz+RlXX9VmMitlLTJXRwKr2jqKeRsMXpTjuX/2rslk6RHbPUB5+RC++Up30oD
         xAMeNcytyChagTyF1mLmd842CPz2co5Tgxvsg2LdNMFX5s2P9VUMvGObEa9tO6+sVywI
         dG1598mhxlfQWBflClfvBsJXP8pPzZuCFn1U8JnP9jzLmcM/y2Z/+YBeMllnF9BqIuad
         XQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335559; x=1768940359;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0tEI8sTF6THmKP493qCDx6Zi23ZmotMCMO32eXZu8A=;
        b=gACxrtizrsPTkD2zWI+b7CQz4ET+abbgB4bxPwe9TqWZKPTkQP+Av8yzWNkCqkmPlb
         h59EFGprF5Bus9VwjJIZo4RSC3ySbdz9cuv15qgK11BGM4oipUcH/g5Q+5T/hmWlw6bC
         f9mDCtn4kCRB/KM4vvLhNowhrfV916UPTYjrQrRcXDWh/whMJcP3iYb4R0bjrzo5s3+y
         BKX7MhQzwKZ0o6Q4/UdofVkF+HEALw+jnZP4zVnA96IHYyUfEj/UmiUp0SUZeL/WyqjE
         WeJskibgWajzwt97XAHo2KzOmUdiK91Y+pLVqc7bdYOj0bIENvQUJ6/EipNSoC8Oe4zH
         JrdA==
X-Forwarded-Encrypted: i=1; AJvYcCVZX2e3R8l4mQT2XWMxd0+jf0G1vmZchkXTQCe68MDEC/IJFJwUZnPjUSwGxd9asKxFbKHYtZTOZbBqBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSz9ciCCggyQl9gL2tl6gseed7Rndvkc3JjTsI5eriWI5B2sp1
	rVJPnJgxUlPVmz9GZziIS2LC7cPw6bpBBAA0coKlT3T52hLjZJkVSUaqyrrj3QbxJQc=
X-Gm-Gg: AY/fxX71sRUHur90Xx3NhVgV4L6SWNC3BQ9kYAxrqHWl+gOc6Pm/4K7zTI6OeX0XXAd
	/b9z34V0I4aAHQv5jUpE2ro66YQnRiAxhRauAxPLP48qG0ozroJm8DQUxhlnFbcsXFuWOVcQmqI
	GNvC7dv2HlpfB7mz9UJdqU844YEseClWumcZx1Cf/Rn6oIIu2lGfSVPfz6i78lgTzTz4B02v6wi
	OckHDrTF1UmdIUW1LJpRgyo9KVnI9IVTnc3DA3Osblyn6N5Y00KkLaoXZTdrn6vNviESoawsz3U
	Rq7rORJBCF/KgZZiMywGdtMlMT+OejpPhgGLtmrIqgLT5yAHEqnTauYmmqVsFRM09xZeZEFcB9E
	lJNas0kSK4RFZ1DBfAoOy0XAqsVZckn2rMTROfnlhcNPiW86z/J4suaxgWoXdPS6//Nf5lbZ5LC
	xJ0AXGpXwdGOUKP78pM1C6X38cVX0IaLnxlX/+d7YTlqBbCfc64g==
X-Received: by 2002:a05:600c:6a95:b0:47d:7004:f488 with SMTP id 5b1f17b1804b1-47ed7c2843dmr39492715e9.10.1768335558993;
        Tue, 13 Jan 2026 12:19:18 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48c2bsm205691895ad.26.2026.01.13.12.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 12:19:16 -0800 (PST)
Message-ID: <0d89dd1d-3233-4ce6-85c0-a97448b8cf64@suse.com>
Date: Wed, 14 Jan 2026 06:49:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bug] WARNING in find_free_extent
To: Jiaming Zhang <r772577952@gmail.com>, clm@fb.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <CANypQFYw8Nt8stgbhoycFojOoUmt+BoZ-z8WJOZVxcogDdwm=Q@mail.gmail.com>
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
In-Reply-To: <CANypQFYw8Nt8stgbhoycFojOoUmt+BoZ-z8WJOZVxcogDdwm=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/14 00:14, Jiaming Zhang 写道:
> Dear Linux kernel developers and maintainers,
> 
> We are writing to report a warning discovered in the btrfs subsystem.
> This issue is reproducible on the latest version (commit
> b71e635feefc852405b14620a7fc58c4c80c0f73).

Before the warning you have tons of fuzzed tree blocks and all rejected 
by tree-checker.

I guess your grep script didn't really catch those warnings in the first 
place?

> 
> The kernel console output, kernel config, syzkaller reproducer, and C
> reproducer are attached to help with analysis. The KASAN report from
> kernel, formatted by syz-symbolize, is listed below:
> 
> ---
> 
> BTRFS: Transaction aborted (error -22)

Although by chance or whatever, this warning still has some value.

For a fully RO mount with all the rescue mount options, we should not 
allow any transaction to be created in the first place.

We can enhance the rescue RO mount to reject all transaction start by 
setting the fs as error in the first place.

Other than that this report doesn't make much sense, if you're using 
rescue= mount option, it's already a screwed up fs.

> WARNING: fs/btrfs/extent-tree.c:4208 at find_free_extent_update_loop
> fs/btrfs/extent-tree.c:4208 [inline], CPU#0: repro.out/9758
> WARNING: fs/btrfs/extent-tree.c:4208 at find_free_extent+0x52ee/0x5d20
> fs/btrfs/extent-tree.c:4611, CPU#0: repro.out/9758
> Modules linked in:
> CPU: 0 UID: 0 PID: 9758 Comm: repro.out Not tainted
> 6.19.0-rc5-00002-gb71e635feefc #7 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:find_free_extent_update_loop fs/btrfs/extent-tree.c:4208 [inline]
> RIP: 0010:find_free_extent+0x52f0/0x5d20 fs/btrfs/extent-tree.c:4611
> Code: 36 b6 01 fe e9 95 03 00 00 e8 dc 04 e8 fd 84 c0 74 66 e8 23 b6
> 01 fe e9 82 03 00 00 e8 19 b6 01 fe 48 8d 3d e2 09 b1 0b 89 ee <67> 48
> 0f b9 3a e9 60 f6 ff ff 48 8b 4c 24 78 80 e1 07 38 c1 0f 8c
> RSP: 0018:ffffc9000445eb28 EFLAGS: 00010293
> RAX: ffffffff83b4ffc7 RBX: ffff88802ad30000 RCX: ffff88802804bd80
> RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffffff8f6609b0
> RBP: 00000000ffffffea R08: ffff88802804bd80 R09: 0000000000000003
> R10: 00000000fffffffb R11: 0000000000000000 R12: ffff88802ad30060
> R13: ffff88802ad30000 R14: 0000000000000000 R15: ffff88802ad30060
> FS:  0000000000000000(0000) GS:ffff8880994e9000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004c1108 CR3: 00000000281ef000 CR4: 0000000000752ef0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   btrfs_reserve_extent+0x2cd/0x790 fs/btrfs/extent-tree.c:4705
>   btrfs_alloc_tree_block+0x1e1/0x10e0 fs/btrfs/extent-tree.c:5157
>   btrfs_force_cow_block+0x578/0x2410 fs/btrfs/ctree.c:517
>   btrfs_cow_block+0x3c4/0xa80 fs/btrfs/ctree.c:708
>   btrfs_search_slot+0xcad/0x2b50 fs/btrfs/ctree.c:2130
>   btrfs_truncate_inode_items+0x45d/0x2350 fs/btrfs/inode-item.c:499
>   btrfs_evict_inode+0x923/0xe70 fs/btrfs/inode.c:5628
>   evict+0x5f4/0xae0 fs/inode.c:837
>   __dentry_kill+0x209/0x660 fs/dcache.c:670
>   finish_dput+0xc9/0x480 fs/dcache.c:879
>   shrink_dcache_for_umount+0xa0/0x170 fs/dcache.c:1661
>   generic_shutdown_super+0x67/0x2c0 fs/super.c:621
>   kill_anon_super+0x3b/0x70 fs/super.c:1289
>   btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2127
>   deactivate_locked_super+0xbc/0x130 fs/super.c:474
>   cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
>   task_work_run+0x1d4/0x260 kernel/task_work.c:233
>   exit_task_work include/linux/task_work.h:40 [inline]
>   do_exit+0x694/0x22f0 kernel/exit.c:971
>   do_group_exit+0x21c/0x2d0 kernel/exit.c:1112
>   __do_sys_exit_group kernel/exit.c:1123 [inline]
>   __se_sys_exit_group kernel/exit.c:1121 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
>   x64_sys_call+0x2210/0x2210 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xe8/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x44f639
> Code: Unable to access opcode bytes at 0x44f60f.
> RSP: 002b:00007ffc15c4e088 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00000000004c32f0 RCX: 000000000044f639
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
> RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004c32f0
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
>   </TASK>
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>     0: 01 fe                add    %edi,%esi
>     2: e9 95 03 00 00        jmp    0x39c
>     7: e8 dc 04 e8 fd        call   0xfde804e8
>     c: 84 c0                test   %al,%al
>     e: 74 66                je     0x76
>    10: e8 23 b6 01 fe        call   0xfe01b638
>    15: e9 82 03 00 00        jmp    0x39c
>    1a: e8 19 b6 01 fe        call   0xfe01b638
>    1f: 48 8d 3d e2 09 b1 0b lea    0xbb109e2(%rip),%rdi        # 0xbb10a08
>    26: 89 ee                mov    %ebp,%esi
> * 28: 67 48 0f b9 3a        ud1    (%edx),%rdi <-- trapping instruction
>    2d: e9 60 f6 ff ff        jmp    0xfffff692
>    32: 48 8b 4c 24 78        mov    0x78(%rsp),%rcx
>    37: 80 e1 07              and    $0x7,%cl
>    3a: 38 c1                cmp    %al,%cl
>    3c: 0f                    .byte 0xf
>    3d: 8c                    .byte 0x8c
> 
> ---
> 
> Please let me know if any further information is required.
> 
> Best Regards,
> Jiaming Zhang


