Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A84433C6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 17:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhKBQv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 12:51:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhKBQvl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 12:51:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D7D881FD29;
        Tue,  2 Nov 2021 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635871745;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PVxaBFAfRe69sytMCRql2hBuYPwuyINsz1jRD/97d4=;
        b=R2QFv17GJmfLglowLHlM2o1VGA4qJ+59J2xfwA4K9ne12nFVawHl2kEJ5lkjGvv0RT+xik
        t97eQDRkFJLdXVO3IhJJy61lmhStLW21b5ELGcE1GDOhmc1ihRBX+UrOkY42KGzONXp494
        XcKzhowDpPfCIJJrRc+0RNdwFUrDERM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635871745;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PVxaBFAfRe69sytMCRql2hBuYPwuyINsz1jRD/97d4=;
        b=Nm7Y1Esyhwk+brWCyPaLm7Y0oMiidozGbzZkvj1B5M+LPPOGgYToG0uHM5gRdZG/MvwNtr
        LsvNztjSBcWfRvAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CFB00A3B8A;
        Tue,  2 Nov 2021 16:49:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5CED2DA7A9; Tue,  2 Nov 2021 17:48:30 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:48:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
Subject: Re: [PATCH v3] btrfs: fix a check-integrity warning on write caching
 disabled disk
Message-ID: <20211102164830.GO20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
References: <20211027223254.8095-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027223254.8095-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 06:32:54AM +0800, Wang Yugui wrote:
> When a disk has write caching disabled, we skip submission of a bio
> with flush and sync requests before writing the superblock, since
> it's not needed. However when the integrity checker is enabled,
> this results in reports that there are metadata blocks referred
> by a superblock that were not properly flushed. So don't skip the
> bio submission only when the integrity checker is enabled
> for the sake of simplicity, since this is a debug tool and
> not meant for use in non-debug builds.
> 
> xfstest/btrfs/220 trigger a check-integrity warning like the following
> when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y and the disk with WCE=0.

Does this need the integrity checker to be also enabled by mount
options? I don't think compile time (ie the #ifdef) is enough, the
message is printed only when it's enabled based on check in
__btrfsic_submit_bio "if (!btrfsic_is_initialized) return", where the
rest of the function does all the verification.

>  btrfs: attempt to write superblock which references block M @5242880 (sdb2/5242880/0) which is not flushed out of disk's write cache (block flush_gen=1, dev->flush_gen=0)!
>  ------------[ cut here ]------------
>  WARNING: CPU: 28 PID: 843680 at fs/btrfs/check-integrity.c:2196 btrfsic_process_written_superblock+0x22a/0x2a0 [btrfs]
>  CPU: 28 PID: 843680 Comm: umount Not tainted 5.15.0-0.rc5.39.el8.x86_64 #1
>  Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
>  RIP: 0010:btrfsic_process_written_superblock+0x22a/0x2a0 [btrfs]
>  Code: 44 24 1c 83 f8 03 0f 85 7e fe ff ff 4c 8b 74 24 08 31 d2 48 89 ef 4c 89 f6 e8 82 f1 ff ff 89 c2 31 c0 83 fa ff 75 a1 89 04 24 <0f> 0b 48 89 ef e8 36 3f 01 00 8b 04 24 eb 8f 48 8b 40 60 48 89 04
>  RSP: 0018:ffffb642afb47940 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
>  RDX: 00000000ffffffff RSI: ffff8b722fc97d00 RDI: ffff8b722fc97d00
>  RBP: ffff8b5601c00000 R08: 0000000000000000 R09: c0000000ffff7fff
>  R10: 0000000000000001 R11: ffffb642afb476f8 R12: ffffffffffffffff
>  R13: ffffb642afb47974 R14: ffff8b5499254c00 R15: 0000000000000003
>  FS:  00007f00a06d4080(0000) GS:ffff8b722fc80000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fff5cff5ff0 CR3: 00000001c0c2a006 CR4: 00000000001706e0
>  Call Trace:
>   btrfsic_process_written_block+0x2f7/0x850 [btrfs]
>   __btrfsic_submit_bio.part.19+0x310/0x330 [btrfs]
>   ? bio_associate_blkg_from_css+0xa4/0x2c0
>   btrfsic_submit_bio+0x18/0x30 [btrfs]
>   write_dev_supers+0x81/0x2a0 [btrfs]
>   ? find_get_pages_range_tag+0x219/0x280
>   ? pagevec_lookup_range_tag+0x24/0x30
>   ? __filemap_fdatawait_range+0x6d/0xf0
>   ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>   ? find_first_extent_bit+0x9b/0x160 [btrfs]
>   ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>   write_all_supers+0x1b3/0xa70 [btrfs]
>   ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>   btrfs_commit_transaction+0x59d/0xac0 [btrfs]
>   close_ctree+0x11d/0x339 [btrfs]
>   generic_shutdown_super+0x71/0x110
>   kill_anon_super+0x14/0x30
>   btrfs_kill_super+0x12/0x20 [btrfs]
>   deactivate_locked_super+0x31/0x70
>   cleanup_mnt+0xb8/0x140
>   task_work_run+0x6d/0xb0
>   exit_to_user_mode_prepare+0x1f0/0x200
>   syscall_exit_to_user_mode+0x12/0x30
>   do_syscall_64+0x46/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f009f711dfb
>  Code: 20 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d 20 2c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fff5cff7928 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
>  RAX: 0000000000000000 RBX: 000055b68c6c9970 RCX: 00007f009f711dfb
>  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055b68c6c9b50
>  RBP: 0000000000000000 R08: 000055b68c6ca900 R09: 00007f009f795580
>  R10: 0000000000000000 R11: 0000000000000246 R12: 000055b68c6c9b50
>  R13: 00007f00a04bf184 R14: 0000000000000000 R15: 00000000ffffffff
>  ---[ end trace 2c4b82abcef9eec4 ]---
>  S-65536(sdb2/65536/1)
>   --> 
>  M-1064960(sdb2/1064960/1)
> 
> Reviewed-by: Filipe Manana <fdmanana@gmail.com>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
> Changes since v2:
> - add the whole Call Trace:
> Changes since v1:
> - update the changelog/code comment. (Filipe Manana)
> - var(struct request_queue *q) is only needed when
>    !CONFIG_BTRFS_FS_CHECK_INTEGRITY
> ---
>  fs/btrfs/disk-io.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 355ea88d5c5f..4ef06d0555b0 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3968,11 +3968,23 @@ static void btrfs_end_empty_barrier(struct bio *bio)
>   */
>  static void write_dev_flush(struct btrfs_device *device)
>  {
> -	struct request_queue *q = bdev_get_queue(device->bdev);
>  	struct bio *bio = device->flush_bio;
>  
> +	#ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> +	/*
> +	* When a disk has write caching disabled, we skip submission of a bio
> +	* with flush and sync requests before writing the superblock, since
> +	* it's not needed. However when the integrity checker is enabled,
> +	* this results in reports that there are metadata blocks referred
> +	* by a superblock that were not properly flushed. So don't skip the
> +	* bio submission only when the integrity checker is enabled
> +	* for the sake of simplicity, since this is a debug tool and
> +	* not meant for use in non-debug builds.
> +	*/
> +	struct request_queue *q = bdev_get_queue(device->bdev);
>  	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
>  		return;
> +	#endif
>  
>  	bio_reset(bio);
>  	bio->bi_end_io = btrfs_end_empty_barrier;
> -- 
> 2.32.0
