Return-Path: <linux-btrfs+bounces-7395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAC95AA8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC37DB25F56
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145EA13B580;
	Thu, 22 Aug 2024 01:29:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758938DD3
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290188; cv=none; b=j0vTFZhc3B9FUrkL7mhzT8Dg0ClNGaAYnTqSdKVJGYGbM2a8ds2GptwBWbZkbka++rQuPnsHSTIB9rL9yLhym7eFms6rL51cb+viz3t/C4mzZNMncfQrstk6UXrirBPuEiy7P+ykoC8IwwZmB1x8twMTY9XBhosjf3wBvZo2dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290188; c=relaxed/simple;
	bh=b5LZsZ0MUgoI3HeshLowtMZNbGOn77j5/5YaV+lZaXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEow0q2NKUMPUYl4R7J8rRUioqk2x6zP5U9s5dfbu34Lwub2KItXGE9x/vRFz9Bw6yIkMgF3ObOjEakgvBR4x61ERrdTLoZzgFapEGloDNKNI2WlI7IsrCTzOCJ32yXx2icr+Nq6ABmFgy6U+vCl4M7J/Vsfm4EQf+YWKd1iF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wq5GY0jV0z2Cn8v;
	Thu, 22 Aug 2024 09:29:41 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 313851400FD;
	Thu, 22 Aug 2024 09:29:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:43 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 13/14] btrfs: convert btrfs_decompress() to take a folio
Date: Thu, 22 Aug 2024 09:37:13 +0800
Message-ID: <20240822013714.3278193-14-lizetao1@huawei.com>
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
index eab79edeb64c..9869944a5acc 100644
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
@@ -1061,10 +1061,10 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
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
@@ -1077,7 +1077,7 @@ int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
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
index e844c409c12a..f9ade617700f 100644
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


