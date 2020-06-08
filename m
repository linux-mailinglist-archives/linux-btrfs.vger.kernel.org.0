Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B721F1BA6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgFHPFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgFHPFM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 11:05:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3400DC08C5C2
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Jun 2020 08:05:12 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c185so17516173qke.7
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Jun 2020 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y4uncGzb48EUbwR9+q9ldqWvwnBRS0WjPqkDwMYfy1E=;
        b=dRnrrmg2Ub+ZiaI6qKuksEJkRIOANTtPqHsbbW6g9uPSTo2b2B+GmXoc3cWycQyosR
         fWQUgtv1Ewxxl6qmtreeBRgOBybsI7KlILlHnLe4CT7Pe0vcP/XpIcUodhDBzPe9ZxKE
         7PUY3lr6G3jDE2/c2wkk+VBpRtSo5JJ2f3jToO1IYssHbnPpgVQ7kr7P2uA1V/XyzXuB
         r7OrrRCyR149F5VfnBUtmucK6Wb2/9xFPKfEEEXR8PfWHW0z6g5nv+Grhddy1CboDwoS
         ZABHIJaDNLb4Ek/yNAC+0omO3TcM/Rv/kzn7krEVcEZ1o7IpNFHKJ3LmJd9t5a+LBGNw
         r0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y4uncGzb48EUbwR9+q9ldqWvwnBRS0WjPqkDwMYfy1E=;
        b=Z40LyAQBpPJS6Fq0/EGmosPLaNQtKP6E/iywjfpI3LjMN+Hhaoh1uHQe/lXt1rIHKM
         xIomEs083PGS7wGvHiG6SfRE9qujw5Z6gSp9LdObmOYgKSAOX0pHLi23Ue2/LIwSo6LC
         7+a9eKA0GAp/nzfcDHhD7vrdO0oELgqyfzDbNRU9pDngv05ozzodOIbvICPvNUgBLiwK
         uTLrMdHTOCyv6YmT4fgslBfB0cnykpdAIP0KFO6SlW6j8zvzWqdXRXeOtUyfrObLmoSo
         2rTv6r0THipgcZL6RsL72IBMD4y4eZBeqNl9Zmyo7nuxIePoYDRq3icyZH/acRmvgAsI
         4PAg==
X-Gm-Message-State: AOAM531oDCRHcXHXiOSVUlZJy6QnzPPd/nTH/KB7ZzvDEFaW5cz4K9oY
        oDBPT+vyzNzhyE0uFdk9Dtja5XqEQ7q1ig==
X-Google-Smtp-Source: ABdhPJwPSwBjnV5YbGoHmOhsrL0uaL7UVCvNIYczRDwQNn4h33phPW0dvErL+CidmCFd3cgnviCsRQ==
X-Received: by 2002:ae9:ed51:: with SMTP id c78mr22208649qkg.412.1591628710837;
        Mon, 08 Jun 2020 08:05:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a4? ([2620:10d:c091:480::1:ae5a])
        by smtp.gmail.com with ESMTPSA id x54sm8223933qta.42.2020.06.08.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 08:05:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] Btrfs: fix data block group relocation failure due to
 concurrent scrub
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200608123255.26354-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <56d58c6e-cb64-af1b-d57e-281a5d376776@toxicpanda.com>
Date:   Mon, 8 Jun 2020 11:05:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608123255.26354-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/8/20 8:32 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running relocation of a data block group while scrub is running in
> parallel, it is possible that the relocation will fail and abort the
> current transaction with an -EINVAL error:
> 
>     [134243.988595] BTRFS info (device sdc): found 14 extents, stage: move data extents
>     [134243.999871] ------------[ cut here ]------------
>     [134244.000741] BTRFS: Transaction aborted (error -22)
>     [134244.001692] WARNING: CPU: 0 PID: 26954 at fs/btrfs/ctree.c:1071 __btrfs_cow_block+0x6a7/0x790 [btrfs]
>     [134244.003380] Modules linked in: btrfs blake2b_generic xor raid6_pq (...)
>     [134244.012577] CPU: 0 PID: 26954 Comm: btrfs Tainted: G        W         5.6.0-rc7-btrfs-next-58 #5
>     [134244.014162] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>     [134244.016184] RIP: 0010:__btrfs_cow_block+0x6a7/0x790 [btrfs]
>     [134244.017151] Code: 48 c7 c7 (...)
>     [134244.020549] RSP: 0018:ffffa41607863888 EFLAGS: 00010286
>     [134244.021515] RAX: 0000000000000000 RBX: ffff9614bdfe09c8 RCX: 0000000000000000
>     [134244.022822] RDX: 0000000000000001 RSI: ffffffffb3d63980 RDI: 0000000000000001
>     [134244.024124] RBP: ffff961589e8c000 R08: 0000000000000000 R09: 0000000000000001
>     [134244.025424] R10: ffffffffc0ae5955 R11: 0000000000000000 R12: ffff9614bd530d08
>     [134244.026725] R13: ffff9614ced41b88 R14: ffff9614bdfe2a48 R15: 0000000000000000
>     [134244.028024] FS:  00007f29b63c08c0(0000) GS:ffff9615ba600000(0000) knlGS:0000000000000000
>     [134244.029491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [134244.030560] CR2: 00007f4eb339b000 CR3: 0000000130d6e006 CR4: 00000000003606f0
>     [134244.031997] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     [134244.033153] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     [134244.034484] Call Trace:
>     [134244.034984]  btrfs_cow_block+0x12b/0x2b0 [btrfs]
>     [134244.035859]  do_relocation+0x30b/0x790 [btrfs]
>     [134244.036681]  ? do_raw_spin_unlock+0x49/0xc0
>     [134244.037460]  ? _raw_spin_unlock+0x29/0x40
>     [134244.038235]  relocate_tree_blocks+0x37b/0x730 [btrfs]
>     [134244.039245]  relocate_block_group+0x388/0x770 [btrfs]
>     [134244.040228]  btrfs_relocate_block_group+0x161/0x2e0 [btrfs]
>     [134244.041323]  btrfs_relocate_chunk+0x36/0x110 [btrfs]
>     [134244.041345]  btrfs_balance+0xc06/0x1860 [btrfs]
>     [134244.043382]  ? btrfs_ioctl_balance+0x27c/0x310 [btrfs]
>     [134244.045586]  btrfs_ioctl_balance+0x1ed/0x310 [btrfs]
>     [134244.045611]  btrfs_ioctl+0x1880/0x3760 [btrfs]
>     [134244.049043]  ? do_raw_spin_unlock+0x49/0xc0
>     [134244.049838]  ? _raw_spin_unlock+0x29/0x40
>     [134244.050587]  ? __handle_mm_fault+0x11b3/0x14b0
>     [134244.051417]  ? ksys_ioctl+0x92/0xb0
>     [134244.052070]  ksys_ioctl+0x92/0xb0
>     [134244.052701]  ? trace_hardirqs_off_thunk+0x1a/0x1c
>     [134244.053511]  __x64_sys_ioctl+0x16/0x20
>     [134244.054206]  do_syscall_64+0x5c/0x280
>     [134244.054891]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [134244.055819] RIP: 0033:0x7f29b51c9dd7
>     [134244.056491] Code: 00 00 00 (...)
>     [134244.059767] RSP: 002b:00007ffcccc1dd08 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>     [134244.061168] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f29b51c9dd7
>     [134244.062474] RDX: 00007ffcccc1dda0 RSI: 00000000c4009420 RDI: 0000000000000003
>     [134244.063771] RBP: 0000000000000003 R08: 00005565cea4b000 R09: 0000000000000000
>     [134244.065032] R10: 0000000000000541 R11: 0000000000000202 R12: 00007ffcccc2060a
>     [134244.066327] R13: 00007ffcccc1dda0 R14: 0000000000000002 R15: 00007ffcccc1dec0
>     [134244.067626] irq event stamp: 0
>     [134244.068202] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>     [134244.069351] hardirqs last disabled at (0): [<ffffffffb2abdedf>] copy_process+0x74f/0x2020
>     [134244.070909] softirqs last  enabled at (0): [<ffffffffb2abdedf>] copy_process+0x74f/0x2020
>     [134244.072392] softirqs last disabled at (0): [<0000000000000000>] 0x0
>     [134244.073432] ---[ end trace bd7c03622e0b0a99 ]---
> 
> The -EINVAL error comes from the following chain of function calls:
> 
>    __btrfs_cow_block() <-- aborts the transaction
>      btrfs_reloc_cow_block()
>        replace_file_extents()
>          get_new_location() <-- returns -EINVAL
> 
> When relocating a data block group, for each allocated extent of the block
> group, we preallocate another extent (at prealloc_file_extent_cluster()),
> associated with the data relocation inode, and then dirty all its pages.
> These preallocated extents have, and must have, the same size that extents
> from the data block group being relocated have.
> 
> Later before we start the relocation stage that updates pointers (bytenr
> field of file extent items) to point to the the new extents, we trigger
> writeback for the data relocation inode. The expectation is that writeback
> will write the pages to the previously preallocated extents, that it
> follows the NOCOW path. That is generally the case, however, if a scrub
> is running it may have turned the block group that contains those extents
> into RO mode, in which case writeback falls back to the COW path.
> 
> However in the COW path instead of allocating exactly one extent with the
> expected size, the allocator may end up allocating several smaller extents
> due to free space fragmentation - because we tell it at cow_file_range()
> that the minimum allocation size can match the filesystem's sector size.
> This later breaks the relocation's expectation that an extent associated
> to a file extent item in the data relocation inode has the same size as
> the respective extent pointed by a file extent item in another tree - in
> this case the extent to which the relocation inode poins to is smaller,
> causing relocation.c:get_new_location() to return -EINVAL.
> 
> For example, if we are relocating a data block group X that has a logical
> address of X and the block group has an extent allocated at the logical
> address X + 128Kb with a size of 64Kb:
> 
> 1) At prealloc_file_extent_cluster() we allocate an extent for the data
>     relocation inode with a size of 64Kb and associate it to the file
>     offset 128Kb (X + 128Kb - X) of the data relocation inode. This
>     preallocated extent was allocated at block group Z;
> 
> 2) A scrub running in parallel turns block group Z into RO mode and
>     starts scrubing its extents;
> 
> 3) Relocation triggers writeback for the data relocation inode;
> 
> 4) When running delalloc (btrfs_run_delalloc_range()), we try first the
>     NOCOW path because the data relocation inode has BTRFS_INODE_PREALLOC
>     set in its flags. However, because block group Z is in RO mode, the
>     NOCOW path (run_delalloc_nocow()) falls back into the COW path, by
>     calling cow_file_range();
> 
> 5) At cow_file_range(), in the first iteration of the while loop we call
>     btrfs_reserve_extent() to allocate a 64Kb extent and pass it a minimum
>     allocation size of 4Kb (fs_info->sectorsize). Due to free space
>     fragmentation, btrfs_reserve_extent() ends up allocating two extents
>     of 32Kb each, each one on a different iteration of that while loop;
> 
> 6) Writeback of the data relocation inode completes;
> 
> 7) Relocation proceeds and ends up at relocation.c:replace_file_extents(),
>     with a leaf which has a file extent item that points to the data extent
>     from block group X, that has a logical address (bytenr) of X + 128Kb
>     and a size of 64Kb. Then it calls get_new_location(), which does a
>     lookup in the data relocation tree for a file extent item starting at
>     offset 128Kb (X + 128Kb - X) and belonging to the data relocation
>     inode. It finds a corresponding file extent item, however that item
>     points to an extent that has a size of 32Kb, which doesn't match the
>     expected size of 64Kb, resuling in -EINVAL being returned from this
>     function and propagated up to __btrfs_cow_block(), which aborts the
>     current transaction.
> 
> To fix this make sure that at cow_file_range() when we call the allocator
> we pass it a minimum allocation size corresponding the desired extent size
> if the inode belongs to the data relocation tree, otherwise pass it the
> filesystem's sector size as the minimum allocation size.
> 
> CC: stable@vger.kernel.org # 4.4+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Nice catch,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
