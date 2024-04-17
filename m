Return-Path: <linux-btrfs+bounces-4333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3248D8A81A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E50B21197
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBD613F44D;
	Wed, 17 Apr 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1GGwzgs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89D13F012
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351833; cv=none; b=YjeeEmvWgwrtc0GqHmaJ68TZ0uUsbQxRcRkiaywJOxHkZFTPqV10SDroOt3hF1KAQp/1H3hHhgRdRSy4aJ+Tpqsn4cXO5ZEse/h7Rm1dytYh+gcNnT7XInAFfY3qoyyNYGoV6ttZhdFchJAayKPcnFgb8zcX9ryOIVXVR0XYBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351833; c=relaxed/simple;
	bh=H7/sxcxSK6j8daBWi4xAOIhZBvV5eZ9TMczjMwTb8gg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cADEB9R7z6z99/4QkWvlcUbi/Qg2nncVeWpmsRUVG+Bbl2Yp/4OFzt8qNzswl1pbwTrI1NZnkoqeQ6xtMKbypnaJ3eHUMIjbZACQA5YKP1837kEsaum38NfK4iJ9yH3o4SyemwWvdtxnf2UyHJEbs4MQCV223dwl6Dhun9JCeFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1GGwzgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9EFC2BD10
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351833;
	bh=H7/sxcxSK6j8daBWi4xAOIhZBvV5eZ9TMczjMwTb8gg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I1GGwzgsLSrsutggS8rhJwlbeftzttXSXWeJQfQRMF8S39EE38nvfMh4eMS7xRIhQ
	 +0/fJlWvGSDWsvGT7YjbWSEixeVLOXL0sBYU7zvDbVNgHlEXo36RWVumBcj0aHwiPt
	 Fxsra6YypneJXz2q4JNwMeSkNAxKD3du+6IP8mqbEZgka/4a+72iblGuwIDTVk6HAe
	 8xFwFs4nhpS99NpGXrQmr1/gq9fcK2c0jbJhxrtLn6rFeqVccAxlYnENXErM44OcTj
	 1NzUsEB4cAoATIcTqCUqS3wJI7KCGUpN8KEQIVTQuWqXhdUzECWLZAlEzSc7yp5FFH
	 V74plLd8JBivw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: make try_release_extent_mapping() return a bool
Date: Wed, 17 Apr 2024 12:03:35 +0100
Message-Id: <49e09cbdb4c54f8b383bf7f21a1678cfbdc12e86.1713302470.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713302470.git.fdmanana@suse.com>
References: <cover.1713302470.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently try_release_extent_mapping() as an int return type, but we
use it as a boolean. Its only caller, the release folio callback, also
returns a boolean which corresponds to try_release_extent_mapping()'s
return value. So change its return value type to bool as well as its
helper try_release_extent_state().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 17 +++++++++--------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     |  7 +++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2230e6b6ba95..a9f9f5abdf53 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2355,19 +2355,20 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
  * are locked or under IO and drops the related state bits if it is safe
  * to drop the page.
  */
-static int try_release_extent_state(struct extent_io_tree *tree,
+static bool try_release_extent_state(struct extent_io_tree *tree,
 				    struct page *page, gfp_t mask)
 {
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	int ret = 1;
+	bool ret;
 
 	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
-		ret = 0;
+		ret = false;
 	} else {
 		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
 				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS |
 				   EXTENT_QGROUP_RESERVED);
+		int ret2;
 
 		/*
 		 * At this point we can safely clear everything except the
@@ -2375,15 +2376,15 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 		 * The delalloc new bit will be cleared by ordered extent
 		 * completion.
 		 */
-		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
+		ret2 = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
 
 		/* if clear_extent_bit failed for enomem reasons,
 		 * we can't allow the release to continue.
 		 */
-		if (ret < 0)
-			ret = 0;
+		if (ret2 < 0)
+			ret = false;
 		else
-			ret = 1;
+			ret = true;
 	}
 	return ret;
 }
@@ -2393,7 +2394,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
  * in the range corresponding to the page, both state records and extent
  * map records are removed
  */
-int try_release_extent_mapping(struct page *page, gfp_t mask)
+bool try_release_extent_mapping(struct page *page, gfp_t mask)
 {
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c81a9b546c9f..f38397765e90 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -230,7 +230,7 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 	kfree(changeset);
 }
 
-int try_release_extent_mapping(struct page *page, gfp_t mask);
+bool try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 30893f12c850..622600f5f313 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7902,13 +7902,12 @@ static void wait_subpage_spinlock(struct page *page)
 
 static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
-	int ret = try_release_extent_mapping(&folio->page, gfp_flags);
-
-	if (ret == 1) {
+	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
 		wait_subpage_spinlock(&folio->page);
 		clear_page_extent_mapped(&folio->page);
+		return true;
 	}
-	return ret;
+	return false;
 }
 
 static bool btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
-- 
2.43.0


