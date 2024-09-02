Return-Path: <linux-btrfs+bounces-7715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69F967E7B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 06:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253641F211DF
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 04:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDFF14D6F9;
	Mon,  2 Sep 2024 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ph4u529E";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ph4u529E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A41E50B
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 04:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725251255; cv=none; b=ZngXbH+MXxmCf5JxhEm6TymI4v5F9wu1KjZ01uzQNo1n+b0vom46V6ZfgH+T6V1PUlkcbrNlwvyBRF6kNRxIhuSj17qpsas1i81+qWSaQGIdzSHJ8OgqbWMPMxOhA4mSw0jXiNY4QBPtZCeFW9hwHqcUk6SjSpFg90braNifeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725251255; c=relaxed/simple;
	bh=KaX6lKGFP6EAd7Ei0UAiPKTNH4fO19LdSEXWQbC9VH0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uVDKAuHagJ8LpswZ+ze/Q6Q4bLznPiDNSgJ0zPXZr93wKrb4gPmjtbnoyUCZxr+BCGuxL5floDkzuAo1NaL3B48NiAl7BO88nx1FroYo0ppXTwIkwfy0giUSUvj53OiIagM8GYoinuSfkgsCqvfqi+AH8vjjRvKdij4sbvkrCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ph4u529E; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ph4u529E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C8351FB8F
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 04:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725251251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=txhjrbamRsjCPCy8Jj6K92bgq5s0tsppxlXxiWknPBQ=;
	b=Ph4u529EKHiUTsLyEVcimCSPx4FrhwzYi9cUHkdHpGnPzoe7+dYhZ4XYM1yacrCU9eqUsQ
	9v3YTe+FmkIDFmKFDDG/cBlVmm0jqxpH3rMUowmr812BF6lmMPZAJpBgOk7IsRVlc/6Dwj
	VlYPg/WH+opjlXNKvtlknkflZluM7nI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ph4u529E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725251251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=txhjrbamRsjCPCy8Jj6K92bgq5s0tsppxlXxiWknPBQ=;
	b=Ph4u529EKHiUTsLyEVcimCSPx4FrhwzYi9cUHkdHpGnPzoe7+dYhZ4XYM1yacrCU9eqUsQ
	9v3YTe+FmkIDFmKFDDG/cBlVmm0jqxpH3rMUowmr812BF6lmMPZAJpBgOk7IsRVlc/6Dwj
	VlYPg/WH+opjlXNKvtlknkflZluM7nI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0BE113A7C
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 04:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qDIiGLI+1WYIegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 04:27:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: merge btrfs_folio_unlock_writer() into btrfs_folio_end_writer_lock()
Date: Mon,  2 Sep 2024 13:57:08 +0930
Message-ID: <4201e46852d085bf6e1790ea2cd12f5f970abb8a.1725251192.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C8351FB8F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function btrfs_folio_unlock_writer() is already calling
btrfs_folio_end_writer_lock() to do the heavy lifting work, the only
missing 0 writer check.

Thus there is no need to keep two different functions, move the 0 writer
check into btrfs_folio_end_writer_lock(), and remove
btrfs_folio_unlock_writer().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/subpage.c   | 81 +++++++++++++++++++-------------------------
 fs/btrfs/subpage.h   |  2 --
 3 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 485d88f9947b..70be1150c34e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2220,7 +2220,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 						       cur, cur_len, !ret);
 			mapping_set_error(mapping, ret);
 		}
-		btrfs_folio_unlock_writer(fs_info, folio, cur, cur_len);
+		btrfs_folio_end_writer_lock(fs_info, folio, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
 next_page:
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 7fe58c4d9923..2f071f4b8b8d 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -378,13 +378,47 @@ int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * Handle different locked folios:
+ *
+ * - Non-subpage folio
+ *   Just unlock it.
+ *
+ * - folio locked but without any subpage locked
+ *   This happens either before writepage_delalloc() or the delalloc range is
+ *   already handled by previous folio.
+ *   We can simple unlock it.
+ *
+ * - folio locked with subpage range locked.
+ *   We go through the locked sectors inside the range and clear their locked
+ *   bitmap, reduce the writer lock number, and unlock the page if that's
+ *   the last locked range.
+ */
 void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len)
 {
+	struct btrfs_subpage *subpage = folio_get_private(folio);
+
+	ASSERT(folio_test_locked(folio));
+
 	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
 		folio_unlock(folio);
 		return;
 	}
+
+	/*
+	 * For subpage case, there are two types of locked page.  With or
+	 * without writers number.
+	 *
+	 * Since we own the page lock, no one else could touch subpage::writers
+	 * and we are safe to do several atomic operations without spinlock.
+	 */
+	if (atomic_read(&subpage->writers) == 0) {
+		/* No writers, locked by plain lock_page() */
+		folio_unlock(folio);
+		return;
+	}
+
 	btrfs_subpage_clamp_range(folio, &start, &len);
 	if (btrfs_subpage_end_and_test_writer(fs_info, folio, start, len))
 		folio_unlock(folio);
@@ -702,53 +736,6 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-/*
- * Handle different locked pages with different page sizes:
- *
- * - Page locked by plain lock_page()
- *   It should not have any subpage::writers count.
- *   Can be unlocked by unlock_page().
- *   This is the most common locked page for extent_writepage() called
- *   inside extent_write_cache_pages().
- *   Rarer cases include the @locked_page from extent_write_locked_range().
- *
- * - Page locked by lock_delalloc_pages()
- *   There is only one caller, all pages except @locked_page for
- *   extent_write_locked_range().
- *   In this case, we have to call subpage helper to handle the case.
- */
-void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
-			       struct folio *folio, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage;
-
-	ASSERT(folio_test_locked(folio));
-	/* For non-subpage case, we just unlock the page */
-	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
-		folio_unlock(folio);
-		return;
-	}
-
-	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	subpage = folio_get_private(folio);
-
-	/*
-	 * For subpage case, there are two types of locked page.  With or
-	 * without writers number.
-	 *
-	 * Since we own the page lock, no one else could touch subpage::writers
-	 * and we are safe to do several atomic operations without spinlock.
-	 */
-	if (atomic_read(&subpage->writers) == 0) {
-		/* No writers, locked by plain lock_page() */
-		folio_unlock(folio);
-		return;
-	}
-
-	/* Have writers, use proper subpage helper to end it */
-	btrfs_folio_end_writer_lock(fs_info, folio, start, len);
-}
-
 /*
  * This is for folio already locked by plain lock_page()/folio_lock(), which
  * doesn't have any subpage awareness.
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index f90e0c4f4cab..f805261e0999 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -155,8 +155,6 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 
 void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 				  struct folio *folio, u64 start, u32 len);
-void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
-			       struct folio *folio, u64 start, u32 len);
 void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
 				    struct folio *folio,
 				    unsigned long *ret_bitmap);
-- 
2.46.0


