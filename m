Return-Path: <linux-btrfs+bounces-7654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71960963513
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 00:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018591F25B3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 22:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A301AD9D8;
	Wed, 28 Aug 2024 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t05VqxK0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t05VqxK0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F11A7AD8
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885723; cv=none; b=nSvWVWDvx75QnI6bhdTBOdxcpwQOgacYxmCxfHoDAapILOoxvE2F7k/zzGz7oHM2KI7gffCqeiZnpUA6paYL3fSTGdnVpNqpVN/6nn4fmxfF8ViD81xLcAO0KEno+4N10RpdymHkYi5fjT0HxMmLgxCUCvjeeIlQ6nKTUcjevAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885723; c=relaxed/simple;
	bh=Vh+pxbRV6AOwhOoh0MGQpagtZg5zStYONnbfSPJFc+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/tCS6Dfg1MQe22TCGzyfMcUfn6BlI7gH6CVEE7nGYoCP3AA9OVfZ+6SWQOmzmiiXMj5ALMANAWABPkMXRbHCyu1guAeDakzwSQxS9b3rCZF2istDOlSkwBoMzOP+f/UZQF4NfSsxlrx5R6WQJN+ydL89vI1b6jySomBO45oSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t05VqxK0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t05VqxK0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C50E21B66;
	Wed, 28 Aug 2024 22:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724885719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tHFZ5SjScAS/kJiF08PFlXnIn846nO49iAa25l/9RiY=;
	b=t05VqxK06taAAWP8bl4q3lenEnBRktoFHBTkMOuCWpPwvX3FAfq7kXfSDoLtEYv61FJvlo
	w68XuQRj4xuuX3wDy0a64lAyIrpffHjPVg43+TsDfbNJR/LlGQC0sS8jgUYW3ulYZrgZfF
	Elb4bzS6ISwEuCiWXBe1v+2YWFr2kG4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=t05VqxK0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724885719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tHFZ5SjScAS/kJiF08PFlXnIn846nO49iAa25l/9RiY=;
	b=t05VqxK06taAAWP8bl4q3lenEnBRktoFHBTkMOuCWpPwvX3FAfq7kXfSDoLtEYv61FJvlo
	w68XuQRj4xuuX3wDy0a64lAyIrpffHjPVg43+TsDfbNJR/LlGQC0sS8jgUYW3ulYZrgZfF
	Elb4bzS6ISwEuCiWXBe1v+2YWFr2kG4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 817341398F;
	Wed, 28 Aug 2024 22:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7lVnEdaqz2a7TAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 28 Aug 2024 22:55:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Rolf Wentland <R.Wentland@gmx.de>
Subject: [PATCH] btrfs: interrupt long running operations if the current process is freezing
Date: Thu, 29 Aug 2024 08:25:00 +0930
Message-ID: <7c5345c3acb54ca6e02fdb2398d9af14a0bebd35.1724885694.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C50E21B66
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

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
Introduce a helper, btrfs_interrupted(), to check both fatal signals and
freezing status, and apply to all long running operations, with
dedicated error code:

- reflink (-EINTR)
- fstrim (-ERESTARTSYS)
- relocation (-ECANCELD)
- llseek (-EINTR)
- defrag (-EAGAIN)
- fiemap (-EINTR)

Reported-by: Rolf Wentland <R.Wentland@gmx.de>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
Signed-off-by: Qu Wenruo <wqu@suse.com>
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
index 878528e086fb..70b3df35aea2 100644
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
+	return signal_pending(current) || btrfs_interrupted();
 }
 
 #endif
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index feec49e6f9c8..08e5df8c7de3 100644
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
+		if (btrfs_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index df7f09f3b02e..372db4e718d1 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -794,7 +794,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 
 		prev_extent_end = extent_end;
 next_item:
-		if (fatal_signal_pending(current)) {
+		if (btrfs_interrupted()) {
 			ret = -EINTR;
 			goto out_unlock;
 		}
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 76f4cc686af9..b915aedbe58a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3676,7 +3676,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 		start = extent_end;
 		last_extent_end = extent_end;
 		path->slots[0]++;
-		if (fatal_signal_pending(current)) {
+		if (btrfs_interrupted()) {
 			ret = -EINTR;
 			goto out;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index eaa1dbd31352..da26fee0eb97 100644
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
+		if (btrfs_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -4000,7 +3999,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		}
 		block_group->discard_cursor = start;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_interrupted()) {
 			if (start != offset)
 				reset_trimming_bitmap(ctl, offset);
 			ret = -ERESTARTSYS;
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 0d599fd847c9..2c0b8ef63445 100644
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
 
+static inline bool btrfs_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 #endif
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index df6b93b927cd..11c05c94c580 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -564,7 +564,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		btrfs_release_path(path);
 		key.offset = prev_extent_end;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_interrupted()) {
 			ret = -EINTR;
 			goto out;
 		}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ea4ed85919ec..17bcda566da8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2936,7 +2936,7 @@ noinline int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info)
 {
 	return atomic_read(&fs_info->balance_cancel_req) ||
 		atomic_read(&fs_info->reloc_cancel_req) ||
-		fatal_signal_pending(current);
+		btrfs_interrupted();
 }
 ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
 
-- 
2.46.0


