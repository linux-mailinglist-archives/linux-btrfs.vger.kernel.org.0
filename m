Return-Path: <linux-btrfs+bounces-2471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F95858E3E
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 10:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE25281F1C
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97F51CFB6;
	Sat, 17 Feb 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PASrEwKl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PASrEwKl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA61CD28
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708160691; cv=none; b=TBA5XUHEGomTNxRbIoA9i8j7IcnWLoURj1OI0UxDWqJodZbol5ZCKCO/TxyNciD7hKN6b8XWnmbAOvVrx+pKXJBSLqMOYs7lYXKSCWD8O73R2Xc2k6OqIlJeLm5PSmQzS29oyDAeFPSyr3M9k1BBSHemPNCN9APkV9G/T+xdP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708160691; c=relaxed/simple;
	bh=yy1K1gBPEk5CmcZVp0VfresExPe5BCExhTeN3D6dQdk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B1OKfzX319s8rDvI45YJnwxsyTvgQbeN4vV6M7BNVALPSo55Houj2mYzNwUZVtrxV1YS7YSRpmTpmTo3aSvNNUPWF/mKeJwF0SsteNp+4OlPezCribWDngJiuT0eoagGwcTYZKUjUO12fqjHG2W5BcDU27E/FM7ETihisRTPkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PASrEwKl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PASrEwKl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A8CB1F455
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 09:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708160683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=peodSUOjXNwOcjvM5hSNedwVDktHGJsZwkOJNncda+o=;
	b=PASrEwKl5WUx5wkTLU66171djxEmL2qmXj7jK1kCquEQQYWrF23l3QQ9XYSvkM31xsVtmC
	84zNPqyOadKYEhNR1hUmrMmc4TtbhnTTABNoPqqU+b1najkfTn5mJ70/M0pKHOFuXUzzCa
	Y8c2j+EaOXFbg9qSNAt/i0diHlvM0Fk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708160683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=peodSUOjXNwOcjvM5hSNedwVDktHGJsZwkOJNncda+o=;
	b=PASrEwKl5WUx5wkTLU66171djxEmL2qmXj7jK1kCquEQQYWrF23l3QQ9XYSvkM31xsVtmC
	84zNPqyOadKYEhNR1hUmrMmc4TtbhnTTABNoPqqU+b1najkfTn5mJ70/M0pKHOFuXUzzCa
	Y8c2j+EaOXFbg9qSNAt/i0diHlvM0Fk=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 75FBD1332F
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 09:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sAJqDqp20GXIfQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 09:04:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make find_lock_delalloc_range() to search until the page end.
Date: Sat, 17 Feb 2024 19:34:39 +1030
Message-ID: <0e21cf35395fd49b87c940cb86332961c1236157.1708160640.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PASrEwKl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 3A8CB1F455
X-Spam-Flag: NO

Currently all caller of lock_delalloc_pages() would assigned @end to the
end of the page, thus if we return false, there is no more delalloc
range in the page.

Thus there is really no need to update @start/@end when we return false,
callers doesn't really utilize that value either.

Finally since the end is always the page end, we only need to make sure
the @start is inside the locked page, thus the ASSERT()s can be
simplified.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c             | 34 +++++++++++++-------------------
 fs/btrfs/tests/extent-io-tests.c | 10 ----------
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 197b9f50e75c..50c58c8568ff 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -306,16 +306,19 @@ static noinline int lock_delalloc_pages(struct inode *inode,
  * Find and lock a contiguous range of bytes in the file marked as delalloc, no
  * more than @max_bytes.
  *
- * @start:	The original start bytenr to search.
- *		Will store the extent range start bytenr.
- * @end:	The original end bytenr of the search range
- *		Will store the extent range end bytenr.
+ * @start:	INPUT and OUTPUT.
+ *		INPUT for the original start bytenr to search.
+ *		OUTPUT to store the found delalloc range start bytenr.
+ *		The output value is still inside the locked page.
+ * @end:	OUTPUT only.
+ *		OUTPUT to store the delalloc range end bytenr.
+ *		The output value can go beyond the locked page.
  *
  * Return true if we find a delalloc range which starts inside the original
  * range, and @start/@end will store the delalloc range start/end.
  *
  * Return false if we can't find any delalloc range which starts inside the
- * original range, and @start/@end will be the non-delalloc range start/end.
+ * original range and @start/@end won't be touched.
  */
 EXPORT_FOR_TESTS
 noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
@@ -325,7 +328,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	const u64 orig_start = *start;
-	const u64 orig_end = *end;
+	const u64 orig_end = page_offset(locked_page) + PAGE_SIZE - 1;
 	/* The sanity tests may not set a valid fs_info. */
 	u64 max_bytes = fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT_SIZE;
 	u64 delalloc_start;
@@ -335,12 +338,10 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	int ret;
 	int loops = 0;
 
-	/* Caller should pass a valid @end to indicate the search range end */
-	ASSERT(orig_end > orig_start);
+	/* The original start must be inside the @locked page. */
+	ASSERT(orig_start >= page_offset(locked_page) &&
+	       orig_start < page_offset(locked_page) + PAGE_SIZE);
 
-	/* The range should at least cover part of the page */
-	ASSERT(!(orig_start >= page_offset(locked_page) + PAGE_SIZE ||
-		 orig_end <= page_offset(locked_page)));
 again:
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
@@ -348,10 +349,6 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
 					  max_bytes, &cached_state);
 	if (!found || delalloc_end <= *start || delalloc_start > orig_end) {
-		*start = delalloc_start;
-
-		/* @delalloc_end can be -1, never go beyond @orig_end */
-		*end = min(delalloc_end, orig_end);
 		free_extent_state(cached_state);
 		return false;
 	}
@@ -1206,12 +1203,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	int ret = 0;
 
 	while (delalloc_start < page_end) {
-		delalloc_end = page_end;
 		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
-					      &delalloc_start, &delalloc_end)) {
-			delalloc_start = delalloc_end + 1;
-			continue;
-		}
+					      &delalloc_start, &delalloc_end))
+			break;
 
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
 					       delalloc_end, wbc);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 865d4af4b303..371ec714d500 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -179,7 +179,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 */
 	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
 	start = 0;
-	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
@@ -210,7 +209,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	}
 	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
-	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
@@ -244,18 +242,12 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		goto out_bits;
 	}
 	start = test_start;
-	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (found) {
 		test_err("found range when we shouldn't have");
 		goto out_bits;
 	}
-	if (end != test_start + PAGE_SIZE - 1) {
-		test_err("did not return the proper end offset");
-		goto out_bits;
-	}
-
 	/*
 	 * Test this scenario
 	 * [------- delalloc -------|
@@ -265,7 +257,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 */
 	set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
-	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
@@ -300,7 +291,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	/* We unlocked it in the previous test */
 	lock_page(locked_page);
 	start = test_start;
-	end = start + PAGE_SIZE - 1;
 	/*
 	 * Currently if we fail to find dirty pages in the delalloc range we
 	 * will adjust max_bytes down to PAGE_SIZE and then re-search.  If
-- 
2.43.2


