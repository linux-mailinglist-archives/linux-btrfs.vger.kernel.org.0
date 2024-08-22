Return-Path: <linux-btrfs+bounces-7391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66795AA8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07F71C2173E
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 01:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605B376F1;
	Thu, 22 Aug 2024 01:29:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC94383A9
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290186; cv=none; b=b2ycp8AHu/NcJkg45xr+52x9gwDj0ijc3GlopmOjQMaJIvpW2Uzmdfd4vLnx4QrIsj6Zzy7Jt6vxU9GEwf7SO5sE5aPdjK0XK2mhA02jgA6yooXNVzTwMCXNs7YreEa+7IjMC+Lrk7xXQJPNHBule6U/jseHRK/U6OMelRD8FRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290186; c=relaxed/simple;
	bh=dkrnOsf7jpX5stbjWjvVADGOILPbQs/omVkSppNGe4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrBnr06Xv0x3U0Hd5dr7ZeAof8273bwWUvoZNuYTHdwUf9mP0y7aY4I0Dp0oMfZUwOtdiezDLRKBxZmfz0YWCaDlrDxNQkGew6LTsBOZecDHGdToiWmrwU83S+yQxio0LJvqxJcC8+iSSLIitDjfuiOrTlkWuZ2CkOCmrbCAARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wq5DL1829z1xvkB;
	Thu, 22 Aug 2024 09:27:46 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id EA28618001B;
	Thu, 22 Aug 2024 09:29:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:40 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<terrelln@fb.com>
CC: <willy@infradead.org>, <lizetao1@huawei.com>,
	<linux-btrfs@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 05/14] btrfs: convert read_key_bytes() to take a folio
Date: Thu, 22 Aug 2024 09:37:05 +0800
Message-ID: <20240822013714.3278193-6-lizetao1@huawei.com>
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
and folio. Moreover, use kmap_local_folio() instend of kmap_local_page(),
which is more consistent with folio usage.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/verity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4042dd6437ae..e36dc99021a0 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -284,7 +284,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
  *              page and ignore dest, but it must still be non-NULL to avoid the
  *              counting-only behavior.
  * @len:        length in bytes to read
- * @dest_page:  copy into this page instead of the dest buffer
+ * @dest_folio: copy into this folio instead of the dest buffer
  *
  * Helper function to read items from the btree.  This returns the number of
  * bytes read or < 0 for errors.  We can return short reads if the items don't
@@ -294,7 +294,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
  * Returns number of bytes read or a negative error code on failure.
  */
 static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
-			  char *dest, u64 len, struct page *dest_page)
+			  char *dest, u64 len, struct folio *dest_folio)
 {
 	struct btrfs_path *path;
 	struct btrfs_root *root = inode->root;
@@ -314,7 +314,7 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 	if (!path)
 		return -ENOMEM;
 
-	if (dest_page)
+	if (dest_folio)
 		path->reada = READA_FORWARD;
 
 	key.objectid = btrfs_ino(inode);
@@ -371,15 +371,15 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		copy_offset = offset - key.offset;
 
 		if (dest) {
-			if (dest_page)
-				kaddr = kmap_local_page(dest_page);
+			if (dest_folio)
+				kaddr = kmap_local_folio(dest_folio, 0);
 
 			data = btrfs_item_ptr(leaf, path->slots[0], void);
 			read_extent_buffer(leaf, kaddr + dest_offset,
 					   (unsigned long)data + copy_offset,
 					   copy_bytes);
 
-			if (dest_page)
+			if (dest_folio)
 				kunmap_local(kaddr);
 		}
 
@@ -762,7 +762,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 	 * [ inode objectid, BTRFS_MERKLE_ITEM_KEY, offset in bytes ]
 	 */
 	ret = read_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY, off,
-			     folio_address(folio), PAGE_SIZE, &folio->page);
+			     folio_address(folio), PAGE_SIZE, folio);
 	if (ret < 0) {
 		folio_put(folio);
 		return ERR_PTR(ret);
-- 
2.34.1


