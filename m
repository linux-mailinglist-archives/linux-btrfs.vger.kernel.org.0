Return-Path: <linux-btrfs+bounces-7646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E87963007
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30807B22E07
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE961AE028;
	Wed, 28 Aug 2024 18:21:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B31ABEB7;
	Wed, 28 Aug 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869271; cv=none; b=k9t1TzPMws9AtFdXluc2G2cAvtffqY2daF0pNdO8K1GIkoo7Q9baCzReydBIxYSb0V/oCnFVkNB/rjH0R3xDMARp/Ytw4qX/ulIvqrdb0gm8/hJBQUGtpJTKnvA51dtzDFs0l9qgYJwqam36baPcfQcZ0E+nCKBFM2o4h7yWzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869271; c=relaxed/simple;
	bh=4Jft9SGSFf3Pam/wHa1peL2vXAIjlg8IDM4IKY/HgGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLcAQdKBAlaM1xUbAeH0rpZ7e8gs3QpIZ/K2+H5P9HdBspmAFMtC8TmBT9cg077jvm/+eLr2IdRu9wguDNQ7xMj6Qo9dQU3A9R9vxBRDsgqjdbObmgcmzK4JeOdPOT4+/8wvNreZ2egrqkXQvOqesMq10SPS8yVbjuj7h8Ueupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvCQb2P7tz1j7fN;
	Thu, 29 Aug 2024 02:20:55 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id D7964140203;
	Thu, 29 Aug 2024 02:21:06 +0800 (CST)
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
Subject: [PATCH -next v2 13/14] btrfs: convert btrfs_decompress() to take a folio
Date: Thu, 29 Aug 2024 02:29:07 +0800
Message-ID: <20240828182908.3735344-14-lizetao1@huawei.com>
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
and folio. Based on the previous patch, the compression path can be
directly used in folio without converting to page.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/compression.c | 14 +++++++-------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/reflink.c     |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index aa5fe5561b36..cbf5a2d5ccc0 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -138,15 +138,15 @@ static int compression_decompress_bio(struct list_head *ws,
 }
 
 static int compression_decompress(int type, struct list_head *ws,
-		const u8 *data_in, struct page *dest_page,
+		const u8 *data_in, struct folio *dest_folio,
 		unsigned long dest_pgoff, size_t srclen, size_t destlen)
 {
 	switch (type) {
-	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, page_folio(dest_page),
+	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, dest_folio,
 						dest_pgoff, srclen, destlen);
-	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, page_folio(dest_page),
+	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, dest_folio,
 						dest_pgoff, srclen, destlen);
-	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, page_folio(dest_page),
+	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, dest_folio,
 						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_NONE:
 	default:
@@ -1056,10 +1056,10 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
  * single page, and we want to read a single page out of it.
  * start_byte tells us the offset into the compressed data we're interested in
  */
-int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
+int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
 		     unsigned long dest_pgoff, size_t srclen, size_t destlen)
 {
-	struct btrfs_fs_info *fs_info = page_to_fs_info(dest_page);
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(dest_folio);
 	struct list_head *workspace;
 	const u32 sectorsize = fs_info->sectorsize;
 	int ret;
@@ -1072,7 +1072,7 @@ int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
 	ASSERT(dest_pgoff + destlen <= PAGE_SIZE && destlen <= sectorsize);
 
 	workspace = get_workspace(type, 0);
-	ret = compression_decompress(type, workspace, data_in, dest_page,
+	ret = compression_decompress(type, workspace, data_in, dest_folio,
 				     dest_pgoff, srclen, destlen);
 	put_workspace(type, workspace);
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index d2453cf28eef..b6563b6a333e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -96,7 +96,7 @@ void __cold btrfs_exit_compress(void);
 int btrfs_compress_folios(unsigned int type_level, struct address_space *mapping,
 			  u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out);
-int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
+int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
 		     unsigned long start_byte, size_t srclen, size_t destlen);
 int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 			      struct compressed_bio *cb, u32 decompressed);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d2366db474ae..25a113bcdb54 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6746,7 +6746,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	read_extent_buffer(leaf, tmp, ptr, inline_size);
 
 	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
-	ret = btrfs_decompress(compress_type, tmp, &folio->page, 0, inline_size,
+	ret = btrfs_decompress(compress_type, tmp, folio, 0, inline_size,
 			       max_size);
 
 	/*
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index df6b93b927cd..b768e590a44c 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -118,7 +118,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 		memcpy_to_page(page, offset_in_page(file_offset), data_start,
 			       datal);
 	} else {
-		ret = btrfs_decompress(comp_type, data_start, page,
+		ret = btrfs_decompress(comp_type, data_start, page_folio(page),
 				       offset_in_page(file_offset),
 				       inline_size, datal);
 		if (ret)
-- 
2.34.1


