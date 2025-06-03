Return-Path: <linux-btrfs+bounces-14405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A43ACC207
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 10:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DDC16EFE0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D1280A58;
	Tue,  3 Jun 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WuRlV/wp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WuRlV/wp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC262C3244
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938611; cv=none; b=J0Z0C94AEYuARFTnjtFxiEBAVY4qDdSARo0hdy2RTH7w+qtPFxFRos68r/dM7n7e7cQ3TFursGNSR+ona6b5gLExObk8MnxMwhxs7odP5aTyc+r2Xv63g+7PuYbb2ZlfylCgUx4kWpgxq4m4HISG9HbTukZ0eGO18E+fK6D+rMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938611; c=relaxed/simple;
	bh=+hMNtigLxnVuovS0QanPIXuYtggBVO6DxW4prjNe+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVJ/DIiLNz/2IsXz1EXtIqxjrs/PxotFyHmvFZM1BxtCeOe6eQLv0FHh9BrLp2sRq+MbNS/kewTKOWrfSq9jTVhCRMmOypXQ0asnb8SNRb5GutpE4Yq+4AUl7I4Ub2id2T8cgn1qfbb1/Q9lpnmC4tWKjfFt/SHztIU9aN3CuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WuRlV/wp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WuRlV/wp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0118F211D5;
	Tue,  3 Jun 2025 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748938596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDxaq/8cd+OExWfZf6qSIeccbi0FjxxAYyUygO2STBg=;
	b=WuRlV/wpRU+3r+Z+PYhcP1dyyBtt9KedZT7ZoL8HWlge8NEIoSboWQW/jh9bhhvQtbxPx2
	D5k25X8qYwEsSunWJT5cWVlJ8+OR9LEIdSHLpC7n/OnxpTsqwi2jfotCMS4oEwxgE/1oWx
	rMxPPSH+aFnxWTDsrgZ0B23/aIlvaaI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748938596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDxaq/8cd+OExWfZf6qSIeccbi0FjxxAYyUygO2STBg=;
	b=WuRlV/wpRU+3r+Z+PYhcP1dyyBtt9KedZT7ZoL8HWlge8NEIoSboWQW/jh9bhhvQtbxPx2
	D5k25X8qYwEsSunWJT5cWVlJ8+OR9LEIdSHLpC7n/OnxpTsqwi2jfotCMS4oEwxgE/1oWx
	rMxPPSH+aFnxWTDsrgZ0B23/aIlvaaI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDE2A13A92;
	Tue,  3 Jun 2025 08:16:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IlwSOmOvPmivIgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 03 Jun 2025 08:16:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: use folio_end() where appropriate
Date: Tue,  3 Jun 2025 10:16:18 +0200
Message-ID: <ffacde8b05e70651b43ceb9077b4ebd059e875a2.1748938504.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748938504.git.dsterba@suse.com>
References: <cover.1748938504.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Simplify folio_pos() + folio_size() and use the new helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.h  |  7 +++----
 fs/btrfs/defrag.c       |  7 +++----
 fs/btrfs/extent_io.c    | 17 ++++++++---------
 fs/btrfs/file.c         |  9 ++++-----
 fs/btrfs/inode.c        | 10 ++++------
 fs/btrfs/ordered-data.c |  2 +-
 fs/btrfs/subpage.c      |  5 ++---
 7 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index d34c4341eaf485..1df3c8dec40a91 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -13,6 +13,7 @@
 #include <linux/wait.h>
 #include <linux/pagemap.h>
 #include "bio.h"
+#include "fs.h"
 #include "messages.h"
 
 struct address_space;
@@ -77,12 +78,10 @@ struct compressed_bio {
 /* @range_end must be exclusive. */
 static inline u32 btrfs_calc_input_length(struct folio *folio, u64 range_end, u64 cur)
 {
-	const u64 folio_end = folio_pos(folio) + folio_size(folio);
-
 	/* @cur must be inside the folio. */
 	ASSERT(folio_pos(folio) <= cur);
-	ASSERT(cur < folio_end);
-	return min(range_end, folio_end) - cur;
+	ASSERT(cur < folio_end(folio));
+	return min(range_end, folio_end(folio)) - cur;
 }
 
 int __init btrfs_init_compress(void);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index e5739835ad02f0..ed15034f33d736 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -886,7 +886,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 	}
 
 	folio_start = folio_pos(folio);
-	folio_last = folio_pos(folio) + folio_size(folio) - 1;
+	folio_last = folio_end(folio) - 1;
 	/* Wait for any existing ordered extent in the range */
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
@@ -1178,8 +1178,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 
 		if (!folio)
 			break;
-		if (start >= folio_pos(folio) + folio_size(folio) ||
-		    start + len <= folio_pos(folio))
+		if (start >= folio_end(folio) || start + len <= folio_pos(folio))
 			continue;
 		btrfs_folio_clamp_clear_checked(fs_info, folio, start, len);
 		btrfs_folio_clamp_set_dirty(fs_info, folio, start, len);
@@ -1220,7 +1219,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 			folios[i] = NULL;
 			goto free_folios;
 		}
-		cur = folio_pos(folios[i]) + folio_size(folios[i]);
+		cur = folio_end(folios[i]);
 	}
 	for (int i = 0; i < nr_pages; i++) {
 		if (!folios[i])
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c562b589876e50..9c099e672236e2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -266,8 +266,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 				goto out;
 			}
 			range_start = max_t(u64, folio_pos(folio), start);
-			range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
-					  end + 1) - range_start;
+			range_len = min_t(u64, folio_end(folio), end + 1) - range_start;
 			btrfs_folio_set_lock(fs_info, folio, range_start, range_len);
 
 			processed_end = range_start + range_len - 1;
@@ -321,7 +320,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	ASSERT(orig_end > orig_start);
 
 	/* The range should at least cover part of the folio */
-	ASSERT(!(orig_start >= folio_pos(locked_folio) + folio_size(locked_folio) ||
+	ASSERT(!(orig_start >= folio_end(locked_folio) ||
 		 orig_end <= folio_pos(locked_folio)));
 again:
 	/* step one, find a bunch of delalloc bytes starting at start */
@@ -419,7 +418,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
 	ASSERT(folio_pos(folio) <= start &&
-	       start + len <= folio_pos(folio) + folio_size(folio));
+	       start + len <= folio_end(folio));
 
 	if (uptodate && btrfs_verify_folio(folio, start, len))
 		btrfs_folio_set_uptodate(fs_info, folio, start, len);
@@ -1086,7 +1085,7 @@ static bool can_skip_one_ordered_range(struct btrfs_inode *inode,
 	 * finished our folio read and unlocked the folio.
 	 */
 	if (btrfs_folio_test_dirty(fs_info, folio, cur, blocksize)) {
-		u64 range_len = min(folio_pos(folio) + folio_size(folio),
+		u64 range_len = min(folio_end(folio),
 				    ordered->file_offset + ordered->num_bytes) - cur;
 
 		ret = true;
@@ -1108,7 +1107,7 @@ static bool can_skip_one_ordered_range(struct btrfs_inode *inode,
 	 * So we return true and update @next_ret to the OE/folio boundary.
 	 */
 	if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
-		u64 range_len = min(folio_pos(folio) + folio_size(folio),
+		u64 range_len = min(folio_end(folio),
 				    ordered->file_offset + ordered->num_bytes) - cur;
 
 		/*
@@ -2085,7 +2084,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
-		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
+		u32 range_len = min_t(u64, folio_end(folio),
 				      eb->start + eb->len) - range_start;
 
 		folio_lock(folio);
@@ -2489,7 +2488,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 			continue;
 		}
 
-		cur_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1, end);
+		cur_end = min_t(u64, folio_end(folio) - 1, end);
 		cur_len = cur_end + 1 - cur;
 
 		ASSERT(folio_test_locked(folio));
@@ -3726,7 +3725,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
-		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
+		u32 range_len = min_t(u64, folio_end(folio),
 				      eb->start + eb->len) - range_start;
 
 		bio_add_folio_nofail(&bbio->bio, folio, range_len,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8ce6f45f45e0bb..12fa50e2fd39cf 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -89,8 +89,7 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio, loff_t pos
 	num_bytes = round_up(write_bytes + pos - start_pos,
 			     fs_info->sectorsize);
 	ASSERT(num_bytes <= U32_MAX);
-	ASSERT(folio_pos(folio) <= pos &&
-	       folio_pos(folio) + folio_size(folio) >= pos + write_bytes);
+	ASSERT(folio_pos(folio) <= pos && folio_end(folio) >= pos + write_bytes);
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
@@ -801,7 +800,7 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
 				  u64 len)
 {
 	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
-	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
+	u64 clamp_end = min_t(u64, pos + len, folio_end(folio));
 	const u32 blocksize = inode_to_fs_info(inode)->sectorsize;
 	int ret = 0;
 
@@ -1233,8 +1232,8 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 	 * The reserved range goes beyond the current folio, shrink the reserved
 	 * space to the folio boundary.
 	 */
-	if (reserved_start + reserved_len > folio_pos(folio) + folio_size(folio)) {
-		const u64 last_block = folio_pos(folio) + folio_size(folio);
+	if (reserved_start + reserved_len > folio_end(folio)) {
+		const u64 last_block = folio_end(folio);
 
 		shrink_reserved_space(inode, *data_reserved, reserved_start,
 				      reserved_len, last_block - reserved_start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 98abb101623aa1..162ccd58613e15 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2328,8 +2328,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 	 * The range must cover part of the @locked_folio, or a return of 1
 	 * can confuse the caller.
 	 */
-	ASSERT(!(end <= folio_pos(locked_folio) ||
-		 start >= folio_pos(locked_folio) + folio_size(locked_folio)));
+	ASSERT(!(end <= folio_pos(locked_folio) || start >= folio_end(locked_folio)));
 
 	if (should_nocow(inode, start, end)) {
 		ret = run_delalloc_nocow(inode, locked_folio, start, end);
@@ -2737,7 +2736,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	struct btrfs_inode *inode = fixup->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 page_start = folio_pos(folio);
-	u64 page_end = folio_pos(folio) + folio_size(folio) - 1;
+	u64 page_end = folio_end(folio) - 1;
 	int ret = 0;
 	bool free_delalloc_space = true;
 
@@ -4818,7 +4817,7 @@ static int truncate_block_zero_beyond_eof(struct btrfs_inode *inode, u64 start)
 	 */
 
 	zero_start = max_t(u64, folio_pos(folio), start);
-	zero_end = folio_pos(folio) + folio_size(folio) - 1;
+	zero_end = folio_end(folio) - 1;
 	folio_zero_range(folio, zero_start - folio_pos(folio),
 			 zero_end - zero_start + 1);
 
@@ -4998,8 +4997,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 		 * not reach disk, it still affects our page caches.
 		 */
 		zero_start = max_t(u64, folio_pos(folio), start);
-		zero_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
-				 end);
+		zero_end = min_t(u64, folio_end(folio) - 1, end);
 	} else {
 		zero_start = max_t(u64, block_start, start);
 		zero_end = min_t(u64, block_end, end);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 9212ce110cdeef..2829f20d7bb59d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -359,7 +359,7 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	if (folio) {
 		ASSERT(folio->mapping);
 		ASSERT(folio_pos(folio) <= file_offset);
-		ASSERT(file_offset + len <= folio_pos(folio) + folio_size(folio));
+		ASSERT(file_offset + len <= folio_end(folio));
 
 		/*
 		 * Ordered flag indicates whether we still have
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 9b63a4d1c98906..2c5c9262b1a83f 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -187,7 +187,7 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	 */
 	if (folio->mapping)
 		ASSERT(folio_pos(folio) <= start &&
-		       start + len <= folio_pos(folio) + folio_size(folio));
+		       start + len <= folio_end(folio));
 }
 
 #define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
@@ -216,8 +216,7 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 	if (folio_pos(folio) >= orig_start + orig_len)
 		*len = 0;
 	else
-		*len = min_t(u64, folio_pos(folio) + folio_size(folio),
-			     orig_start + orig_len) - *start;
+		*len = min_t(u64, folio_end(folio), orig_start + orig_len) - *start;
 }
 
 static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
-- 
2.49.0


