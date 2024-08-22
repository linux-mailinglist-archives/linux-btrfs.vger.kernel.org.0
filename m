Return-Path: <linux-btrfs+bounces-7388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815EF95AA88
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D781F23662
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0349B5589A;
	Thu, 22 Aug 2024 01:29:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABF364CD
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290185; cv=none; b=u04VHzQRDeA+JJm3QP8uB6n3VM48XIEBkQxWtOM8LP/FXShTIXU09WGd5VV9qQ8vMy+F59PeY9Lzae1sKHxp0eWzc+ZnsgP1BS68DukFUiPO/g7MRQcoSsZph0EOOhjuqq+4R9rZ9pGnbksGBI3c/TeKGo4zgJ/B3Kqvf+VzeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290185; c=relaxed/simple;
	bh=ZsaV82DJrS/7r0BDVfW1MKgAiOdRcOueLhOgM8PSvRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8Av40cmNLT4WveBredIciKjjWEsqkEwQreUpNz00524aDdiSD2yo7WgST9PsnXy7NsnVdgKp+CNJGu8pyDKG/uMJYQcNTiHQiirkCmbuR/WE+W4AiOJr+RssWOPSWafTOpHzYu4ABLEgfpfP+5aU2L6yLnqIDk22Ry+ElklfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wq5G51c7KzyR80;
	Thu, 22 Aug 2024 09:29:17 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 83B521800FF;
	Thu, 22 Aug 2024 09:29:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:39 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 04/14] btrfs: convert try_release_extent_buffer() to take a folio
Date: Thu, 22 Aug 2024 09:37:04 +0800
Message-ID: <20240822013714.3278193-5-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

The old page API is being gradually replaced and converted to use folio
to improve code readability and avoid repeated conversion between page
and folio.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/extent_io.c | 15 +++++++--------
 fs/btrfs/extent_io.h |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6f5441e62d1..ca2f52a28fb0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -525,7 +525,7 @@ static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
 	if (folio_test_writeback(folio) || folio_test_dirty(folio))
 		return false;
 
-	return try_release_extent_buffer(&folio->page);
+	return try_release_extent_buffer(folio);
 }
 
 static void btree_invalidate_folio(struct folio *folio, size_t offset,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 77c1f69f4229..a0102b9b67ff 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4241,21 +4241,20 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 
 }
 
-int try_release_extent_buffer(struct page *page)
+int try_release_extent_buffer(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct extent_buffer *eb;
 
-	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
-		return try_release_subpage_extent_buffer(page_folio(page));
+	if (folio_to_fs_info(folio)->nodesize < PAGE_SIZE)
+		return try_release_subpage_extent_buffer(folio);
 
 	/*
 	 * We need to make sure nobody is changing folio private, as we rely on
 	 * folio private as the pointer to extent buffer.
 	 */
-	spin_lock(&page->mapping->i_private_lock);
+	spin_lock(&folio->mapping->i_private_lock);
 	if (!folio_test_private(folio)) {
-		spin_unlock(&page->mapping->i_private_lock);
+		spin_unlock(&folio->mapping->i_private_lock);
 		return 1;
 	}
 
@@ -4270,10 +4269,10 @@ int try_release_extent_buffer(struct page *page)
 	spin_lock(&eb->refs_lock);
 	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 		spin_unlock(&eb->refs_lock);
-		spin_unlock(&page->mapping->i_private_lock);
+		spin_unlock(&folio->mapping->i_private_lock);
 		return 0;
 	}
-	spin_unlock(&page->mapping->i_private_lock);
+	spin_unlock(&folio->mapping->i_private_lock);
 
 	/*
 	 * If tree ref isn't set then we know the ref on this eb is a real ref,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 236da2231a0e..f4c93ca46bdd 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -237,7 +237,7 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 }
 
 bool try_release_extent_mapping(struct page *page, gfp_t mask);
-int try_release_extent_buffer(struct page *page);
+int try_release_extent_buffer(struct folio *folio);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
 void extent_write_locked_range(struct inode *inode, const struct folio *locked_folio,
-- 
2.34.1


