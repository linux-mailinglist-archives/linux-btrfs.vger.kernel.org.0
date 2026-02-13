Return-Path: <linux-btrfs+bounces-21674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEj5Bb6Lj2nURQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21674-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:38:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BA1397AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFF3C307E094
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 20:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0A9283FDC;
	Fri, 13 Feb 2026 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqaD2z6+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335E280338
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015028; cv=none; b=HtAP2bFKK8RGdShYl2gS02CIbakDbZ+jIemc9wQuLsv/eZ/xQUbRq0vukrpxGIASMeQzdCuYPwgDhKUKDEOjliecCRVW/FOf4dCbiEtzJOdjknKDfcNQdGwGZ5vLBAV+V/iU3Q/JSEQhsZbRTRmF2T7bXP+yXPdAnrYMrqdWgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015028; c=relaxed/simple;
	bh=8GijHF6RU04TOarbUe3vo51JVLi3eyLvdGIJA9IcIUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kK+DcInqhRWOPqkzqVUDSFs92w+l/6wim84f4r/qCbv4GAwgAqdAQKrgCETifMXtkJ7xUlrWuHlNdB+2G/bs+ux9J+5a9cR7fOF1vTnhPIgYM2YzKuFSO+lff3nrHIA3VIx/sBlRLJazGRMJEHZ7pHp5KMFC1E0VK5C3IO9RGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqaD2z6+; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7974d908318so16211807b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 12:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771015025; x=1771619825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wUCaLu1SdGjs5b2Ln33Bt14IS56C66jG5qvxmJrhnY=;
        b=AqaD2z6+I7cjbI5L6nD0hAa3wsXP0pVSiEWm7HhyGk9OU+8O9j2AMPdRlzGYAs5Wcg
         9TjnCxyO9irqa7wIz5/E9kX3SeYbN2cWIE/yDjFoG/iYiZ3Bmv3fn2Gw21zPmU32mp/j
         qvx34qrDzjW/CnkqdZCS1iYCV6LhtWUguehfs/q6+SBATsyFMDxDVJ5i+NikdExfLnmy
         vlt6t1i5FQCBl3NM2SjDUn70WW7BWZjlt5TdsOU1tsVOc+2EcLfE1teUa4Vy/GjdI/X4
         I21y9KGrL1G4RNmVnAbAfwOlN8UtbVbCVimsKegMSFsePX77cLZ/TuYMO+TNz2EjJ1ij
         Lt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771015025; x=1771619825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9wUCaLu1SdGjs5b2Ln33Bt14IS56C66jG5qvxmJrhnY=;
        b=gXfrMkTGR5SYIXhuaofINkb8c1R4MFZXR0FPkeqycepCphe2nNfWxdnacPR3GGP9XY
         pmUKknInz94PPEZUf0YVAakm+e0jeQ1PJzga3J5J5CEfLN1zBL1ng0xOfrtdgwmFj2CL
         cZu+nw4n//2KaMRKwsYHHbzjue8hy/ZBle0K8xA7uwpUd4BuhKb6Iieyahcc001ugG+/
         BNoSuat7LffCnYtKlPLGFQ5L1r1ImOS5IvOViSw3JmjgssiALhFo8cGMSXuilGbRtPFz
         boiW9WlLtQ9qZOECT/EnWLz79IxQFXXjI8YES0B0WTLEFKTa46uscm8bZXrOjH+cZ9RK
         PeUQ==
X-Gm-Message-State: AOJu0YzajTVYWqrHs+FJuSz5Cu2wKLAqPU6DjuWs9jqcMrq4wWixR736
	lcXCxtcKaWoLFt5d/qWILQ6KQ5uw4ZYE3k7huYo+7Uf2cmfT/Cm44FS5avIB4JYU
X-Gm-Gg: AZuq6aKzijyksouItaUAoVqueHaFjNHvLEZMm3sq1TuWonMXjL0cx6h4x9SN+xoSgM7
	ul/ykHU1+oBh2STm2qs4wKKa9M2ld1j+xm1IXGz6OlPKAslS+0j3HKjzxKzwqxTOMuw/POyQ3xz
	UqRjUiO7zyIqQxtcbGeo/jMdj/MKikuPo81/i809cXGOp4ygeqcU7bHtk+hke63zfX/pub2vxaL
	5xB5M0E3JOjWfBPGi5YCer/DwplrHgFg22RtZRnH46DETgPVfyCB9sqNS5IOxSCqTtXFYFv2twF
	j3RcZgz4utxasVNS0b526z1YIeIm+LemzCT0vBPXGXhaJXBXxPphEwEoi0tChPuy3R2UvKTu2A4
	Gm1zTgnr+Zndm3TrZJafw7x194vP23ojkYsJ1lLCvdwc7Xj1xQYKLkm7Y+CiUejN8vvWTC/GE46
	8/87Di0R07RGOK/XQSAXRy4iVWXbrW
X-Received: by 2002:a05:690c:86:b0:794:e463:d086 with SMTP id 00721157ae682-797ac66c2a9mr5905787b3.68.1771015025089;
        Fri, 13 Feb 2026 12:37:05 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23c244sm74188877b3.26.2026.02.13.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:37:04 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: inhibit extent buffer writeback to prevent COW amplification
Date: Fri, 13 Feb 2026 12:30:25 -0800
Message-ID: <14139b6aa359a53a1c12119fb84fcbd29227d498.1771012202.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771012202.git.loemra.dev@gmail.com>
References: <cover.1771012202.git.loemra.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21674-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D0BA1397AE
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
---
 fs/btrfs/ctree.c       |  4 +++
 fs/btrfs/extent_io.c   | 62 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/extent_io.h   |  5 ++++
 fs/btrfs/transaction.c | 19 +++++++++++++
 fs/btrfs/transaction.h |  2 ++
 5 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a345e1be24d8..55187ba59cc0 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -590,6 +590,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_tree_unlock(buf);
 	free_extent_buffer_stale(buf);
 	btrfs_mark_buffer_dirty(trans, cow);
+
+	/* Inhibit writeback on the COW'd buffer for this transaction handle */
+	btrfs_inhibit_eb_writeback(trans, cow);
+
 	*cow_ret = cow;
 	return 0;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dfc17c292217..0c9276cff299 100644
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
 
@@ -2999,6 +3001,63 @@ static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
+/*
+ * btrfs_inhibit_eb_writeback - Inhibit writeback on buffer during transaction
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
+	/* Check if already inhibited by this handle */
+	old = xa_load(&trans->writeback_inhibited_ebs, index);
+	if (old == eb)
+		return;
+
+	refcount_inc(&eb->refs);	/* Take reference */
+
+	old = xa_store(&trans->writeback_inhibited_ebs, index, eb, GFP_NOFS);
+	if (xa_is_err(old)) {
+		/* Allocation failed, just skip inhibiting this buffer */
+		free_extent_buffer(eb);
+		return;
+	}
+
+	/* Handle replacement of different eb at same index */
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
+ * btrfs_uninhibit_all_eb_writeback - Uninhibit writeback on all buffers
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
@@ -3009,6 +3068,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	eb->len = fs_info->nodesize;
 	eb->fs_info = fs_info;
 	init_rwsem(&eb->lock);
+	atomic_set(&eb->writeback_inhibitors, 0);
 
 	btrfs_leak_debug_add_eb(eb);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 73571d5d3d5a..4b15a5d8bc0f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -102,6 +102,7 @@ struct extent_buffer {
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	s8 log_index;
 	u8 folio_shift;
+	atomic_t writeback_inhibitors;	/* inhibits writeback when > 0 */
 	struct rcu_head rcu_head;
 
 	struct rw_semaphore lock;
@@ -381,4 +382,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
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
index 18ef069197e5..f0d12c16d796 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -12,6 +12,7 @@
 #include <linux/time64.h>
 #include <linux/mutex.h>
 #include <linux/wait.h>
+#include <linux/xarray.h>
 #include "btrfs_inode.h"
 #include "delayed-ref.h"
 
@@ -162,6 +163,7 @@ struct btrfs_trans_handle {
 	struct btrfs_fs_info *fs_info;
 	struct list_head new_bgs;
 	struct btrfs_block_rsv delayed_rsv;
+	struct xarray writeback_inhibited_ebs;	/* ebs with writeback inhibited */
 };
 
 /*
-- 
2.47.3


