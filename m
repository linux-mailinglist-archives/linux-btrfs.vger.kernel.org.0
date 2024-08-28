Return-Path: <linux-btrfs+bounces-7658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B288F963682
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 01:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26214B22DEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E31AC8AD;
	Wed, 28 Aug 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A+553Gug";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A+553Gug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BA647
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889401; cv=none; b=AihNOvs3Pixl5uAuoclSscpclvuQu261vzFlScAcNnKuOb++plwhCRD/Fzt1wvqxZ1azyyhMV4yRCW50VPZAcjqbG87qLL9JFdhx6Xw2vMizxXNd+vWf33ENPjWgCKFPN2IatN2QWsJoFcsoX0QDfxGuOYnsgZLfEypKnnpxGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889401; c=relaxed/simple;
	bh=rFzUsCvhUZ9AajvLWp/GmIs+o7seGe5o1CNtE3cJsV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCE0cSvzkr3HxRA8Pzl8fVyzkQLH2vTUToub5KR/l5BSwMUCnNOMMwoTjrUrFLN+SXObDDlQJ5026BeZu9gU+UARhJhNIoXQttNymNf+GSJxTbYl25IOwnKSsosp3sPYzAxcSadu0X/KO/G7tHuJ4veK4iw1y5eGdGc6OCQ3IHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A+553Gug; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A+553Gug; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F39521B81;
	Wed, 28 Aug 2024 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724889396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z2Ue/29E9YyCq9s+v3ZMcfllNTbY+kOiR2oupJIMOsQ=;
	b=A+553GugjTzlKuX0K3aZ1lrEl6Ds3F/cNO2m7xiJKNRe43+go1Vt/fd3tzy4DK/QNIdNyX
	2k3ISMUBLyKpucZAaAr0q8IzKAWB1RNLYnmuSel5IBoD6vDf9wRZq65hfCZHUg2lV3wiqw
	ke2PANuBSuruE0Z9jfmNjig6y7VRXOQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724889396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z2Ue/29E9YyCq9s+v3ZMcfllNTbY+kOiR2oupJIMOsQ=;
	b=A+553GugjTzlKuX0K3aZ1lrEl6Ds3F/cNO2m7xiJKNRe43+go1Vt/fd3tzy4DK/QNIdNyX
	2k3ISMUBLyKpucZAaAr0q8IzKAWB1RNLYnmuSel5IBoD6vDf9wRZq65hfCZHUg2lV3wiqw
	ke2PANuBSuruE0Z9jfmNjig6y7VRXOQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BCFC1347F;
	Wed, 28 Aug 2024 23:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QRc5CDO5z2abWwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 28 Aug 2024 23:56:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Rolf Wentland <R.Wentland@gmx.de>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2] btrfs: interrupt long running operations if the current process is freezing
Date: Thu, 29 Aug 2024 09:26:17 +0930
Message-ID: <bbcd9ebaeccb3a9e5a875a2ffc1afb498d6b75fe.1724889346.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,toxicpanda.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:url,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There is a bug report that running fstrim will prevent the system from
hibernation, result the following dmesg:

 PM: suspend entry (deep)
 Filesystems sync: 0.060 seconds
 Freezing user space processes
 Freezing user space processes failed after 20.007 seconds (1 tasks refusing to freeze, wq_busy=0):
 task:fstrim          state:D stack:0     pid:15564 tgid:15564 ppid:1      flags:0x00004006
 Call Trace:
  <TASK>
  __schedule+0x381/0x1540
  schedule+0x24/0xb0
  schedule_timeout+0x1ea/0x2a0
  io_schedule_timeout+0x19/0x50
  wait_for_completion_io+0x78/0x140
  submit_bio_wait+0xaa/0xc0
  blkdev_issue_discard+0x65/0xb0
  btrfs_issue_discard+0xcf/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_discard_extent+0x120/0x2a0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  do_trimming+0xd4/0x220 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  trim_bitmaps+0x418/0x520 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_trim_block_group+0xcb/0x130 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_trim_fs+0x119/0x460 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_ioctl_fitrim+0xfb/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_ioctl+0x11cc/0x29f0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  __x64_sys_ioctl+0x92/0xd0
  do_syscall_64+0x5b/0x80
  entry_SYSCALL_64_after_hwframe+0x7c/0xe6
 RIP: 0033:0x7f5f3b529f9b
 RSP: 002b:00007fff279ebc20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007fff279ebd60 RCX: 00007f5f3b529f9b
 RDX: 00007fff279ebc90 RSI: 00000000c0185879 RDI: 0000000000000003
 RBP: 000055748718b2d0 R08: 00005574871899e8 R09: 00007fff279eb010
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
 R13: 000055748718ac40 R14: 000055748718b290 R15: 000055748718b290
  </TASK>
 OOM killer enabled.
 Restarting tasks ... done.
 random: crng reseeded on system resumption
 PM: suspend exit
 PM: suspend entry (s2idle)
 Filesystems sync: 0.047 seconds

[CAUSE]
PM code is freezing all user space processes before entering
hibernation/suspension, but if a user space process is trapping into the
kernel for a long running operation, it will not be frozen since it's
still inside kernel.

Normally those long running operations check for fatal signals and exit
early, but freezing user space processes is not done by signals but a
different infrastructure.

Unfortunately btrfs only checks fatal signals but not if the current
task is being frozen.

[FIX]
Introduce a helper, btrfs_task_interrupted(), to check both fatal signals
and freezing status, and apply to all long running operations, with
dedicated error code:

- reflink (-EINTR)
- fstrim (-ERESTARTSYS)
- relocation (-ECANCELD)
- llseek (-EINTR)
- defrag (-EAGAIN)
- fiemap (-EINTR)

Reported-by: Rolf Wentland <R.Wentland@gmx.de>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Rename the helper to btrfs_task_interrupted()
---
 fs/btrfs/defrag.h           | 3 ++-
 fs/btrfs/extent-tree.c      | 3 +--
 fs/btrfs/fiemap.c           | 2 +-
 fs/btrfs/file.c             | 2 +-
 fs/btrfs/free-space-cache.c | 5 ++---
 fs/btrfs/misc.h             | 7 +++++++
 fs/btrfs/reflink.c          | 2 +-
 fs/btrfs/relocation.c       | 2 +-
 8 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/defrag.h b/fs/btrfs/defrag.h
index 878528e086fb..f5e84c6b11cd 100644
--- a/fs/btrfs/defrag.h
+++ b/fs/btrfs/defrag.h
@@ -5,6 +5,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler_types.h>
+#include "misc.h"
 
 struct inode;
 struct file_ra_state;
@@ -26,7 +27,7 @@ int btrfs_defrag_root(struct btrfs_root *root);
 
 static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
 {
-	return signal_pending(current);
+	return signal_pending(current) || btrfs_task_interrupted();
 }
 
 #endif
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index feec49e6f9c8..81ed4d1359aa 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/sched.h>
-#include <linux/sched/signal.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
@@ -6459,7 +6458,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_task_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index df7f09f3b02e..a3d9b8922bb9 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -794,7 +794,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 
 		prev_extent_end = extent_end;
 next_item:
-		if (fatal_signal_pending(current)) {
+		if (btrfs_task_interrupted()) {
 			ret = -EINTR;
 			goto out_unlock;
 		}
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 76f4cc686af9..088f06dca16e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3676,7 +3676,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 		start = extent_end;
 		last_extent_end = extent_end;
 		path->slots[0]++;
-		if (fatal_signal_pending(current)) {
+		if (btrfs_task_interrupted()) {
 			ret = -EINTR;
 			goto out;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index eaa1dbd31352..7c9506ee7be6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -5,7 +5,6 @@
 
 #include <linux/pagemap.h>
 #include <linux/sched.h>
-#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/math64.h>
 #include <linux/ratelimit.h>
@@ -3809,7 +3808,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		if (async && *total_trimmed)
 			break;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_task_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -4000,7 +3999,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		}
 		block_group->discard_cursor = start;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_task_interrupted()) {
 			if (start != offset)
 				reset_trimming_bitmap(ctl, offset);
 			ret = -ERESTARTSYS;
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 0d599fd847c9..fcc9715b55fe 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -9,6 +9,8 @@
 #include <linux/wait.h>
 #include <linux/math64.h>
 #include <linux/rbtree.h>
+#include <linux/sched/signal.h>
+#include <linux/freezer.h>
 
 /*
  * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
@@ -163,4 +165,9 @@ static inline bool bitmap_test_range_all_zero(const unsigned long *addr,
 	return (found_set == start + nbits);
 }
 
+static inline bool btrfs_task_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 #endif
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index df6b93b927cd..f2063d388553 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -564,7 +564,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		btrfs_release_path(path);
 		key.offset = prev_extent_end;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_task_interrupted()) {
 			ret = -EINTR;
 			goto out;
 		}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ea4ed85919ec..feafa46ef7a5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2936,7 +2936,7 @@ noinline int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info)
 {
 	return atomic_read(&fs_info->balance_cancel_req) ||
 		atomic_read(&fs_info->reloc_cancel_req) ||
-		fatal_signal_pending(current);
+		btrfs_task_interrupted();
 }
 ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
 
-- 
2.46.0


