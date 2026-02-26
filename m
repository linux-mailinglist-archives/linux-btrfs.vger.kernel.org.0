Return-Path: <linux-btrfs+bounces-21953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMWCFlIZoGmzfgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21953-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 10:58:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBDF1A3DCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 10:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16A7D312E24F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8932C314D18;
	Thu, 26 Feb 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGuMKVox"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245E318139
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099477; cv=none; b=Qugk4h1eL2g2HmfIuUBbUEibHzRCzu3I68rbQxdrNs/9dzHiA4QaAxyV+iYdbLpur4d6QfxRY7iNtdjvaVjxq1EPsQLf2I8+j+PQzo/fmYYKOgzZO9p/OF8WZP2AJ7mElyz1Qcx0RIGz88YRWsknu2omFT7VpGf+nU7C5h5sw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099477; c=relaxed/simple;
	bh=Q0A0piYxrUxRs+S245LT5lcH+6bjpqm3U6OqA0656kI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/omg5nN1xYmFAdPCYYSYglNjjlnOsqZArbk73r6+VohFNbzdfTvXNtUfdryYHjP0dPAIMjvhnluNkvDlQdbeWdKLh9xpa3h8lgUbr3kbghdG+KMPulNAv0WCkh49K+Hwo3fgt5LKwSEL54vR4YkW3S/QzV93LJDE5sMCpL/NAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGuMKVox; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so464101d50.1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772099475; x=1772704275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LR32YeLzci5ocTqko1GfF7LrWr2zVil+Uu/C7SPsRQ4=;
        b=bGuMKVoxEikx19PL/M1GuwD0HUFf8RdV7nqV5aDZcXcgtr4TWo1NkTX8zcgPOsUsga
         tMSZH2otp9PvUt622n2qd++mMNEmU52+uB0PFVnQ6uAM4qrc51SgtLAycrCOGNmlOP1G
         y4pmsvldmUOud5lnwZoL2jb3ZPOJ7DuO+BVEy1qkdAwVQqqFXxidFbpdjAxHIwt57EJc
         X07PMYRMS7dlsDnKnOeeCWyFXl9YJuGTdAltHZnAmcW0ZPDXqEoDdxcVyOJH882Ag4fl
         qzLJhlVtwY2lgH1gCRBHtc634edLz/0umNzbMqBC2rIQwpOjaTDXNsRrtqR0VtoOLiXO
         qJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772099475; x=1772704275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LR32YeLzci5ocTqko1GfF7LrWr2zVil+Uu/C7SPsRQ4=;
        b=YsVpHJKiXDY16Bw6VcJeCvtrEp7EuOOUsNEUWxCMGxSd3VjNPRM0OWiVmUqbBenm5W
         NO8N9XtWXq9l4v32HsnXtwPMsFCOpOlWdRQ/BpLPO/KMFlHpXUSXblgNB1XWQc5ittot
         9sAwjqBnZHShfaVQvLMP89tDaDxfnWU0QFHKSFid79cdVHOpd4QhvDQuyCmqIPNvXDYh
         kGvvL7lDzsIToAyml/u1Go1nhikVT50dcN7Qs4WAngs62O5ekO/v8tRuk9du4hbQDii/
         rbwirrKqv8xHWYx0bVTFSoDX9VaKFatpBmNnRN5G4BhBTAV70SHf4ZGK+tJnLQupu0le
         O4hQ==
X-Gm-Message-State: AOJu0Yx6B5hSEAmIcuhGUIQD58/erPqXmVG5jDVkXRgJduOHskvPqB3d
	27bK9QzL0caYhf85YLTcBqAm7Gi9CzWqIotshj7CvdKsJf2c5WJRqE7d5E3L4i6d
X-Gm-Gg: ATEYQzyjRdyB0AfF37BlbdmiQp+3/l0m06eKPqUlX4BLirsi0KN+V5WxpuM+rPZx7sh
	Nji/cSBYR+kZeiZydqQZrNtNVpWelKJyzxGX5bmLkCAw6p7+8wuAEVLzOm4Rkfp06uakbu5lPiK
	jQheiTOxXr+rb4BHCZcBBe6dWuvnqKDbs41+Qjat7sB73xcVN0LxGdTq5tWKYZ0BgTeR/eGtbhj
	IE5PS+45epGl00hD5AymLz0Lu6gnf6ygrIUgZQXXTY6dLelJjFEUghYieCcvkl0U6sAELSrgw1s
	+sQwUzjGhqQQmQHQR+nVurFHABbH3FeJthc9LyDr1qYajYBGWDklY5MgyRcrbSvXJs42SUwprzN
	h+Ct33ZMFQgUPW1e5ZFdaAwjSN5IjeSko/idTLHP8VcY6d+BMoBGTBjO/r0IqezGie9n25BbKcn
	YXSNQUXAaARF7acfo2
X-Received: by 2002:a53:d013:0:b0:64a:ee9d:8b7c with SMTP id 956f58d0204a3-64cb7c67789mr1089860d50.42.1772099475058;
        Thu, 26 Feb 2026 01:51:15 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb763f145sm800296d50.19.2026.02.26.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:51:14 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 2/3] btrfs: inhibit extent buffer writeback to prevent COW amplification
Date: Thu, 26 Feb 2026 01:51:07 -0800
Message-ID: <9e49ee6ee946e6cabb6b691693a955dbd201055c.1772097864.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772097864.git.loemra.dev@gmail.com>
References: <cover.1772097864.git.loemra.dev@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21953-lists,linux-btrfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FBDF1A3DCC
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

Also inhibit writeback in should_cow_block() when COW is skipped,
so that every transaction handle that reuses an already-COW'd buffer
also inhibits its writeback. Without this, if handle A COWs a block
and inhibits it, and handle B later reuses the same block without
inhibiting, handle A's uninhibit on end_transaction leaves the buffer
unprotected while handle B is still using it. This ensures all handles
that access a COW'd buffer contribute to the inhibitor count, and the
buffer remains protected until the last handle releases it.

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
---
 fs/btrfs/ctree.c       |  9 ++++++
 fs/btrfs/extent_io.c   | 63 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/extent_io.h   |  6 ++++
 fs/btrfs/transaction.c | 19 +++++++++++++
 fs/btrfs/transaction.h |  3 ++
 5 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ea7cfc3a9e89..46a715c95bc8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -21,6 +21,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "extent_io.h"
 #include "relocation.h"
 #include "file-item.h"
 
@@ -590,6 +591,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_tree_unlock(buf);
 	free_extent_buffer_stale(buf);
 	btrfs_mark_buffer_dirty(trans, cow);
+
+	/* Inhibit writeback on the COW'd buffer for this transaction handle. */
+	btrfs_inhibit_eb_writeback(trans, cow);
+
 	*cow_ret = cow;
 	return 0;
 
@@ -617,6 +622,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
  * When returning false for a WRITTEN buffer allocated in the current
  * transaction, re-dirties the buffer for in-place overwrite instead
  * of requesting a new COW.
+ *
+ * When returning false, inhibits background writeback on the buffer
+ * for the lifetime of the transaction handle.
  */
 static inline bool should_cow_block(struct btrfs_trans_handle *trans,
 				    const struct btrfs_root *root,
@@ -684,6 +692,7 @@ static inline bool should_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_mark_buffer_dirty(trans, buf);
 	}
 
+	btrfs_inhibit_eb_writeback(trans, buf);
 	return false;
 }
 
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


