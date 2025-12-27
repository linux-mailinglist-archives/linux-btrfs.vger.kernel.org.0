Return-Path: <linux-btrfs+bounces-20029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D9CCE029F
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Dec 2025 23:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00D163014D9A
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Dec 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B852367A2;
	Sat, 27 Dec 2025 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JTgZt04P";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fS7Lbu6g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDC17A2E8
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Dec 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766874762; cv=none; b=MvUANSc9SKkw7vd3LMQzL4N+JUcTiQI1tHOnPp6nfpiRIWw6Ph5lHegH8V8+AyBpA6H676kvprUYT0lxwpRo7wpbPMu7qpN21TGUv2RrJCbca38UkfRGFZnUIFudY4dTi77f/t2/u6OaOCqZeh2bgd/nVhqV14FKEU1dzHAdhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766874762; c=relaxed/simple;
	bh=M+fO9BXRTTxTvOSciclMSBrqwEYNVeogCkhXnMGNl24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNW2qumytDwwo1Sf4QfTMbITZHPVtYZHNq/MSRKt8VlvtlhEygCEZD3HUadxfe8SQc+5PxedwnopeXSABs0ivlHYszxH4wIbp8M+Rz7x4RQXQnHmf5UMmZraE30jIK61F+4tn6w3frlX5N6monIJa77/PLaDO0bbeU4iZIGuAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JTgZt04P; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fS7Lbu6g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8749C336A1;
	Sat, 27 Dec 2025 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766874751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dK/ncG42P4Ij95eEGy11hwCuFy63OtR74HJ2I+q1ziM=;
	b=JTgZt04P9cz05X5iZUUDUddLxGFAqDsWYEhCPoBBZfvtiEsbqraLUjtIU3PSskmYmOAj4I
	xQ/sO8G09QFuEV9dfATSSBsbJtMn0rpqzWiq0igZzyYnmv6Cqt09xxT51hqxreXw2FDZL1
	+iJ6Q+2E59uuNeTfOEaE57PNAQ2Dd3g=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766874750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dK/ncG42P4Ij95eEGy11hwCuFy63OtR74HJ2I+q1ziM=;
	b=fS7Lbu6gj/hj8s/HJXqMsuvqqeg6mEySE0ITq0/fBcXNiZk2pxNTSMsWV9ALFZlM2t0eHb
	vAriyx8g8AhRCfLWkKr7YEEo6qmR3hF2kT3s2HCXFyg7/PzrlNASyekn5mQMWm9WusA67e
	NRPcKHAxELxHl9U4J+DLh6SAAHFfPCo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 832DC3EA63;
	Sat, 27 Dec 2025 22:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ygsYEX1eUGkPNQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 27 Dec 2025 22:32:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: ZhengYuan Huang <gality369@gmail.com>
Subject: [PATCH] btrfs: do not sync fs when the fs is not yet fully mounted
Date: Sun, 28 Dec 2025 09:02:07 +1030
Message-ID: <7cdad50af2ac47b00bc1d81dfc97ad8776528d86.1766874707.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

[LOCKDEP WARNING]
There is a lockdep warning between qgroup related tree lock and
kernfs_rwsem.

However the involved call chains show that the fs is being mounted
meanwhile the fs is also triggering sync_fs() from unmounting process:

WARNING: possible circular locking dependency detected
6.18.0-dirty #1 Tainted: G           OE
------------------------------------------------------
syz.0.279/4686 is trying to acquire lock:
ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429

but task is already holding lock:
ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #7 (&root->kernfs_rwsem){++++}-{4:4}:
      down_write+0x91/0x210 kernel/locking/rwsem.c:1590
      kernfs_add_one+0x39/0x700 fs/kernfs/dir.c:791
      kernfs_create_dir_ns+0x103/0x1a0 fs/kernfs/dir.c:1093
      sysfs_create_dir_ns+0x143/0x2b0 fs/sysfs/dir.c:59
      create_dir lib/kobject.c:73 [inline]
      kobject_add_internal+0x24d/0xad0 lib/kobject.c:240
      kobject_add_varg lib/kobject.c:374 [inline]
      kobject_init_and_add+0x114/0x1a0 lib/kobject.c:457
      btrfs_sysfs_add_one_qgroup+0xe2/0x170 fs/btrfs/sysfs.c:2599
      btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
      open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
      btrfs_fill_super fs/btrfs/super.c:987 [inline]
      btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
      btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
      btrfs_get_tree+0x114c/0x22e0 fs/btrfs/super.c:2128
      vfs_get_tree+0x9a/0x370 fs/super.c:1758
      fc_mount fs/namespace.c:1199 [inline] <<<<
      do_new_mount_fc fs/namespace.c:3642 [inline]
      do_new_mount fs/namespace.c:3718 [inline]
      path_mount+0x5aa/0x1e90 fs/namespace.c:4028
      do_mount fs/namespace.c:4041 [inline]
      __do_sys_mount fs/namespace.c:4229 [inline]
      __se_sys_mount fs/namespace.c:4206 [inline]
      __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
      x64_sys_call+0x1a7d/0x26a0
arch/x86/include/generated/asm/syscalls_64.h:166
      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
      do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #6 (btrfs-quota-00){++++}-{4:4}:
      down_read_nested+0xa0/0x4d0 kernel/locking/rwsem.c:1662
      btrfs_tree_read_lock_nested+0x32/0x1d0 fs/btrfs/locking.c:145
      btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
      btrfs_read_lock_root_node+0x73/0xb0 fs/btrfs/locking.c:266
      btrfs_search_slot_get_root fs/btrfs/ctree.c:1742 [inline]
      btrfs_search_slot+0x3e0/0x3580 fs/btrfs/ctree.c:2066
      update_qgroup_info_item fs/btrfs/qgroup.c:882 [inline]
      btrfs_run_qgroups+0x4f3/0x870 fs/btrfs/qgroup.c:3112
      commit_cowonly_roots+0x1f3/0x8f0 fs/btrfs/transaction.c:1354
      btrfs_commit_transaction+0x1c64/0x3f70 fs/btrfs/transaction.c:2459
      btrfs_sync_fs+0xf2/0x660 fs/btrfs/super.c:1057
      sync_filesystem fs/sync.c:66 [inline]
      sync_filesystem+0x1ba/0x260 fs/sync.c:30
      generic_shutdown_super+0x88/0x520 fs/super.c:621 <<<<
      kill_anon_super+0x41/0x80 fs/super.c:1288
      btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
      deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
      deactivate_super fs/super.c:506 [inline]
      deactivate_super+0xad/0xd0 fs/super.c:502
      cleanup_mnt+0x214/0x460 fs/namespace.c:1318
      __cleanup_mnt+0x1b/0x30 fs/namespace.c:1325
      task_work_run+0x16a/0x270 kernel/task_work.c:227
      resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
      exit_to_user_mode_loop+0x147/0x190 kernel/entry/common.c:43
      exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
      syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
      syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
      do_syscall_64+0x3a0/0xa90 arch/x86/entry/syscall_64.c:100
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

[CAUSE]
At btrfs_sync_fs() we always assume the fs is already fully mounted, but
if it's not the case we have more problems to bother other than just
lockdep warnings.

[FIX]
Check if the target fs is fully mounted, if not skip btrfs_sync_fs()
completely.

Reported-by: ZhengYuan Huang <gality369@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAOmEq9XdTN64=oE7na3J+vCG+fV2bFHSpprHswcE_wEfk_edNg@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c141b7e1ee81..af98f622023f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1013,6 +1013,9 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *root = fs_info->tree_root;
 
+	if (unlikely(!test_bit(BTRFS_FS_OPEN, &fs_info->flags)))
+		return 0;
+
 	trace_btrfs_sync_fs(fs_info, wait);
 
 	if (!wait) {
-- 
2.52.0


