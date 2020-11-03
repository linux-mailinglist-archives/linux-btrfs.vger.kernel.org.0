Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637E72A4F03
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 19:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgKCSiA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 13:38:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:47938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCSh7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 13:37:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEC8DAB8F;
        Tue,  3 Nov 2020 18:37:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 318BBDA7D2; Tue,  3 Nov 2020 19:36:18 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:36:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
Subject: Re: [PATCH RESEND v2] btrfs: fix devid 0 without a replace item by
 failing the mount
Message-ID: <20201103183618.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <cover.1604009248.git.anand.jain@oracle.com>
 <d0b5790792b8b826504dd239ad9efc514f3d9109.1604009248.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b5790792b8b826504dd239ad9efc514f3d9109.1604009248.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 30, 2020 at 06:53:56AM +0800, Anand Jain wrote:
> If there is a BTRFS_DEV_REPLACE_DEVID without a replace item, then
> it means some device is trying to attack or may be corrupted. Fail the
> mount so that the user can remove the attacking or fix the corrupted
> device.
> 
> As of now if BTRFS_DEV_REPLACE_DEVID is present without the replace
> item, in __btrfs_free_extra_devids() we determine that there is an
> extra device, and free those extra devices but continue to mount the
> device.
> However, we were wrong in keeping tack of the rw_devices so the syzbot
> testcase failed as below [1].
> 
> [1]
> WARNING: CPU: 1 PID: 3612 at fs/btrfs/volumes.c:1166 close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 3612 Comm: syz-executor.2 Not tainted 5.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x198/0x1fd lib/dump_stack.c:118
>  panic+0x347/0x7c0 kernel/panic.c:231
>  __warn.cold+0x20/0x46 kernel/panic.c:600
>  report_bug+0x1bd/0x210 lib/bug.c:198
>  handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
> Code: 0f b6 04 02 84 c0 74 02 7e 33 48 8b 44 24 18 c6 80 30 01 00 00 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 99 ce 6a fe <0f> 0b e9 71 ff ff ff e8 8d ce 6a fe 0f 0b e9 20 ff ff ff e8 d1 d5

Unless we need the Code: line to understand what happend, you can remove
it from the changelog

> RSP: 0018:ffffc900091777e0 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffffffffffffffff RCX: ffffc9000c8b7000
> RDX: 0000000000040000 RSI: ffffffff83097f47 RDI: 0000000000000007
> RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880988a187f
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88809593a130
> R13: ffff88809593a1ec R14: ffff8880988a1908 R15: ffff88809593a050
>  close_fs_devices fs/btrfs/volumes.c:1193 [inline]
>  btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
>  open_ctree+0x4984/0x4a2d fs/btrfs/disk-io.c:3434
>  btrfs_fill_super fs/btrfs/super.c:1316 [inline]
>  btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672
> 
> The fix here is, when we determine that there isn't a replace item
> then fail the mount if there is a replace target device (devid 0).
> 
> Cc: josef@toxicpanda.com
> Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Depends on the patches
>  btrfs: drop never met condition of disk_total_bytes == 0
>  btrfs: fix btrfs_find_device unused arg seed

As this is a fix that could go to the master, the cleanups should
follow.

> If these patches aren't integrated yet, then please add the last arg in
> the function btrfs_find_device(). Any value is fine as it doesn't care.

Ok, fixed.

> fstest case will follow.
> 
> v2: changed title
>     old: btrfs: fix rw_devices count in __btrfs_free_extra_devids
> 
>     In btrfs_init_dev_replace() try to match the presence of replace_item
>     to the BTRFS_DEV_REPLACE_DEVID device. If fails then fail the
>     mount. So drop the similar check in __btrfs_free_extra_devids().
> 
>  fs/btrfs/dev-replace.c | 26 ++++++++++++++++++++++++--
>  fs/btrfs/volumes.c     | 26 +++++++-------------------
>  2 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index ffab2758f991..8b3935757dc1 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -91,6 +91,17 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>  	ret = btrfs_search_slot(NULL, dev_root, &key, path, 0, 0);
>  	if (ret) {
>  no_valid_dev_replace_entry_found:
> +		/*
> +		 * We don't have a replace item or it's corrupted.
> +		 * If there is a replace target, fail the mount.
> +		 */
> +		if (btrfs_find_device(fs_info->fs_devices,
> +				      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
> +			btrfs_err(fs_info,
> +			"found replace target device without a replace item");
> +			ret = -EIO;

This IMHO qualifies as a corruption so it should be EUCLEAN. The rest of
the function used EIO for error state but the code is from 2012 and we
used EIO instead.

> +			goto out;
> +		}
>  		ret = 0;
>  		dev_replace->replace_state =
>  			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
> @@ -143,8 +154,19 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>  	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
>  	case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
>  	case BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED:
> -		dev_replace->srcdev = NULL;
> -		dev_replace->tgtdev = NULL;
> +		/*
> +		 * We don't have an active replace item but if there is a
> +		 * replace target, fail the mount.
> +		 */
> +		if (btrfs_find_device(fs_info->fs_devices,
> +				      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
> +			btrfs_err(fs_info,
> +			"replace devid present without an active replace item");
> +			ret = -EIO;

Same here.

> +		} else {
> +			dev_replace->srcdev = NULL;
> +			dev_replace->tgtdev = NULL;
> +		}
>  		break;
>  	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
>  	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1b2742da5d4a..bb6f067f2fb9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1056,22 +1056,13 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>  			continue;
>  		}
>  
> -		if (device->devid == BTRFS_DEV_REPLACE_DEVID) {
> -			/*
> -			 * In the first step, keep the device which has
> -			 * the correct fsid and the devid that is used
> -			 * for the dev_replace procedure.
> -			 * In the second step, the dev_replace state is
> -			 * read from the device tree and it is known
> -			 * whether the procedure is really active or
> -			 * not, which means whether this device is
> -			 * used or whether it should be removed.
> -			 */
> -			if (step == 0 || test_bit(BTRFS_DEV_STATE_REPLACE_TGT,

This removes the use of step parameter so it can be removed from the
call chain too (separate patch).

Patch added to misc-next, thanks.
