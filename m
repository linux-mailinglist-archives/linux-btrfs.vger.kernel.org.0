Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9634095F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 16:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhCRPzd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 11:55:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:51086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCRPzD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 11:55:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 209E4AC24;
        Thu, 18 Mar 2021 15:55:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89F5BDA6E2; Thu, 18 Mar 2021 16:52:59 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:52:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix sleep while in non-sleep context during
 qgroup removal
Message-ID: <20210318155259.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <206d121e2e2b609ffe31217e6d90bfabe1c4e121.1616066404.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206d121e2e2b609ffe31217e6d90bfabe1c4e121.1616066404.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 18, 2021 at 11:22:05AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> While removing a qgroup's sysfs entry we end up taking the kernfs_mutex,
> through kobject_del(), while holding the fs_info->qgroup_lock spinlock,
> producing the following trace:
> 
> [  821.843637] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
> [  821.843641] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 28214, name: podman
> [  821.843644] CPU: 3 PID: 28214 Comm: podman Tainted: G        W         5.11.6 #15
> [  821.843646] Hardware name: Dell Inc. PowerEdge R330/084XW4, BIOS 2.11.0 12/08/2020
> [  821.843647] Call Trace:
> [  821.843650]  dump_stack+0xa1/0xfb
> [  821.843656]  ___might_sleep+0x144/0x160
> [  821.843659]  mutex_lock+0x17/0x40
> [  821.843662]  kernfs_remove_by_name_ns+0x1f/0x80
> [  821.843666]  sysfs_remove_group+0x7d/0xe0
> [  821.843668]  sysfs_remove_groups+0x28/0x40
> [  821.843670]  kobject_del+0x2a/0x80
> [  821.843672]  btrfs_sysfs_del_one_qgroup+0x2b/0x40 [btrfs]
> [  821.843685]  __del_qgroup_rb+0x12/0x150 [btrfs]
> [  821.843696]  btrfs_remove_qgroup+0x288/0x2a0 [btrfs]
> [  821.843707]  btrfs_ioctl+0x3129/0x36a0 [btrfs]
> [  821.843717]  ? __mod_lruvec_page_state+0x5e/0xb0
> [  821.843719]  ? page_add_new_anon_rmap+0xbc/0x150
> [  821.843723]  ? kfree+0x1b4/0x300
> [  821.843725]  ? mntput_no_expire+0x55/0x330
> [  821.843728]  __x64_sys_ioctl+0x5a/0xa0
> [  821.843731]  do_syscall_64+0x33/0x70
> [  821.843733]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  821.843736] RIP: 0033:0x4cd3fb
> [  821.843739] Code: fa ff eb bd e8 86 8b fa ff e9 61 ff ff ff cc e8 fb 55 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [  821.843741] RSP: 002b:000000c000906b20 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  821.843744] RAX: ffffffffffffffda RBX: 000000c000050000 RCX: 00000000004cd3fb
> [  821.843745] RDX: 000000c000906b98 RSI: 000000004010942a RDI: 000000000000000f
> [  821.843747] RBP: 000000c000907cd0 R08: 000000c000622901 R09: 0000000000000000
> [  821.843748] R10: 000000c000d992c0 R11: 0000000000000206 R12: 000000000000012d
> [  821.843749] R13: 000000000000012c R14: 0000000000000200 R15: 0000000000000049
> 
> Fix this by removing the qgroup sysfs entry while not holding the spinlock,
> since the spinlock is only meant for protection of the qgroup rbtree.
> 
> Reported-by: Stuart Shelton <srcshelton@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/7A5485BB-0628-419D-A4D3-27B1AF47E25A@gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, with the Fixes: tag, thanks.
