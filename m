Return-Path: <linux-btrfs+bounces-7645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83494962FD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BFD1F2482D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03121AD9E7;
	Wed, 28 Aug 2024 18:21:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9220156997;
	Wed, 28 Aug 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869271; cv=none; b=euBKjg/yOogDi+tA0yn1EHlVozis1YOFrH7TYyoRvAG3tN8Uen/xgdGb6e3tYmahyelKKIuX+JWKhKDUAZBZFboFircBC26d7kjrGP24gEaiV7kSakF5JE5RvqZGhmzjLkFttDb5hPj/Mc4cif3qfbdHyhv0cXnHCytChN5y4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869271; c=relaxed/simple;
	bh=sLcNcQ0HvptR9FcTZRyanZ/tnIc8QDBBEuxtliif3gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b83UBz+naD0SE7c+2fmpeKeq5icDYBfzc5mCA/RoUaApvwIRFgxPBsomVqOhz6OVfitJ5QOx5eQdpJa3yUoNPMvhxpMn71DhldkrlCfUWCHe+YcUiRWvH5K0L5ZIM2BRLkMxbeMXrBYHKvS+cSm8vq86Pd8ZNBlvGASlY2HCZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvCQZ5JKPz2Dbb9;
	Thu, 29 Aug 2024 02:20:54 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 749341A0188;
	Thu, 29 Aug 2024 02:21:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 29 Aug
 2024 02:21:05 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>, <quwenruo.btrfs@gmx.com>, <willy@infradead.org>,
	<dan.carpenter@linaro.org>
CC: <lizetao1@huawei.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2 12/14] btrfs: convert zstd_decompress() to take a folio
Date: Thu, 29 Aug 2024 02:29:06 +0800
Message-ID: <20240828182908.3735344-13-lizetao1@huawei.com>
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
and folio. And memcpy_to_page() can be replaced with memcpy_to_folio().
But there is no memzero_folio(), but it can be replaced equivalently by
folio_zero_range().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/zstd.c        | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 921456879640..aa5fe5561b36 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -146,7 +146,7 @@ static int compression_decompress(int type, struct list_head *ws,
 						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, page_folio(dest_page),
 						dest_pgoff, srclen, destlen);
-	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, dest_page,
+	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, page_folio(dest_page),
 						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_NONE:
 	default:
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 4b5a7ba54815..d2453cf28eef 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -183,7 +183,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 		unsigned long *total_in, unsigned long *total_out);
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
+		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
 void zstd_init_workspace_manager(void);
 void zstd_cleanup_workspace_manager(void);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 05cf7cebc17c..866607fd3e58 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -656,11 +656,11 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 }
 
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
+		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	struct btrfs_fs_info *fs_info = btrfs_sb(dest_page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(folio_inode(dest_folio)->i_sb);
 	const u32 sectorsize = fs_info->sectorsize;
 	zstd_dstream *stream;
 	int ret = 0;
@@ -669,12 +669,12 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 	stream = zstd_init_dstream(
 			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
 	if (unlikely(!stream)) {
-		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+		struct btrfs_inode *inode = folio_to_inode(dest_folio);
 
 		btrfs_err(inode->root->fs_info,
 		"zstd decompression init failed, root %llu inode %llu offset %llu",
 			  btrfs_root_id(inode->root), btrfs_ino(inode),
-			  page_offset(dest_page));
+			  folio_pos(dest_folio));
 		ret = -EIO;
 		goto finish;
 	}
@@ -693,21 +693,21 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 	 */
 	ret = zstd_decompress_stream(stream, &workspace->out_buf, &workspace->in_buf);
 	if (unlikely(zstd_is_error(ret))) {
-		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+		struct btrfs_inode *inode = folio_to_inode(dest_folio);
 
 		btrfs_err(inode->root->fs_info,
 		"zstd decompression failed, error %d root %llu inode %llu offset %llu",
 			  zstd_get_error_code(ret), btrfs_root_id(inode->root),
-			  btrfs_ino(inode), page_offset(dest_page));
+			  btrfs_ino(inode), folio_pos(dest_folio));
 		goto finish;
 	}
 	to_copy = workspace->out_buf.pos;
-	memcpy_to_page(dest_page, dest_pgoff, workspace->out_buf.dst, to_copy);
+	memcpy_to_folio(dest_folio, dest_pgoff, workspace->out_buf.dst, to_copy);
 finish:
 	/* Error or early end. */
 	if (unlikely(to_copy < destlen)) {
 		ret = -EIO;
-		memzero_page(dest_page, dest_pgoff + to_copy, destlen - to_copy);
+		folio_zero_range(dest_folio, dest_pgoff + to_copy, destlen - to_copy);
 	}
 	return ret;
 }
-- 
2.34.1


