Return-Path: <linux-btrfs+bounces-7392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463595AA8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A04B24024
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CE46E611;
	Thu, 22 Aug 2024 01:29:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24449658
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290187; cv=none; b=QpkoXYxyEZ18ei4Jh8lOd2J0eLTwhyGtLTIItn3blVgpeoktp48Uot0tpJHHxu/XQ54Je0l2o/KciHy6Be96lGSkmHtXwfJ+1kMso3fIwjMI2nhQb1oikhHZXeLf49GkRS53AOInyQygPE91KTF7CxQqH7lF90JKJFUaluPWAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290187; c=relaxed/simple;
	bh=/bRdWSuLR1wbeyxHO6BvFE4HS4WpF5quNs+9E/e3dlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzHti09bytDxHyvE34+Dst8nkpcGnx8PShSZot5AlFMkiYFfCtfsx5/xPAyFBzOAIRkqXuGUlbHMZjhixqt4zldtmn5D1ctoeNgZklaJliyhjV3IWFUFvfK5Ga+qu0EuWakeb6YLU8C6h/9JFG2UTrNH3ySDWw7RWSnQfNIV694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wq5DN1KN8z1xvkQ;
	Thu, 22 Aug 2024 09:27:48 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id F22A31400FD;
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
Subject: [PATCH 10/14] btrfs: convert zlib_decompress() to take a folio
Date: Thu, 22 Aug 2024 09:37:10 +0800
Message-ID: <20240822013714.3278193-11-lizetao1@huawei.com>
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
and folio. And memcpy_to_page() can be replaced with memcpy_to_folio().
But there is no memzero_folio(), but it can be replaced equivalently by
folio_zero_range().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/zlib.c        | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 832ab8984c41..19d18f875563 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -142,7 +142,7 @@ static int compression_decompress(int type, struct list_head *ws,
 		unsigned long dest_pgoff, size_t srclen, size_t destlen)
 {
 	switch (type) {
-	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, dest_page,
+	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, page_folio(dest_page),
 						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, dest_page,
 						dest_pgoff, srclen, destlen);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 5d01f092ae13..f4f7a981cb90 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -162,7 +162,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 		unsigned long *total_in, unsigned long *total_out);
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
+		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
 struct list_head *zlib_alloc_workspace(unsigned int level);
 void zlib_free_workspace(struct list_head *ws);
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 8aa82ee1991e..4ca7ff38234c 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -393,7 +393,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 }
 
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
+		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
@@ -421,12 +421,12 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 
 	ret = zlib_inflateInit2(&workspace->strm, wbits);
 	if (unlikely(ret != Z_OK)) {
-		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+		struct btrfs_inode *inode = folio_to_inode(dest_folio);
 
 		btrfs_err(inode->root->fs_info,
 		"zlib decompression init failed, error %d root %llu inode %llu offset %llu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode),
-			  page_offset(dest_page));
+			  folio_pos(dest_folio));
 		return -EIO;
 	}
 
@@ -439,16 +439,16 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 	if (ret != Z_STREAM_END)
 		goto out;
 
-	memcpy_to_page(dest_page, dest_pgoff, workspace->buf, to_copy);
+	memcpy_to_folio(dest_folio, dest_pgoff, workspace->buf, to_copy);
 
 out:
 	if (unlikely(to_copy != destlen)) {
-		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+		struct btrfs_inode *inode = folio_to_inode(dest_folio);
 
 		btrfs_err(inode->root->fs_info,
 "zlib decompression failed, error %d root %llu inode %llu offset %llu decompressed %lu expected %zu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode),
-			  page_offset(dest_page), to_copy, destlen);
+			  folio_pos(dest_folio), to_copy, destlen);
 		ret = -EIO;
 	} else {
 		ret = 0;
@@ -457,7 +457,7 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 	zlib_inflateEnd(&workspace->strm);
 
 	if (unlikely(to_copy < destlen))
-		memzero_page(dest_page, dest_pgoff + to_copy, destlen - to_copy);
+		folio_zero_range(dest_folio, dest_pgoff + to_copy, destlen - to_copy);
 	return ret;
 }
 
-- 
2.34.1


