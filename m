Return-Path: <linux-btrfs+bounces-21952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENqnNrkXoGmzfgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21952-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 10:51:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A81A3C4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A62A9301FE59
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC7C38B7D5;
	Thu, 26 Feb 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clI6+nCe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78522316190
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099476; cv=none; b=neAu6WVZ7RsMORoRdvpVqLk47rDceMD274EWKUSWmQ95oPkomrxwNPx4E5D8SykeWHhJnNv0Cldq3ZNdbuQUKM0nXPIFX+mP+3k8l4S2CSI+cZ5Xuo2wJSbZyKyRXkO5x+AwXRkw7Bnr1nyTQq0DrbV7PXbxK+YqEUkUSDXesNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099476; c=relaxed/simple;
	bh=MPHvew53eMEEhwSPw1bOvm7qFldtyXDId/TaLI7AXx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X08JHMbXHik6YzmU3wxm00vxl78GcDa8VyMh3y0APXa6gU5L4I1LJMLXl9ZXjyZd+LGtuesVZ2a7mAX2WygZgjpAepB2LJJ7LxY7+z2LgV8hWGDt18iuMB5Ucutwrt7OThcXrfY5x2KwQ0wkOxDM6BsFP5C4sPu3gdcH+1Jc2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clI6+nCe; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-798527f822cso6361527b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 01:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772099473; x=1772704273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEmDvyJnUvzLr9D/XxcAsuC+G6Oh0WjW3A3Uwp2ROks=;
        b=clI6+nCeuvkjNIbltntOanZkmCGQKOi6p4V0Cq8hiKjW+Q+zc9BlQiaECyKI+1fu3Y
         M55lMnMYgAzsEr9gQvN3oDxraw6qvENSsQ8/+ZyL1OHmQ5MqfeDhgkzbBYgkUMa08oj1
         y0rvbNw6QQRsqjk7YCxMkn+yFUSISZ3JiY1BdPHHSpRTL1oegKtE43Sd0nUhIeWUhVYB
         75QwElxz3Ntw0JE2Qi/W5/eJBT1a+UEYAC/uFs7xYWfW3z6q4MnobsK+X+J/YbMFhhFY
         B4retROtgZ9VSNWqHFRy48KCCx5c3Dci8x15GFjngMHEONHZDMOS9WZnhpyUFAwbeHHq
         s8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772099473; x=1772704273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OEmDvyJnUvzLr9D/XxcAsuC+G6Oh0WjW3A3Uwp2ROks=;
        b=kkeL4bs3kocidJa/RbAYnvO/3STyMRct5TsWEFJjA778lXcsa69Wivr8F4Vk3YiCqu
         wTvSV+wpi+aLZS9VavuU1zbK/c13QY8L6+Q/9lKGcGq2+O5jYe2Wgr+F3mZlj4lpnBWq
         vI/imUOyPllU4xRn1aITZ9XVUdsrj5oM7Zmq7OMiqpanlecqkTl0PjFGJ+Md7RmW9CMT
         P8Qwedh/nQbhoxcHjdIVAJwC8zB7Ko7SHTGbjpw/0TSy/ygKYhjgNLoSaPXz0G5rlCV0
         G0bbi6hYO0tiKVs2piiY2WfjB5v5YYUykaOVNR+f1Hd9MMlE77L4BAFA7wfqV6kTBjuW
         68aA==
X-Gm-Message-State: AOJu0Ywe55G81jPAfMzWe5eQd2+SNu6KY7kOHhMUOv+O6TiLJD+mu6iG
	CjrvPP8RR/iUzs+Gy6t553zpg7kHzhvmUx9z+D9WTZLB41bQUUd1u345VZcstOi9
X-Gm-Gg: ATEYQzy1eBEQFMOn/x2MZ9AGRxSKI/8F3kOUcmIDP+PgHFyQ9iSHe2+zY6nuSYvU6A9
	nb/6WtSyEM7acGdnpPCe+lyn7ZxO1/2H4f0YpFK9iTzSMf9k3IOizVAXUOVc4iH/kqX2aaOGxaR
	fPCzRcTXjCdcLkK5bf1oDjncz6Xziooy9xmzCXibPAkcoOtxqAegxAyGlNsUglW/oeUMjyq603U
	Q1tyEqxky2D2J6AjYpfQYrxvqmRf4VYACoR++bJqh0TOlKth1nYugn4hvlrdEFT/OZjnxv/cpCP
	b9Z8BJEr2HdD4UrbeGP/ZFWBsZZTkBvy8ClR80CKhoCKV4PfCe5XuGY1HSFKxUmBE1w8Ji5LWvC
	33sk8opG8MishuOE/5aT6smdqcpw8USkEbk4ughPeSPW2uKtDJl1G4YyyE7fzEIne2Rj4Z38qZu
	Wr1nT9aJR2GievkS6S
X-Received: by 2002:a05:690c:4d8a:b0:794:fc73:5d2e with SMTP id 00721157ae682-7986ff54907mr34773207b3.54.1772099473201;
        Thu, 26 Feb 2026 01:51:13 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8feacsm7276047b3.11.2026.02.26.01.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:51:12 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v4 1/3] btrfs: skip COW for written extent buffers allocated in current transaction
Date: Thu, 26 Feb 2026 01:51:06 -0800
Message-ID: <e8e4f5e396d821ba9ed6a4eee073ae8628d52aeb.1772097864.git.loemra.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21952-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0B6A81A3C4F
X-Rspamd-Action: no action

When memory pressure causes writeback of a recently COW'd buffer,
btrfs sets BTRFS_HEADER_FLAG_WRITTEN on it. Subsequent
btrfs_search_slot() restarts then see the WRITTEN flag and re-COW
the buffer unnecessarily, causing COW amplification that can exhaust
block reservations and degrade throughput.

Overwriting in place is crash-safe because the committed superblock
does not reference buffers allocated in the current (uncommitted)
transaction, so no on-disk tree points to this block yet.

When should_cow_block() encounters a WRITTEN buffer whose generation
matches the current transaction, instead of requesting a COW, re-dirty
the buffer and re-register its range in the transaction's dirty_pages.

Both are necessary because btrfs tracks dirty metadata through two
independent mechanisms. set_extent_buffer_dirty() sets the
EXTENT_BUFFER_DIRTY flag and the buffer_tree xarray PAGECACHE_TAG_DIRTY
mark, which is what background writeback (btree_write_cache_pages) uses
to find and write dirty buffers. The transaction's dirty_pages io tree
is a separate structure used by btrfs_write_and_wait_transaction() at
commit time to ensure all buffers allocated during the transaction are
persisted. The dirty_pages range was originally registered in
btrfs_init_new_buffer() when the block was first allocated. Normally
dirty_pages is only cleared at commit time by
btrfs_write_and_wait_transaction(), but if qgroups are enabled and
snapshots are being created, qgroup_account_snapshot() may have already
called btrfs_write_and_wait_transaction() and released the range before
the final commit-time call.

Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
correctly pins the block if it is freed later.

Relax the lockdep assertion in btrfs_mark_buffer_dirty() from
btrfs_assert_tree_write_locked() to lockdep_assert_held() so that it
accepts either a read or write lock. should_cow_block() may be called
from btrfs_search_slot() when only a read lock is held (nodes above
write_lock_level are read-locked). The write lock assertion previously
documented the caller convention that buffer content was being modified
under exclusive access, but btrfs_mark_buffer_dirty() and
set_extent_buffer_dirty() themselves only perform independently
synchronized operations: atomic bit ops on bflags, folio_mark_dirty()
(kernel-internal folio locking), xarray mark updates (xarray spinlock),
and percpu counter updates. The read lock is sufficient because it
prevents lock_extent_buffer_for_io() from acquiring the write lock and
racing on the dirty state. Since rw_semaphore permits concurrent
readers, multiple threads can enter btrfs_mark_buffer_dirty()
simultaneously for the same buffer; this is safe because
test_and_set_bit(EXTENT_BUFFER_DIRTY) ensures only one thread performs
the full dirty state transition.

Remove the CONFIG_BTRFS_DEBUG assertion in set_extent_buffer_dirty()
that checked folio_test_dirty() after marking the buffer dirty. This
assertion assumed exclusive access (only one thread in
set_extent_buffer_dirty() at a time), which held when the only caller
was btrfs_mark_buffer_dirty() under write lock. With concurrent readers
calling through should_cow_block(), a thread that loses the
test_and_set_bit race sees was_dirty=true and skips the folio dirty
marking, but the winning thread may not have called
btrfs_meta_folio_set_dirty() yet, causing the assertion to fire. This
is a benign race: the winning thread will complete the folio dirty
marking, and no writeback can clear it while readers hold their locks.

Hoist the EXTENT_BUFFER_WRITEBACK, BTRFS_HEADER_FLAG_RELOC, and
BTRFS_ROOT_FORCE_COW checks before the WRITTEN block since they apply
regardless of whether the buffer has been written back. This
consolidates the exclusion logic and simplifies the WRITTEN path to
only handle log trees and zoned devices. Moving the RELOC checks
before the smp_mb__before_atomic() barrier is safe because both
btrfs_root_id() (immutable) and BTRFS_HEADER_FLAG_RELOC (set at COW
time under tree lock) are stable values not subject to concurrent
modification; the barrier is only needed for BTRFS_ROOT_FORCE_COW
which is set concurrently by create_pending_snapshot().

Exclude cases where in-place overwrite is not safe:
 - EXTENT_BUFFER_WRITEBACK: buffer is mid-I/O
 - Zoned devices: require sequential writes
 - Log trees: log blocks are immediately referenced by a committed
   superblock via btrfs_sync_log(), so overwriting could corrupt the
   committed log
 - BTRFS_ROOT_FORCE_COW: snapshot in progress
 - BTRFS_HEADER_FLAG_RELOC: block being relocated

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c     | 87 ++++++++++++++++++++++++++++++++++----------
 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/extent_io.c |  4 --
 3 files changed, 69 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7267b2502665..ea7cfc3a9e89 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -599,29 +599,40 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
+/*
+ * Check if @buf needs to be COW'd.
+ *
+ * Returns true if COW is required, false if the block can be reused
+ * in place.
+ *
+ * We do not need to COW a block if:
+ * 1) the block was created or changed in this transaction;
+ * 2) the block does not belong to TREE_RELOC tree;
+ * 3) the root is not forced COW.
+ *
+ * Forced COW happens when we create a snapshot during transaction commit:
+ * after copying the src root, we must COW the shared block to ensure
+ * metadata consistency.
+ *
+ * When returning false for a WRITTEN buffer allocated in the current
+ * transaction, re-dirties the buffer for in-place overwrite instead
+ * of requesting a new COW.
+ */
+static inline bool should_cow_block(struct btrfs_trans_handle *trans,
 				    const struct btrfs_root *root,
-				    const struct extent_buffer *buf)
+				    struct extent_buffer *buf)
 {
 	if (btrfs_is_testing(root->fs_info))
 		return false;
 
-	/*
-	 * We do not need to cow a block if
-	 * 1) this block is not created or changed in this transaction;
-	 * 2) this block does not belong to TREE_RELOC tree;
-	 * 3) the root is not forced COW.
-	 *
-	 * What is forced COW:
-	 *    when we create snapshot during committing the transaction,
-	 *    after we've finished copying src root, we must COW the shared
-	 *    block to ensure the metadata consistency.
-	 */
-
 	if (btrfs_header_generation(buf) != trans->transid)
 		return true;
 
-	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
+	if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags))
+		return true;
+
+	if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
+	    btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
 		return true;
 
 	/* Ensure we can see the FORCE_COW bit. */
@@ -629,11 +640,49 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
 	if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
 		return true;
 
-	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-		return false;
+	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
+		/*
+		 * The buffer was allocated in this transaction and has been
+		 * written back to disk (WRITTEN is set). Normally we'd COW
+		 * it again, but since the committed superblock doesn't
+		 * reference this buffer (it was allocated in this transaction),
+		 * we can safely overwrite it in place.
+		 *
+		 * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has been
+		 * persisted at this bytenr and will be again after the
+		 * in-place update. This is important so that
+		 * btrfs_free_tree_block() correctly pins the block if it is
+		 * freed later (e.g., during tree rebalancing or FORCE_COW).
+		 *
+		 * Log trees and zoned devices cannot use this optimization:
+		 * - Log trees: log blocks are written and immediately
+		 *   referenced by a committed superblock via
+		 *   btrfs_sync_log(), bypassing the normal transaction
+		 *   commit. Overwriting in place could corrupt the
+		 *   committed log.
+		 * - Zoned devices: require sequential writes.
+		 */
+		if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID ||
+		    btrfs_is_zoned(root->fs_info))
+			return true;
 
-	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
-		return true;
+		/*
+		 * Re-register this block's range in the current transaction's
+		 * dirty_pages so that btrfs_write_and_wait_transaction()
+		 * writes it. The range was originally registered when the
+		 * block was allocated. Normally dirty_pages is only cleared
+		 * at commit time by btrfs_write_and_wait_transaction(), but
+		 * if qgroups are enabled and snapshots are being created,
+		 * qgroup_account_snapshot() may have already called
+		 * btrfs_write_and_wait_transaction() and released the range
+		 * before the final commit-time call.
+		 */
+		btrfs_set_extent_bit(&trans->transaction->dirty_pages,
+				     buf->start,
+				     buf->start + buf->len - 1,
+				     EXTENT_DIRTY, NULL);
+		btrfs_mark_buffer_dirty(trans, buf);
+	}
 
 	return false;
 }
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 32fffb0557e5..bee8f76fbfea 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4491,7 +4491,7 @@ void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
 #endif
 	/* This is an active transaction (its state < TRANS_STATE_UNBLOCKED). */
 	ASSERT(trans->transid == fs_info->generation);
-	btrfs_assert_tree_write_locked(buf);
+	lockdep_assert_held(&buf->lock);
 	if (unlikely(transid != fs_info->generation)) {
 		btrfs_abort_transaction(trans, -EUCLEAN);
 		btrfs_crit(fs_info,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dfc17c292217..ff1fc699a6ca 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3791,10 +3791,6 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 					 eb->len,
 					 eb->fs_info->dirty_metadata_batch);
 	}
-#ifdef CONFIG_BTRFS_DEBUG
-	for (int i = 0; i < num_extent_folios(eb); i++)
-		ASSERT(folio_test_dirty(eb->folios[i]));
-#endif
 }
 
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
-- 
2.47.3


