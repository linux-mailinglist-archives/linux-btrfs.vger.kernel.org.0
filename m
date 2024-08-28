Return-Path: <linux-btrfs+bounces-7644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E404962FD2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88BD285D0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD701AD410;
	Wed, 28 Aug 2024 18:21:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470501AB50F;
	Wed, 28 Aug 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869270; cv=none; b=agjEFfqQz+AX/3x5JwnFCn8bhCtRDZf1e2MVYM+0xGoOQrvuXLeJqtaHCdUGmABpVVfhXfeRxIAkFmrr3iVedFh5rQaibY8SShrorokiM1CNJkrIC11KKi+catkiZlpShHokZCsMd17BGOEcKs12SytrAwoAwzAHYoSfskehAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869270; c=relaxed/simple;
	bh=Ds7BIK7Se0N0nTpI+5RFXMsp3n/QljYwFp/b1NI1Q1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O56Twlk+GSglX1JNifU2o1dMK7Zl1rz5CZNsuoiTGyV54wBziGsMcHgbCpdo8jYkTBrDmFanGH7z00PGddqcSZWumz0OLSCan0WFhui/manoJC/dfvVdqWMw+7VfJAZdGY+oZ52QOboV3UAWBvxK4erBst4SCO/i0ePrcavZ6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvCNq4ChNzpTyC;
	Thu, 29 Aug 2024 02:19:23 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 174661800CC;
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
Subject: [PATCH -next v2 11/14] btrfs: convert lzo_decompress() to take a folio
Date: Thu, 29 Aug 2024 02:29:05 +0800
Message-ID: <20240828182908.3735344-12-lizetao1@huawei.com>
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
 fs/btrfs/lzo.c         | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 31ed80ef8ec2..921456879640 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -144,7 +144,7 @@ static int compression_decompress(int type, struct list_head *ws,
 	switch (type) {
 	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, page_folio(dest_page),
 						dest_pgoff, srclen, destlen);
-	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, dest_page,
+	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, page_folio(dest_page),
 						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, dest_page,
 						dest_pgoff, srclen, destlen);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index f4f7a981cb90..4b5a7ba54815 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -173,7 +173,7 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 		unsigned long *total_in, unsigned long *total_out);
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
+		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
 struct list_head *lzo_alloc_workspace(unsigned int level);
 void lzo_free_workspace(struct list_head *ws);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 1e2a68b8f62d..72856f6775f7 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -438,11 +438,11 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 }
 
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
+		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	struct btrfs_fs_info *fs_info = page_to_fs_info(dest_page);
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(dest_folio);
 	const u32 sectorsize = fs_info->sectorsize;
 	size_t in_len;
 	size_t out_len;
@@ -467,22 +467,22 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	out_len = sectorsize;
 	ret = lzo1x_decompress_safe(data_in, in_len, workspace->buf, &out_len);
 	if (unlikely(ret != LZO_E_OK)) {
-		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+		struct btrfs_inode *inode = folio_to_inode(dest_folio);
 
 		btrfs_err(fs_info,
 		"lzo decompression failed, error %d root %llu inode %llu offset %llu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode),
-			  page_offset(dest_page));
+			  folio_pos(dest_folio));
 		ret = -EIO;
 		goto out;
 	}
 
 	ASSERT(out_len <= sectorsize);
-	memcpy_to_page(dest_page, dest_pgoff, workspace->buf, out_len);
+	memcpy_to_folio(dest_folio, dest_pgoff, workspace->buf, out_len);
 	/* Early end, considered as an error. */
 	if (unlikely(out_len < destlen)) {
 		ret = -EIO;
-		memzero_page(dest_page, dest_pgoff + out_len, destlen - out_len);
+		folio_zero_range(dest_folio, dest_pgoff + out_len, destlen - out_len);
 	}
 out:
 	return ret;
-- 
2.34.1


