Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3713728E1C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbgJNN5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 09:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbgJNN5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 09:57:30 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605CC061755
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Oct 2020 06:57:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p9so5228247ilr.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Oct 2020 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dohiwopqt0sJC9cX2BNGmjPjyjfYIaqFHHqtAb2xLAw=;
        b=T+maCiLF3P5R1+GdbNYuqsRVFLKc/zgH6b3manTXdoBo8tVSYJPDuwY0DNC/M4dMNf
         CmWHZX/sQc22gJWlRiSoUfQJ4ktVdjBysSE41npsvnGFiyCbnUqzZ8BmSKwmKmI4NPk7
         6Af7oGxXuLN/+Xue3NLy19I5FfOcJ0Syu5wIzMc40woA1fbmV8Umif+OyHGd8uz3lab1
         WWDNHb85TMhHoxeMEteOAv+vaJrIjn8KDFApCzz6SUoEvSmSwo2mJHjbu8vIBOi69TTb
         gQBmQX6m5W5hSqLjSLj98lyDbKhLYcpjgIJVk50L/aSTIM4n7yc5pN18ISOTWHUuhAvz
         gNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dohiwopqt0sJC9cX2BNGmjPjyjfYIaqFHHqtAb2xLAw=;
        b=Dh73G6Oa1V63NEKsroOrR6oBtT413JlqmbIC4H0qGYDYGnXEibWVWyG0gD8f8d7ikn
         PJuB/SKJC2VCKnnUpWai+NrOKQB8wNVgWiGFrFea1MnmFN6oD6Y4ucflVh7s0E1DtkjB
         SqUGRsqT2Zq8BTUEjtChWqu/LRVLfRNmXP/GZT/nHizNlJuxh35fFQ9S5AZODuuay9UW
         +kyHxtVTDgiz3pfwWLsgXFQPZLCxQuGLl6L8NivT+XnZFKyxttuAGZrEiMVvzKzQqA5o
         bb655pgJYjaUYMMLSR85nt+4QIgWvganvSS4Ww8z8YAguCqV0G2/RxT+7ZbOAsauh5J7
         Fqfg==
X-Gm-Message-State: AOAM530mbnoEYcjjxtB/Qg4MIND3ZuDQ0NTfu6F+JoMb8liKtmj78pGm
        zjgnp5/sbhea6L/MruUoxBC5hCAT5o4SJg==
X-Google-Smtp-Source: ABdhPJz2Quc4Nv8yR8PbbOy5Iqy6Mei78EIyUNWLv+SfXnv8SDO7Y3Q4H4hrSPA/a+A6tBhDoNXiUA==
X-Received: by 2002:a92:c946:: with SMTP id i6mr3966915ilq.199.1602683847512;
        Wed, 14 Oct 2020 06:57:27 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1116? ([2620:10d:c091:480::1:42])
        by smtp.gmail.com with ESMTPSA id v78sm3322178ilk.20.2020.10.14.06.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 06:57:26 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix relocation failure due to race with fallocate
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f7a664e3c6d79a4ed793461b4a3f8f7508be6fb2.1602666574.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <397c69ba-410e-4857-061e-780a1727899f@toxicpanda.com>
Date:   Wed, 14 Oct 2020 09:57:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <f7a664e3c6d79a4ed793461b4a3f8f7508be6fb2.1602666574.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/14/20 5:10 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a fallocate() we have a short time window, after reserving an
> extent and before starting a transaction, where if relocation for the block
> group containing the reserved extent happens, we can end up missing the
> extent in the data relocation inode causing relocation to fail later.
> 
> This only happens when we don't pass a transaction to the internal
> fallocate function __btrfs_prealloc_file_range(), which is for all the
> cases where fallocate() is called from user space (the internal use cases
> include space cache extent allocation and relocation).
> 
> When the race triggers the relocation failure, it produces a trace like
> the following:
> 
> [200611.995995] ------------[ cut here ]------------
> [200611.997084] BTRFS: Transaction aborted (error -2)
> [200611.998208] WARNING: CPU: 3 PID: 235845 at fs/btrfs/ctree.c:1074 __btrfs_cow_block+0x3a0/0x5b0 [btrfs]
> [200611.999042] Modules linked in: dm_thin_pool dm_persistent_data (...)
> [200612.003287] CPU: 3 PID: 235845 Comm: btrfs Not tainted 5.9.0-rc6-btrfs-next-69 #1
> [200612.004442] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [200612.006186] RIP: 0010:__btrfs_cow_block+0x3a0/0x5b0 [btrfs]
> [200612.007110] Code: 1b 00 00 02 72 2a 83 f8 fb 0f 84 b8 01 (...)
> [200612.007341] BTRFS warning (device sdb): Skipping commit of aborted transaction.
> [200612.008959] RSP: 0018:ffffaee38550f918 EFLAGS: 00010286
> [200612.009672] BTRFS: error (device sdb) in cleanup_transaction:1901: errno=-30 Readonly filesystem
> [200612.010428] RAX: 0000000000000000 RBX: ffff9174d96f4000 RCX: 0000000000000000
> [200612.011078] BTRFS info (device sdb): forced readonly
> [200612.011862] RDX: 0000000000000001 RSI: ffffffffa8161978 RDI: 00000000ffffffff
> [200612.013215] RBP: ffff9172569a0f80 R08: 0000000000000000 R09: 0000000000000000
> [200612.014263] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9174b8403b88
> [200612.015203] R13: ffff9174b8400a88 R14: ffff9174c90f1000 R15: ffff9174a5a60e08
> [200612.016182] FS:  00007fa55cf878c0(0000) GS:ffff9174ece00000(0000) knlGS:0000000000000000
> [200612.017174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [200612.018418] CR2: 00007f8fb8048148 CR3: 0000000428a46003 CR4: 00000000003706e0
> [200612.019510] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [200612.020648] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [200612.021520] Call Trace:
> [200612.022434]  btrfs_cow_block+0x10b/0x250 [btrfs]
> [200612.023407]  do_relocation+0x54e/0x7b0 [btrfs]
> [200612.024343]  ? do_raw_spin_unlock+0x4b/0xc0
> [200612.025280]  ? _raw_spin_unlock+0x29/0x40
> [200612.026200]  relocate_tree_blocks+0x3bc/0x6d0 [btrfs]
> [200612.027088]  relocate_block_group+0x2f3/0x600 [btrfs]
> [200612.027961]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
> [200612.028896]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
> [200612.029772]  btrfs_balance+0xb22/0x1790 [btrfs]
> [200612.030601]  ? btrfs_ioctl_balance+0x253/0x380 [btrfs]
> [200612.031414]  btrfs_ioctl_balance+0x2cf/0x380 [btrfs]
> [200612.032279]  btrfs_ioctl+0x620/0x36f0 [btrfs]
> [200612.033077]  ? _raw_spin_unlock+0x29/0x40
> [200612.033948]  ? handle_mm_fault+0x116d/0x1ca0
> [200612.034749]  ? up_read+0x18/0x240
> [200612.035542]  ? __x64_sys_ioctl+0x83/0xb0
> [200612.036244]  __x64_sys_ioctl+0x83/0xb0
> [200612.037269]  do_syscall_64+0x33/0x80
> [200612.038190]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [200612.038976] RIP: 0033:0x7fa55d07ed87
> [200612.040127] Code: 00 00 00 48 8b 05 09 91 0c 00 64 c7 00 26 (...)
> [200612.041669] RSP: 002b:00007ffd5ebf03e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [200612.042437] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa55d07ed87
> [200612.043511] RDX: 00007ffd5ebf0470 RSI: 00000000c4009420 RDI: 0000000000000003
> [200612.044250] RBP: 0000000000000003 R08: 000055d8362642a0 R09: 00007fa55d148be0
> [200612.044963] R10: fffffffffffff52e R11: 0000000000000206 R12: 00007ffd5ebf1614
> [200612.045683] R13: 00007ffd5ebf0470 R14: 0000000000000002 R15: 00007ffd5ebf0470
> [200612.046361] irq event stamp: 0
> [200612.047040] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [200612.047725] hardirqs last disabled at (0): [<ffffffffa6eb5ab3>] copy_process+0x823/0x1bc0
> [200612.048387] softirqs last  enabled at (0): [<ffffffffa6eb5ab3>] copy_process+0x823/0x1bc0
> [200612.049024] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [200612.049722] ---[ end trace 49006c6876e65227 ]---
> 
> The race happens like this:
> 
> 1) Task A starts an fallocate() (plain or zero range) and it calls
>     __btrfs_prealloc_file_range() with the 'trans' parameter set to NULL;
> 
> 2) Task A calls btrfs_reserve_extent() and gets an extent that belongs to
>     block group X;
> 
> 3) Before task A gets into btrfs_replace_file_extents(), through the call
>     to insert_prealloc_file_extent(), task B starts relocation of block
>     group X;
> 
> 4) Task B enters btrfs_relocate_block_group() and it sets block group X to
>     RO mode;
> 
> 5) Task B enters relocate_block_group(), it calls prepare_to_relocate()
>     whichs joins/starts a transaction and then commits the transaction;
> 
> 6) Task B then starts scanning the extent tree looking for extents that
>     belong to block group X - it does not find yet the extent reserved by
>     task A, since that extent was not yet added to the extent tree, as its
>     delayed reference was not even yet created at this point;
> 
> 7) The data relocation inode ends up not having the extent reserved by
>     task A associated to it;
> 
> 8) Task A then starts a transaction through btrfs_replace_file_extents(),
>     inserts a file extent item in the subvolume tree pointing to the
>     reserved extent and creates a delayed reference for it;
> 
> 9) Task A finishes and returns success to user space;
> 
> 10) Later on, while relocation is still in progress, the leaf where task A
>      inserted the new file extent item is COWed, so we end up at
>      __btrfs_cow_block(), which calls btrfs_reloc_cow_block(), and that in
>      turn calls relocation.c:replace_file_extents();
> 
> 11) At relocation.c:replace_file_extents() we iterate over all the items in
>      the leaf and find the file extent item pointing to the extent that was
>      allocated by task A, and then call relocation.c:get_new_location(), to
>      find the new location for the extent;
> 
> 12) However relocation.c:get_new_location() fails, returning -ENOENT,
>      because it couldn't find a corresponding file extent item associated
>      with the data relocation inode. This is because the extent was not seen
>      in the extent tree at step 6). The -ENOENT error is propagated to
>      __btrfs_cow_block(), which aborts the transaction.
> 
> So fix this simply by decrementing the block group's number or reservations
> after calling insert_prealloc_file_extent(), as relocation waits for that
> counter to go down to zero before calling prepare_to_relocate() and start
> looking for extents in the extent tree.
> 
> This issue only started to happen recently as of commit 8fccebfa534c79
> ("btrfs: fix metadata reservation for fallocate that leads to transaction
> aborts"), because now we can reserve an extent before starting/joining a
> transaction, and previously we always did it after that, so relocation
> ended up waiting for a concurrent fallocate() to finish because before
> searching for the extents of the block group, it starts/joins a transaction
> and then commits it (at prepare_to_relocate()), which made it wait for the
> fallocate task to complete first.
> 
> Fixes: 8fccebfa534c79 ("btrfs: fix metadata reservation for fallocate that leads to transaction aborts")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
