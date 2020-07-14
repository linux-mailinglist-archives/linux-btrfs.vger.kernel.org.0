Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8A21F86B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 19:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgGNRne (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 13:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:34876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbgGNRnc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 13:43:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBB08AE2B;
        Tue, 14 Jul 2020 17:43:32 +0000 (UTC)
Subject: Re: [RFC] btrfs: volumes: Drop chunk_mutex lock/unlock on
 btrfs_read_chunk_tree
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200714172153.12956-1-marcos@mpdesouza.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 xsFNBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABzSJOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuZGU+wsF4BBMBAgAiBQJYijkSAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRBxvoJG5T8oV/B6D/9a8EcRPdHg8uLEPywuJR8URwXzkofT5bZE
 IfGF0Z+Lt2ADe+nLOXrwKsamhweUFAvwEUxxnndovRLPOpWerTOAl47lxad08080jXnGfYFS
 Dc+ew7C3SFI4tFFHln8Y22Q9075saZ2yQS1ywJy+TFPADIprAZXnPbbbNbGtJLoq0LTiESnD
 w/SUC6sfikYwGRS94Dc9qO4nWyEvBK3Ql8NkoY0Sjky3B0vL572Gq0ytILDDGYuZVo4alUs8
 LeXS5ukoZIw1QYXVstDJQnYjFxYgoQ5uGVi4t7FsFM/6ykYDzbIPNOx49Rbh9W4uKsLVhTzG
 BDTzdvX4ARl9La2kCQIjjWRg+XGuBM5rxT/NaTS78PXjhqWNYlGc5OhO0l8e5DIS2tXwYMDY
 LuHYNkkpMFksBslldvNttSNei7xr5VwjVqW4vASk2Aak5AleXZS+xIq2FADPS/XSgIaepyTV
 tkfnyreep1pk09cjfXY4A7qpEFwazCRZg9LLvYVc2M2eFQHDMtXsH59nOMstXx2OtNMcx5p8
 0a5FHXE/HoXz3p9bD0uIUq6p04VYOHsMasHqHPbsMAq9V2OCytJQPWwe46bBjYZCOwG0+x58
 fBFreP/NiJNeTQPOa6FoxLOLXMuVtpbcXIqKQDoEte9aMpoj9L24f60G4q+pL/54ql2VRscK
 d87BTQRYigc+ARAAyJSq9EFk28++SLfg791xOh28tLI6Yr8wwEOvM3wKeTfTZd+caVb9gBBy
 wxYhIopKlK1zq2YP7ZjTP1aPJGoWvcQZ8fVFdK/1nW+Z8/NTjaOx1mfrrtTGtFxVBdSCgqBB
 jHTnlDYV1R5plJqK+ggEP1a0mr/rpQ9dFGvgf/5jkVpRnH6BY0aYFPprRL8ZCcdv2DeeicOO
 YMobD5g7g/poQzHLLeT0+y1qiLIFefNABLN06Lf0GBZC5l8hCM3Rpb4ObyQ4B9PmL/KTn2FV
 Xq/c0scGMdXD2QeWLePC+yLMhf1fZby1vVJ59pXGq+o7XXfYA7xX0JsTUNxVPx/MgK8aLjYW
 hX+TRA4bCr4uYt/S3ThDRywSX6Hr1lyp4FJBwgyb8iv42it8KvoeOsHqVbuCIGRCXqGGiaeX
 Wa0M/oxN1vJjMSIEVzBAPi16tztL/wQtFHJtZAdCnuzFAz8ue6GzvsyBj97pzkBVacwp3/Mw
 qbiu7sDz7yB0d7J2tFBJYNpVt/Lce6nQhrvon0VqiWeMHxgtQ4k92Eja9u80JDaKnHDdjdwq
 FUikZirB28UiLPQV6PvCckgIiukmz/5ctAfKpyYRGfez+JbAGl6iCvHYt/wAZ7Oqe/3Cirs5
 KhaXBcMmJR1qo8QH8eYZ+qhFE3bSPH446+5oEw8A9v5oonKV7zMAEQEAAcLBXwQYAQIACQUC
 WIoHPgIbDAAKCRBxvoJG5T8oV1pyD/4zdXdOL0lhkSIjJWGqz7Idvo0wjVHSSQCbOwZDWNTN
 JBTP0BUxHpPu/Z8gRNNP9/k6i63T4eL1xjy4umTwJaej1X15H8Hsh+zakADyWHadbjcUXCkg
 OJK4NsfqhMuaIYIHbToi9K5pAKnV953xTrK6oYVyd/Rmkmb+wgsbYQJ0Ur1Ficwhp6qU1CaJ
 mJwFjaWaVgUERoxcejL4ruds66LM9Z1Qqgoer62ZneID6ovmzpCWbi2sfbz98+kW46aA/w8r
 7sulgs1KXWhBSv5aWqKU8C4twKjlV2XsztUUsyrjHFj91j31pnHRklBgXHTD/pSRsN0UvM26
 lPs0g3ryVlG5wiZ9+JbI3sKMfbdfdOeLxtL25ujs443rw1s/PVghphoeadVAKMPINeRCgoJH
 zZV/2Z/myWPRWWl/79amy/9MfxffZqO9rfugRBORY0ywPHLDdo9Kmzoxoxp9w3uTrTLZaT9M
 KIuxEcV8wcVjr+Wr9zRl06waOCkgrQbTPp631hToxo+4rA1jiQF2M80HAet65ytBVR2pFGZF
 zGYYLqiG+mpUZ+FPjxk9kpkRYz61mTLSY7tuFljExfJWMGfgSg1OxfLV631jV1TcdUnx+h3l
 Sqs2vMhAVt14zT8mpIuu2VNxcontxgVr1kzYA/tQg32fVRbGr449j1gw57BV9i0vww==
Message-ID: <93d4e5d9-cd4b-f8ea-19f5-50feaf89fdc3@suse.com>
Date:   Tue, 14 Jul 2020 20:43:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714172153.12956-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.07.20 г. 20:21 ч., Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> There is a lockdep report when running xfstests btrfs/161 (seed + sprout
> devices) related to chunk_mutex:
> 

For whatever reason this submission seems garbled. In any case my
proposal was to replace the chunk mutex with FS_EXCL_OP in
btrfs_read_chunk_tree which you haven't done. You simply remove the
chunk mutex.


> ======================================================
> WARNING: possible circular locking dependency detected
> 5.8.0-rc4-default #504 Not tainted
> ------------------------------------------------------
> mount/454 is trying to acquire lock:
> ffff8881133058e8 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x4d/0x340
> 
> but task is already holding lock:
> ffff888112010988 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0xcc/0x600
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x139/0x13e0
>        btrfs_init_new_device+0x1ed1/0x3c50
>        btrfs_ioctl+0x19b4/0x8130
>        ksys_ioctl+0xa9/0xf0
>        __x64_sys_ioctl+0x6f/0xb0
>        do_syscall_64+0x50/0xd0
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
>        __lock_acquire+0x2df6/0x4da0
>        lock_acquire+0x176/0x820
>        __mutex_lock+0x139/0x13e0
>        clone_fs_devices+0x4d/0x340
>        read_one_dev+0xa5c/0x13e0
>        btrfs_read_chunk_tree+0x480/0x600
>        open_ctree+0x244b/0x450d
>        btrfs_mount_root.cold.80+0x10/0x129
>        legacy_get_tree+0xff/0x1f0
>        vfs_get_tree+0x83/0x250
>        fc_mount+0xf/0x90
>        vfs_kern_mount.part.47+0x5c/0x80
>        btrfs_mount+0x215/0xbcf
>        legacy_get_tree+0xff/0x1f0
>        vfs_get_tree+0x83/0x250
>        do_mount+0x106d/0x16f0
>        __x64_sys_mount+0x162/0x1b0
>        do_syscall_64+0x50/0xd0
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&fs_info->chunk_mutex);
>                                lock(&fs_devs->device_list_mutex);
>                                lock(&fs_info->chunk_mutex);
>   lock(&fs_devs->device_list_mutex);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by mount/454:
>  #0: ffff8881119340e8 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super.isra.21+0x183/0x990
>  #1: ffffffff83b260d0 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0xb6/0x600
>  #2: ffff888112010988 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0xcc/0x600
> 
> stack backtrace:
> CPU: 3 PID: 454 Comm: mount Not tainted 5.8.0-rc4-default #504
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  dump_stack+0x9d/0xe0
>  check_noncircular+0x351/0x410
>  ? print_circular_bug.isra.41+0x360/0x360
>  ? mark_lock+0x12d/0x14d0
>  ? rcu_read_unlock+0x40/0x40
>  ? sched_clock+0x5/0x10
>  ? sched_clock_cpu+0x18/0x170
>  ? sched_clock_cpu+0x18/0x170
>  __lock_acquire+0x2df6/0x4da0
>  ? lockdep_hardirqs_on_prepare+0x540/0x540
>  ? _raw_spin_unlock_irqrestore+0x3e/0x50
>  ? trace_hardirqs_on+0x20/0x170
>  ? stack_depot_save+0x260/0x470
>  lock_acquire+0x176/0x820
>  ? clone_fs_devices+0x4d/0x340
>  ? btrfs_mount_root.cold.80+0x10/0x129
>  ? rcu_read_unlock+0x40/0x40
>  ? vfs_kern_mount.part.47+0x5c/0x80
>  ? btrfs_mount+0x215/0xbcf
>  ? legacy_get_tree+0xff/0x1f0
>  ? vfs_get_tree+0x83/0x250
>  ? do_mount+0x106d/0x16f0
>  ? __x64_sys_mount+0x162/0x1b0
>  ? do_syscall_64+0x50/0xd0
>  __mutex_lock+0x139/0x13e0
>  ? clone_fs_devices+0x4d/0x340
>  ? clone_fs_devices+0x4d/0x340
>  ? mark_held_locks+0xb7/0x120
>  ? mutex_lock_io_nested+0x12a0/0x12a0
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? lockdep_init_map_waits+0x29f/0x810
>  ? lockdep_init_map_waits+0x29f/0x810
>  ? debug_mutex_init+0x31/0x60
>  ? clone_fs_devices+0x4d/0x340
>  clone_fs_devices+0x4d/0x340
>  ? read_extent_buffer+0x15b/0x2a0
>  read_one_dev+0xa5c/0x13e0
>  ? split_leaf+0xef0/0xef0
>  ? read_one_chunk+0xb20/0xb20
>  ? btrfs_get_token_32+0x730/0x730
>  ? memcpy+0x38/0x60
>  ? read_extent_buffer+0x15b/0x2a0
>  btrfs_read_chunk_tree+0x480/0x600
>  ? btrfs_check_rw_degradable+0x340/0x340
>  ? btrfs_root_node+0x2d/0x240
>  ? memcpy+0x38/0x60
>  ? read_extent_buffer+0x15b/0x2a0
>  ? btrfs_root_node+0x2d/0x240
>  open_ctree+0x244b/0x450d
>  ? close_ctree+0x61c/0x61c
>  ? sget+0x328/0x400
>  btrfs_mount_root.cold.80+0x10/0x129
>  ? parse_rescue_options+0x260/0x260
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? kfree+0x2e2/0x330
>  ? parse_rescue_options+0x260/0x260
>  legacy_get_tree+0xff/0x1f0
>  vfs_get_tree+0x83/0x250
>  fc_mount+0xf/0x90
>  vfs_kern_mount.part.47+0x5c/0x80
>  btrfs_mount+0x215/0xbcf
>  ? check_object+0xb3/0x2c0
>  ? btrfs_get_subvol_name_from_objectid+0x7f0/0x7f0
>  ? ___slab_alloc+0x4e5/0x570
>  ? vfs_parse_fs_string+0xc0/0x100
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? kfree+0x2e2/0x330
>  ? btrfs_get_subvol_name_from_objectid+0x7f0/0x7f0
>  ? legacy_get_tree+0xff/0x1f0
>  legacy_get_tree+0xff/0x1f0
>  vfs_get_tree+0x83/0x250
>  do_mount+0x106d/0x16f0
>  ? lock_downgrade+0x720/0x720
>  ? copy_mount_string+0x20/0x20
>  ? _copy_from_user+0xbe/0x100
>  ? memdup_user+0x47/0x70
>  __x64_sys_mount+0x162/0x1b0
>  do_syscall_64+0x50/0xd0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f82dd1583ca
> Code: Bad RIP value.
> RSP: 002b:00007ffcf6935fc8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000562f10678500 RCX: 00007f82dd1583ca
> RDX: 0000562f1067f8e0 RSI: 0000562f1067b3f0 RDI: 0000562f106786e0
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000c0ed0000 R11: 0000000000000202 R12: 0000562f106786e0
> R13: 0000562f1067f8e0 R14: 0000000000000000 R15: 00007f82dd6798a4
> 
> In volumes.c there are comments stating that chunk_mutex is used to
> protect add/remove chunks, trim or add/remove devices. Since
> btrfs_read_chunk_tree is only called on mount, and trim and chunk alloc
> cannot happen at mount time, it's safe to remove this lock/unlock.
> 
> Also, btrfs_ioctl_{add|rm}_dev calls set BTRFS_FS_EXCL_OP, which should
> be safe.
> 
> Dropping the mutex lock/unlock solves the lockdep warning.
> 
> Suggested-by: Nokolay Borisov <nborisov@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/volumes.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c7a3d4d730a3..94cbdadd9d26 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7033,7 +7033,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>  	 * otherwise we don't need it.
>  	 */
>  	mutex_lock(&uuid_mutex);
> -	mutex_lock(&fs_info->chunk_mutex);
>  
>  	/*
>  	 * Read all device items, and then all the chunk items. All
> @@ -7100,7 +7099,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>  	}
>  	ret = 0;
>  error:
> -	mutex_unlock(&fs_info->chunk_mutex);
>  	mutex_unlock(&uuid_mutex);
>  
>  	btrfs_free_path(path);
> 
