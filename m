Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C29AF76F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfIKIIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 04:08:19 -0400
Received: from mxc1.seznam.cz ([77.75.79.23]:58756 "EHLO mxc1.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfIKIIT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 04:08:19 -0400
X-Greylist: delayed 799 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 04:08:18 EDT
Received: from email.seznam.cz
        by email-smtpc10a.ko.seznam.cz (email-smtpc10a.ko.seznam.cz [10.53.11.45])
        id 6f18a9217f90131d6f128460;
        Wed, 11 Sep 2019 10:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1568189296; bh=Y0odnW9rjPSgnBjGiH1Dk1DhQB/OXGJZ38pJExJE0RU=;
        h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
         Content-Type:Content-Transfer-Encoding;
        b=S9Lj/p3q0FBpGEAvhprnDgSZazk2mEArOAJE5LGyjtF3LKQBUAhZ3W3KaAMB4iVaI
         zHniNkZOeXDnLaj5SvLfw9j+6T95cqZvhA+2hsktNXFDZILc3+yVepFodfqEw5ogVi
         D0vjZo4d7LWoDlE/Jb4ze3dzK8i9KCEk0OU/2CJc=
Received: from unknown ([::ffff:62.24.65.155])
        by email.seznam.cz (szn-ebox-4.5.361) with HTTP;
        Wed, 11 Sep 2019 09:54:52 +0200 (CEST)
From:   "Zdenek Sojka" <zsojka@seznam.cz>
To:     <linux-btrfs@vger.kernel.org>
Subject: =?utf-8?q?possible_circular_locking_dependency_detected_=28sb=5Fi?=
        =?utf-8?q?nternal/fs=5Freclaim=29?=
Date:   Wed, 11 Sep 2019 09:54:52 +0200 (CEST)
Message-Id: <GZb.2yo4.6GbOlvQ7LF7.1TUAXC@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.45)
X-Mailer: szn-ebox-4.5.361
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

this is my fourth attempt to post this message to the mailing list; this t=
ime, without any attached kernel config (because it has over 100KiB). I al=
so tried contacting the kernel btrfs maintainers directly by email, but th=
ey probably also didn't receive the message...

I am running kernel with lock debugging enabled since I am quite often enc=
ountering various lockups and hung tasks. Several of the problems have bee=
n fixed recently, but not all; I don't know if the following backtrace is =
related to the hangups, or if it is just a false positive.

$ uname -a
Linux zso 5.2.11-gentoo #2 SMP Fri Aug 30 07:18:03 CEST 2019 x86_64 Intel(=
R) Core(TM) i7-6700 CPU @ 3.40GHz GenuineIntel GNU/Linux

The kernel has a distro patchset applied (which should not affect this, bu=
t you can never say that for sure) and I am compiling at -O3 -fipa-pta -ma=
rch=3Dnative instead of default -O2 (gcc-8.3.0).

Please let me know if I can provide any more information.

Best regards,
Zdenek Sojka

The dmesg warning I recently triggered:

[30560.303721] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[30560.303722] WARNING: possible circular locking dependency detected
[30560.303723] 5.2.11-gentoo #2 Not tainted
[30560.303724] ------------------------------------------------------
[30560.303725] kswapd0/711 is trying to acquire lock:
[30560.303726] 000000007777a663 (sb_internal){.+.+}, at: start_transaction=
+0x3a8/0x500
[30560.303731]
but task is already holding lock:
[30560.303732] 000000000ba86300 (fs_reclaim){+.+.}, at: __fs_reclaim_acqui=
re+0x0/0x30
[30560.303735]
which lock already depends on the new lock.

[30560.303736]
the existing dependency chain (in reverse order) is:
[30560.303737]
-> #1 (fs_reclaim){+.+.}:
[30560.303740] kmem_cache_alloc+0x1f/0x1c0
[30560.303742] btrfs_alloc_inode+0x1f/0x260
[30560.303744] alloc_inode+0x16/0xa0
[30560.303745] new_inode+0xe/0xb0
[30560.303747] btrfs_new_inode+0x70/0x610
[30560.303749] btrfs_symlink+0xd0/0x420
[30560.303750] vfs_symlink+0x9c/0x100
[30560.303751] do_symlinkat+0x66/0xe0
[30560.303753] do_syscall_64+0x55/0x1c0
[30560.303756] entry_SYSCALL_64_after_hwframe+0x49/0xbe
[30560.303756]
-> #0 (sb_internal){.+.+}:
[30560.303758] __sb_start_write+0xf6/0x150
[30560.303759] start_transaction+0x3a8/0x500
[30560.303760] btrfs_commit_inode_delayed_inode+0x59/0x110
[30560.303761] btrfs_evict_inode+0x19e/0x4c0
[30560.303763] evict+0xbc/0x1f0
[30560.303763] inode_lru_isolate+0x113/0x190
[30560.303765] __list_lru_walk_one.isra.4+0x5c/0x100
[30560.303766] list_lru_walk_one+0x32/0x50
[30560.303766] prune_icache_sb+0x36/0x80
[30560.303768] super_cache_scan+0x14a/0x1d0
[30560.303769] do_shrink_slab+0x131/0x320
[30560.303770] shrink_node+0xf7/0x380
[30560.303772] balance_pgdat+0x2d5/0x640
[30560.303773] kswapd+0x2ba/0x5e0
[30560.303774] kthread+0x147/0x160
[30560.303775] ret_from_fork+0x24/0x30
[30560.303776]
other info that might help us debug this:

[30560.303776] Possible unsafe locking scenario:

[30560.303777] CPU0 CPU1
[30560.303777] ---- ----
[30560.303778] lock(fs_reclaim);
[30560.303778] lock(sb_internal);
[30560.303779] lock(fs_reclaim);
[30560.303780] lock(sb_internal);
[30560.303780]
*** DEADLOCK ***

[30560.303781] 3 locks held by kswapd0/711:
[30560.303782] #0: 000000000ba86300 (fs_reclaim){+.+.}, at: __fs_reclaim_a=
cquire+0x0/0x30
[30560.303784] #1: 000000004a5100f8 (shrinker_rwsem){++++}, at: shrink_nod=
e+0x9a/0x380
[30560.303786] #2: 00000000f956fa46 (&type->s_umount_key#30){++++}, at: su=
per_cache_scan+0x35/0x1d0
[30560.303788]
stack backtrace:
[30560.303789] CPU: 7 PID: 711 Comm: kswapd0 Not tainted 5.2.11-gentoo #2=

[30560.303790] Hardware name: Dell Inc. Precision Tower 3620/0MWYPT, BIOS =
2.4.2 09/29/2017
[30560.303791] Call Trace:
[30560.303793] dump_stack+0x85/0xc7
[30560.303795] print_circular_bug.cold.40+0x1d9/0x235
[30560.303796] __lock_acquire+0x18b1/0x1f00
[30560.303797] lock_acquire+0xa6/0x170
[30560.303798] ? start_transaction+0x3a8/0x500
[30560.303799] __sb_start_write+0xf6/0x150
[30560.303800] ? start_transaction+0x3a8/0x500
[30560.303801] start_transaction+0x3a8/0x500
[30560.303802] btrfs_commit_inode_delayed_inode+0x59/0x110
[30560.303804] btrfs_evict_inode+0x19e/0x4c0
[30560.303805] ? var_wake_function+0x20/0x20
[30560.303806] evict+0xbc/0x1f0
[30560.303807] inode_lru_isolate+0x113/0x190
[30560.303808] ? discard_new_inode+0xc0/0xc0
[30560.303809] __list_lru_walk_one.isra.4+0x5c/0x100
[30560.303810] ? discard_new_inode+0xc0/0xc0
[30560.303811] list_lru_walk_one+0x32/0x50
[30560.303812] prune_icache_sb+0x36/0x80
[30560.303813] super_cache_scan+0x14a/0x1d0
[30560.303815] do_shrink_slab+0x131/0x320
[30560.303816] shrink_node+0xf7/0x380
[30560.303817] balance_pgdat+0x2d5/0x640
[30560.303819] kswapd+0x2ba/0x5e0
[30560.303820] ? __wake_up_common_lock+0x90/0x90
[30560.303822] kthread+0x147/0x160
[30560.303823] ? balance_pgdat+0x640/0x640
[30560.303824] ? __kthread_create_on_node+0x160/0x160
[30560.303826] ret_from_fork+0x24/0x30
