Return-Path: <linux-btrfs+bounces-7386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D529A95AA86
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825D41F21235
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793A37160;
	Thu, 22 Aug 2024 01:29:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3160376F1
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290184; cv=none; b=i6J8ojltDhIIzibs1tibC7oNnPL2KzDkeDYFldRt8/siOfLQ5pB3Y+Awr1y7pqR8d1TZ3O6Lv53VcwKQaT/Fp3XgHm3QKfiILA0+S6R0MujzUS6EU33CoheSDOGRFkFe91t1x00B/J13+/f9jCbSEF2hKG7V3EnD//CanarWi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290184; c=relaxed/simple;
	bh=ygDL5dc+HslxbcFN865/eR5dsKEMC/jldJYQ5agrB3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0CtGq7glAL/NgXJfNtei0aYOd7iemBpP/3M8LWTqCEgHxBJvaTHAue8el2DDdx6l/CiCdOBSeubakTOhH1ObhDKP+cHNMENHGIrULc6PVC7YbflYonE4RWtllOenFt9Dvwbss5c6ikMwuJW4vIB+BPjPHCvsNU8BWWZg8ZB4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wq5GS1XV2z2CmwF;
	Thu, 22 Aug 2024 09:29:36 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C27D14022D;
	Thu, 22 Aug 2024 09:29:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:38 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 01/14] btrfs: convert clear_page_extent_mapped() to take a folio
Date: Thu, 22 Aug 2024 09:37:01 +0800
Message-ID: <20240822013714.3278193-2-lizetao1@huawei.com>
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
 fs/btrfs/extent_io.c | 9 ++++-----
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 822e2bf8bc99..3c2ad5c9990d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -951,18 +951,17 @@ int set_folio_extent_mapped(struct folio *folio)
 	return 0;
 }
 
-void clear_page_extent_mapped(struct page *page)
+void clear_page_extent_mapped(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_fs_info *fs_info;
 
-	ASSERT(page->mapping);
+	ASSERT(folio->mapping);
 
 	if (!folio_test_private(folio))
 		return;
 
-	fs_info = page_to_fs_info(page);
-	if (btrfs_is_subpage(fs_info, page->mapping))
+	fs_info = folio_to_fs_info(folio);
+	if (btrfs_is_subpage(fs_info, folio->mapping))
 		return btrfs_detach_subpage(fs_info, folio);
 
 	folio_detach_private(folio);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b38460279b99..236da2231a0e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -249,7 +249,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
 int set_page_extent_mapped(struct page *page);
-void clear_page_extent_mapped(struct page *page);
+void clear_page_extent_mapped(struct folio *folio);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8ad540d6de2..5e3b834cc72b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7240,7 +7240,7 @@ static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
 		wait_subpage_spinlock(folio);
-		clear_page_extent_mapped(&folio->page);
+		clear_page_extent_mapped(folio);
 		return true;
 	}
 	return false;
@@ -7438,7 +7438,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	btrfs_folio_clear_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
 	if (!inode_evicting)
 		__btrfs_release_folio(folio, GFP_NOFS);
-	clear_page_extent_mapped(&folio->page);
+	clear_page_extent_mapped(folio);
 }
 
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
-- 
2.34.1


