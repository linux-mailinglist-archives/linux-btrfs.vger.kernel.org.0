Return-Path: <linux-btrfs+bounces-20118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA2CF67F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 03:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F0DF30223D5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 02:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF7239562;
	Tue,  6 Jan 2026 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WqH4Rrkm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F120468E
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667435; cv=none; b=ECFoQMMpbV4SlENoGwN1p1A4XW3CQ8fsKCdnVvVcGYMRcGMpyAveHDbqI1TuiUcJPLH0PuSmxdYpWHKJ2bVONPkdzH53nFgWUMvXupuV36ZAGIZac433t9d8+i0V9cEOrkKg6IO4/I5/XH7okPIcEOBO/dP8JtWBezy/gLVGnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667435; c=relaxed/simple;
	bh=TEcxpyuXiG3osHFc4ij/1eIqK2WYgoT9rKdT9aineN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXz165qMVirlbzgazyvhN5eGdMnqEutzIC6DU2BmNV+qTHrbjP/9rPOtRnies+ngfilYa8odNCkOzzytvdew7+wDW4+Bj7W/5j/zL2jJKWWdUlG3QcOHEf5otlh8aU5e5rK/y1nuV8qt5IrMOhOYm8gkTRuN+de8QSL38INPjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WqH4Rrkm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47774d3536dso4872705e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 18:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767667431; x=1768272231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DfaRDytmd9Xutxx/ZYg7BxJSUkTH8YXEflKMtJu5TeY=;
        b=WqH4RrkmxqSssMM70GzEEsxr84ZoBnOV5aIuhgr+nCYfs9QOPPXJoowcuZsUF9aD9A
         B1mhvL+JarBFNHRBAWuIAUG3hIhjESq2dKJA+5pHOcr71wBGL/eoAYWIZ5Iv1DgX1Kqv
         E4QQcsr9jB/R6MS+pyuG6b2gK+tOLF/buOvz1Zo+4A8XJ2e5BlhLvrA/fs6x7uPI8NIo
         x1bwQH07vB1vXqJN6rx66agi81NB5MSuSCMFYVKmhBRscqh3nGsUsjtfRFnQrlhad/Q3
         jFuzYiYUHEVce9LHV1t8h0usQ8cCXZQTF7OpDI+7T+Dn0LbPm4EVzFDnHMJUSQr3uPek
         QsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767667431; x=1768272231;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfaRDytmd9Xutxx/ZYg7BxJSUkTH8YXEflKMtJu5TeY=;
        b=L2quR0PrcTj24mE8mkYb0VT2F7FmLrbTIteOPdVYxBctxDQjOorcws06/KOqKcA/bi
         wnYs+po8pxhA5lksbtD8zc+yqdlw11/aCnDFTw0tmKK88YFyRNsk4q73s2XFgH4GM9pq
         sph/yxfIC4t1nu0TYWxLOUiuBvPdcNmP/wCjUVU+jIoHgjEraPAWZzz8My9rJpXFOwtS
         ZpVhuHXAplITvpAt1GwYpjbwm5kiSlDy/9m5Y7RAfy9euWQccNnA6INpOHPnxpfJTGX8
         H+4THmP1gxYEIsDLH+X0fXOK+F1aeyTLMr+08DxNiW27tIoyPTKAA8EyainvBX2n3WDC
         5Q4w==
X-Gm-Message-State: AOJu0Yx87NlLzK03fUyGnjpXy9V5HAIBJlbCuEC7ZHHbjdMySFzUWh0S
	qs7/cKSBPboHeiXXvl6uUVGNHnypyjlC40wRrakhEibopUDHQMv0HfqD6aZi+VxmQiQ=
X-Gm-Gg: AY/fxX6lf0OPrdFEJB3+SCP4VSzZg8b6ShTBR9qzObN7FsdkRhREYqFygwc3KeTiiV8
	bt3lkCVUXl9IltutEe1GaVp2tb2lDN8KjuAjQvbGautZVe0toHcqU/HaWwBWlCydbDj429FD2L/
	ZYQdF3H+trbgfg1rhzWYkKy9MgzSzUePBDIFeThq/yGj/hScugLRDraAjdfe/m9w0IFYWj2YBlE
	tA9GjDnLpLyAiDrOK4MbNx/qkij0ZejFYifnG03aCJjvZ2yGSkqblnesXW8O/OH32omfgKU0plC
	cUvWbNKOz+DpE806vJiA9oHE2A5DBz84owpt+enTP5kD1EqRSddmN1ubP255rORNNQr0s3RKdeA
	fOX4vy5120meRNt8FOJzIFMR7NWp2ZYotTNZCVTHxJlN/hch9ZZFEEBFtQsJIrrpAvRwZZzrkCm
	EtX7apvbA73VidX+ZaljOJTQU1lOPVQ0QRP90ZAus1VUkzlOzRcA==
X-Google-Smtp-Source: AGHT+IFByp/Z4da8y7+lX4EURLT8S3tjXR96qoPCOiRoeEcB1WepCaNoNbFzfbsTiJdrDrugIlkHJw==
X-Received: by 2002:a05:600c:22d4:b0:477:a53c:8ca1 with SMTP id 5b1f17b1804b1-47d7f62823emr10766185e9.14.1767667430904;
        Mon, 05 Jan 2026 18:43:50 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb64b3esm604604a91.10.2026.01.05.18.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 18:43:50 -0800 (PST)
Message-ID: <4d9ec144-0f04-46d7-8b52-e26b318f2f49@suse.com>
Date: Tue, 6 Jan 2026 13:13:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not sync fs when the fs is not yet fully
 mounted
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, ZhengYuan Huang <gality369@gmail.com>
References: <7cdad50af2ac47b00bc1d81dfc97ad8776528d86.1766874707.git.wqu@suse.com>
 <CAL3q7H5rboRQD0GGAVHtGvcJcUnrOuJQuwEw1WfN6K-jzaT1cg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5rboRQD0GGAVHtGvcJcUnrOuJQuwEw1WfN6K-jzaT1cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/6 02:45, Filipe Manana 写道:
> On Sat, Dec 27, 2025 at 10:32 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [LOCKDEP WARNING]
>> There is a lockdep warning between qgroup related tree lock and
>> kernfs_rwsem.
>>
>> However the involved call chains show that the fs is being mounted
>> meanwhile the fs is also triggering sync_fs() from unmounting process:
> 
> So we can have an unmount during mount?
> That sentence is confusing.
> 
>>
>> WARNING: possible circular locking dependency detected
>> 6.18.0-dirty #1 Tainted: G           OE
>> ------------------------------------------------------
>> syz.0.279/4686 is trying to acquire lock:
>> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
>> mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
>> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
>> get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
>> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
>> lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429
>>
>> but task is already holding lock:
>> ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
>> kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #7 (&root->kernfs_rwsem){++++}-{4:4}:
>>        down_write+0x91/0x210 kernel/locking/rwsem.c:1590
>>        kernfs_add_one+0x39/0x700 fs/kernfs/dir.c:791
>>        kernfs_create_dir_ns+0x103/0x1a0 fs/kernfs/dir.c:1093
>>        sysfs_create_dir_ns+0x143/0x2b0 fs/sysfs/dir.c:59
>>        create_dir lib/kobject.c:73 [inline]
>>        kobject_add_internal+0x24d/0xad0 lib/kobject.c:240
>>        kobject_add_varg lib/kobject.c:374 [inline]
>>        kobject_init_and_add+0x114/0x1a0 lib/kobject.c:457
>>        btrfs_sysfs_add_one_qgroup+0xe2/0x170 fs/btrfs/sysfs.c:2599
>>        btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
>>        open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
>>        btrfs_fill_super fs/btrfs/super.c:987 [inline]
>>        btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
>>        btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
>>        btrfs_get_tree+0x114c/0x22e0 fs/btrfs/super.c:2128
>>        vfs_get_tree+0x9a/0x370 fs/super.c:1758
>>        fc_mount fs/namespace.c:1199 [inline] <<<<
>>        do_new_mount_fc fs/namespace.c:3642 [inline]
>>        do_new_mount fs/namespace.c:3718 [inline]
>>        path_mount+0x5aa/0x1e90 fs/namespace.c:4028
>>        do_mount fs/namespace.c:4041 [inline]
>>        __do_sys_mount fs/namespace.c:4229 [inline]
>>        __se_sys_mount fs/namespace.c:4206 [inline]
>>        __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
>>        x64_sys_call+0x1a7d/0x26a0
>> arch/x86/include/generated/asm/syscalls_64.h:166
>>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>        do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
>>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> -> #6 (btrfs-quota-00){++++}-{4:4}:
>>        down_read_nested+0xa0/0x4d0 kernel/locking/rwsem.c:1662
>>        btrfs_tree_read_lock_nested+0x32/0x1d0 fs/btrfs/locking.c:145
>>        btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
>>        btrfs_read_lock_root_node+0x73/0xb0 fs/btrfs/locking.c:266
>>        btrfs_search_slot_get_root fs/btrfs/ctree.c:1742 [inline]
>>        btrfs_search_slot+0x3e0/0x3580 fs/btrfs/ctree.c:2066
>>        update_qgroup_info_item fs/btrfs/qgroup.c:882 [inline]
>>        btrfs_run_qgroups+0x4f3/0x870 fs/btrfs/qgroup.c:3112
>>        commit_cowonly_roots+0x1f3/0x8f0 fs/btrfs/transaction.c:1354
>>        btrfs_commit_transaction+0x1c64/0x3f70 fs/btrfs/transaction.c:2459
>>        btrfs_sync_fs+0xf2/0x660 fs/btrfs/super.c:1057
>>        sync_filesystem fs/sync.c:66 [inline]
>>        sync_filesystem+0x1ba/0x260 fs/sync.c:30
>>        generic_shutdown_super+0x88/0x520 fs/super.c:621 <<<<
>>        kill_anon_super+0x41/0x80 fs/super.c:1288
>>        btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
>>        deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
>>        deactivate_super fs/super.c:506 [inline]
>>        deactivate_super+0xad/0xd0 fs/super.c:502
>>        cleanup_mnt+0x214/0x460 fs/namespace.c:1318
>>        __cleanup_mnt+0x1b/0x30 fs/namespace.c:1325
>>        task_work_run+0x16a/0x270 kernel/task_work.c:227
>>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>        exit_to_user_mode_loop+0x147/0x190 kernel/entry/common.c:43
>>        exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>>        syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>>        syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>>        do_syscall_64+0x3a0/0xa90 arch/x86/entry/syscall_64.c:100
>>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Can you please paste the whole lockdep splat?
> This misses several stack traces and the report at the bottom with the
> detected lock dependencies:
> 
> 
> Chain exists of:
> &mm->mmap_lock --> btrfs-quota-00 --> &root->kernfs_rwsem
> 
> Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
> rlock(&root->kernfs_rwsem);
>                                lock(btrfs-quota-00);
>                                lock(&root->kernfs_rwsem);
> rlock(&mm->mmap_lock);
> 
>>
>> [CAUSE]
>> At btrfs_sync_fs() we always assume the fs is already fully mounted, but
>> if it's not the case we have more problems to bother other than just
>> lockdep warnings.
> 
> But how did you arrive at the conclusion that the fs is not already
> fully mounted?
> There are stack traces of mmap writes, which suggests the fs is fully
> mounted (otherwise how could they happen?).

The #7 call chain shows that we're still inside a mounting process:

  	...
         btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
         open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
         btrfs_fill_super fs/btrfs/super.c:987 [inline]
	...

But the #6 call chain shows it's during unmount.

	sync_filesystem+0x1ba/0x260 fs/sync.c:30
	generic_shutdown_super+0x88/0x520 fs/super.c:621
	kill_anon_super+0x41/0x80 fs/super.c:1288
	btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
	deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
	deactivate_super fs/super.c:506 [inline]
	deactivate_super+0xad/0xd0 fs/super.c:502
	cleanup_mnt+0x214/0x460 fs/namespace.c:1318

> 
> We may have a nested mount going on (like mounting the subvolume of an
> already mounted fs into another mount point).

That won't explain the lockdep report of lock chain #7.

If we're mounting a subvolume of an already mounted btrfs, at the 
sget_fc() call inside btrfs_get_tree_super() would return an existing 
super block with s_root populated.

And in that case we won't go through btrfs_fill_super().

I'm even starting wondering if the original reporter has even modified 
their kernel to do something tricky on the VFS front.

Thanks,
Qu

> 
> To me it seems the best would be to call btrfs_sysfs_add_one_qgroup()
> in btrfs_read_qgroup_config() after releasing the path, and then
> search again in the quota tree for the next qgroup.
> 
> Thanks.
> 
> 
>>
>> [FIX]
>> Check if the target fs is fully mounted, if not skip btrfs_sync_fs()
>> completely.
> 
> 
> 
>>
>> Reported-by: ZhengYuan Huang <gality369@gmail.com>
>> Link: https://lore.kernel.org/linux-btrfs/CAOmEq9XdTN64=oE7na3J+vCG+fV2bFHSpprHswcE_wEfk_edNg@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/super.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index c141b7e1ee81..af98f622023f 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -1013,6 +1013,9 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
>>          struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>>          struct btrfs_root *root = fs_info->tree_root;
>>
>> +       if (unlikely(!test_bit(BTRFS_FS_OPEN, &fs_info->flags)))
>> +               return 0;
>> +
>>          trace_btrfs_sync_fs(fs_info, wait);
>>
>>          if (!wait) {
>> --
>> 2.52.0
>>
>>


