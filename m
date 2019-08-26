Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CABF9CE84
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfHZLs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:48:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:39194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730823AbfHZLs5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D55CAF81
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:55 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 01/11] btrfs-progs: don't blindly assume crc32c in csum_tree_block_size()
Date:   Mon, 26 Aug 2019 13:48:43 +0200
Message-Id: <20190826114853.14860-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190826114853.14860-1-jthumshirn@suse.de>
References: <20190826114853.14860-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The callers of csum_tree_block_size() blindly assume we're only having
crc32c as a possible checksum and thus pass in
btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32] for the size argument of
csum_tree_block_size().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 mkfs/common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index caca5e707233..b6e549b19272 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -101,7 +101,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	}
 
 	/* generate checksum */
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
 
 	/* write back root tree */
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_ROOT_TREE]);
@@ -292,7 +292,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_EXTENT_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -380,7 +380,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CHUNK_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_CHUNK_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CHUNK_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -420,7 +420,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_DEV_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_DEV_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -433,7 +433,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FS_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_FS_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_FS_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -445,7 +445,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CSUM_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_CSUM_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CSUM_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -456,7 +456,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
 	memcpy(buf->data, &super, sizeof(super));
 	buf->len = BTRFS_SUPER_INFO_SIZE;
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
 	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
 			cfg->blocks[MKFS_SUPER_BLOCK]);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
-- 
2.16.4

