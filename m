Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C8F28D004
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgJMOQy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 10:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgJMOQy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 10:16:54 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88BC0613D0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 07:16:54 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w17so1756478ilg.8
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GyKwbG7xo5ajr8bSQU8nfGlcC1PY0Xjyqe8ZrpwgDDM=;
        b=Be75D77p9ABzG4rwq/3zhQScvBOvolkW5VoasCYicHx8qGd6risRlSuCnh0TQ9HlA2
         V0sboAi3Vz074kYg4nyR7HAdrG/Ylpg4IFJNrLLzgbXO08HbcOanjJSz6Rjs5MbMcMYg
         jJjo49xsmcFCDzwpcn60Lf6IlaWIbKGU4ktr1R3lEEgs/b1Wo5YkgS71CCNPFMljGjrz
         +zRbj6WiwLC1VPzMV/n88wCeY3OSV4LI0MPrYOTyhNugcxh9JtBE+UYtrhbdjjBRZc3u
         O/81/zXmaGxY7UnRfuhY3+6mN29DOcTTfKDWe2TvQpKc/95rdjENuiARzTTaWmkvdy/Q
         IsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GyKwbG7xo5ajr8bSQU8nfGlcC1PY0Xjyqe8ZrpwgDDM=;
        b=nhNw6uTKQ7b8X4MpqwbSTN6nOvPWME2KglJzrUpvtBJCjuOyjr0OYu2fXlqs7OOHfU
         NqUuelJKye01L6cm0y0pPilaVKoBEehMKsmFxZWs1BLw77AlXXdL8Q/YBcf1j+qjOzSR
         imCEnKimFcNFSw7SzPrCt9u26govGPvTmlUBwjXIlMu0RNpUhA2hqMuHElFN1uEb1j9B
         MKK+Aik6FkBjtQS3jcG+MG73cvyjGsB360hKMdc73kuivBM8Vo07a2SKRKff4JK5tI60
         2fSdUDv6BMz4iaN0/EJEYBgTud0Zkj0k0Q5+eyOIYEd/9KmLvFvfTCT8tjVstB5vgTWz
         fc/A==
X-Gm-Message-State: AOAM532sZxe1Et3LXagpX7vc6Kupsm/yVMIQ7AWtBNsDa2GvY6XDmNEM
        ceYxuaJcKbkji6byp/lhg7jJFFa+eZQwEg==
X-Google-Smtp-Source: ABdhPJwmeE5UV5bWrV8vF8D3NLjuErEpGF82x9NIl7mHFtxuAunewZdHc3dHij1C4vBoH/+uu+wXPQ==
X-Received: by 2002:a92:d383:: with SMTP id o3mr124832ilo.83.1602598612619;
        Tue, 13 Oct 2020 07:16:52 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1096? ([2620:10d:c091:480::1:d057])
        by smtp.gmail.com with ESMTPSA id t13sm2470298ilj.41.2020.10.13.07.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 07:16:50 -0700 (PDT)
Subject: Re: [PATCH 1/4] btrfs: fix use-after-free on readahead extent after
 failure to create it
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1602499587.git.fdmanana@suse.com>
 <2db542cfa0e255a78eb25a11eb719caa5760087d.1602499588.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0fa8db71-38a4-f105-e0ae-9ed3b2318c38@toxicpanda.com>
Date:   Tue, 13 Oct 2020 10:16:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <2db542cfa0e255a78eb25a11eb719caa5760087d.1602499588.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/12/20 6:55 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we fail to find suitable zones for a new readahead extent, we end up
> leaving a stale pointer in the global readahead extents radix tree
> (fs_info->reada_tree), which can trigger the following trace later on:
> 
> [13367.696354] BUG: kernel NULL pointer dereference, address: 00000000000000b0
> [13367.696802] #PF: supervisor read access in kernel mode
> [13367.697249] #PF: error_code(0x0000) - not-present page
> [13367.697721] PGD 0 P4D 0
> [13367.698171] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
> [13367.698632] CPU: 6 PID: 851214 Comm: btrfs Tainted: G        W         5.9.0-rc6-btrfs-next-69 #1
> [13367.699100] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [13367.700069] RIP: 0010:__lock_acquire+0x20a/0x3970
> [13367.700562] Code: ff 1f 0f b7 c0 48 0f (...)
> [13367.701609] RSP: 0018:ffffb14448f57790 EFLAGS: 00010046
> [13367.702140] RAX: 0000000000000000 RBX: 29b935140c15e8cf RCX: 0000000000000000
> [13367.702698] RDX: 0000000000000002 RSI: ffffffffb3d66bd0 RDI: 0000000000000046
> [13367.703240] RBP: ffff8a52ba8ac040 R08: 00000c2866ad9288 R09: 0000000000000001
> [13367.703783] R10: 0000000000000001 R11: 00000000b66d9b53 R12: ffff8a52ba8ac9b0
> [13367.704330] R13: 0000000000000000 R14: ffff8a532b6333e8 R15: 0000000000000000
> [13367.704880] FS:  00007fe1df6b5700(0000) GS:ffff8a5376600000(0000) knlGS:0000000000000000
> [13367.705438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13367.705995] CR2: 00000000000000b0 CR3: 000000022cca8004 CR4: 00000000003706e0
> [13367.706565] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [13367.707127] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [13367.707686] Call Trace:
> [13367.708246]  ? ___slab_alloc+0x395/0x740
> [13367.708820]  ? reada_add_block+0xae/0xee0 [btrfs]
> [13367.709383]  lock_acquire+0xb1/0x480
> [13367.709955]  ? reada_add_block+0xe0/0xee0 [btrfs]
> [13367.710537]  ? reada_add_block+0xae/0xee0 [btrfs]
> [13367.711097]  ? rcu_read_lock_sched_held+0x5d/0x90
> [13367.711659]  ? kmem_cache_alloc_trace+0x8d2/0x990
> [13367.712221]  ? lock_acquired+0x33b/0x470
> [13367.712784]  _raw_spin_lock+0x34/0x80
> [13367.713356]  ? reada_add_block+0xe0/0xee0 [btrfs]
> [13367.713966]  reada_add_block+0xe0/0xee0 [btrfs]
> [13367.714529]  ? btrfs_root_node+0x15/0x1f0 [btrfs]
> [13367.715077]  btrfs_reada_add+0x117/0x170 [btrfs]
> [13367.715620]  scrub_stripe+0x21e/0x10d0 [btrfs]
> [13367.716141]  ? kvm_sched_clock_read+0x5/0x10
> [13367.716657]  ? __lock_acquire+0x41e/0x3970
> [13367.717184]  ? scrub_chunk+0x60/0x140 [btrfs]
> [13367.717697]  ? find_held_lock+0x32/0x90
> [13367.718254]  ? scrub_chunk+0x60/0x140 [btrfs]
> [13367.718773]  ? lock_acquired+0x33b/0x470
> [13367.719278]  ? scrub_chunk+0xcd/0x140 [btrfs]
> [13367.719786]  scrub_chunk+0xcd/0x140 [btrfs]
> [13367.720291]  scrub_enumerate_chunks+0x270/0x5c0 [btrfs]
> [13367.720787]  ? finish_wait+0x90/0x90
> [13367.721281]  btrfs_scrub_dev+0x1ee/0x620 [btrfs]
> [13367.721762]  ? rcu_read_lock_any_held+0x8e/0xb0
> [13367.722235]  ? preempt_count_add+0x49/0xa0
> [13367.722710]  ? __sb_start_write+0x19b/0x290
> [13367.723192]  btrfs_ioctl+0x7f5/0x36f0 [btrfs]
> [13367.723660]  ? __fget_files+0x101/0x1d0
> [13367.724118]  ? find_held_lock+0x32/0x90
> [13367.724559]  ? __fget_files+0x101/0x1d0
> [13367.724982]  ? __x64_sys_ioctl+0x83/0xb0
> [13367.725399]  __x64_sys_ioctl+0x83/0xb0
> [13367.725802]  do_syscall_64+0x33/0x80
> [13367.726188]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [13367.726574] RIP: 0033:0x7fe1df7add87
> [13367.726948] Code: 00 00 00 48 8b 05 09 91 (...)
> [13367.727763] RSP: 002b:00007fe1df6b4d48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [13367.728179] RAX: ffffffffffffffda RBX: 000055ce1fb596a0 RCX: 00007fe1df7add87
> [13367.728604] RDX: 000055ce1fb596a0 RSI: 00000000c400941b RDI: 0000000000000003
> [13367.729021] RBP: 0000000000000000 R08: 00007fe1df6b5700 R09: 0000000000000000
> [13367.729431] R10: 00007fe1df6b5700 R11: 0000000000000246 R12: 00007ffd922b07de
> [13367.729842] R13: 00007ffd922b07df R14: 00007fe1df6b4e40 R15: 0000000000802000
> [13367.730275] Modules linked in: btrfs blake2b_generic xor (...)
> [13367.732638] CR2: 00000000000000b0
> [13367.733166] ---[ end trace d298b6805556acd9 ]---
> 
> What happens is the following:
> 
> 1) At reada_find_extent() we don't find any existing readahead extent for
>     the metadata extent starting at logical address X;
> 
> 2) So we proceed to create a new one. We then call btrfs_map_block() to get
>     information about which stripes contain extent X;
> 
> 3) After that we iterate over the stripes and create only one zone for the
>     readahead extent - only one because reada_find_zone() returned NULL for
>     all iterations except for one, either because a memory allocation failed
>     or it couldn't find the block group of the extent (it may have just been
>     deleted);
> 
> 4) We then add the new readahead extent to the readahead extents radix
>     tree at fs_info->reada_tree;
> 
> 5) Then we iterate over each zone of the new readahead extent, and find
>     that the device used for that zone no longer exists, because it was
>     removed or it was the source device of a device replace operation.
>     Since this left 'have_zone' set to 0, after finishing the loop we jump
>     to the 'error' label, call kfree() on the new readahead extent and
>     return without removing it from the radix tree at fs_info->reada_tree;
> 
> 6) Any future call to reada_find_extent() for the logical address X will
>     find the stale pointer in the readahead extents radix tree, increment
>     its reference counter, which can trigger the use-after-free right
>     away or return it to the caller reada_add_block() that results in the
>     use-after-free of the example trace above.
> 
> So fix this by making sure we delete the readahead extent from the radix
> tree if we fail to setup zones for it (when 'have_zone = 0').
> 
> Fixes: 319450211842ba ("btrfs: reada: bypass adding extent when all zone failed")
> CC: stable@vger.kernel.org # 4.10+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
