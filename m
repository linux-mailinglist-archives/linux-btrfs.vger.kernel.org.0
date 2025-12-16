Return-Path: <linux-btrfs+bounces-19803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A88CC530A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 22:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F9CF30419B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C64B312801;
	Tue, 16 Dec 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fEUTS7rV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D96285CAE
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765919790; cv=none; b=U1/xPLrdd15ikSi9hGxP66yJpTc16VjxRHs4Zr7tL3TArjHeZYW8R/GU3xRKxgWfDTnWwT2cZdMxDJmIs5i3E2NTnST7XW+ytJbR6+KfqjNPcvbwdZ7kXk4z08uRZ85Y6Q1M5i7ppCcIszX44oA+/lnA2sby4i1xd1ApUjfgtnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765919790; c=relaxed/simple;
	bh=/MgQ7o33P9sRVzt0SfPFUEUi8OazanJGM1B8Ok0bITo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nnbk0BIfYU6hmJ4AlQD6p1EaPPUeiBtvgMZralgDXrIBV+Je2axKbTtOH977tp9UaCFRLPGAjupSxkacJLppQvimn8QMHawNRm/kviSMqHwym++s93v1/hyM3ZUZDhyo7gww61pW3WFDCXvitpsSrMveApYV71J4QJWB6U+1G44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fEUTS7rV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso29598385e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 13:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765919786; x=1766524586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2bNcmrvGh0DP6RG2YwkPYXrKG82aiySbLmvVEd9C0g=;
        b=fEUTS7rVJLVwFaxkiBFNHs6Hx7nMlItM5eGExIbZnfMWsU7FukRCmvQn9rhavi5RwW
         7SYSGs3vd+UjwKp5eLxnuULwmAEZkmLxF+LV9qGma7rrSbh8G+b0a9+pvkZ8QyO+29Mk
         IFbQ6RprbxSclzd3bJJ6Lge1myqqgKCPA94yOQCm8dtUAa1ryOFNs24vVCx8va0pDsFS
         U1lc4u22Pf3ax5utXVwzXFDXqeDPv1PFmsXePwRSHrk5/n9VZ49MDtQPu9CG5kMc1Vfs
         tmcO45aQ+vmgb08fxvu3DLiVvlUcga6CdAjtPzMT561qXNqBKzmENORXJUjm5m4Ait2k
         6MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765919786; x=1766524586;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2bNcmrvGh0DP6RG2YwkPYXrKG82aiySbLmvVEd9C0g=;
        b=v+td8fxT3mNI+FvuRc2hTj1NYf23nCd8lV18PTPbw0YGK+fEGC07bGrxvwqkMyN40N
         PDyQjMmVirTzr6VNrTbyGA9QZxqVuZbZVxwvQ1q63I/5RkyTvaq1exeSwVIO53/mcX1I
         yaYuYM3RbhTK1n3EnGGbP66wgBHKEDu8ysxQu3ZQOTGu2VpOcLj7Sr9q0u+aNVfPK058
         Q47YqnfWU7HXK+sWofX+jPzAjo9aRlFGilxuT7CxhWU0HgRUch0Ly3+HiUqAMoWVdCvY
         I0EQwmx4Ph9PnGoG00NZ68c6jU8mBYf+jnsF6dGycgr1tpibrPdaT8vrQVqiZA23QNPs
         7jKg==
X-Forwarded-Encrypted: i=1; AJvYcCXAGDabLXpql4WLrAAZ/W7QbbDs6+2F2yexrMNCceXWKISer4I7F+MHDmaF9xfUtnm7vJ8Qqok+83zLAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLDb+rWJ1Dd+6RkH/oj7ZnutAfpiud7pzcgW/JcgM2VIDSnHW
	P/ggyjF4lNKjgh2tpiCulXBNe4eV/CJRn6jlzcVlRQoH7BmPdnfbE2tjBWZ1w34bf14=
X-Gm-Gg: AY/fxX6fSLyggHjiuJ/JXK74L6TUEa8cvtujNV5AmZJtEnWf3g5TS8fdxYWo72tWu5C
	nMbVkT3/+FFOkKaUY0zs+xXqHYYtVEttrrSrbx3F/Qy2ptanMpHHZWX3v/e96ZIRAb4acsR6YcL
	sI3eFO0Sa4Iz/R+NBujvwpgQa5/SEDPmVNPWkqDoPak4zIWrqozYb7HZAvswN/c3p67P16q96Lp
	gDNA2hTR5ybRgK7YOzsX6IXA3w9oCBE7tsy4lNaW4P0h64Yr1mTLQPl2wWCBkgMur7QNpvIm5x7
	rNAArwmFYsrOZMffmYkuZ6OQyX6ehvEoDo4TdO3mpDd0LkmoJboubMaMTW7m0GAT56zELqUVoqp
	WL7RDOdZeS5l/XLPQnlxzeeRsAOc8mx2/JU3Og/sGrHMpM17TuBjOanz2qxgiCjCBUmXK0iuVpD
	d3fa3VJ+z+pq+kCOujhZqD3Xj6FVZx1Xwpz3mqUkA=
X-Google-Smtp-Source: AGHT+IGBHQag3LizC0Eslv/3IQ5IffGYPBP436IpIkPc/U4H6LGSE/qHv61bemkxKFKr71z/QeM/VQ==
X-Received: by 2002:a05:600c:4e90:b0:477:557b:691d with SMTP id 5b1f17b1804b1-47a942cd40dmr138344255e9.25.1765919785756;
        Tue, 16 Dec 2025 13:16:25 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbb11ec17sm479667b3a.42.2025.12.16.13.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 13:16:25 -0800 (PST)
Message-ID: <58390da3-ae35-49c6-929e-dd313c4fc62c@suse.com>
Date: Wed, 17 Dec 2025 07:46:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: release path before initializing extent tree in
 btrfs_read_locked_inode()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <d3b2797ff1161a809b1935ed0e1ce31d6110cc33.1765897890.git.fdmanana@suse.com>
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
In-Reply-To: <d3b2797ff1161a809b1935ed0e1ce31d6110cc33.1765897890.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/17 01:42, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs_read_locked_inode() we are calling btrfs_init_file_extent_tree()
> while holding a path with a read locked leaf from a subvolume tree, and
> btrfs_init_file_extent_tree() may do a GFP_KERNEL allocation, which can
> trigger reclaim.
> 
> This can create a circular lock dependency which lockdep warns about with
> the following splat:
> 
>     [27386.164433] ======================================================
>     [27386.164574] WARNING: possible circular locking dependency detected
>     [27386.164583] 6.18.0+ #4 Tainted: G     U
>     [27386.164591] ------------------------------------------------------
>     [27386.164599] kswapd0/117 is trying to acquire lock:
>     [27386.164606] ffff8d9b6333c5b8 (&delayed_node->mutex){+.+.}-{3:3}, at:
>     __btrfs_release_delayed_node.part.0+0x39/0x2f0
>     [27386.164625]
>                    but task is already holding lock:
>     [27386.164633] ffffffffa4ab8ce0 (fs_reclaim){+.+.}-{0:0}, at:
>     balance_pgdat+0x195/0xc60
>     [27386.164646]
>                    which lock already depends on the new lock.
> 
>     [27386.164657]
>                    the existing dependency chain (in reverse order) is:
>     [27386.164667]
>                    -> #2 (fs_reclaim){+.+.}-{0:0}:
>     [27386.164677]        fs_reclaim_acquire+0x9d/0xd0
>     [27386.164685]        __kmalloc_cache_noprof+0x59/0x750
>     [27386.164694]        btrfs_init_file_extent_tree+0x90/0x100
>     [27386.164702]        btrfs_read_locked_inode+0xc3/0x6b0
>     [27386.164710]        btrfs_iget+0xbb/0xf0
>     [27386.164716]        btrfs_lookup_dentry+0x3c5/0x8e0
>     [27386.164724]        btrfs_lookup+0x12/0x30
>     [27386.164731]        lookup_open.isra.0+0x1aa/0x6a0
>     [27386.164739]        path_openat+0x5f7/0xc60
>     [27386.164746]        do_filp_open+0xd6/0x180
>     [27386.164753]        do_sys_openat2+0x8b/0xe0
>     [27386.164760]        __x64_sys_openat+0x54/0xa0
>     [27386.164768]        do_syscall_64+0x97/0x3e0
>     [27386.164776]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     [27386.164784]
>                    -> #1 (btrfs-tree-00){++++}-{3:3}:
>     [27386.164794]        lock_release+0x127/0x2a0
>     [27386.164801]        up_read+0x1b/0x30
>     [27386.164808]        btrfs_search_slot+0x8e0/0xff0
>     [27386.164817]        btrfs_lookup_inode+0x52/0xd0
>     [27386.164825]        __btrfs_update_delayed_inode+0x73/0x520
>     [27386.164833]        btrfs_commit_inode_delayed_inode+0x11a/0x120
>     [27386.164842]        btrfs_log_inode+0x608/0x1aa0
>     [27386.164849]        btrfs_log_inode_parent+0x249/0xf80
>     [27386.164857]        btrfs_log_dentry_safe+0x3e/0x60
>     [27386.164865]        btrfs_sync_file+0x431/0x690
>     [27386.164872]        do_fsync+0x39/0x80
>     [27386.164879]        __x64_sys_fsync+0x13/0x20
>     [27386.164887]        do_syscall_64+0x97/0x3e0
>     [27386.164894]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     [27386.164903]
>                    -> #0 (&delayed_node->mutex){+.+.}-{3:3}:
>     [27386.164913]        __lock_acquire+0x15e9/0x2820
>     [27386.164920]        lock_acquire+0xc9/0x2d0
>     [27386.164927]        __mutex_lock+0xcc/0x10a0
>     [27386.164934]        __btrfs_release_delayed_node.part.0+0x39/0x2f0
>     [27386.164944]        btrfs_evict_inode+0x20b/0x4b0
>     [27386.164952]        evict+0x15a/0x2f0
>     [27386.164958]        prune_icache_sb+0x91/0xd0
>     [27386.164966]        super_cache_scan+0x150/0x1d0
>     [27386.164974]        do_shrink_slab+0x155/0x6f0
>     [27386.164981]        shrink_slab+0x48e/0x890
>     [27386.164988]        shrink_one+0x11a/0x1f0
>     [27386.164995]        shrink_node+0xbfd/0x1320
>     [27386.165002]        balance_pgdat+0x67f/0xc60
>     [27386.165321]        kswapd+0x1dc/0x3e0
>     [27386.165643]        kthread+0xff/0x240
>     [27386.165965]        ret_from_fork+0x223/0x280
>     [27386.166287]        ret_from_fork_asm+0x1a/0x30
>     [27386.166616]
>                    other info that might help us debug this:
> 
>     [27386.167561] Chain exists of:
>                      &delayed_node->mutex --> btrfs-tree-00 --> fs_reclaim
> 
>     [27386.168503]  Possible unsafe locking scenario:
> 
>     [27386.169110]        CPU0                    CPU1
>     [27386.169411]        ----                    ----
>     [27386.169707]   lock(fs_reclaim);
>     [27386.169998]                                lock(btrfs-tree-00);
>     [27386.170291]                                lock(fs_reclaim);
>     [27386.170581]   lock(&delayed_node->mutex);
>     [27386.170874]
>                     *** DEADLOCK ***
> 
>     [27386.171716] 2 locks held by kswapd0/117:
>     [27386.171999]  #0: ffffffffa4ab8ce0 (fs_reclaim){+.+.}-{0:0}, at:
>     balance_pgdat+0x195/0xc60
>     [27386.172294]  #1: ffff8d998344b0e0 (&type->s_umount_key#40){++++}-
>     {3:3}, at: super_cache_scan+0x37/0x1d0
>     [27386.172596]
>                    stack backtrace:
>     [27386.173183] CPU: 11 UID: 0 PID: 117 Comm: kswapd0 Tainted: G     U
>     6.18.0+ #4 PREEMPT(lazy)
>     [27386.173185] Tainted: [U]=USER
>     [27386.173186] Hardware name: ASUS System Product Name/PRIME B560M-A
>     AC, BIOS 2001 02/01/2023
>     [27386.173187] Call Trace:
>     [27386.173187]  <TASK>
>     [27386.173189]  dump_stack_lvl+0x6e/0xa0
>     [27386.173192]  print_circular_bug.cold+0x17a/0x1c0
>     [27386.173194]  check_noncircular+0x175/0x190
>     [27386.173197]  __lock_acquire+0x15e9/0x2820
>     [27386.173200]  lock_acquire+0xc9/0x2d0
>     [27386.173201]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
>     [27386.173204]  __mutex_lock+0xcc/0x10a0
>     [27386.173206]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
>     [27386.173208]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
>     [27386.173211]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
>     [27386.173213]  __btrfs_release_delayed_node.part.0+0x39/0x2f0
>     [27386.173215]  btrfs_evict_inode+0x20b/0x4b0
>     [27386.173217]  ? lock_acquire+0xc9/0x2d0
>     [27386.173220]  evict+0x15a/0x2f0
>     [27386.173222]  prune_icache_sb+0x91/0xd0
>     [27386.173224]  super_cache_scan+0x150/0x1d0
>     [27386.173226]  do_shrink_slab+0x155/0x6f0
>     [27386.173228]  shrink_slab+0x48e/0x890
>     [27386.173229]  ? shrink_slab+0x2d2/0x890
>     [27386.173231]  shrink_one+0x11a/0x1f0
>     [27386.173234]  shrink_node+0xbfd/0x1320
>     [27386.173236]  ? shrink_node+0xa2d/0x1320
>     [27386.173236]  ? shrink_node+0xbd3/0x1320
>     [27386.173239]  ? balance_pgdat+0x67f/0xc60
>     [27386.173239]  balance_pgdat+0x67f/0xc60
>     [27386.173241]  ? finish_task_switch.isra.0+0xc4/0x2a0
>     [27386.173246]  kswapd+0x1dc/0x3e0
>     [27386.173247]  ? __pfx_autoremove_wake_function+0x10/0x10
>     [27386.173249]  ? __pfx_kswapd+0x10/0x10
>     [27386.173250]  kthread+0xff/0x240
>     [27386.173251]  ? __pfx_kthread+0x10/0x10
>     [27386.173253]  ret_from_fork+0x223/0x280
>     [27386.173255]  ? __pfx_kthread+0x10/0x10
>     [27386.173257]  ret_from_fork_asm+0x1a/0x30
>     [27386.173260]  </TASK>
> 
> This is because:
> 
> 1) The fsync task is holding an inode's delayed node mutex (for a
>     directory) while calling __btrfs_update_delayed_inode() and that needs
>     to do a search on the subvolume's btree (therefore read lock some
>     extent buffers);
> 
> 2) The lookup task, at btrfs_lookup(), triggered reclaim with the
>     GFP_KERNEL allocation done by btrfs_init_file_extent_tree() while
>     holding a read lock on a subvolume leaf;
> 
> 3) The reclaim triggered kswapd which is doing inode eviction for the
>     directory inode the fsync task is using as an argument to
>     btrfs_commit_inode_delayed_inode() - but in that call chain we are
>     trying to read lock the same leaf that the lookup task is holding
>     while calling btrfs_init_file_extent_tree() and doing the GFP_KERNEL
>     allocation.
> 
> Fix this by calling btrfs_init_file_extent_tree() after we don't need the
> path anymore and release it in btrfs_read_locked_inode().
> 
> Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Link: https://lore.kernel.org/linux-btrfs/6e55113a22347c3925458a5d840a18401a38b276.camel@linux.intel.com/
> Fixes: 8679d2687c35 ("btrfs: initialize inode::file_extent_tree after i_mode has been set")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/inode.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 457624de84a0..a8ce2bf53b82 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4043,11 +4043,6 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
>   	btrfs_set_inode_mapping_order(inode);
>   
>   cache_index:
> -	ret = btrfs_init_file_extent_tree(inode);
> -	if (ret)
> -		goto out;
> -	btrfs_inode_set_file_extent_range(inode, 0,
> -			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
>   	/*
>   	 * If we were modified in the current generation and evicted from memory
>   	 * and then re-read we need to do a full sync since we don't have any
> @@ -4158,6 +4153,20 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
>   		break;
>   	}
>   
> +	/*
> +	 * We don't need the path anymore, so release it to avoid holding a read
> +	 * lock on a leaf while calling btrfs_init_file_extent_tree(), which can
> +	 * allocate memory that triggers reclaim (GFP_KERNEL) and cause a locking
> +	 * dependency.
> +	 */
> +	btrfs_release_path(path);

We can release the path earlier, the last path usage is 
btrfs_load_inode_props(), we can release the path after that "if 
(first_xattr_slot != -1) {}" check.

Other than that looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>


BTW, it doesn't looks a good practice of passing btrfs_path pointer 
around for btrfs_read_locked_inode().

Either it's btrfs_iget(), which allocates a path only for this call and 
immediately free it, or it's btrfs_iget_path() which is only utilized by 
free-space-cache and no one is really utilizing the path anyway.

Thus it's better to just allocate the path inside 
btrfs_read_locked_inode() to minimize the lifespan.
Of course this should be another dedicated cleanup.

Thanks,
Qu

> +
> +	ret = btrfs_init_file_extent_tree(inode);
> +	if (ret)
> +		goto out;
> +	btrfs_inode_set_file_extent_range(inode, 0,
> +			  round_up(i_size_read(vfs_inode), fs_info->sectorsize));
> +
>   	btrfs_sync_inode_flags_to_i_flags(inode);
>   
>   	ret = btrfs_add_inode_to_root(inode, true);


