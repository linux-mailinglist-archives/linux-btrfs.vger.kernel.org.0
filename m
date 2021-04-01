Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D235189E
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhDARqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 13:46:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236037AbhDARni (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F293B23F;
        Thu,  1 Apr 2021 17:09:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01DD4DA790; Thu,  1 Apr 2021 19:07:47 +0200 (CEST)
Date:   Thu, 1 Apr 2021 19:07:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix exhaustion of the system chunk array due to
 concurrent allocations
Message-ID: <20210401170747.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <beffbc19524a06910b0c59daa97570b8e94c4efc.1617188005.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beffbc19524a06910b0c59daa97570b8e94c4efc.1617188005.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 31, 2021 at 11:55:50AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we are running out of space for updating the chunk tree, that is,
> when we are low on available space in the system space info, if we have
> many task concurrently allocating block groups, via fallocate for example,
> many of them can end up all allocating new system chunks when only one is
> needed. In extreme cases this can lead to exhaustion of the system chunk
> array, which has a size limit of 2048 bytes, and results in a transaction
> abort with errno -EFBIG, producing a trace in dmesg like the following,
> which was triggered on a PowerPC machine with a node/leaf size of 64K:
> 
> [ 1359.518899] ------------[ cut here ]------------
> [ 1359.518980] BTRFS: Transaction aborted (error -27)
> [ 1359.519135] WARNING: CPU: 3 PID: 16463 at ../fs/btrfs/block-group.c:1968 btrfs_create_pending_block_groups+0x340/0x3c0 [btrfs]
> [ 1359.519152] Modules linked in: (...)
> [ 1359.519239] Supported: Yes, External
> [ 1359.519252] CPU: 3 PID: 16463 Comm: stress-ng Tainted: G               X    5.3.18-47-default #1 SLE15-SP3
> [ 1359.519274] NIP:  c008000000e36fe8 LR: c008000000e36fe4 CTR: 00000000006de8e8
> [ 1359.519293] REGS: c00000056890b700 TRAP: 0700   Tainted: G               X     (5.3.18-47-default)
> [ 1359.519317] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48008222  XER: 00000007
> [ 1359.519356] CFAR: c00000000013e170 IRQMASK: 0
> [ 1359.519356] GPR00: c008000000e36fe4 c00000056890b990 c008000000e83200 0000000000000026
> [ 1359.519356] GPR04: 0000000000000000 0000000000000000 0000d52a3b027651 0000000000000007
> [ 1359.519356] GPR08: 0000000000000003 0000000000000001 0000000000000007 0000000000000000
> [ 1359.519356] GPR12: 0000000000008000 c00000063fe44600 000000001015e028 000000001015dfd0
> [ 1359.519356] GPR16: 000000000000404f 0000000000000001 0000000000010000 0000dd1e287affff
> [ 1359.519356] GPR20: 0000000000000001 c000000637c9a000 ffffffffffffffe5 0000000000000000
> [ 1359.519356] GPR24: 0000000000000004 0000000000000000 0000000000000100 ffffffffffffffc0
> [ 1359.519356] GPR28: c000000637c9a000 c000000630e09230 c000000630e091d8 c000000562188b08
> [ 1359.519561] NIP [c008000000e36fe8] btrfs_create_pending_block_groups+0x340/0x3c0 [btrfs]
> [ 1359.519613] LR [c008000000e36fe4] btrfs_create_pending_block_groups+0x33c/0x3c0 [btrfs]
> [ 1359.519626] Call Trace:
> [ 1359.519671] [c00000056890b990] [c008000000e36fe4] btrfs_create_pending_block_groups+0x33c/0x3c0 [btrfs] (unreliable)
> [ 1359.519729] [c00000056890ba90] [c008000000d68d44] __btrfs_end_transaction+0xbc/0x2f0 [btrfs]
> [ 1359.519782] [c00000056890bae0] [c008000000e309ac] btrfs_alloc_data_chunk_ondemand+0x154/0x610 [btrfs]
> [ 1359.519844] [c00000056890bba0] [c008000000d8a0fc] btrfs_fallocate+0xe4/0x10e0 [btrfs]
> [ 1359.519891] [c00000056890bd00] [c0000000004a23b4] vfs_fallocate+0x174/0x350
> [ 1359.519929] [c00000056890bd50] [c0000000004a3cf8] ksys_fallocate+0x68/0xf0
> [ 1359.519957] [c00000056890bda0] [c0000000004a3da8] sys_fallocate+0x28/0x40
> [ 1359.519988] [c00000056890bdc0] [c000000000038968] system_call_exception+0xe8/0x170
> [ 1359.520021] [c00000056890be20] [c00000000000cb70] system_call_common+0xf0/0x278
> [ 1359.520037] Instruction dump:
> [ 1359.520049] 7d0049ad 40c2fff4 7c0004ac 71490004 40820024 2f83fffb 419e0048 3c620000
> [ 1359.520082] e863bcb8 7ec4b378 48010d91 e8410018 <0fe00000> 3c820000 e884bcc8 7ec6b378
> [ 1359.520122] ---[ end trace d6c186e151022e20 ]---
> 
> The following steps explain how we can end up in this situation:
> 
> 1) Task A is at check_system_chunk(), either because it is allocating a
>    new data or metadata block group, at btrfs_chunk_alloc(), or because
>    it is removing a block group or turning a block group RO. It does not
>    matter why;
> 
> 2) Task A sees that there is not enough free space in the system
>    space_info object, that is 'left' is < 'thresh'. And at this point
>    the system space_info has a value of 0 for its 'bytes_may_use'
>    counter;
> 
> 3) As a consequence task A calls btrfs_alloc_chunk() in order to allocate
>    a new system block group (chunk) and then reserves 'thresh' bytes in
>    the chunk block reserve with the call to btrfs_block_rsv_add(). This
>    changes the chunk block reserve's 'reserved' and 'size' counters by an
>    amount of 'thresh', and changes the 'bytes_may_use' counter of the
>    system space_info object from 0 to 'thresh'.
> 
>    Also during its call to btrfs_alloc_chunk(), we end up increasing the
>    value of the 'total_bytes' counter of the system space_info object by
>    8MiB (the size of a system chunk stripe). This happens through the
>    call chain:
> 
>    btrfs_alloc_chunk()
>        create_chunk()
>            btrfs_make_block_group()
>                btrfs_update_space_info()
> 
> 4) After it finishes the first phase of the block group allocation, at
>    btrfs_chunk_alloc(), task A unlocks the chunk mutex;
> 
> 5) At this point the new system block group was added to the transaction
>    handle's list of new block groups, but its block group item, device
>    items and chunk item were not yet inserted in the extent, device and
>    chunk trees, respectively. That only happens later when we call
>    btrfs_finish_chunk_alloc() through a call to
>    btrfs_create_pending_block_groups();
> 
>    Note that only when we update the chunk tree, through the call to
>    btrfs_finish_chunk_alloc(), we decrement the 'reserved' counter
>    of the chunk block reserve as we COW/allocate extent buffers,
>    through:
> 
>    btrfs_alloc_tree_block()
>       btrfs_use_block_rsv()
>          btrfs_block_rsv_use_bytes()
> 
>    And the system space_info's 'bytes_may_use' is decremented everytime
>    we allocate an extent buffer for COW operations on the chunk tree,
>    through:
> 
>    btrfs_alloc_tree_block()
>       btrfs_reserve_extent()
>          find_free_extent()
>             btrfs_add_reserved_bytes()
> 
>    If we end up COWing less chunk btree nodes/leaves than expected, which
>    is the typical case since the amount of space we reserve is always
>    pessimistic to account for the worst possible case, we release the
>    unused space through:
> 
>    btrfs_create_pending_block_groups()
>       btrfs_trans_release_chunk_metadata()
>          btrfs_block_rsv_release()
>             block_rsv_release_bytes()
>                 btrfs_space_info_free_bytes_may_use()
> 
>    But before task A gets into btrfs_create_pending_block_groups()...
> 
> 6) Many other tasks start allocating new block groups through fallocate,
>    each one does the first phase of block group allocation in a
>    serialized way, since btrfs_chunk_alloc() takes the chunk mutex
>    before calling check_system_chunk() and btrfs_alloc_chunk().
> 
>    However before everyone enters the final phase of the block group
>    allocation, that is, before calling btrfs_create_pending_block_groups(),
>    new tasks keep coming to allocate new block groups and while at
>    check_system_chunk(), the system space_info's 'bytes_may_use' keeps
>    increasing each time a task reserves space in the chunk block reserve.
>    This means that eventually some other task can end up not seeing enough
>    free space in the system space_info and decide to allocate yet another
>    system chunk.
> 
>    This may repeat several times if yet more new tasks keep allocating
>    new block groups before task A, and all the other tasks, finish the
>    creation of the pending block groups, which is when reserved space
>    in excess is released. Eventually this can result in exhaustion of
>    system chunk array in the superblock, with btrfs_add_system_chunk()
>    returning -EFBIG, resulting later in a transaction abort.
> 
>    Even when we don't reach the extreme case of exhausting the system
>    array, most, if not all, unnecessarily created system block groups
>    end up being unused since when finishing creation of the first
>    pending system block group, the creation of the following ones end
>    up not needing to COW nodes/leaves of the chunk tree, so we never
>    allocate and deallocate from them, resulting in them never being
>    added to the list of unused block groups - as a consequence they
>    don't get deleted by the cleaner kthread - the only exceptions are
>    if we unmount and mount the filesystem again, which adds any unused
>    block groups to the list of unused block groups, if a scrub is
>    run, which also adds unused block groups to the unused list, and
>    under some circumstances when using a zoned filesystem or async
>    discard, which may also add unused block groups to the unused list.
> 
> So fix this by:
> 
> *) Tracking the number of reserved bytes for the chunk tree per
>    transaction, which is the sum of reserved chunk bytes by each
>    transaction handle currently being used;
> 
> *) When there is not enough free space in the system space_info,
>    if there are other transaction handles which reserved chunk space,
>    wait for some of them to complete in order to have enough excess
>    reserved space released, and then try again. Otherwise proceed with
>    the creation of a new system chunk.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next.
