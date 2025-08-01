Return-Path: <linux-btrfs+bounces-15793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D5B188EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 23:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CD05A0A72
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 21:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720EF220F2B;
	Fri,  1 Aug 2025 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="boVu1spM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5C2135C5
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Aug 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084894; cv=none; b=Oufq2Cffyl20rrwF0HwTpbdOqXxipivOKt/MVVM/lKu6cdq/Hxqi+JdyMjWw8rsUsrVAf6FRtWe7Rxxu2KPbRvkapDzp3MP1jVcT16D8PPJ+tIJYWiSbzlomy8I+YtLxVTKauXNI5BU0/YVe8LYkh+vCLj/BL0QgFPKzs7HLsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084894; c=relaxed/simple;
	bh=2nYU1lkP3rdwvxv7duZEWvr237Q7jYErtWE5+DzE6ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hjyYR0bAhSgYLb3vD6G2dskG0sQZRFEhctlNoGAjwsKPxIqGSIjpRxcA2cz25H6v4nrUGzlhy6QAVzVHwWm83ggigQU5nRIZK7bab9KxswWZEdbGLsFAcDBCtkNoUWYVzmaEugu0WSfign2fw6ONnpRuPonE0G/EarfxDxX5NHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=boVu1spM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so3440195e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Aug 2025 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754084890; x=1754689690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fI91IK0Uee+l0l0RWTtUg4WuMooWIVkt0N1mcrqEpF0=;
        b=boVu1spM8aZjuoy3DX2oVYh+Oal/aUnAVq+GSHIEuM880u07jG25ErqybIo2+LkAOV
         mO3NrOfxO+swqDN9GU0oZS7tBNUNRlgv+EXwguouV4cqs56HKCi1p5BPMWtAZ3AWmJjV
         sMNsxWjwFnQeK8li/ypBk9rUIFH0Zh0lxP4TTPO3gmqkJPOmfLk3j8clCc81Pi2PZCk8
         7E13RkzfLmWDz1aHMijLSaCawsSsUsE9UX8DEbPmLOWpHqm/FgPwW8ZCU2lBrBqhKcuT
         +Y4MBK+uVMrisgj4MBMZuif+qSyteI2+1iTMi9BiYYIPvztyBNZmpvQKYBHYxd7sG12Z
         YvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084890; x=1754689690;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fI91IK0Uee+l0l0RWTtUg4WuMooWIVkt0N1mcrqEpF0=;
        b=K5i+t7X3LfRAuOoB8MRfL+yNUFT52EYKJLddUcpsV5lD8gzKNHdhhrqZJKUHuMz9jj
         8TP/imwV9GIsiTiQaMKB1sgeufCmpnperJ97ZKVuJ7ylcN2km8i2VWTfzxb5suLF4FW2
         mh2LwK3YYqcWJw2j4PVSBIiPEVnda6JM/+glVcCdITBZ0eYGk+8lg6lVNmtY3Gn4ei7x
         Wk1zuC9Tdqe3Nxg6jZWkM3MOXw5pAk1ZXw5+CbYjUxY1IxwSmkgZvWX5luDwOP2DT6ic
         J5it/fXi2/78fm6GPsVdQcJ7Dw6yMs8MFgqG4kzKIQY3hHboUC/8X7ziPgWgfEQLtQuR
         LoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMG4NK5cthxI+Wr0BlyAjPDBrTBSbzXEhxT6Z/QogXHmaNjKgq3qTlVhmjGixniPmw+S97fTGmYUqvjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYgoZzZbC101sTWw1WX7EaUVs4/I86/gqtKI5gT3xTFHvV5bD
	/2ObkpYEMFeTRKEtMmO4EloR6ulh5hpCyNlfXDBNNBvJquKOCB3CqDbMCQVhEdyTNwM=
X-Gm-Gg: ASbGncs5CLOh5M/x4s7CMwRAMHnC7bR8zqSNL6De5gnXgk7OAoVSyR80yxU5QmWIgTc
	m3Fn5h2tbxBuYZqMBeK2z2my8FILOo49ycQ2ZGTyU2LKvkMxzIBQ7EiBCrv5ChnVIET6Nig+Sao
	eVENRakWQHafcJzfBd8ap58+tLnne4adGa/InXBCkRe/XyPbKcyohZpUmkM1IowUsviXYU8pyhZ
	XGhxOX1qKV4jFtvLOqoM1A5A0/2n6mLHBRGkDu2PR25sJ+AQn4aeaMDvYRjPTuzDuE1WI3ztycC
	h+XT//SgDnuLh9ZSB0/tUD45Fi06N2FvRdhP/8aunF6ywQXiG87KXNYMv/Z9FKjAr7TTs3qI/2D
	rE+KGNR3Wb/RAhKQaLj4zXQOLXKSIlWjjptvcc3srjv+ka8/BhA==
X-Google-Smtp-Source: AGHT+IGcxPd6ttW5Fwu5Shapyv7KzTnHMlxiyiHlTA8E6mP0eDANxculcsx2qawer8ysoo6aDZPWhw==
X-Received: by 2002:a5d:5f87:0:b0:3b7:8473:31bd with SMTP id ffacd0b85a97d-3b8d9409097mr975786f8f.0.1754084890278;
        Fri, 01 Aug 2025 14:48:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da6141sm8315065a91.1.2025.08.01.14.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:48:09 -0700 (PDT)
Message-ID: <45b62d6f-40fb-41c0-9c1a-e97b341930e3@suse.com>
Date: Sat, 2 Aug 2025 07:18:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_lookup_extent_info (2)
To: syzbot <syzbot+c035bce0effd1de39e05@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <688d0dde.050a0220.f0410.0130.GAE@google.com>
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
In-Reply-To: <688d0dde.050a0220.f0410.0130.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/2 04:26, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    038d61fd6422 Linux 6.16
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bd14a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=831eea247244ce8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c035bce0effd1de39e05
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-038d61fd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/45453fb53a5d/vmlinux-038d61fd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4094774b8a7e/bzImage-038d61fd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c035bce0effd1de39e05@syzkaller.appspotmail.com

The real problem happens before that:

[   76.684845][ T5354] FAULT_INJECTION: forcing a failure.
[   76.684845][ T5354] name failslab, interval 1, probability 0, space 
0, times 1
[   76.699734][ T5354] CPU: 0 UID: 0 PID: 5354 Comm: syz.0.0 Not tainted 
6.16.0-syzkaller #0 PREEMPT(full)
[   76.699754][ T5354] Hardware name: QEMU Standard PC (Q35 + ICH9, 
2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   76.699761][ T5354] Call Trace:
[   76.699766][ T5354]  <TASK>
[   76.699772][ T5354]  dump_stack_lvl+0x189/0x250
[   76.699851][ T5354]  ? __pfx____ratelimit+0x10/0x10
[   76.699894][ T5354]  ? __pfx_dump_stack_lvl+0x10/0x10
[   76.699908][ T5354]  ? __pfx__printk+0x10/0x10
[   76.699927][ T5354]  ? __pfx___might_resched+0x10/0x10
[   76.699940][ T5354]  ? fs_reclaim_acquire+0x7d/0x100
[   76.699992][ T5354]  should_fail_ex+0x414/0x560
[   76.700013][ T5354]  should_failslab+0xa8/0x100
[   76.700030][ T5354]  kmem_cache_alloc_noprof+0x73/0x3c0
[   76.700043][ T5354]  ? __btrfs_inc_extent_ref+0x1e0/0x710
[   76.700063][ T5354]  __btrfs_inc_extent_ref+0x1e0/0x710
[   76.700085][ T5354]  ? __pfx___btrfs_inc_extent_ref+0x10/0x10
[   76.700113][ T5354]  __btrfs_run_delayed_refs+0xea2/0x3a50

An ENOMEM is injected to a critical path. And we handled it gracefully, 
not crashing the kernel.

But this also means the extent tree is not properly updated (thus can be 
considered as a corrupted extent tree)>
> BTRFS info (device loop0): balance: start -d -m
> BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
> BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5337 at fs/btrfs/extent-tree.c:209 btrfs_lookup_extent_info+0xcc6/0xd80 fs/btrfs/extent-tree.c:209

The warning is very likely to be caused by the previous error injection.

I'd say, if you're injecting errors, please allow us to give a warning 
or two.

Thanks,
Qu

> Modules linked in:
> CPU: 0 UID: 0 PID: 5337 Comm: syz.0.0 Not tainted 6.16.0-syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:btrfs_lookup_extent_info+0xcc6/0xd80 fs/btrfs/extent-tree.c:209
> Code: 8b ff ff ff 48 8b 7c 24 50 48 c7 c6 31 97 ae 8d ba a9 00 00 00 b9 8b ff ff ff e8 c5 85 6a fd e9 16 fe ff ff e8 0b ee 00 fe 90 <0f> 0b 90 e9 6d fd ff ff e8 dd 44 b0 07 89 d9 80 e1 07 38 c1 0f 8c
> RSP: 0018:ffffc9000ddfeea0 EFLAGS: 00010293
> RAX: ffffffff83bf4305 RBX: ffff8880363d43b0 RCX: ffff8880118c0000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000ddff000 R08: ffff8880363d43b3 R09: 1ffff11006c7a876
> R10: dffffc0000000000 R11: ffffed1006c7a877 R12: dffffc0000000000
> R13: ffff88805325c6d4 R14: 0000000000000000 R15: ffffc9000ddff0c0
> FS:  00007fe87d3d46c0(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000453000 CR3: 0000000011d7e000 CR4: 0000000000352ef0
> Call Trace:
>   <TASK>
>   update_ref_for_cow+0x998/0x1210 fs/btrfs/ctree.c:373
>   btrfs_force_cow_block+0x9d4/0x1e10 fs/btrfs/ctree.c:527
>   btrfs_cow_block+0x40a/0x830 fs/btrfs/ctree.c:688
>   do_relocation+0xd64/0x1610 fs/btrfs/relocation.c:2275
>   relocate_tree_block fs/btrfs/relocation.c:2528 [inline]
>   relocate_tree_blocks+0x118b/0x1e90 fs/btrfs/relocation.c:2635
>   relocate_block_group+0x760/0xd90 fs/btrfs/relocation.c:3607
>   btrfs_relocate_block_group+0x966/0xde0 fs/btrfs/relocation.c:4008
>   btrfs_relocate_chunk+0x12a/0x3b0 fs/btrfs/volumes.c:3437
>   __btrfs_balance+0x1870/0x21d0 fs/btrfs/volumes.c:4212
>   btrfs_balance+0xc94/0x11d0 fs/btrfs/volumes.c:4589
>   btrfs_ioctl_balance+0x3d3/0x610 fs/btrfs/ioctl.c:3583
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe880f8e9a9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe87d3d4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fe8811b6080 RCX: 00007fe880f8e9a9
> RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000005
> RBP: 00007fe881010d69 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007fe8811b6080 R15: 00007ffc53dc1948
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


