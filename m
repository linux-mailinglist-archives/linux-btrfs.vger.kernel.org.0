Return-Path: <linux-btrfs+bounces-7634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6FA962FBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC01C229E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B01AAE39;
	Wed, 28 Aug 2024 18:21:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABF2747B;
	Wed, 28 Aug 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869267; cv=none; b=XsWadLFTHFaCRHM9gB5RRk47HJpgsMfdrich6LE419S6VRO21rl0YwNlM4EoQhW1X38/hdwPTiReGH9daiORpkY6KHvxL4w9KE1RlDvgH+tiKcoP4J8e1++RoQHsp8pus0Yn1Smr4aOChw9XvXJI8sOL7E8XgMY1R+OVZx778Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869267; c=relaxed/simple;
	bh=zKO0QC/sfuHjz0tyujMt3M++7xZf2OUSJUv4aav3yt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCY5Ma8181xRHmhyNjUZowlABE4aRxoUNBH34r/ntaPsN9uDJZAJ+4b5MfDdNroU8IDhyyXtUDPPn15EE11n5b0O4TDMoVU20aK0B+u0hvTHBXUCMCjBXULwUUMm2ouEzgZk45ngUmK8vQveYYH/0MN01oFXfNZR7gFk+m0NpuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvCNl57H3zpTwf;
	Thu, 29 Aug 2024 02:19:19 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 3549A1800CC;
	Thu, 29 Aug 2024 02:21:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 29 Aug
 2024 02:21:01 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>, <quwenruo.btrfs@gmx.com>, <willy@infradead.org>,
	<dan.carpenter@linaro.org>
CC: <lizetao1@huawei.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2 01/14] btrfs: convert clear_page_extent_mapped() to take a folio
Date: Thu, 29 Aug 2024 02:28:55 +0800
Message-ID: <20240828182908.3735344-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828182908.3735344-1-lizetao1@huawei.com>
References: <20240828182908.3735344-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

The old page API is being gradually replaced and converted to use folio
to improve code readability and avoid repeated conversion between page
and folio. And Now clear_page_extent_mapped() can deal with a folio
directly, so change it name to clear_folio_extent_mapped().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: change funtion name clear_page_extent_mapped to
  clear_folio_extent_mapped.
v1: https://lore.kernel.org/all/20240822013714.3278193-2-lizetao1@huawei.com/

 fs/btrfs/extent_io.c | 9 ++++-----
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bd737b797864..7f630edcc791 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -877,18 +877,17 @@ int set_folio_extent_mapped(struct folio *folio)
 	return 0;
 }
 
-void clear_page_extent_mapped(struct page *page)
+void clear_folio_extent_mapped(struct folio *folio)
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
index b38460279b99..1d9b30021109 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -249,7 +249,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
 int set_page_extent_mapped(struct page *page);
-void clear_page_extent_mapped(struct page *page);
+void clear_folio_extent_mapped(struct folio *folio);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8ad540d6de2..f113ec3d5392 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7240,7 +7240,7 @@ static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
 		wait_subpage_spinlock(folio);
-		clear_page_extent_mapped(&folio->page);
+		clear_folio_extent_mapped(folio);
 		return true;
 	}
 	return false;
@@ -7438,7 +7438,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	btrfs_folio_clear_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
 	if (!inode_evicting)
 		__btrfs_release_folio(folio, GFP_NOFS);
-	clear_page_extent_mapped(&folio->page);
+	clear_folio_extent_mapped(folio);
 }
 
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
-- 
2.34.1


