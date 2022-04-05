Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E4C4F4432
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 00:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiDEPE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392016AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096CBC3C
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 00B3A1F7AE
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YT6TLJf+R4qEsLvLdSUy9LtyBsZXc6mAknVNTBPiXxA=;
        b=KBj6CJgP4/mpX8Ej2CMecfUptNpNcZfUV/8A0nQXz18V6sfw8f68Vj0ZZtJ7FXPq/5euDj
        KykoRsoMGXFPwsXty7Vg+RTAM16GZVdM6PDoQz70IrUCcMD/dcTiXBzZkvgo73ca5z+dRR
        cZRuG+u0mRyeWYtR1HVOrti1gMsRCvQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51D8513A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oCUwKLU6TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs-progs: use read_data_from_disk() to replace read_extent_from_disk() and replace read_extent_data()
Date:   Tue,  5 Apr 2022 20:48:27 +0800
Message-Id: <b762c53825c77001749829e4a391fd2fa7485599.1649162174.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
References: <cover.1649162174.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function read_extent_from_disk() is only a wrapper to read tree
block.

And read_extent_data() is just a while loop to eliminate short read
caused by stripe boundary.

In fact, a lot of call sites of read_extent_data() are either reading
metadata (thus no possible short read) or doing extra loop by
themselves.

This patch will replace those two functions with read_data_from_disk(),
making it the only entrance for data/metadata read.
And update read_data_from_disk() to return the read bytes, so caller can
do a simple while loop.

For the few callers of read_extent_data(), open-code a small while loop
for them.

This will allow later RAID56 read repair using P/Q much easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c            | 29 +++--------
 btrfs-map-logical.c              |  5 +-
 btrfstune.c                      |  3 +-
 check/main.c                     |  2 +-
 check/mode-common.c              |  4 +-
 cmds/restore.c                   |  4 +-
 image/main.c                     |  2 +-
 kernel-shared/disk-io.c          | 73 +++-------------------------
 kernel-shared/disk-io.h          |  2 -
 kernel-shared/extent_io.c        | 83 +++++++++++---------------------
 kernel-shared/extent_io.h        |  6 +--
 kernel-shared/file.c             | 20 ++++----
 kernel-shared/free-space-cache.c | 20 ++++++--
 13 files changed, 80 insertions(+), 173 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 8ec6d63f060c..92d608e6b9c0 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -40,33 +40,18 @@ static int debug_corrupt_block(struct extent_buffer *eb,
 		struct btrfs_root *root, u64 bytenr, u32 blocksize, u64 copy)
 {
 	int ret;
-	u64 length;
-	struct btrfs_multi_bio *multi = NULL;
-	struct btrfs_device *device;
 	int num_copies;
 	int mirror_num = 1;
 
-	length = blocksize;
 	while (1) {
-		ret = btrfs_map_block(root->fs_info, READ, eb->start, &length,
-				      &multi, mirror_num, NULL);
-		if (ret) {
-			error("cannot map block %llu length %llu mirror %d: %d",
-				eb->start, length, mirror_num, ret);
-			return ret;
-		}
-		device = multi->stripes[0].dev;
-		eb->fd = device->fd;
-		device->total_ios++;
-		eb->dev_bytenr = multi->stripes[0].physical;
-
-		fprintf(stdout,
-			"mirror %d logical %llu physical %llu device %s\n",
-			mirror_num, bytenr, eb->dev_bytenr, device->name);
-		free(multi);
-
 		if (!copy || mirror_num == copy) {
-			ret = read_extent_from_disk(eb, 0, eb->len);
+			u64 read_len = eb->len;
+
+			ret = read_data_from_disk(eb->fs_info, eb->data,
+						  eb->start, &read_len,
+						  mirror_num);
+			if (read_len < eb->len)
+				ret = -EIO;
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot read eb bytenr %llu: %m",
diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index b3a7526b22a4..860c196d6d9b 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -173,8 +173,9 @@ static int write_extent_content(struct btrfs_fs_info *fs_info, int out_fd,
 
 	while (cur_offset < length) {
 		cur_len = min_t(u64, length - cur_offset, BUFFER_SIZE);
-		ret = read_extent_data(fs_info, buffer,
-				       logical + cur_offset, &cur_len, mirror);
+		ret = read_data_from_disk(fs_info, buffer,
+					  logical + cur_offset, &cur_len,
+					  mirror);
 		if (ret < 0) {
 			errno = -ret;
 			fprintf(stderr,
diff --git a/btrfstune.c b/btrfstune.c
index 33c83bf16291..c9a92349a44c 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -333,7 +333,8 @@ static int populate_csum(struct btrfs_trans_handle *trans,
 
 	while (offset < len) {
 		sectorsize = fs_info->sectorsize;
-		ret = read_extent_data(fs_info, buf, start + offset, &sectorsize, 0);
+		ret = read_data_from_disk(fs_info, buf, start + offset,
+					  &sectorsize, 0);
 		if (ret)
 			break;
 		ret = btrfs_csum_file_block(trans, start + len, start + offset,
diff --git a/check/main.c b/check/main.c
index 954d02413f82..b23e6b2e7b2b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5757,7 +5757,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 		for (mirror = 1; mirror <= num_copies; mirror++) {
 			read_len = num_bytes - offset;
 			/* read as much space once a time */
-			ret = read_extent_data(gfs_info, (char *)data + offset,
+			ret = read_data_from_disk(gfs_info, (char *)data + offset,
 					bytenr + offset, &read_len, mirror);
 			if (ret)
 				goto out;
diff --git a/check/mode-common.c b/check/mode-common.c
index a906a5852a46..facc672ccd21 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1202,8 +1202,8 @@ static int populate_csum(struct btrfs_trans_handle *trans,
 
 	while (offset < len) {
 		sectorsize = gfs_info->sectorsize;
-		ret = read_extent_data(gfs_info, buf, start + offset,
-				       &sectorsize, 0);
+		ret = read_data_from_disk(gfs_info, buf, start + offset,
+					  &sectorsize, 0);
 		if (ret)
 			break;
 		ret = btrfs_csum_file_block(trans, start + len, start + offset,
diff --git a/cmds/restore.c b/cmds/restore.c
index 81ca6cd57cb5..5923d571c986 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -407,8 +407,8 @@ again:
 	cur = bytenr;
 	while (cur < bytenr + size_left) {
 		length = bytenr + size_left - cur;
-		ret = read_extent_data(root->fs_info, inbuf + cur - bytenr, cur,
-				       &length, mirror_num);
+		ret = read_data_from_disk(root->fs_info, inbuf + cur - bytenr, cur,
+					  &length, mirror_num);
 		if (ret < 0) {
 			mirror_num++;
 			if (mirror_num > num_copies) {
diff --git a/image/main.c b/image/main.c
index 75f9203fab12..88ed54f5b129 100644
--- a/image/main.c
+++ b/image/main.c
@@ -615,7 +615,7 @@ static int read_data_extent(struct metadump_struct *md,
 	for (cur_mirror = 1; cur_mirror <= num_copies; cur_mirror++) {
 		while (bytes_left) {
 			read_len = bytes_left;
-			ret = read_extent_data(fs_info,
+			ret = read_data_from_disk(fs_info,
 					(char *)(async->buffer + offset),
 					logical, &read_len, cur_mirror);
 			if (ret < 0)
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index f68284264319..78fe2b39da4c 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -316,45 +316,20 @@ static int read_on_restore(struct extent_buffer *eb)
 int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror)
 {
 	unsigned long offset = 0;
-	struct btrfs_multi_bio *multi = NULL;
-	struct btrfs_device *device;
 	int ret = 0;
-	u64 read_len;
 	unsigned long bytes_left = eb->len;
 
 	while (bytes_left) {
-		read_len = bytes_left;
-		device = NULL;
+		u64 read_len = bytes_left;
 
 		if (info->on_restoring)
 			return read_on_restore(eb);
 
-		ret = btrfs_map_block(info, READ, eb->start + offset,
-				      &read_len, &multi, mirror, NULL);
-		if (ret) {
-			printk("Couldn't map the block %llu\n", eb->start + offset);
-			kfree(multi);
-			return -EIO;
-		}
-		device = multi->stripes[0].dev;
-
-		if (device->fd <= 0) {
-			kfree(multi);
-			return -EIO;
-		}
-
-		eb->fd = device->fd;
-		device->total_ios++;
-		eb->dev_bytenr = multi->stripes[0].physical;
-		kfree(multi);
-		multi = NULL;
-
-		if (read_len > bytes_left)
-			read_len = bytes_left;
-
-		ret = read_extent_from_disk(eb, offset, read_len);
-		if (ret)
-			return -EIO;
+		ret = read_data_from_disk(info, eb->data + offset,
+					  eb->start + offset, &read_len,
+					  mirror);
+		if (ret < 0)
+			return ret;
 		offset += read_len;
 		bytes_left -= read_len;
 	}
@@ -471,42 +446,6 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	return ERR_PTR(ret);
 }
 
-int read_extent_data(struct btrfs_fs_info *fs_info, char *data, u64 logical,
-		     u64 *len, int mirror)
-{
-	u64 offset = 0;
-	struct btrfs_multi_bio *multi = NULL;
-	struct btrfs_device *device;
-	int ret = 0;
-	u64 max_len = *len;
-
-	ret = btrfs_map_block(fs_info, READ, logical, len, &multi, mirror,
-			      NULL);
-	if (ret) {
-		fprintf(stderr, "Couldn't map the block %llu\n",
-				logical + offset);
-		goto err;
-	}
-	device = multi->stripes[0].dev;
-
-	if (*len > max_len)
-		*len = max_len;
-	if (device->fd < 0) {
-		ret = -EIO;
-		goto err;
-	}
-
-	ret = btrfs_pread(device->fd, data, *len, multi->stripes[0].physical,
-			  fs_info->zoned);
-	if (ret != *len)
-		ret = -EIO;
-	else
-		ret = 0;
-err:
-	kfree(multi);
-	return ret;
-}
-
 int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 {
 	int ret;
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index e07141a9596d..bba97fc1a814 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -141,8 +141,6 @@ int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirr
 struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		u64 parent_transid);
 
-int read_extent_data(struct btrfs_fs_info *fs_info, char *data, u64 logical,
-		     u64 *len, int mirror);
 void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 			  u64 parent_transid);
 struct extent_buffer* btrfs_find_create_tree_block(
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index ccc8b98107b4..c8bb30f62c2d 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -28,6 +28,7 @@
 #include "kernel-lib/list.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/disk-io.h"
 #include "common/utils.h"
 #include "common/device-utils.h"
 #include "common/internal.h"
@@ -789,69 +790,41 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int read_extent_from_disk(struct extent_buffer *eb,
-			  unsigned long offset, unsigned long len)
-{
-	int ret;
-	ret = btrfs_pread(eb->fd, eb->data + offset, len, eb->dev_bytenr,
-			  eb->fs_info->zoned);
-	if (ret < 0) {
-		ret = -errno;
-		goto out;
-	}
-	if (ret != len) {
-		ret = -EIO;
-		goto out;
-	}
-	ret = 0;
-out:
-	return ret;
-}
-
-int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
-			u64 bytes, int mirror)
+int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
+			u64 *len, int mirror)
 {
 	struct btrfs_multi_bio *multi = NULL;
 	struct btrfs_device *device;
-	u64 bytes_left = bytes;
-	u64 read_len;
-	u64 total_read = 0;
+	u64 read_len = *len;
 	int ret;
 
-	while (bytes_left) {
-		read_len = bytes_left;
-		ret = btrfs_map_block(info, READ, offset, &read_len, &multi,
-				      mirror, NULL);
-		if (ret) {
-			fprintf(stderr, "Couldn't map the block %llu\n",
-				offset);
-			return -EIO;
-		}
-		device = multi->stripes[0].dev;
-
-		read_len = min(bytes_left, read_len);
-		if (device->fd <= 0) {
-			kfree(multi);
-			return -EIO;
-		}
+	ret = btrfs_map_block(info, READ, logical, &read_len, &multi, mirror,
+			      NULL);
+	if (ret) {
+		fprintf(stderr, "Couldn't map the block %llu\n", logical);
+		return -EIO;
+	}
+	device = multi->stripes[0].dev;
 
-		ret = btrfs_pread(device->fd, buf + total_read, read_len,
-				  multi->stripes[0].physical, info->zoned);
+	read_len = min(*len, read_len);
+	if (device->fd <= 0) {
 		kfree(multi);
-		if (ret < 0) {
-			fprintf(stderr, "Error reading %llu, %d\n", offset,
-				ret);
-			return ret;
-		}
-		if (ret != read_len) {
-			fprintf(stderr, "Short read for %llu, read %d, "
-				"read_len %llu\n", offset, ret, read_len);
-			return -EIO;
-		}
+		return -EIO;
+	}
 
-		bytes_left -= read_len;
-		offset += read_len;
-		total_read += read_len;
+	ret = btrfs_pread(device->fd, buf, read_len,
+			  multi->stripes[0].physical, info->zoned);
+	kfree(multi);
+	if (ret < 0) {
+		fprintf(stderr, "Error reading %llu, %d\n", logical,
+			ret);
+		return ret;
+	}
+	if (ret != read_len) {
+		fprintf(stderr,
+			"Short read for %llu, read %d, read_len %llu\n",
+			logical, ret, read_len);
+		return -EIO;
 	}
 
 	return 0;
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index b787c19ef049..cd5e893b165a 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -150,8 +150,6 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						u64 bytenr, u32 blocksize);
 void free_extent_buffer(struct extent_buffer *eb);
 void free_extent_buffer_nocache(struct extent_buffer *eb);
-int read_extent_from_disk(struct extent_buffer *eb,
-			  unsigned long offset, unsigned long len);
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
@@ -169,8 +167,8 @@ int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr);
 int set_extent_buffer_dirty(struct extent_buffer *eb);
 int clear_extent_buffer_dirty(struct extent_buffer *eb);
-int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
-			u64 bytes, int mirror);
+int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
+			u64 *len, int mirror);
 int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
 		       u64 bytes, int mirror);
 void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
diff --git a/kernel-shared/file.c b/kernel-shared/file.c
index a31728102afa..59d82a1dd5f7 100644
--- a/kernel-shared/file.c
+++ b/kernel-shared/file.c
@@ -225,11 +225,11 @@ int btrfs_read_file(struct btrfs_root *root, u64 ino, u64 start, int len,
 	memset(dest, 0, len);
 	while (1) {
 		struct btrfs_file_extent_item *fi;
+		u64 offset = 0;
 		u64 extent_start;
 		u64 extent_len;
 		u64 read_start;
 		u64 read_len;
-		u64 read_len_ret;
 		u64 disk_bytenr;
 
 		leaf = path.nodes[0];
@@ -282,14 +282,16 @@ int btrfs_read_file(struct btrfs_root *root, u64 ino, u64 start, int len,
 
 		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi) +
 			      btrfs_file_extent_offset(leaf, fi);
-		read_len_ret = read_len;
-		ret = read_extent_data(fs_info, dest + read_start - start, disk_bytenr,
-				       &read_len_ret, 0);
-		if (ret < 0)
-			break;
-		/* Short read, something went wrong */
-		if (read_len_ret != read_len)
-			return -EIO;
+		while (offset < read_len) {
+			u64 read_len_ret = read_len - offset;
+
+			ret = read_data_from_disk(fs_info,
+					dest + read_start - start + offset,
+					disk_bytenr + offset, &read_len_ret, 0);
+			if (ret < 0)
+				goto out;
+			offset += read_len_ret;
+		}
 		read += read_len;
 next:
 		ret = btrfs_next_item(root, &path);
diff --git a/kernel-shared/free-space-cache.c b/kernel-shared/free-space-cache.c
index 6d7fee9c86fb..50eeb4381ed4 100644
--- a/kernel-shared/free-space-cache.c
+++ b/kernel-shared/free-space-cache.c
@@ -118,6 +118,8 @@ static int io_ctl_prepare_pages(struct io_ctl *io_ctl, struct btrfs_root *root,
 	}
 
 	while (total_read < io_ctl->total_size) {
+		u64 offset = 0;
+
 		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret) {
@@ -150,11 +152,19 @@ static int io_ctl_prepare_pages(struct io_ctl *io_ctl, struct btrfs_root *root,
 		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi) +
 			btrfs_file_extent_offset(leaf, fi);
 		len = btrfs_file_extent_num_bytes(leaf, fi);
-		ret = read_data_from_disk(root->fs_info,
-					  io_ctl->buffer + key.offset, bytenr,
-					  len, 0);
-		if (ret)
-			break;
+		while (offset < len) {
+			u64 read_len = len - offset;
+
+			ret = read_data_from_disk(root->fs_info,
+					  io_ctl->buffer + key.offset + offset,
+					  bytenr + offset,
+					  &read_len, 0);
+			if (ret < 0) {
+				btrfs_release_path(path);
+				return ret;
+			}
+			offset += read_len;
+		}
 		total_read += len;
 		path->slots[0]++;
 	}
-- 
2.35.1

