Return-Path: <linux-btrfs+bounces-20469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C72D1B52E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 21:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 104C330445FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 20:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E79261B78;
	Tue, 13 Jan 2026 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eXoFStFC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eXoFStFC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820A322B6E
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337915; cv=none; b=Ec2BVRmdMPtwh07lIzyhxt31uROh+dp//7OuusEM2CI75JzISIFz/tjbJHH46j9xMYUzNx8Hx1EIx2sYJPmmpDcsfho9X0JyQjcXNWinwj1BnPsLE6yGkCHlLGfoiqZ4ccSFeKr/p+3nruRgV4ZJwtsrVbQlFKvvjoyP7banrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337915; c=relaxed/simple;
	bh=2vQPMHHGCS/Ik011hzeaqhNM//kgcy06iHj/g0007RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzbocY9B1MaQpbUDF81NzcLdpzkuvMuEGlv/via0sVe/r2WSL54DB5gdl0hjm21VxJLryVhAw3xsq8y7BwVUGKbDReI06eNYdoOIVqMU/A1HmFqPyZhz5/fq1YHk6LElHi96xiQdsQC7Ap5o7tl3uOAokxugtVckyTGXhgI/kpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eXoFStFC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eXoFStFC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00486336A0;
	Tue, 13 Jan 2026 20:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768337912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ASJRUNV3Gbe+oiHix3TRa7NmUJpNMFllPbBE/g3/YoI=;
	b=eXoFStFCLzJb686Q+kAFvm+S8fSkU3bL12UMk21vPnIkmJ0U8cHfdWAaJDJ1mSRx1quRru
	DLG7JGlYAH3DsEEBATQ60VkEkSkzRjC9Pm4yuubp/T67WZK8+FZsDB+lv2W5uobHj46JG9
	mvNvQBXc02KE9OgWOXmCQkY489vaBoY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eXoFStFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768337912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ASJRUNV3Gbe+oiHix3TRa7NmUJpNMFllPbBE/g3/YoI=;
	b=eXoFStFCLzJb686Q+kAFvm+S8fSkU3bL12UMk21vPnIkmJ0U8cHfdWAaJDJ1mSRx1quRru
	DLG7JGlYAH3DsEEBATQ60VkEkSkzRjC9Pm4yuubp/T67WZK8+FZsDB+lv2W5uobHj46JG9
	mvNvQBXc02KE9OgWOXmCQkY489vaBoY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D9193EA63;
	Tue, 13 Jan 2026 20:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x3UXMfaxZmn+SQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 13 Jan 2026 20:58:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>
Subject: [PATCH] btrfs: reject new transactions if the fs is fully read-only
Date: Wed, 14 Jan 2026 07:28:28 +1030
Message-ID: <f0a259857d106f82ea377b49a85bc422fff001fc.1768337256.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 00486336A0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

[BUG]
There is a bug report where a heavily fuzzed fs is mounted with all
rescue mount options, which leads to the following warnings during
unmount:

 BTRFS: Transaction aborted (error -22)
 Modules linked in:
 CPU: 0 UID: 0 PID: 9758 Comm: repro.out Not tainted
 6.19.0-rc5-00002-gb71e635feefc #7 PREEMPT(full)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 RIP: 0010:find_free_extent_update_loop fs/btrfs/extent-tree.c:4208 [inline]
 RIP: 0010:find_free_extent+0x52f0/0x5d20 fs/btrfs/extent-tree.c:4611
 Call Trace:
  <TASK>
  btrfs_reserve_extent+0x2cd/0x790 fs/btrfs/extent-tree.c:4705
  btrfs_alloc_tree_block+0x1e1/0x10e0 fs/btrfs/extent-tree.c:5157
  btrfs_force_cow_block+0x578/0x2410 fs/btrfs/ctree.c:517
  btrfs_cow_block+0x3c4/0xa80 fs/btrfs/ctree.c:708
  btrfs_search_slot+0xcad/0x2b50 fs/btrfs/ctree.c:2130
  btrfs_truncate_inode_items+0x45d/0x2350 fs/btrfs/inode-item.c:499
  btrfs_evict_inode+0x923/0xe70 fs/btrfs/inode.c:5628
  evict+0x5f4/0xae0 fs/inode.c:837
  __dentry_kill+0x209/0x660 fs/dcache.c:670
  finish_dput+0xc9/0x480 fs/dcache.c:879
  shrink_dcache_for_umount+0xa0/0x170 fs/dcache.c:1661
  generic_shutdown_super+0x67/0x2c0 fs/super.c:621
  kill_anon_super+0x3b/0x70 fs/super.c:1289
  btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2127
  deactivate_locked_super+0xbc/0x130 fs/super.c:474
  cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
  task_work_run+0x1d4/0x260 kernel/task_work.c:233
  exit_task_work include/linux/task_work.h:40 [inline]
  do_exit+0x694/0x22f0 kernel/exit.c:971
  do_group_exit+0x21c/0x2d0 kernel/exit.c:1112
  __do_sys_exit_group kernel/exit.c:1123 [inline]
  __se_sys_exit_group kernel/exit.c:1121 [inline]
  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
  x64_sys_call+0x2210/0x2210 arch/x86/include/generated/asm/syscalls_64.h:232
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xe8/0xf80 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x44f639
 Code: Unable to access opcode bytes at 0x44f60f.
 RSP: 002b:00007ffc15c4e088 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
 RAX: ffffffffffffffda RBX: 00000000004c32f0 RCX: 000000000044f639
 RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
 RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004c32f0
 R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
  </TASK>

Since rescue mount options will mark the full fs read-only, there should
be no new transaction triggered.

But during unmount we will evict all inodes, which can trigger a new
transaction, and triggers warnings on a heavy corrupted fs.

[CAUSE]
Btrfs allows new transaction even on a read-only fs, this is to allow
log replay happen even on read-only mounts, just like what ext4/xfs.

However with rescue mount options, the fs is fully read-only and can not
be remounted read-write, thus in that case we should also reject any new
transactions.

[FIX]
If we find the fs has rescue mount options, we should treat the fs as
error, so that no new transaction can be started.

Reported-by: Jiaming Zhang <r772577952@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CANypQFYw8Nt8stgbhoycFojOoUmt+BoZ-z8WJOZVxcogDdwm=Q@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 13 +++++++++++++
 fs/btrfs/fs.h      |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cecb81d0f9e0..02cb79fc5b7a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3230,6 +3230,15 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	return 0;
 }
 
+static bool fs_is_full_ro(struct btrfs_fs_info *fs_info)
+{
+	if (!sb_rdonly(fs_info->sb))
+		return false;
+	if (unlikely(fs_info->mount_opt & BTRFS_MOUNT_FULL_RO_MASK))
+		return true;
+	return false;
+}
+
 int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices)
 {
 	u32 sectorsize;
@@ -3335,6 +3344,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
 		WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
 
+	/* If the fs has any rescue options, no transaction is allowed. */
+	if (fs_is_full_ro(fs_info))
+		WRITE_ONCE(fs_info->fs_error, -EROFS);
+
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
 	sectorsize = btrfs_super_sectorsize(disk_super);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 859551cf9bee..a54fbf341ce1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -266,6 +266,14 @@ enum {
 	BTRFS_MOUNT_REF_TRACKER			= (1ULL << 33),
 };
 
+/* Those mount options requires a full RO fs, no new transaction is allowed. */
+#define BTRFS_MOUNT_FULL_RO_MASK		\
+	(BTRFS_MOUNT_NOLOGREPLAY |		\
+	 BTRFS_MOUNT_IGNOREBADROOTS |		\
+	 BTRFS_MOUNT_IGNOREDATACSUMS |		\
+	 BTRFS_MOUNT_IGNOREMETACSUMS |		\
+	 BTRFS_MOUNT_IGNORESUPERFLAGS)
+
 /*
  * Compat flags that we support.  If any incompat flags are set other than the
  * ones specified below then we will fail to mount
-- 
2.52.0


