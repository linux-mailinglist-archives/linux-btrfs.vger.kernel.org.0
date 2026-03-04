Return-Path: <linux-btrfs+bounces-22217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILEgLOrZp2kRkQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22217-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 08:06:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A21FB5DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 08:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 715ED302DE45
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317B361DA7;
	Wed,  4 Mar 2026 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="J8UyIE5q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from cu-gy11p00im-quki08153201.gy.silu.net (cu-gy11p00im-quki08153201.gy.silu.net [157.255.1.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00804207A;
	Wed,  4 Mar 2026 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.255.1.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607966; cv=none; b=VOsw+5GkTpTkHUK6cjRVfjJSGDyI+E4wP//pxyypUwIX4/j4fE193oI3DMrtNcUrYUu72PZ1oRSF/8NxOjwDSeOPbZeZ9KZJIemYwMBV8ZTFBgo9/Ktqarkkfc13W4AGg94Mwhahwzp7/aO504NMi9IQoFw9EXH/I+yLR4kZi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607966; c=relaxed/simple;
	bh=WZruq0YHiH+dtTjy6hNP4WuwgaSNfc0s0mN3ECUQPqM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=aH6+gcykniFw59o8Ca1TappfFcUNEwDPfyFWE+GtCet8Za1HcAAfxc7VlRyCqHU542RK8Txm9IAMCOHLx/4E0s1x8yOahMizyfTOx+l43lu8oNvmyHZN3O2yk7jloCy9JgmDhjeyhN7MHCf3GniP5Np9/YwvleVoOMbRKR9iVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=J8UyIE5q; arc=none smtp.client-ip=157.255.1.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from smtpclient.apple (gy11p00im-asmtpcmvip.gy.silu.net [112.19.199.76])
	by gy11p00im-quki08153201.gy.silu.net (Postfix) with ESMTPS id E52F8246000B;
	Wed,  4 Mar 2026 07:05:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1772607962; x=1775199962; bh=8VNf1gnZtuE/OBBqVJjNNUwEXder+/33LlrRF7sRZRo=; h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme; b=J8UyIE5qQwACZUQWJvo+2aZ7FOjlH4AUN7gNCFfXypLfdNajhkH4HytLafncdlJQwBDXgd738/jRDVIRS8DHW+NkZX49hpx5Vcne3D4MGZNBulHUsdCWClCWBFh1PABDhHYbv4tj+a+bF2gy1qr8TiWmsu1bD3DKDjUXhLTCW+KFo1YDK8onQ0/5zNJ3S5oKU8vEoIIIZCAVgm2CX48d+c+W31T0bUAGj0/VKSB9326vrAfqATMFj5GF7EHZr8NBtq59UjUAdaMirYG4C2RgKyZY7Q6auE1mFCLe/9AuY6J+9kFvMkMrur+QtOA4+G4nxzOMdn8lNdLbDgd8FYg8zQ==
From: wheatfox17@icloud.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: [BUG] btrfs: circular locking dependency in zoned mode (mmap_lock <->
 kernfs_rwsem)
Message-Id: <45B9FF84-9FC0-4AE7-BA9E-B2B60F1E4F7B@icloud.com>
Date: Wed, 4 Mar 2026 15:05:46 +0800
Cc: David Sterba <dsterba@suse.com>,
 Chris Mason <clm@fb.com>
To: linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAzOCBTYWx0ZWRfX/aC6lrEkIy2q
 28dINJwH0C+wwYtfwjO2LtwZ94zb4bOR/GyR34G1S8CntT7c+5m5VeQSCcS+2Yb1xmmdMtbjD5J
 uQY67hIGC3625NR4sr4dZpxK+HHB6KbAH6OwBjZpKrutqEW9KiT642HasgeKN9jUgwpG/6Web2s
 8rSb6UmNWqSNr6H/j9m8NEWZSTbUcrIHAUKm0ysMr+MxIA4pQ65iWT6kB01TUxTiB5o4vDmO1zq
 VchXkOXE8O6MFNaolqmXj6ToqWgWXg62/3ElYPxbxcfXHgvKoOs73L/gm7IyNw528ha2giOSiGZ
 KW+wxLr++BlGb8WksMwQEx6ytN9Jp7ufQSQ12kPUQ==
X-Proofpoint-GUID: XWgcckUhbl1gvRY5fx_mguQiCHGxcjMb
X-Proofpoint-ORIG-GUID: XWgcckUhbl1gvRY5fx_mguQiCHGxcjMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 clxscore=-2147483648 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603040038
X-Rspamd-Queue-Id: 644A21FB5DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22217-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wheatfox17@icloud.com,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[icloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,icloud.com:dkim,icloud.com:email,icloud.com:mid,qemu.org:url]
X-Rspamd-Action: no action

There=E2=80=99s a circular locking dependency detected by lockdep when =
running Syzkaller
on a Btrfs filesystem with zoned mode. The deadlock involves a =
four-stage dependency
chain starting from mmap_lock and ending back at it via kernfs_rwsem.

Upstream commit: 7.0.0-rc2, 0031c06807cfa8aa51a759ff8aa09e1aa48149af
Kernel Architecture: x86_64
Kernel Config: https://pastebin.com/CAZu430t
Hardware: FEMU b3272c0130faa5fd04826303541a831731a8dfb2 ZNS SSD mode

Reported-by: Yulong Han <wheatfox17@icloud.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
        SYZKALLER BUG REPORT AND REPRODUCER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Syzkaller hit 'possible deadlock in lock_mm_and_find_vma' bug.

syz-executor (436) used greatest stack depth: 24176 bytes left
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
7.0.0-rc2-g0031c06807cf #7 Not tainted
------------------------------------------------------
syz.3.82/1572 is trying to acquire lock:
ffff88811270e140 (&mm->mmap_lock){++++}-{4:4}, at: =
mmap_read_lock_killable include/linux/mmap_lock.h:601 [inline]
ffff88811270e140 (&mm->mmap_lock){++++}-{4:4}, at: =
get_mmap_lock_carefully mm/mmap_lock.c:450 [inline]
ffff88811270e140 (&mm->mmap_lock){++++}-{4:4}, at: =
lock_mm_and_find_vma+0x485/0x1200 mm/mmap_lock.c:501

but task is already holding lock:
ffff88810021e988 (&root->kernfs_rwsem){++++}-{4:4}, at: =
kernfs_fop_readdir+0x15b/0x990 fs/kernfs/dir.c:1898

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&root->kernfs_rwsem){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x194/0x300 kernel/locking/lockdep.c:5825
       down_write+0x8b/0x1e0 kernel/locking/rwsem.c:1590
       kernfs_add_one+0x38/0x850 fs/kernfs/dir.c:796
       kernfs_create_dir_ns+0xfc/0x1a0 fs/kernfs/dir.c:1098
       sysfs_create_dir_ns+0x13a/0x2b0 fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x247/0x8f0 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_add+0x16a/0x1e0 lib/kobject.c:426
       btrfs_sysfs_add_block_group_type+0x246/0x500 =
fs/btrfs/sysfs.c:1866
       btrfs_create_pending_block_groups+0xfb0/0x1820 =
fs/btrfs/block-group.c:2876
       __btrfs_end_transaction+0xf5/0x8e0 fs/btrfs/transaction.c:1080
       btrfs_zoned_reserve_data_reloc_bg+0x62c/0x930 =
fs/btrfs/zoned.c:2836
       open_ctree+0x423d/0x5f52 fs/btrfs/disk-io.c:3597
       btrfs_fill_super fs/btrfs/super.c:981 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1944 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2087 [inline]
       btrfs_get_tree.cold+0xe1/0x2b7 fs/btrfs/super.c:2121
       vfs_get_tree+0x92/0x320 fs/super.c:1754
       vfs_cmd_create+0xd7/0x2a0 fs/fsopen.c:231
       vfs_fsconfig_locked fs/fsopen.c:295 [inline]
       __do_sys_fsconfig+0x55a/0xcb0 fs/fsopen.c:463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (btrfs_trans_num_extwriters){.+.+}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x194/0x300 kernel/locking/lockdep.c:5825
       join_transaction+0x149/0xf40 fs/btrfs/transaction.c:323
       start_transaction+0x3c4/0x1fe0 fs/btrfs/transaction.c:708
       btrfs_zoned_reserve_data_reloc_bg+0x5bc/0x930 =
fs/btrfs/zoned.c:2827
       open_ctree+0x423d/0x5f52 fs/btrfs/disk-io.c:3597
       btrfs_fill_super fs/btrfs/super.c:981 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1944 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2087 [inline]
       btrfs_get_tree.cold+0xe1/0x2b7 fs/btrfs/super.c:2121
       vfs_get_tree+0x92/0x320 fs/super.c:1754
       vfs_cmd_create+0xd7/0x2a0 fs/fsopen.c:231
       vfs_fsconfig_locked fs/fsopen.c:295 [inline]
       __do_sys_fsconfig+0x55a/0xcb0 fs/fsopen.c:463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (btrfs_trans_num_writers){.+.+}-{0:0}:
       reacquire_held_locks+0xce/0x1e0 kernel/locking/lockdep.c:5385
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release kernel/locking/lockdep.c:5889 [inline]
       lock_release+0x11f/0x2c0 kernel/locking/lockdep.c:5875
       percpu_up_read include/linux/percpu-rwsem.h:112 [inline]
       __sb_end_write include/linux/fs/super.h:14 [inline]
       sb_end_intwrite include/linux/fs/super.h:101 [inline]
       __btrfs_end_transaction+0x5c7/0x8e0 fs/btrfs/transaction.c:1085
       btrfs_dirty_inode+0x131/0x200 fs/btrfs/inode.c:6443
       btrfs_update_time fs/btrfs/inode.c:6468 [inline]
       btrfs_update_time+0xc4/0x100 fs/btrfs/inode.c:6454
       touch_atime+0x255/0x780 fs/inode.c:2271
       file_accessed include/linux/fs.h:2263 [inline]
       btrfs_file_mmap_prepare+0x206/0x280 fs/btrfs/file.c:2051
       vfs_mmap_prepare include/linux/fs.h:2075 [inline]
       call_mmap_prepare mm/vma.c:2644 [inline]
       __mmap_region+0xe0d/0x2980 mm/vma.c:2743
       mmap_region+0x2e0/0x3b0 mm/vma.c:2837
       do_mmap+0xc53/0x12d0 mm/mmap.c:559
       vm_mmap_pgoff+0x201/0x390 mm/util.c:581
       ksys_mmap_pgoff+0x466/0x5b0 mm/mmap.c:605
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add+0xeb/0xce0 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x128f/0x1a50 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x194/0x300 kernel/locking/lockdep.c:5825
       down_read_killable+0x9c/0x490 kernel/locking/rwsem.c:1560
       mmap_read_lock_killable include/linux/mmap_lock.h:601 [inline]
       get_mmap_lock_carefully mm/mmap_lock.c:450 [inline]
       lock_mm_and_find_vma+0x485/0x1200 mm/mmap_lock.c:501
       do_user_addr_fault+0x333/0xe90 arch/x86/mm/fault.c:1357
       handle_page_fault arch/x86/mm/fault.c:1474 [inline]
       exc_page_fault+0x66/0xc0 arch/x86/mm/fault.c:1527
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
       filldir+0x1ec/0x650 fs/readdir.c:296
       dir_emit include/linux/fs.h:3566 [inline]
       kernfs_fop_readdir+0x40c/0x990 fs/kernfs/dir.c:1915
       iterate_dir+0x1e0/0x5e0 fs/readdir.c:108
       __do_sys_getdents fs/readdir.c:327 [inline]
       __se_sys_getdents fs/readdir.c:312 [inline]
       __x64_sys_getdents+0x13b/0x2b0 fs/readdir.c:312
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> btrfs_trans_num_extwriters --> &root->kernfs_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&root->kernfs_rwsem);
                               lock(btrfs_trans_num_extwriters);
                               lock(&root->kernfs_rwsem);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz.3.82/1572:
 #0: ffff8881035db7b8 (&f->f_pos_lock){+.+.}-{4:4}, at: =
fdget_pos+0x2aa/0x380 fs/file.c:1261
 #1: ffff888106bb99f8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: =
iterate_dir+0xdc/0x5e0 fs/readdir.c:101
 #2: ffff88810021e988 (&root->kernfs_rwsem){++++}-{4:4}, at: =
kernfs_fop_readdir+0x15b/0x990 fs/kernfs/dir.c:1898

stack backtrace:
CPU: 3 UID: 0 PID: 1572 Comm: syz.3.82 Not tainted =
7.0.0-rc2-g0031c06807cf #7 PREEMPT(full)=20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xba/0x110 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xce0 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x128f/0x1a50 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x194/0x300 kernel/locking/lockdep.c:5825
 down_read_killable+0x9c/0x490 kernel/locking/rwsem.c:1560
 mmap_read_lock_killable include/linux/mmap_lock.h:601 [inline]
 get_mmap_lock_carefully mm/mmap_lock.c:450 [inline]
 lock_mm_and_find_vma+0x485/0x1200 mm/mmap_lock.c:501
 do_user_addr_fault+0x333/0xe90 arch/x86/mm/fault.c:1357
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x66/0xc0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0010:filldir+0x1ec/0x650 fs/readdir.c:296
Code: 0f 01 cb 0f ae e8 48 8b 44 24 08 49 89 46 08 e8 6a 2b b6 ff 4c 8b =
74 24 30 48 8b 44 24 10 49 89 06 e8 58 2b b6 ff 44 8b 24 24 <66> 45 89 =
66 10 e8 4a 2b b6 ff 8b 44 24 04 49 63 cc 48 89 4c 24 08
RSP: 0018:ffff88810ebbfce0 EFLAGS: 00050293
RAX: 0000000000000000 RBX: ffff88810ebbfe70 RCX: ffffffff8ed596f8
RDX: ffff888111c0c480 RSI: 0000200000001fd0 RDI: 0000000000000006
RBP: ffff888107f8ad00 R08: 0000000000000000 R09: ffff888111c0c480
R10: 0000200000002010 R11: 0000000000000003 R12: 0000000000000020
R13: ffff88810ebbfe94 R14: 0000200000001ff0 R15: 0000000000000008
 dir_emit include/linux/fs.h:3566 [inline]
 kernfs_fop_readdir+0x40c/0x990 fs/kernfs/dir.c:1915
 iterate_dir+0x1e0/0x5e0 fs/readdir.c:108
 __do_sys_getdents fs/readdir.c:327 [inline]
 __se_sys_getdents fs/readdir.c:312 [inline]
 __x64_sys_getdents+0x13b/0x2b0 fs/readdir.c:312
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1010d9acf9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1010bff028 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007f1011005fa0 RCX: 00007f1010d9acf9
RDX: 0000000000001000 RSI: 0000200000001ac0 RDI: 0000000000000003
RBP: 00007f1010e08bf7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1011006038 R14: 00007f1011005fa0 R15: 00007ffd376f51d8
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f 01 cb             	stac
   3:	0f ae e8             	lfence
   6:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   b:	49 89 46 08          	mov    %rax,0x8(%r14)
   f:	e8 6a 2b b6 ff       	call   0xffb62b7e
  14:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  19:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  1e:	49 89 06             	mov    %rax,(%r14)
  21:	e8 58 2b b6 ff       	call   0xffb62b7e
  26:	44 8b 24 24          	mov    (%rsp),%r12d
* 2a:	66 45 89 66 10       	mov    %r12w,0x10(%r14) <-- trapping =
instruction
  2f:	e8 4a 2b b6 ff       	call   0xffb62b7e
  34:	8b 44 24 04          	mov    0x4(%rsp),%eax
  38:	49 63 cc             	movslq %r12d,%rcx
  3b:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)


Syzkaller reproducer:
# {Threaded:true Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 =
Sandbox:none SandboxArg:0 Leak:false NetInjection:false NetDevices:true =
NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false =
DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false =
IEEE802154:false Sysctl:true Swap:false UseTmpDir:true HandleSegv:true =
Trace:false CallComments:true LegacyOptions:{Collide:false Fault:false =
FaultCall:0 FaultNth:0}}
r0 =3D openat(0xffffffffffffff9c, &(0x7f0000000280)=3D'./cgroup\x00', =
0x0, 0x0)
getdents(r0, &(0x7f0000001ac0)=3D""/4096, 0x1000) (async)
fstat(0xffffffffffffffff, 0x0)
newfstatat(0xffffffffffffff9c, 0x0, 0x0, 0x0)



