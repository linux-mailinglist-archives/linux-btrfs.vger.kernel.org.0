Return-Path: <linux-btrfs+bounces-7397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9E95AA92
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267371F21287
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28F13C675;
	Thu, 22 Aug 2024 01:29:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730936B11
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290192; cv=none; b=mEOcVOAh/CuODK0Trxw3xtYp+PhZDfc+OT4MM96WW+YNpFPm4HfnK+/KMe2y3MZxj0FK74l9KH206veGwwFTfuB1K5Pf1wapa599RGcRWXEg3JHG5n6WOzO9OeI0HEvploo7hOjn7lcASor/stQUaRqfFo4A0bFCSYmuzll6gTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290192; c=relaxed/simple;
	bh=dcfR+lly5hchEpn5kkI0pOloCg+4qe046RLJ/5zfvE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRrp4dtesu8LDW2q85ceK5uBvnwXeR8EpjZBK8PORsuBTNhCpgI/lkjed3KqzWVSsIXL2jE2Jp//DW484+cNAS8pnzdi5RMRanIR+/ijjNBLQMTIih0RZcqmo/trCahvvwcTEQBB9MTSAq0uxBDFfrrg+pNTv3HgUPVGWENHBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wq5GV6PHbz1S8V0;
	Thu, 22 Aug 2024 09:29:38 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DFC11400FD;
	Thu, 22 Aug 2024 09:29:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:42 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 09/14] btrfs: convert try_release_extent_mapping() to take a folio
Date: Thu, 22 Aug 2024 09:37:09 +0800
Message-ID: <20240822013714.3278193-10-lizetao1@huawei.com>
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
and folio. And page_to_inode() can be replaced with folio_to_inode() now.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 27ca7a56d8f5..cfd523b523b3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2435,11 +2435,11 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
  * in the range corresponding to the page, both state records and extent
  * map records are removed
  */
-bool try_release_extent_mapping(struct page *page, gfp_t mask)
+bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 {
-	u64 start = page_offset(page);
+	u64 start = folio_pos(folio);
 	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_inode *inode = page_to_inode(page);
+	struct btrfs_inode *inode = folio_to_inode(folio);
 	struct extent_io_tree *io_tree = &inode->io_tree;
 
 	while (start <= end) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index f4c93ca46bdd..d1c54788d444 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -236,7 +236,7 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 	kfree(changeset);
 }
 
-bool try_release_extent_mapping(struct page *page, gfp_t mask);
+bool try_release_extent_mapping(struct folio *folio, gfp_t mask);
 int try_release_extent_buffer(struct folio *folio);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5e3b834cc72b..e844c409c12a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7238,7 +7238,7 @@ static int btrfs_launder_folio(struct folio *folio)
 
 static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
-	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
+	if (try_release_extent_mapping(folio, gfp_flags)) {
 		wait_subpage_spinlock(folio);
 		clear_page_extent_mapped(folio);
 		return true;
-- 
2.34.1


