Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0437EF94
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 01:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhELXN6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 19:13:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1392438AbhELWeI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 18:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C4EAAFC1;
        Wed, 12 May 2021 22:32:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 528BDDA919; Thu, 13 May 2021 00:30:28 +0200 (CEST)
Date:   Thu, 13 May 2021 00:30:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: zoned: sanity check zone type
Message-ID: <20210512223028.GC7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
 <20210504083024.28072-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504083024.28072-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 04, 2021 at 10:30:23AM +0200, Johannes Thumshirn wrote:
> From: Naohiro Aota <naohiro.aota@wdc.com>
> 
> The xfstests test case generic/475 creates a dm-linear device that gets
> changed to a dm-error device. This leads to errors in loading the block
> group's zone information when running on a zoned file system, ultimately
> resulting in a list corruption. When running on a kernel with list
> debugging enabled this leads to the following crash.
> 
>  BTRFS: error (device dm-2) in cleanup_transaction:1953: errno=-5 IO failure
>  kernel BUG at lib/list_debug.c:54!
>  invalid opcode: 0000 [#1] SMP PTI
>  CPU: 1 PID: 2433 Comm: umount Tainted: G        W         5.12.0+ #1018
>  RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
>  RSP: 0018:ffffc90001473df0 EFLAGS: 00010296
>  RAX: 0000000000000054 RBX: ffff8881038fd000 RCX: ffffc90001473c90
>  RDX: 0000000100001a31 RSI: 0000000000000003 RDI: 0000000000000003
>  RBP: ffff888308871108 R08: 0000000000000003 R09: 0000000000000001
>  R10: 3961373532383838 R11: 6666666620736177 R12: ffff888308871000
>  R13: ffff8881038fd088 R14: ffff8881038fdc78 R15: dead000000000100
>  FS:  00007f353c9b1540(0000) GS:ffff888627d00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f353cc2c710 CR3: 000000018e13c000 CR4: 00000000000006a0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   btrfs_free_block_groups+0xc9/0x310 [btrfs]
>   close_ctree+0x2ee/0x31a [btrfs]
>   ? call_rcu+0x8f/0x270
>   ? mutex_lock+0x1c/0x40
>   generic_shutdown_super+0x67/0x100
>   kill_anon_super+0x14/0x30
>   btrfs_kill_super+0x12/0x20 [btrfs]
>   deactivate_locked_super+0x31/0x90
>   cleanup_mnt+0x13e/0x1b0
>   task_work_run+0x63/0xb0
>   exit_to_user_mode_loop+0xd9/0xe0
>   exit_to_user_mode_prepare+0x3e/0x60
>   syscall_exit_to_user_mode+0x1d/0x50
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> As dm-error has no support for zones, btrfs will run it's zone emulation
> mode on this device. The zone emulation mode emulates conventional zones,
> so bail out if the zone bitmap that gets populated on mount sees the zone
> as sequential while we're thinking it's a conventional zone when creating
> a block group.
> 
> Note: this scenario is unlikely in a real wold application and can only
> happen by this (ab)use of device-mapper targets.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> [ jth: commit message and error messages ]
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 70b23a0d03b1..6edf88580f47 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1126,6 +1126,15 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>  			goto out;
>  		}
>  
> +		if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
> +			btrfs_err(fs_info,
> +				  "zoned: unexpected conventional zone: %llu on device %s (devid %llu)",
> +				  zone.start << SECTOR_SHIFT,
> +				  rcu_str_deref(device->name), device->devid);
> +			ret = -EIO;

I messed up the patch queues when sending the pull request and the V1
got merged, without the message. I got this diff after rebase of
misc-next

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1127,6 +1127,10 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
                }

                if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
+                       btrfs_err_in_rcu(fs_info,
+       "zoned: unexpected conventional zone %llu on device %s (devid %llu)",
+                               zone.start << SECTOR_SHIFT,
+                               rcu_str_deref(device->name), device->devid);
                        ret = -EIO;
                        goto out;
---

I can update the changelog to describe what happened and that we want
this message and you don't need to resend anything, or you can send it
but because that it's my fault I'd rather do that but wanted to let you
know.
