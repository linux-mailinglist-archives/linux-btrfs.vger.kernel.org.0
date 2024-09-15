Return-Path: <linux-btrfs+bounces-8039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97915979978
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 01:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE381C21DBD
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA612E1CD;
	Sun, 15 Sep 2024 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H511x3UJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H511x3UJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901147F69
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726441924; cv=none; b=pugDN0EQYxlcuF3e0uhlR+LAeABHcE+gX4s2cC7Ns+GXOEKI6MF43T4sl1Yrn/z4zP2yq/EGTgIAIqRaJrqc9Rg9o+5vxY1/PFuDj8ERgrBbdIv0Gf5efEM8zXIJ3XH9sLwvpfWd2lPr4mjAL0CjInmfXhdf8hoKE6JFhu5mMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726441924; c=relaxed/simple;
	bh=+VNJHeJtPSR34m/l7MKM2MIblGc9ZiJsv1MdCFFWLXk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVyc56V1bweddyd5xf9D9iwlCIalfIrqGFi8SP60yi0a99zKgr8uwTSDV+ZYmVY4G9RMz+EB9MlVkxq7yRCf79JveIMJxnhlie30CPUA20hAK3U04Vg83mLj6fNRvJnBKmB0RiqRkzhVSl/NbfOPRK4N5FdBYJXYbogc9k6Xa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H511x3UJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H511x3UJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 237BE1F836
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726441914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKoxXEeDFsG8dsxQFtTHMT3GG99uwGeJR8Ju6JII3ik=;
	b=H511x3UJ+1ouOLTjEEQPu7j2X8GvGd/ryPmjrhG31zk1ip6I+JtQHzN9SI53uWUH7Lz8QU
	d00k7MgSPtzAOyhVPLbCzp+WtzDS3w36ALUU2q8NCxUPyKgL1wqWfY1rgGOr4R2YhSiA+Z
	jlMsTLtv/I5ToseO5UT6xlpijz74t/8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726441914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKoxXEeDFsG8dsxQFtTHMT3GG99uwGeJR8Ju6JII3ik=;
	b=H511x3UJ+1ouOLTjEEQPu7j2X8GvGd/ryPmjrhG31zk1ip6I+JtQHzN9SI53uWUH7Lz8QU
	d00k7MgSPtzAOyhVPLbCzp+WtzDS3w36ALUU2q8NCxUPyKgL1wqWfY1rgGOr4R2YhSiA+Z
	jlMsTLtv/I5ToseO5UT6xlpijz74t/8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F2911351A
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qCFGBLlp52aRLAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:11:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: move the delalloc range bitmap search into extent_io.c
Date: Mon, 16 Sep 2024 08:41:29 +0930
Message-ID: <851a6314a3409eaa5211e36bca1ff36a6cc188aa.1726441226.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726441226.git.wqu@suse.com>
References: <cover.1726441226.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently for subpage (sector size < page size) cases, we reuse subpage
locked bitmap to find out all delalloc ranges we have locked, and run
all those found ranges.

However such reuse is not perfect, e.g.:

    0       32K      64K      96K       128K
    |       |////////||///////|    |////|
                                   120K

For above range, writepage_delalloc() for page 0 will handle the range
[32K, 96k), note delalloc range can be beyond the page boundary.

But writepage_delalloc() for page 64K will only handle range [120K,
128K), as the previous run on page 0 has already handled range [64K,
96K).
Meanwhile for the writeback we should expect range [64K, 96K) to also be
locked, this leads to the mismatch from locked bitmap and delalloc
range.

This is not causing problems yet, but it's still an inconsistent
behavior.

So instead of relying on the subpage locked bitmap, move the delalloc
range search using local @delalloc_bitmap, so that we can remove the
existing btrfs_folio_find_writer_locked().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 44 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/subpage.c   | 47 --------------------------------------------
 fs/btrfs/subpage.h   |  4 ----
 3 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 982bb469046f..1210e24b6277 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1101,6 +1101,45 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	return ret;
 }
 
+static void set_delalloc_bitmap(struct folio *folio, unsigned long *delalloc_bitmap,
+				u64 start, u32 len)
+{
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
+	const u64 folio_start = folio_pos(folio);
+	unsigned int start_bit;
+	unsigned int nbits;
+
+	ASSERT(start >= folio_start && start + len <= folio_start + PAGE_SIZE);
+	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
+	nbits = len >> fs_info->sectorsize_bits;
+	ASSERT(bitmap_test_range_all_zero(delalloc_bitmap, start_bit, nbits));
+	bitmap_set(delalloc_bitmap, start_bit, nbits);
+}
+
+static bool find_next_delalloc_bitmap(struct folio *folio,
+				      unsigned long *delalloc_bitmap, u64 start,
+				      u64 *found_start, u32 *found_len)
+{
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
+	const u64 folio_start = folio_pos(folio);
+	const unsigned int bitmap_size = fs_info->sectors_per_page;
+	unsigned int start_bit;
+	unsigned int first_zero;
+	unsigned int first_set;
+
+	ASSERT(start >= folio_start && start < folio_start + PAGE_SIZE);
+
+	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
+	first_set = find_next_bit(delalloc_bitmap, bitmap_size, start_bit);
+	if (first_set >= bitmap_size)
+		return false;
+
+	*found_start = folio_start + (first_set << fs_info->sectorsize_bits);
+	first_zero = find_next_zero_bit(delalloc_bitmap, bitmap_size, first_set);
+	*found_len = (first_zero - first_set) << fs_info->sectorsize_bits;
+	return true;
+}
+
 /*
  * helper for extent_writepage(), doing all of the delayed allocation setup.
  *
@@ -1120,6 +1159,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	const bool is_subpage = btrfs_is_subpage(fs_info, folio->mapping);
 	const u64 page_start = folio_pos(folio);
 	const u64 page_end = page_start + folio_size(folio) - 1;
+	unsigned long delalloc_bitmap = 0;
 	/*
 	 * Save the last found delalloc end. As the delalloc end can go beyond
 	 * page boundary, thus we cannot rely on subpage bitmap to locate the
@@ -1147,6 +1187,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
+		set_delalloc_bitmap(folio, &delalloc_bitmap, delalloc_start,
+				    min(delalloc_end, page_end) + 1 - delalloc_start);
 		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
 					    min(delalloc_end, page_end) + 1 -
 					    delalloc_start);
@@ -1174,7 +1216,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			found_len = last_delalloc_end + 1 - found_start;
 			found = true;
 		} else {
-			found = btrfs_subpage_find_writer_locked(fs_info, folio,
+			found = find_next_delalloc_bitmap(folio, &delalloc_bitmap,
 					delalloc_start, &found_start, &found_len);
 		}
 		if (!found)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 8a8724c4a0a1..bb02d2ef899f 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -801,53 +801,6 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-/*
- * Find any subpage writer locked range inside @folio, starting at file offset
- * @search_start. The caller should ensure the folio is locked.
- *
- * Return true and update @found_start_ret and @found_len_ret to the first
- * writer locked range.
- * Return false if there is no writer locked range.
- */
-bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
-				      struct folio *folio, u64 search_start,
-				      u64 *found_start_ret, u32 *found_len_ret)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const u32 sectors_per_page = fs_info->sectors_per_page;
-	const unsigned int len = PAGE_SIZE - offset_in_page(search_start);
-	const unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
-						locked, search_start, len);
-	const unsigned int locked_bitmap_start = sectors_per_page * btrfs_bitmap_nr_locked;
-	const unsigned int locked_bitmap_end = locked_bitmap_start + sectors_per_page;
-	unsigned long flags;
-	int first_zero;
-	int first_set;
-	bool found = false;
-
-	ASSERT(folio_test_locked(folio));
-	spin_lock_irqsave(&subpage->lock, flags);
-	first_set = find_next_bit(subpage->bitmaps, locked_bitmap_end, start_bit);
-	if (first_set >= locked_bitmap_end)
-		goto out;
-
-	found = true;
-
-	*found_start_ret = folio_pos(folio) +
-		((first_set - locked_bitmap_start) << fs_info->sectorsize_bits);
-	/*
-	 * Since @first_set is ensured to be smaller than locked_bitmap_end
-	 * here, @found_start_ret should be inside the folio.
-	 */
-	ASSERT(*found_start_ret < folio_pos(folio) + PAGE_SIZE);
-
-	first_zero = find_next_zero_bit(subpage->bitmaps, locked_bitmap_end, first_set);
-	*found_len_ret = (first_zero - first_set) << fs_info->sectorsize_bits;
-out:
-	spin_unlock_irqrestore(&subpage->lock, flags);
-	return found;
-}
-
 #define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
 {									\
 	const int sectors_per_page = fs_info->sectors_per_page;		\
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 4b85d91d0e18..d16fbddeda68 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -108,10 +108,6 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len);
 void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 					struct folio *folio, unsigned long bitmap);
-bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
-				      struct folio *folio, u64 search_start,
-				      u64 *found_start_ret, u32 *found_len_ret);
-
 /*
  * Template for subpage related operations.
  *
-- 
2.46.0


