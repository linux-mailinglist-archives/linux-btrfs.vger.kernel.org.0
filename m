Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964B131DE6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhBQRhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 12:37:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:38710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231905AbhBQRgR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 12:36:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9615B7B8;
        Wed, 17 Feb 2021 17:35:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D70BDA7C5; Wed, 17 Feb 2021 18:33:38 +0100 (CET)
Date:   Wed, 17 Feb 2021 18:33:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: fix possible deadlock on log sync
Message-ID: <20210217173337.GW1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <ba64e01fa8f13d10daebe1d8e24ad1a20de9b231.1613545566.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba64e01fa8f13d10daebe1d8e24ad1a20de9b231.1613545566.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 04:06:18PM +0900, Johannes Thumshirn wrote:
> Lockdep with fstests test-case btrfs/041 detected a unsafe locking
> scenario when we allocate the log node on a zoned filesystem.
> 
> btrfs/041
>  ============================================
>  WARNING: possible recursive locking detected
>  5.11.0-rc7+ #939 Not tainted
>  --------------------------------------------
>  xfs_io/698 is trying to acquire lock:
>  ffff88810cd673a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x3d1/0xee0 [btrfs]
> 
>  but task is already holding lock:
>  ffff88810b0fc3a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x313/0xee0 [btrfs]
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&root->log_mutex);
>    lock(&root->log_mutex);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>  2 locks held by xfs_io/698:
>   #0: ffff88810cd66620 (sb_internal){.+.+}-{0:0}, at: btrfs_sync_file+0x2c3/0x570 [btrfs]
>   #1: ffff88810b0fc3a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x313/0xee0 [btrfs]
> 
>  stack backtrace:
>  CPU: 0 PID: 698 Comm: xfs_io Not tainted 5.11.0-rc7+ #939
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>  Call Trace:
>   dump_stack+0x77/0x97
>   __lock_acquire.cold+0xb9/0x32a
>   lock_acquire+0xb5/0x400
>   ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
>   __mutex_lock+0x7b/0x8d0
>   ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
>   ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
>   ? find_first_extent_bit+0x9f/0x100 [btrfs]
>   ? __mutex_unlock_slowpath+0x35/0x270
>   btrfs_sync_log+0x3d1/0xee0 [btrfs]
>   btrfs_sync_file+0x3a8/0x570 [btrfs]
>   __x64_sys_fsync+0x34/0x60
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7f1e856b8ecb
>  Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 b3 f6 ff ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 11 f7 ff ff 8b 44

This line should be deleted from the stacktraces.

>  RSP: 002b:00007ffde89011b0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
>  RAX: ffffffffffffffda RBX: 0000557ef97886c0 RCX: 00007f1e856b8ecb
>  RDX: 0000000000000002 RSI: 0000557ef97886e0 RDI: 0000000000000003
>  RBP: 0000557ef97886e0 R08: 0000000000000000 R09: 0000000000000003
>  R10: fffffffffffff50e R11: 0000000000000293 R12: 0000000000000001
>  R13: 0000557ef97886c0 R14: 0000000000000001 R15: 0000557ef976e2a0
> 
> This happens, because we are taking the ->log_mutex albeit it has already
> been locked.
> 
> Also while at it, fix the bogus unlock of the tree_log_mutex in the error
> handling.
> 
> Fixes: 3ddebf27fcd3 ("btrfs: zoned: reorder log node allocation on zoned filesystem")
> Cc: Filipe Manana <fdmanana@suse.com>
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

With updated subject adde to misc-next, thanks.
