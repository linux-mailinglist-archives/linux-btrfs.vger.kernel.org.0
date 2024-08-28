Return-Path: <linux-btrfs+bounces-7647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A5962FD8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55921C24CD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD621AE05B;
	Wed, 28 Aug 2024 18:21:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4991AC43A;
	Wed, 28 Aug 2024 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869272; cv=none; b=ZXhN82WjQjEhAKz//aHOwireSdaQl7Ap/267WvRngOeiGzeT6nD7Zzzn4xlNwkq3DFnD7yVYDyT6gAusbcjXeGRVz5xWZ/kF1pV9ThxL3cNSBsvNweUu7r1w9GIyzxyybg4840xodoFUklHaO0heNSLLlBx1ZyDmRbV222EYA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869272; c=relaxed/simple;
	bh=jiA3UuqlX97ZnvNUnN+w9YMYUFqBk/4d4uYQfP38048=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSiJsirIpiA0qxdQCaRYcgDR12cKxd3wttzMal8ty3x2ZuMab6wan9eHCA0perCigGrxnHNB7RwKsaBWLjle3bwSKGFHosXoGYpe3ylpXRMB5PC5JxgZ5PclpojyxPmlB8aPz2VXMOnGHros/0nJCAobQWQHrABBPPkw+Wc3E/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WvCPt4t1Mz16Pbm;
	Thu, 29 Aug 2024 02:20:18 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 42D2518007C;
	Thu, 29 Aug 2024 02:21:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 29 Aug
 2024 02:21:06 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>, <quwenruo.btrfs@gmx.com>, <willy@infradead.org>,
	<dan.carpenter@linaro.org>
CC: <lizetao1@huawei.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2 14/14] btrfs: convert copy_inline_to_page() to use folio
Date: Thu, 29 Aug 2024 02:29:08 +0800
Message-ID: <20240828182908.3735344-15-lizetao1@huawei.com>
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
and folio. Moreover find_or_create_page() is compatible API, and it can
replaced with __filemap_get_folio(). Some interfaces have been converted
to use folio before, so the conversion operation from page can be
eliminated here.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: fix a bug when a vaild folio should be unlocked and put in
  copy_inline_to_page().
v1: https://lore.kernel.org/all/20240822013714.3278193-15-lizetao1@huawei.com/

 fs/btrfs/reflink.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b768e590a44c..f0824c948cb7 100644
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
+	if (!IS_ERR(folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	if (ret)
 		btrfs_delalloc_release_space(inode, data_reserved, file_offset,
-- 
2.34.1


