Return-Path: <linux-btrfs+bounces-21893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GCtHpr6nWnLSwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21893-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 20:23:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94718BFF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D50B30451D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549B3ACEFD;
	Tue, 24 Feb 2026 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBATxj2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C43ACA6E
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960977; cv=none; b=NylkVSfl6SgAQfNytaLQWaons5MEXnAkK/Nscqx3qSWcepjWP+XHulKKce6x0ADOEHLrvBG/0D5xJCqQhgW0ekuqlBCmqbzFD7QxDeC+Fv6nER0xSyxd5me/gesBGt2CVe2hKxn0bpQWKbg4omWBklkWYJ1RBXHeyqDmJAKT4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960977; c=relaxed/simple;
	bh=gufBFGSI6wh5Vo6wxdgNEOu9rokSY9frOYuJC2UOYlM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXKUcVO19vEpw92quQthmBPz/VRlWGcXOpgeEGztT4hRr7IBJBjy7wq4kdlz56GrP8sCYe10phSRb6xVWXYJumVOLo7L5dlGeVw8pUqCpc80M8zr6FD5ZsDVBpKM0qU2d4OuCCQcBXsDT1ezpgs6w9QTY6/kFe6djIGr6CFGdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBATxj2m; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-649278a69c5so5924308d50.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960971; x=1772565771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD++iBj9IxDjwbbBgZSLqBIEox6IDYIGv8zNghuEH1I=;
        b=EBATxj2mjtgqj4wyddfp8s3KZrSzHayVfy1E53M7ZIGaSEkIIJjijNZRK27Smt/6Eg
         VA80nlh2yd9SVpV/WWo8IiKxfTRNJlbezj+S2d9BjRp+FyMhB8pCBXwFwuBBr5PddvaR
         ub5mIi7+HS2+uRQxTS7d5k8venhq1hpH5kGx3SUuRcc03EP9+6xl3c7d+exEYjNbcnLo
         OSjyz2UC4eF2Iv87XGZXnON9KX2AObKBPPk2M8Lv8Yow6KAyHzTnJiUQ/xkk8VLdw+mD
         uxhNN6XGZ7ouAeubbNiGpnYSzOznh/kqBmdrjcZt/U5+eK4OVltPNI66TMp7zAz8wzwd
         9trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960971; x=1772565771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oD++iBj9IxDjwbbBgZSLqBIEox6IDYIGv8zNghuEH1I=;
        b=aNRI21axThC7vQ4T3n4Rkm8rbxiG/sgyYGgXubUW2Cob5OZPHocvi75AtDX1Wv1NS4
         iA5tPKrJ5tBjcS0iOcsjk+LEMTcCsM7AZVPL+076E78CI97jIDqwalwQhVlvl8bJ0uLH
         oDCTje63KgRN0MB36MDdB+lhIPYQ/e3iDbsNCapeBHcvDXs4J7Y+HtO+GBzB89wLUEj/
         1wBdIfk1/gE+iGEZu6vm0v/qHPl/sWsl6Qel7AA0nSEnGIZ127jD9YIELROvNVryWR4m
         Y/kDLezF5D5aY21veTWpReQTxl9zmo7kKJ48xZ6dtPDgyELZUxqla4ZOIM8YqfilEu61
         jhZg==
X-Gm-Message-State: AOJu0YxSqvF7u2sXqsxUxmMieHIYx/axaqud1Mt447PsOWNXHVoblZYG
	+fydZCnHVQJzagl788qozsBNJkEewpqH0xV02Mw2wlukJBhzYd7r2GWY56iD7AME1W8=
X-Gm-Gg: ATEYQzx0sPKyH9YyxV1yowNciCoOi7kouPx0vjVOKRRBjEaJIDObtQrEO1ekZGdMWb2
	YwXIQotmFSLwOlKocBNL7lc4TZ/gFKNJCZ9EySBhxLKy1Z/hErlhlqX916UQKEvwgTxrqKPPDY1
	Gtvefua3aTrXQcWjdVDU8fJqtD56mQNiNGZo6CipfmzaNBOFzLLwNW/mtO02ICrFEgKh5072ytV
	dTxIz5VE8ahObNuxY9Y9SMVOnPvltVmT0y3/DyBTCUZmhcLFTFoNEiodcnuNTrfpMl8dlaC/FbM
	ibo9Os+OCCjntAzt8SrO6hgrIEJhrIohn6q7lWb5tkvKd9SJJY0Y+KQIpQypEvq4XjadGTg2csL
	mCqaSujerXlfeptrOMbt5Am+lhLFxoq2i3FTEBOJ3h5eYUtP0psty6UASLh2BevRFzQ7Uz+i0j9
	sP9+I5VcXlMFbDJ8PlccSGMMdEKVuO
X-Received: by 2002:a53:d008:0:b0:649:429a:4577 with SMTP id 956f58d0204a3-64c790a6274mr10830921d50.86.1771960971402;
        Tue, 24 Feb 2026 11:22:51 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a35b41bsm4709512d50.14.2026.02.24.11.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:22:51 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 1/3] btrfs: skip COW for written extent buffers allocated in current transaction
Date: Tue, 24 Feb 2026 11:22:32 -0800
Message-ID: <4ce911a475b998ddf76951629ad203e6440ab0ca.1771884128.git.loemra.dev@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21893-lists,linux-btrfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C94718BFF1
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
---
 fs/btrfs/ctree.c     | 56 ++++++++++++++++++++++++++++++++++++++------
 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/extent_io.c |  4 ----
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7267b2502665..0e02b7b14adc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -599,9 +599,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
+static inline bool should_cow_block(struct btrfs_trans_handle *trans,
 				    const struct btrfs_root *root,
-				    const struct extent_buffer *buf)
+				    struct extent_buffer *buf)
 {
 	if (btrfs_is_testing(root->fs_info))
 		return false;
@@ -621,7 +621,11 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
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
@@ -629,11 +633,49 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
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


