Return-Path: <linux-btrfs+bounces-7396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9F795AA90
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D101F21606
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1FF13B787;
	Thu, 22 Aug 2024 01:29:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BBF56766
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290188; cv=none; b=Y5fkFaWHbGPhDGwdsxCcTknq0zhRB4buxULeFHeDXltRdJeoz9MulsLIKFMoBJBgtUyHrjKxX2vTCljJky0FHXSoptHyaM0cTq/GkbcHZ87RnJAiaLxgAI1QV3GfxPo/Eh79gJTog4XfLMHIsjMP4WeDVGWdMGOo6lDzAgT59G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290188; c=relaxed/simple;
	bh=uDLeiFNv8iQbAb0vm7pscTF80mc3TKjg1EkRm1JDnU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPVsSlcXkK+pD+w3CCYuXwDxgDo7fZNSDnm/QkOK/A6kEqEgcMxqaRlDZ+9fw0GSikgqY5luM6OEMkfkLTBm9uUsQeR9aFSMd6i7y+2V9dGTvNgrsCC/ZKT1Zpf59ISJJLbVA9UzcTNki0tEzdt7876d/kw56/sEoDJpgtS7oC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wq5DH5KK5zhY5Y;
	Thu, 22 Aug 2024 09:27:43 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 942941800D3;
	Thu, 22 Aug 2024 09:29:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:44 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 14/14] btrfs: convert copy_inline_to_page() to use folio
Date: Thu, 22 Aug 2024 09:37:14 +0800
Message-ID: <20240822013714.3278193-15-lizetao1@huawei.com>
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
and folio. Moreover find_or_create_page() is compatible API, and it can
replaced with __filemap_get_folio(). Some interfaces have been converted
to use folio before, so the conversion operation from page can be
eliminated here.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/reflink.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b768e590a44c..1681d63f03dd 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -66,7 +66,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
 	char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
 	struct extent_changeset *data_reserved = NULL;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	int ret;
 
@@ -83,14 +83,15 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	if (ret)
 		goto out;
 
-	page = find_or_create_page(mapping, file_offset >> PAGE_SHIFT,
-				   btrfs_alloc_write_mask(mapping));
-	if (!page) {
+	folio = __filemap_get_folio(mapping, file_offset >> PAGE_SHIFT,
+					FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					btrfs_alloc_write_mask(mapping));
+	if (IS_ERR(folio)) {
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
 
-	ret = set_page_extent_mapped(page);
+	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -115,15 +116,15 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	set_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &inode->runtime_flags);
 
 	if (comp_type == BTRFS_COMPRESS_NONE) {
-		memcpy_to_page(page, offset_in_page(file_offset), data_start,
-			       datal);
+		memcpy_to_folio(folio, offset_in_folio(folio, file_offset), data_start,
+					datal);
 	} else {
-		ret = btrfs_decompress(comp_type, data_start, page_folio(page),
-				       offset_in_page(file_offset),
+		ret = btrfs_decompress(comp_type, data_start, folio,
+				       offset_in_folio(folio, file_offset),
 				       inline_size, datal);
 		if (ret)
 			goto out_unlock;
-		flush_dcache_page(page);
+		flush_dcache_folio(folio);
 	}
 
 	/*
@@ -139,15 +140,15 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	 * So what's in the range [500, 4095] corresponds to zeroes.
 	 */
 	if (datal < block_size)
-		memzero_page(page, datal, block_size - datal);
+		folio_zero_range(folio, datal, block_size - datal);
 
-	btrfs_folio_set_uptodate(fs_info, page_folio(page), file_offset, block_size);
-	btrfs_folio_clear_checked(fs_info, page_folio(page), file_offset, block_size);
-	btrfs_folio_set_dirty(fs_info, page_folio(page), file_offset, block_size);
+	btrfs_folio_set_uptodate(fs_info, folio, file_offset, block_size);
+	btrfs_folio_clear_checked(fs_info, folio, file_offset, block_size);
+	btrfs_folio_set_dirty(fs_info, folio, file_offset, block_size);
 out_unlock:
-	if (page) {
-		unlock_page(page);
-		put_page(page);
+	if (IS_ERR(folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	if (ret)
 		btrfs_delalloc_release_space(inode, data_reserved, file_offset,
-- 
2.34.1


