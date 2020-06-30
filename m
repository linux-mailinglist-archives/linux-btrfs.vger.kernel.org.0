Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C220FFE9
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 00:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgF3WKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 18:10:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgF3WKY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 18:10:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A790AB89;
        Tue, 30 Jun 2020 22:10:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90148DA781; Wed,  1 Jul 2020 00:10:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
Subject: BUG at fs/btrfs/relocation.c:794!
Date:   Wed,  1 Jul 2020 00:10:06 +0200
Message-Id: <20200630221006.17585-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've hit a crash in relocation I've never seen before.

[ 2129.210066] kernel BUG at fs/btrfs/relocation.c:794!
[ 2129.215268] invalid opcode: 0000 [#1] PREEMPT SMP
[ 2129.220114] CPU: 1 PID: 3303 Comm: btrfs Not tainted 5.8.0-rc3-git+ #638
[ 2129.220116] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
[ 2129.220265] RIP: 0010:create_reloc_root+0x214/0x260 [btrfs]
[ 2129.258760] RSP: 0018:ffffbe1e809b38b8 EFLAGS: 00010282
[ 2129.258763] RAX: 00000000ffffffef RBX: ffff988d577f9000 RCX: 0000000000000000
[ 2129.258765] RDX: 0000000000000001 RSI: ffffffff8e2a2580 RDI: ffff988d64aaa6a8
[ 2129.258766] RBP: ffff988d5dfcdc00 R08: 0000000000000000 R09: 0000000000000000
[ 2129.258767] R10: 0000000000000001 R11: 0000000000000000 R12: ffff988d0e02fa78
[ 2129.258769] R13: 0000000000000005 R14: ffff988d64fe8000 R15: ffff988d0e02fa78
[ 2129.258771] FS:  00007f82a612e8c0(0000) GS:ffff988d67000000(0000) knlGS:0000000000000000
[ 2129.258772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2129.258774] CR2: 000000000559d028 CR3: 000000020b289000 CR4: 00000000000006e0
[ 2129.258775] Call Trace:
[ 2129.258825]  btrfs_init_reloc_root+0xe8/0x120 [btrfs]
[ 2129.258862]  record_root_in_trans+0xae/0xd0 [btrfs]
[ 2129.258901]  btrfs_record_root_in_trans+0x51/0x70 [btrfs]
[ 2129.340388]  select_reloc_root+0x94/0x340 [btrfs]
[ 2129.340433]  do_relocation+0xda/0x7b0 [btrfs]
[ 2129.349854]  ? _raw_spin_unlock+0x1f/0x40
[ 2129.349898]  relocate_tree_blocks+0x336/0x670 [btrfs]
[ 2129.359325]  relocate_block_group+0x2f6/0x600 [btrfs]
[ 2129.359365]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
[ 2129.359408]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
[ 2129.375494]  __btrfs_balance+0x42c/0xce0 [btrfs]
[ 2129.375553]  btrfs_balance+0x66a/0xbe0 [btrfs]
[ 2129.375562]  ? kmem_cache_alloc_trace+0x19c/0x330
[ 2129.389852]  btrfs_ioctl_balance+0x298/0x350 [btrfs]
[ 2129.389887]  btrfs_ioctl+0x304/0x2490 [btrfs]
[ 2129.389898]  ? do_user_addr_fault+0x221/0x49c
[ 2129.404070]  ? sched_clock_cpu+0x15/0x140
[ 2129.404073]  ? do_user_addr_fault+0x221/0x49c
[ 2129.404079]  ? up_read+0x18/0x240
[ 2129.404086]  ? ksys_ioctl+0x68/0xa0
[ 2129.404091]  ksys_ioctl+0x68/0xa0
[ 2129.423308]  __x64_sys_ioctl+0x16/0x20
[ 2129.423312]  do_syscall_64+0x50/0xe0
[ 2129.423315]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2129.423318] RIP: 0033:0x7f82a51c6327
[ 2129.423319] Code: Bad RIP value.
[ 2129.423348] RSP: 002b:00007ffd32cf6218 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[ 2129.423367] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f82a51c6327
[ 2129.423368] RDX: 00007ffd32cf62a0 RSI: 00000000c4009420 RDI: 0000000000000003
[ 2129.423372] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[ 2129.423377] R10: 000000000fa99fa0 R11: 0000000000000206 R12: 00007ffd32cf8823
[ 2129.423379] R13: 00007ffd32cf62a0 R14: 0000000000000001 R15: 0000000000000000

Relevant code called from create_reloc_root:

        ret = btrfs_insert_root(trans, fs_info->tree_root,
                                &root_key, root_item);
        BUG_ON(ret)

and according to EAX, ret is -17 which is EEXIST.

I don't have a reproducer, the testing image has been filled by random git
checkouts, deduplicated by BEES, then tons of snapshots created until the
metadata got exhausted, some file deletion and balances.

This is the same image that led to the patch "btrfs: allow use of global block
reserve for balance item deletion", so this could have left it in some
intermediate state where the balance item was not removed and the reloc tree as
well.

There were a few unsuccessful mounts due to relocation recovery, that was
trying to debug but then it started to work.

The error happened with this 'fi df' saved after the balance start:

# btrfs fi df mnt
Data, single: total=80.01GiB, used=38.67GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=19.99GiB, used=19.46GiB
GlobalReserve, single: total=512.00MiB, used=44.00KiB

The error looks like a repeated relocation tree creation, which would point to
the unsuccesful balances or inconsistent state (balance item, reloc trees).
It's not a "typical" mix of operations but I'd appreciate any insights here.
