Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D05172923
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 21:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgB0UBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 15:01:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:55638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbgB0UBJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 15:01:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A741FB1D1;
        Thu, 27 Feb 2020 20:01:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B74A8DA83A; Thu, 27 Feb 2020 21:00:47 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: simplify tree block checksumming loop
Date:   Thu, 27 Feb 2020 21:00:47 +0100
Message-Id: <4f450bbeec245479a3bc2b40d023d1979d622587.1582832619.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582832619.git.dsterba@suse.com>
References: <cover.1582832619.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thw whole point of csum_tree_block is to iterate over all extent buffer
pages and pass it to checksumming functions. The bytes where checksum is
stored must be skipped, thus map_private_extent_buffer. This complicates
further offset calculations.

As the first page will be always present, checksum the relevant bytes
unconditionally and then do a simple iteration over the remaining pages.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3952e4a2f3d7..5f74eb69f2fe 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -259,38 +259,22 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
+	const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	unsigned long len;
-	unsigned long cur_len;
-	unsigned long offset = BTRFS_CSUM_SIZE;
 	char *kaddr;
-	unsigned long map_start;
-	unsigned long map_len;
-	int err;
+	int i;
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
+	kaddr = page_address(buf->pages[0]);
+	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
+			    PAGE_SIZE - BTRFS_CSUM_SIZE);
 
-	len = buf->len - offset;
-
-	while (len > 0) {
-		/*
-		 * Note: we don't need to check for the err == 1 case here, as
-		 * with the given combination of 'start = BTRFS_CSUM_SIZE (32)'
-		 * and 'min_len = 32' and the currently implemented mapping
-		 * algorithm we cannot cross a page boundary.
-		 */
-		err = map_private_extent_buffer(buf, offset, 32,
-					&kaddr, &map_start, &map_len);
-		if (WARN_ON(err))
-			return err;
-		cur_len = min(len, map_len - (offset - map_start));
-		crypto_shash_update(shash, kaddr + offset - map_start, cur_len);
-		len -= cur_len;
-		offset += cur_len;
+	for (i = 1; i < num_pages; i++) {
+		kaddr = page_address(buf->pages[i]);
+		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
-
 	crypto_shash_final(shash, result);
 
 	return 0;
-- 
2.25.0

