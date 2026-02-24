Return-Path: <linux-btrfs+bounces-21894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBY7A7n6nWmeSwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21894-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 20:23:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C218C007
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 20:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D303030B8E71
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8963ACA6C;
	Tue, 24 Feb 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naEQdBhE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116E277CA4
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960979; cv=none; b=KkEORR5VEfAo4IDdhjVn/r2kXplMiwTCs1Ainkd5xu1a2FJH6Sl4XWdraciHVfc9MmUN3mFz3UqMrhbeQD+YjU/NGJDIP84eYwKf7OtQKSb/fslZoy0O0ZTnnFc9YgP64IFADuV4cN8JHjWJtugTE3seweq1C6NyRjtiIJe6GMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960979; c=relaxed/simple;
	bh=0roapicKqypHJgsT5IdXyQqmsdIijnqhozmyb7JDgbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0ZXWjbNVK8xLmuqqL7IoXxdeR4hHKMQSuhL4fkJJozMPLj0WsBvRyoT1LC9bEIQdlqsEtdoJJeog/TGFZyg71WV95pKm4KUwgK44caFKry/y3TAVfHFTeV5YJRE3Zxbs7WUNOxE5XSwmyRCHmHl1JQVE71NfbuwkdtGnmerhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naEQdBhE; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64ca1ba0089so764722d50.1
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960973; x=1772565773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS4fGbsX+aJ0/7b54Jk6S20Gu9F+OEI9Oa2c8P64Axw=;
        b=naEQdBhEPZaxInMXr8aPk9c6IKHmQVtxgewCbmtY/gzq21yM54724SLpyqt4a/q9Dk
         Hc7Rlj0h5wHc3JdNEpQ3tTyLlVpno1DQzCijeQ7ntz3H1CRTyJpwtxHCjq3Z8srfqUSd
         2BVis9aqhOIFd6khSL4alK+TGPu/aiB3q0y+44wynPbAIZmIBKTsNHskrzyNDDlM9Abh
         gNDtKjYQUDf19r1B45J4s0dsw9xuYKahsqBtEpmzOtsVUYoWjgbulIIYhBftzFpwDek4
         F69WeuNYkN2y+023glxNDFO9dHOafcL1FPG1FPjnX1ueQW10mIIzjKrgCJl4t53d9g1v
         MqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960973; x=1772565773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lS4fGbsX+aJ0/7b54Jk6S20Gu9F+OEI9Oa2c8P64Axw=;
        b=Ps4hfdHxB2ckxKEifvcb6JqYWV6YkLQ7bTtPvr4XdfH7K/sxsGojRmE2H1wax+ytnt
         Fw0gJghC8Y8jGCC+L+mufSHXj8EvBjjCCSrQ3b+OTWVJHtfDcvbf0nDrBoDaPMvNlqM4
         SRAxoItyhkFKCJSo8/0RTlKgYaF3k5HgXIkC9qTmiJc02Yhr6noMuf7prcGRdDwL8FlY
         dAvErdSSuJmg5bTsZgWr2+peBavSKHu/23M0RqsO+kJJFnN3hTJboPpKY4tGxFCF+Bkl
         biVmt3v//tPWgo1Gu6rSQxIe98S2CJSD1g5yOWXy0U3LffinOag8v56begj/+mfgmiWm
         sGAw==
X-Gm-Message-State: AOJu0YzM/9fdXskNNbB4+PlSkwf7yYOY1USmYX1uNMxc5xwBqDt4J31e
	RlghSSbZ8tZojslW2FMCL2+3dGVHkhQUbvhdSX7YjYkQ4ytOiN7amDEILuVPVEj8tKI=
X-Gm-Gg: ATEYQzyEk5nKgszK5H8AXQrQiqmozn9gRqnYuF+yYHnlcF8RzBMANO2ZHpvvug1u6Rr
	szpZr7+/6UHqL1k2dnWeBb+DRz6pVScPaxwCEYwN95alasJxe8yXaiXIMT5T+ZDfkTZgT8tSSCh
	VhHTj7MCQ2Zkm4bBtm+WIJJaWEwoyUO7p3evnrY2MFTcPWPd735suJZNMkAyv3iWXyFQnZJRRmb
	SPucf7QoQRcCWfFES9Km4igEdAlLEe5hXisy7sicS3MiQ2R//Q8OE/7n5SVREF3icRyd1VmKKZT
	gd6LgLepbvlso99tVgvbfvl3/TD3plJD9kjc2XSqrN01A6DqHZrysR1enR5SBIv8/U90Stkbifs
	zdGgQHZ5RnpulU5twCvGRan/N7O+a2DyaeNiV54wDcyRAWnyosEbt+SIqF/sCh+DM5EsVNADlWT
	4MYbiYMXgEpjVyKHBpog==
X-Received: by 2002:a05:690c:6086:b0:795:1ad3:26be with SMTP id 00721157ae682-79829041d59mr122126357b3.52.1771960972637;
        Tue, 24 Feb 2026 11:22:52 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982de0fd63sm46933897b3.46.2026.02.24.11.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:22:52 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 2/3] btrfs: inhibit extent buffer writeback to prevent COW amplification
Date: Tue, 24 Feb 2026 11:22:33 -0800
Message-ID: <cc847a35e26cc4dfad18c59e3c525cea507ff440.1771884128.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771884128.git.loemra.dev@gmail.com>
References: <cover.1771884128.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21894-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 504C218C007
X-Rspamd-Action: no action

Inhibit writeback on COW'd extent buffers for the lifetime of the
transaction handle, preventing background writeback from setting
BTRFS_HEADER_FLAG_WRITTEN and causing unnecessary re-COW.

COW amplification occurs when background writeback flushes an extent
buffer that a transaction handle is still actively modifying. When
lock_extent_buffer_for_io() transitions a buffer from dirty to
writeback, it sets BTRFS_HEADER_FLAG_WRITTEN, marking the block as
having been persisted to disk at its current bytenr. Once WRITTEN is
set, should_cow_block() must either COW the block again or overwrite
it in place, both of which are unnecessary overhead when the buffer
is still being modified by the same handle that allocated it. By
inhibiting background writeback on actively-used buffers, WRITTEN is
never set while a transaction handle holds a reference to the buffer,
avoiding this overhead entirely.

Add an atomic_t writeback_inhibitors counter to struct extent_buffer,
which fits in an existing 6-byte hole without increasing struct size.
When a buffer is COW'd in btrfs_force_cow_block(), call
btrfs_inhibit_eb_writeback() to store the eb in the transaction
handle's writeback_inhibited_ebs xarray (keyed by eb->start), take a
reference, and increment writeback_inhibitors. The function handles
dedup (same eb inhibited twice by the same handle) and replacement
(different eb at the same logical address). Allocation failure is
graceful: the buffer simply falls back to the pre-existing behavior
where it may be written back and re-COW'd.

In lock_extent_buffer_for_io(), when writeback_inhibitors is non-zero
and the writeback mode is WB_SYNC_NONE, skip the buffer. WB_SYNC_NONE
is used by the VM flusher threads for background and periodic
writeback, which are the only paths that cause COW amplification by
opportunistically writing out dirty extent buffers mid-transaction.
Skipping these is safe because the buffers remain dirty in the page
cache and will be written out at transaction commit time.

WB_SYNC_ALL must always proceed regardless of writeback_inhibitors.
This is required for correctness in the fsync path: btrfs_sync_log()
writes log tree blocks via filemap_fdatawrite_range() (WB_SYNC_ALL)
while the transaction handle that inhibited those same blocks is still
active. Without the WB_SYNC_ALL bypass, those inhibited log tree
blocks would be silently skipped, resulting in an incomplete log on
disk and corruption on replay. btrfs_write_and_wait_transaction()
also uses WB_SYNC_ALL via filemap_fdatawrite_range(); for that path,
inhibitors are already cleared beforehand, but the bypass ensures
correctness regardless.

Uninhibit in __btrfs_end_transaction() before atomic_dec(num_writers)
to prevent a race where the committer proceeds while buffers are still
inhibited. Also uninhibit in btrfs_commit_transaction() before writing
and in cleanup_transaction() for the error path.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c       |  4 +++
 fs/btrfs/extent_io.c   | 63 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/extent_io.h   |  6 ++++
 fs/btrfs/transaction.c | 19 +++++++++++++
 fs/btrfs/transaction.h |  3 ++
 5 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0e02b7b14adc..d4da65bb9096 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -590,6 +590,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_tree_unlock(buf);
 	free_extent_buffer_stale(buf);
 	btrfs_mark_buffer_dirty(trans, cow);
+
+	/* Inhibit writeback on the COW'd buffer for this transaction handle. */
+	btrfs_inhibit_eb_writeback(trans, cow);
+
 	*cow_ret = cow;
 	return 0;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ff1fc699a6ca..e04e42a81978 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1940,7 +1940,9 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 	 * of time.
 	 */
 	spin_lock(&eb->refs_lock);
-	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
+	if ((wbc->sync_mode == WB_SYNC_ALL ||
+	     atomic_read(&eb->writeback_inhibitors) == 0) &&
+	    test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
 		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
 		unsigned long flags;
 
@@ -2999,6 +3001,64 @@ static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
+/*
+ * btrfs_inhibit_eb_writeback - Inhibit writeback on buffer during transaction.
+ * @trans: transaction handle that will own the inhibitor
+ * @eb: extent buffer to inhibit writeback on
+ *
+ * Attempts to track this extent buffer in the transaction's inhibited set.
+ * If memory allocation fails, the buffer is simply not tracked. It may
+ * be written back and need re-COW, which is the original behavior.
+ * This is acceptable since inhibiting writeback is an optimization.
+ */
+void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
+				struct extent_buffer *eb)
+{
+	unsigned long index = eb->start >> trans->fs_info->nodesize_bits;
+	void *old;
+
+	/* Check if already inhibited by this handle. */
+	old = xa_load(&trans->writeback_inhibited_ebs, index);
+	if (old == eb)
+		return;
+
+	/* Take reference for the xarray entry. */
+	refcount_inc(&eb->refs);
+
+	old = xa_store(&trans->writeback_inhibited_ebs, index, eb, GFP_NOFS);
+	if (xa_is_err(old)) {
+		/* Allocation failed, just skip inhibiting this buffer. */
+		free_extent_buffer(eb);
+		return;
+	}
+
+	/* Handle replacement of different eb at same index. */
+	if (old && old != eb) {
+		struct extent_buffer *old_eb = old;
+
+		atomic_dec(&old_eb->writeback_inhibitors);
+		free_extent_buffer(old_eb);
+	}
+
+	atomic_inc(&eb->writeback_inhibitors);
+}
+
+/*
+ * btrfs_uninhibit_all_eb_writeback - Uninhibit writeback on all buffers.
+ * @trans: transaction handle to clean up
+ */
+void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans)
+{
+	struct extent_buffer *eb;
+	unsigned long index;
+
+	xa_for_each(&trans->writeback_inhibited_ebs, index, eb) {
+		atomic_dec(&eb->writeback_inhibitors);
+		free_extent_buffer(eb);
+	}
+	xa_destroy(&trans->writeback_inhibited_ebs);
+}
+
 static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 						   u64 start)
 {
@@ -3009,6 +3069,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	eb->len = fs_info->nodesize;
 	eb->fs_info = fs_info;
 	init_rwsem(&eb->lock);
+	atomic_set(&eb->writeback_inhibitors, 0);
 
 	btrfs_leak_debug_add_eb(eb);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 73571d5d3d5a..fb68fbd4866c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -102,6 +102,8 @@ struct extent_buffer {
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	s8 log_index;
 	u8 folio_shift;
+	/* Inhibits WB_SYNC_NONE writeback when > 0. */
+	atomic_t writeback_inhibitors;
 	struct rcu_head rcu_head;
 
 	struct rw_semaphore lock;
@@ -381,4 +383,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
 #define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
 #endif
 
+void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
+			       struct extent_buffer *eb);
+void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans);
+
 #endif
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f4cc9e1a1b93..a9a22629b49d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -15,6 +15,7 @@
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
+#include "extent_io.h"
 #include "transaction.h"
 #include "locking.h"
 #include "tree-log.h"
@@ -688,6 +689,8 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		goto alloc_fail;
 	}
 
+	xa_init(&h->writeback_inhibited_ebs);
+
 	/*
 	 * If we are JOIN_NOLOCK we're already committing a transaction and
 	 * waiting on this guy, so we don't need to do the sb_start_intwrite
@@ -1083,6 +1086,13 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	if (trans->type & __TRANS_FREEZABLE)
 		sb_end_intwrite(info->sb);
 
+	/*
+	 * Uninhibit extent buffer writeback before decrementing num_writers,
+	 * since the decrement wakes the committing thread which needs all
+	 * buffers uninhibited to write them to disk.
+	 */
+	btrfs_uninhibit_all_eb_writeback(trans);
+
 	WARN_ON(cur_trans != info->running_transaction);
 	WARN_ON(atomic_read(&cur_trans->num_writers) < 1);
 	atomic_dec(&cur_trans->num_writers);
@@ -2110,6 +2120,7 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 	if (!test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags))
 		btrfs_scrub_cancel(fs_info);
 
+	btrfs_uninhibit_all_eb_writeback(trans);
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
 }
 
@@ -2556,6 +2567,14 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	    fs_info->cleaner_kthread)
 		wake_up_process(fs_info->cleaner_kthread);
 
+	/*
+	 * Uninhibit writeback on all extent buffers inhibited during this
+	 * transaction before writing them to disk. Inhibiting prevented
+	 * writeback while the transaction was building, but now we need
+	 * them written.
+	 */
+	btrfs_uninhibit_all_eb_writeback(trans);
+
 	ret = btrfs_write_and_wait_transaction(trans);
 	if (unlikely(ret)) {
 		btrfs_err(fs_info, "error while writing out transaction: %d", ret);
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 18ef069197e5..7d70fe486758 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -12,6 +12,7 @@
 #include <linux/time64.h>
 #include <linux/mutex.h>
 #include <linux/wait.h>
+#include <linux/xarray.h>
 #include "btrfs_inode.h"
 #include "delayed-ref.h"
 
@@ -162,6 +163,8 @@ struct btrfs_trans_handle {
 	struct btrfs_fs_info *fs_info;
 	struct list_head new_bgs;
 	struct btrfs_block_rsv delayed_rsv;
+	/* Extent buffers with writeback inhibited by this handle. */
+	struct xarray writeback_inhibited_ebs;
 };
 
 /*
-- 
2.47.3


