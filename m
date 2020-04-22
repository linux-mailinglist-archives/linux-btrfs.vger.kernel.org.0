Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5007A1B37EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgDVGv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:51:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgDVGv3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:51:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 67F3DAD9F;
        Wed, 22 Apr 2020 06:51:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 21/26] fs: btrfs: Rename btrfs_file_read() and its callees to avoid name conflicts
Date:   Wed, 22 Apr 2020 14:50:04 +0800
Message-Id: <20200422065009.69392-22-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c     | 2 +-
 fs/btrfs/btrfs.h     | 6 +++---
 fs/btrfs/extent-io.c | 4 ++--
 fs/btrfs/inode.c     | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 8d1dee2f73c4..3916696ab909 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -275,7 +275,7 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 	if (len > inode.size - offset)
 		len = inode.size - offset;
 
-	rd = btrfs_file_read(&root, inr, offset, len, buf);
+	rd = __btrfs_file_read(&root, inr, offset, len, buf);
 	if (rd == -1ULL) {
 		printf("An error occured while reading file %s\n", file);
 		return -1;
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index eb32eb2006a8..025cf4007503 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -58,16 +58,16 @@ int __btrfs_readlink(const struct __btrfs_root *, u64, char *);
 int btrfs_readlink(struct btrfs_root *root, u64 ino, char *target);
 u64 __btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
 		       struct btrfs_inode_item *, int);
-u64 btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
+u64 __btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
 
 /* subvolume.c */
 u64 btrfs_get_default_subvol_objectid(void);
 
 /* extent-io.c */
-u64 btrfs_read_extent_inline(struct __btrfs_path *,
+u64 __btrfs_read_extent_inline(struct __btrfs_path *,
 			      struct btrfs_file_extent_item *, u64, u64,
 			      char *);
-u64 btrfs_read_extent_reg(struct __btrfs_path *, struct btrfs_file_extent_item *,
+u64 __btrfs_read_extent_reg(struct __btrfs_path *, struct btrfs_file_extent_item *,
 			   u64, u64, char *);
 
 #endif /* !__BTRFS_BTRFS_H__ */
diff --git a/fs/btrfs/extent-io.c b/fs/btrfs/extent-io.c
index 456b8776ef67..2af710f0dd32 100644
--- a/fs/btrfs/extent-io.c
+++ b/fs/btrfs/extent-io.c
@@ -13,7 +13,7 @@
 #include "extent-io.h"
 #include "disk-io.h"
 
-u64 btrfs_read_extent_inline(struct __btrfs_path *path,
+u64 __btrfs_read_extent_inline(struct __btrfs_path *path,
 			     struct btrfs_file_extent_item *extent, u64 offset,
 			     u64 size, char *out)
 {
@@ -65,7 +65,7 @@ err:
 	return -1ULL;
 }
 
-u64 btrfs_read_extent_reg(struct __btrfs_path *path,
+u64 __btrfs_read_extent_reg(struct __btrfs_path *path,
 			  struct btrfs_file_extent_item *extent, u64 offset,
 			  u64 size, char *out)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ff411d5251e9..797063449ca6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -587,7 +587,7 @@ u64 __btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 	return inr;
 }
 
-u64 btrfs_file_read(const struct __btrfs_root *root, u64 inr, u64 offset,
+u64 __btrfs_file_read(const struct __btrfs_root *root, u64 inr, u64 offset,
 		    u64 size, char *buf)
 {
 	struct __btrfs_path path;
@@ -622,11 +622,11 @@ u64 btrfs_file_read(const struct __btrfs_root *root, u64 inr, u64 offset,
 
 		if (extent->type == BTRFS_FILE_EXTENT_INLINE) {
 			btrfs_file_extent_item_to_cpu_inl(extent);
-			rd = btrfs_read_extent_inline(&path, extent, offset,
+			rd = __btrfs_read_extent_inline(&path, extent, offset,
 						      size, buf);
 		} else {
 			btrfs_file_extent_item_to_cpu(extent);
-			rd = btrfs_read_extent_reg(&path, extent, offset, size,
+			rd = __btrfs_read_extent_reg(&path, extent, offset, size,
 						   buf);
 		}
 
-- 
2.26.0

