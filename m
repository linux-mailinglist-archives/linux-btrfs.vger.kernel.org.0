Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734FA3AE193
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 04:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUCBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 22:01:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14132 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFUCBi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 22:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624240765; x=1655776765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tkdSwhITMRcei5omTXapM0Hyyfr6kQ5ioNRjtuot1jk=;
  b=ZGe3WPnQJrugrPMUNuO6IslaE8GxElXGpEIWeh7P5lh9GueD0rBzGx/q
   AUc7AyNbG1gBheQvKJh0u1k9Zvs/KF0rdDX0/i11HsBIjzy/xj6QMK448
   OH2ubEMeZR7DtCD/XypIyGEL39TYeM/qTBRYE0I5P6XADBoZvt18AgnHr
   rz6YtvOuxuNePGfWOjuTqSvv5ryaz/eC8T/28sQ6kT9FardjNywAAvi6d
   HEYL0vncDRDZcSXbAnhKbFAeY4NBO5/ayoyXz5toiK1BV/qyK+jzOJTZL
   u7ReexSzBRU25Mx/2a0uDwWoqpou8PF5jl3DD8CJuQE40OUdpNNUMe+tf
   w==;
IronPort-SDR: ntEQDrzlOTmxz0oCjYQ5gY30xz4sdo6pIcIbWwENz0GDVqdO16ewn+EoezM8t6351mgI0zjuna
 1jy5vgoB9evLgoLHOKcHNhtLsrXxkq5tDvX2lJRsBlBi6t711bLqwToBiTvHahzMg9+6MA4zT7
 3lgcl190J1CX/3jZuoc5X46uxlihNJhtbWV0vtyqRK8rIonJp9kx7zyUPSQWq8vwCQTTXTev/w
 43oe/8TCjTGDkwSZdb0/wxyf1HQCb6SecJKUSZlOwr9V6L93zVALhw0WRM06SN/r+5+35w7WxQ
 s5E=
X-IronPort-AV: E=Sophos;i="5.83,288,1616428800"; 
   d="scan'208";a="177229228"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2021 09:59:23 +0800
IronPort-SDR: r6A3DVDY8wyTftlEjAOGZFVLdDX89x4wH8nzksoa+mY0RBeOESYglqxafTyN0jzlsXQ9K589Fa
 H0JoqCtyYiMp54oKxdxe+cUFZPXVpszYTSLqn4wO6NdffxH7XmLGzPyuwbNJTc4+JUYC7xBs0W
 bFkDDtA33rZ9Ja56ezFGioSG2RFKCBh1nMUHsJudjbAxDrzHTayOkkg3Cr0SqTbGCcSCm1xcPy
 e/g1M/gju6ck+xVzgpmhwx30HOgofccc5N1yhpbx0kBTorUHdS4A+BLIFOHQLlQM5xnCTwLTeU
 Gy7I6Z3ZBO9wUkSEr/v2/EyP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 18:36:43 -0700
IronPort-SDR: oLriaeeHHkUKLgWiaCg4a1Ky+8iRXVmABOX18yZ1+cuZ4S2RUdM9VP9r9qVXHMhLnhexd1ReOw
 Ulp/VpOx5dsBxIOeefiY267W9DdHXIqKyxqWxYT4b7h1UsWcj4rrO2K1nvLgknzuTWSnSI9wQ0
 nkpIFruSfv9Mi5aS01tK2HB4JxeR1VdWVjmSALL/NXZuo4puxMYa9KHnPlIyl106dLDMCrbNCX
 mv9EHZaLNLyh8TGfULTTV4WIz9BEC7PhYBKh0gIrv6d9vzI7QMSisNBTcROA8//+xT4ZC64JXf
 Byo=
WDCIronportException: Internal
Received: from 5cg0390p95.ad.shared (HELO naota-xeon) ([10.225.48.64])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 18:59:23 -0700
Date:   Mon, 21 Jun 2021 10:59:22 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: hung_task issue by wait_event() in check_system_chunk()
Message-ID: <20210621015922.ewgbffxuawia7liz@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We recently observed a hung_task issue on our 5.13-rc* test runs
(without any lockdep warnings!). The code is based on Linux 5.13-rc6 +
a patch to fix unbalanced unlock in qgroup_account_snapshot() [1] +
some debug printings. I found the cause of the issue, but I'm not sure
how we can fix it.

[1] https://lore.kernel.org/linux-btrfs/20210621012114.1884779-1-naohiro.aota@wdc.com/T/#u

* Summary:

In btrfs_chunk_alloc(), we set space_info->chunk_alloc = 1 before a
chunk allocation and turn it to 0 after the allocation. We block other
chunk allocations while space_info->chunk_alloc == 1. So, the code
should be forward-progress while space_info->chunk_alloc == 1.

However, commit eafa4fd0ad06 ("btrfs: fix exhaustion of the system
chunk array due to concurrent allocations") broke the assumption. It
introduced wait_event() to wait for an ongoing transaction which
allocated a new chunk to finish. That waiting leads to an invisible
circular dependency. If the thread that allocated a chunk tries to
allocate another chunk, it cannot proceed because the wait_event()'ing
thread set space_info->chunk_alloc = 1.

We might need to set space_info->chunk_alloc = 0 while wait_event()?
But then we need to recheck everything again from the start of
btrfs_chunk_alloc()?

* Full analysis:

# These messages are from check_system_chunk() after "trans->chunk_bytes_reserved += thresh;"
[  905.785876][  T722] 722 add 393216 to transaction 233
[  905.800494][ T5063] 5063 add 393216 to transaction 233

Thread 722 and 5063 reserved space for its chunk allocation metadata
on the running transaction.

[  905.806845][ T5070] BTRFS info (device nullb1): left=65536, need=393216, flags=4
[  905.811547][ T5070] BTRFS info (device nullb1): space_info 2 has 65536 free, is not full
...
# This message is from check_system_chunk() before the wait_event()
[  905.831000][ T5070] waiting for reserved 786432 trans 0 min_needed 393216

Now thread 5070 does not have enough SYSTEM space (left=65536 <
need=393216) for its chunk allocation. And, since other
transaction_handle in the same transaction (transaction_handle of
thread 722 and 5063) already reserved space for them, it now waits for
them to free their reservation with transaction commit.

[ 1108.499029][   T22] INFO: task kworker/u4:5:721 blocked for more than 122 seconds.

But, nothing progressed!

So, what is happened with threads 722 and 5063?

Backtrace of thread 722

crash> bt 722 
PID: 722    TASK: ffff888100f80000  CPU: 0   COMMAND: "kworker/u4:6"
 #0 [ffffc90002467160] __schedule at ffffffff8260da25
 #1 [ffffc90002467268] preempt_schedule_common at ffffffff8260f635
 #2 [ffffc90002467288] __cond_resched at ffffffff8260f68d
 #3 [ffffc90002467298] btrfs_chunk_alloc at ffffffffa03cd50a [btrfs]
 #4 [ffffc90002467330] find_free_extent at ffffffffa01adfa2 [btrfs]
 #5 [ffffc900024674f0] btrfs_reserve_extent at ffffffffa01bf7d0 [btrfs]
 #6 [ffffc90002467580] btrfs_alloc_tree_block at ffffffffa01c074f [btrfs]
 #7 [ffffc90002467720] alloc_tree_block_no_bg_flush at ffffffffa018d9e5 [btrfs]
 #8 [ffffc90002467780] __btrfs_cow_block at ffffffffa0194fb1 [btrfs]
 #9 [ffffc900024678d0] btrfs_cow_block at ffffffffa01960b5 [btrfs]
#10 [ffffc90002467950] btrfs_search_slot at ffffffffa01a15c7 [btrfs]
#11 [ffffc90002467ac0] btrfs_remove_chunk at ffffffffa027f43c [btrfs]
#12 [ffffc90002467c50] btrfs_relocate_chunk at ffffffffa0280503 [btrfs]
#13 [ffffc90002467c88] btrfs_reclaim_bgs_work.cold at ffffffffa040e7b7 [btrfs]
#14 [ffffc90002467c90] __kasan_check_read at ffffffff8167ebf1
#15 [ffffc90002467d08] process_one_work at ffffffff811ae718
#16 [ffffc90002467e40] worker_thread at ffffffff811af8de
#17 [ffffc90002467f08] kthread at ffffffff811c0857
#18 [ffffc90002467f50] ret_from_fork at ffffffff810034b2

So, here it is. Since check_system_chunk() takes neither
space_info->lock nor fs_info->chunk_mutex while the waiting, thread
722 is in busy-loop to wait for space_info->chunk_alloc == 0.

 #3 [ffffc90002467298] btrfs_chunk_alloc at ffffffffa03cd50a [btrfs] 
    /home/naota/src/linux-works/btrfs-zoned/fs/btrfs/block-group.c: 3282

And, how about thread 5063?

crash> bt 5063
PID: 5063   TASK: ffff8881ca254000  CPU: 0   COMMAND: "fsstress"
 #0 [ffffc90007d46fd8] __schedule at ffffffff8260da25
 #1 [ffffc90007d470e0] schedule at ffffffff8260f247
 #2 [ffffc90007d47110] rwsem_down_read_slowpath at ffffffff82619b9d
 #3 [ffffc90007d47268] __down_read_common at ffffffff8126492c
 #4 [ffffc90007d47318] down_read_nested at ffffffff81264da4
 #5 [ffffc90007d47368] btrfs_read_lock_root_node at ffffffffa02b5007 [btrfs]
 #6 [ffffc90007d47390] btrfs_search_slot at ffffffffa01a181b [btrfs]
 #7 [ffffc90007d47500] _raw_spin_unlock_irqrestore at ffffffff8262349c
 #8 [ffffc90007d47550] insert_with_overflow at ffffffffa01c74b9 [btrfs]
 #9 [ffffc90007d47600] btrfs_insert_dir_item at ffffffffa01c7bff [btrfs]
#10 [ffffc90007d47738] create_subvol at ffffffffa02a610b [btrfs]
#11 [ffffc90007d47970] btrfs_mksubvol at ffffffffa02a7829 [btrfs]
#12 [ffffc90007d47a08] _copy_from_user at ffffffff81b315ab
#13 [ffffc90007d47a60] btrfs_ioctl_snap_create_v2 at ffffffffa02a832f [btrfs]
#14 [ffffc90007d47ab8] btrfs_ioctl at ffffffffa02ae668 [btrfs]
#15 [ffffc90007d47d40] __x64_sys_ioctl at ffffffff8171c09f
#16 [ffffc90007d47f38] do_syscall_64 at ffffffff82602a70
#17 [ffffc90007d47f50] entry_SYSCALL_64_after_hwframe at ffffffff8280007c

So, it's contended here:

  #4 [ffffc90007d47318] down_read_nested at ffffffff81264da4
    ffffc90007d47320: [ffff88811a30bc20:btrfs_extent_buffer] 0000000000000000 
    ffffc90007d47330: 0000000000000000 ffffc90007d47360 
    ffffc90007d47340: __btrfs_tree_read_lock+40 [ffff88811a30bc20:btrfs_extent_buffer] 
    ffffc90007d47350: ffffed102e902800 dffffc0000000000 
    ffffc90007d47360: ffffc90007d47388 btrfs_read_lock_root_node+71 

Thread 5063 is trying to read lock this extent buffer.

crash> struct extent_buffer ffff88811a30bc20
struct extent_buffer {
  start = 1803321344, 
...
  lock_owner = 5065, 
...

The lock is owned by thread 5065.

crash> bt 5065
PID: 5065   TASK: ffff88812a7f0000  CPU: 1   COMMAND: "fsstress"
 #0 [ffffc90007d66ab0] __schedule at ffffffff8260da25
 #1 [ffffc90007d66bb8] preempt_schedule_common at ffffffff8260f635
 #2 [ffffc90007d66bd8] __cond_resched at ffffffff8260f68d
 #3 [ffffc90007d66be8] btrfs_chunk_alloc at ffffffffa03cd50a [btrfs]
 #4 [ffffc90007d66c80] find_free_extent at ffffffffa01adfa2 [btrfs]
 #5 [ffffc90007d66e40] btrfs_reserve_extent at ffffffffa01bf7d0 [btrfs]
 #6 [ffffc90007d66ed0] btrfs_alloc_tree_block at ffffffffa01c074f [btrfs]
 #7 [ffffc90007d67070] alloc_tree_block_no_bg_flush at ffffffffa018d9e5 [btrfs]
 #8 [ffffc90007d670d0] __btrfs_cow_block at ffffffffa0194fb1 [btrfs]
 #9 [ffffc90007d67220] btrfs_cow_block at ffffffffa01960b5 [btrfs]
#10 [ffffc90007d672a0] btrfs_search_slot at ffffffffa01a15c7 [btrfs]
#11 [ffffc90007d67410] btrfs_lookup_file_extent at ffffffffa01ca05e [btrfs]
#12 [ffffc90007d674a8] btrfs_drop_extents at ffffffffa0233449 [btrfs]
#13 [ffffc90007d67738] btrfs_replace_file_extents at ffffffffa023762d [btrfs]
#14 [ffffc90007d678d8] btrfs_clone at ffffffffa03d674f [btrfs]
#15 [ffffc90007d67b20] btrfs_extent_same_range at ffffffffa03d6d38 [btrfs]
#16 [ffffc90007d67b68] btrfs_remap_file_range at ffffffffa03d7b68 [btrfs]
#17 [ffffc90007d67c60] vfs_dedupe_file_range_one at ffffffff8179f58b
#18 [ffffc90007d67cd0] vfs_dedupe_file_range at ffffffff8179fadd
#19 [ffffc90007d67d40] __x64_sys_ioctl at ffffffff8171c344
#20 [ffffc90007d67f38] do_syscall_64 at ffffffff82602a70
#21 [ffffc90007d67f50] entry_SYSCALL_64_after_hwframe at ffffffff8280007c

Again! Thread 5065 is busy-looping in the same loop in
btrfs_chunk_alloc().

* How to fix it?

I'm not sure how we can fix it without breaking the original intention
of commit eafa4fd0ad06. We might need to set space_info->chunk_alloc =
0 while in the wait_event(). But then, we also need to recheck
everything from the start of btrfs_chunk_alloc().

Or, we can commit the transaction before another chunk allocation if
its transaction_handle is waited?

Thanks,
