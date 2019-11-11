Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82FFF7E66
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 20:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKKTD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 14:03:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:52816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729869AbfKKSpb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 13:45:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C9C9AD19;
        Mon, 11 Nov 2019 18:45:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6C6EDA7AF; Mon, 11 Nov 2019 19:45:34 +0100 (CET)
Date:   Mon, 11 Nov 2019 19:45:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix log context list corruption after rename
 exchange operation
Message-ID: <20191111184534.GU3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191108161156.2342-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108161156.2342-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 08, 2019 at 04:11:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During rename exchange we might have successfully log the new name in the
> source root's log tree, in which case we leave our log context (allocated
> on stack) in the root's list of log contextes. However we might fail to
> log the new name in the destination root, in which case we fallback to
> a transaction commit later and never sync the log of the source root,
> which causes the source root log context to remain in the list of log
> contextes. This later causes invalid memory accesses because the context
> was allocated on stack and after rename exchange finishes the stack gets
> reused and overwritten for other purposes.
> 
> The kernel's linked list corruption detector (CONFIG_DEBUG_LIST=y) can
> detect this and report something like the following:
> 
>   [  691.489929] ------------[ cut here ]------------
>   [  691.489947] list_add corruption. prev->next should be next (ffff88819c944530), but was ffff8881c23f7be4. (prev=ffff8881c23f7a38).
>   [  691.489967] WARNING: CPU: 2 PID: 28933 at lib/list_debug.c:28 __list_add_valid+0x95/0xe0
>   (...)
>   [  691.489998] CPU: 2 PID: 28933 Comm: fsstress Not tainted 5.4.0-rc6-btrfs-next-62 #1
>   [  691.490001] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>   [  691.490003] RIP: 0010:__list_add_valid+0x95/0xe0
>   (...)
>   [  691.490007] RSP: 0018:ffff8881f0b3faf8 EFLAGS: 00010282
>   [  691.490010] RAX: 0000000000000000 RBX: ffff88819c944530 RCX: 0000000000000000
>   [  691.490011] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffffa2c497e0
>   [  691.490013] RBP: ffff8881f0b3fe68 R08: ffffed103eaa4115 R09: ffffed103eaa4114
>   [  691.490015] R10: ffff88819c944000 R11: ffffed103eaa4115 R12: 7fffffffffffffff
>   [  691.490016] R13: ffff8881b4035610 R14: ffff8881e7b84728 R15: 1ffff1103e167f7b
>   [  691.490019] FS:  00007f4b25ea2e80(0000) GS:ffff8881f5500000(0000) knlGS:0000000000000000
>   [  691.490021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [  691.490022] CR2: 00007fffbb2d4eec CR3: 00000001f2a4a004 CR4: 00000000003606e0
>   [  691.490025] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [  691.490027] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [  691.490029] Call Trace:
>   [  691.490058]  btrfs_log_inode_parent+0x667/0x2730 [btrfs]
>   [  691.490083]  ? join_transaction+0x24a/0xce0 [btrfs]
>   [  691.490107]  ? btrfs_end_log_trans+0x80/0x80 [btrfs]
>   [  691.490111]  ? dget_parent+0xb8/0x460
>   [  691.490116]  ? lock_downgrade+0x6b0/0x6b0
>   [  691.490121]  ? rwlock_bug.part.0+0x90/0x90
>   [  691.490127]  ? do_raw_spin_unlock+0x142/0x220
>   [  691.490151]  btrfs_log_dentry_safe+0x65/0x90 [btrfs]
>   [  691.490172]  btrfs_sync_file+0x9f1/0xc00 [btrfs]
>   [  691.490195]  ? btrfs_file_write_iter+0x1800/0x1800 [btrfs]
>   [  691.490198]  ? rcu_read_lock_any_held.part.11+0x20/0x20
>   [  691.490204]  ? __do_sys_newstat+0x88/0xd0
>   [  691.490207]  ? cp_new_stat+0x5d0/0x5d0
>   [  691.490218]  ? do_fsync+0x38/0x60
>   [  691.490220]  do_fsync+0x38/0x60
>   [  691.490224]  __x64_sys_fdatasync+0x32/0x40
>   [  691.490228]  do_syscall_64+0x9f/0x540
>   [  691.490233]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [  691.490235] RIP: 0033:0x7f4b253ad5f0
>   (...)
>   [  691.490239] RSP: 002b:00007fffbb2d6078 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
>   [  691.490242] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4b253ad5f0
>   [  691.490244] RDX: 00007fffbb2d5fe0 RSI: 00007fffbb2d5fe0 RDI: 0000000000000003
>   [  691.490245] RBP: 000000000000000d R08: 0000000000000001 R09: 00007fffbb2d608c
>   [  691.490247] R10: 00000000000002e8 R11: 0000000000000246 R12: 00000000000001f4
>   [  691.490248] R13: 0000000051eb851f R14: 00007fffbb2d6120 R15: 00005635a498bda0
> 
> This started happening recently when running some test cases from fstests
> like btrfs/004 for example, because support for rename exchange was added
> last week to fsstress from fstests.
> 
> So fix this by deleting the log context for the source root from the list
> if we have logged the new name in the source root.
> 
> Reported-by: Su Yue <Damenly_Su@gmx.com>
> Fixes: d4682ba03ef618 ("Btrfs: sync log after logging new name")
> CC: stable@vger.kernel.org # 4.19+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, added to misc-next, most likely to be sent in a late 5.4-rc pull
request too.
