Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C516FC55C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjEILtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjEILtG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:49:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFECA4209
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 04:49:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 986171FD9C
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683632942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HkOJYsx8IxMr1bD1Fu5vVOAev/00v9KSXlnQhxX/ync=;
        b=MGmbwQTpMjCb4mrFKWNMplIBeRufPdMvhajgVMu3FOGl/xf1yflJq4w7xJurRageG6FQcf
        tabC9OJatJKqFImqttMGcrFImRDf+SL89xpIK1DDYTumWuEd/g30HQidERUfoYAVCWB0Pz
        vSgsk/KxdSLGm6GH163GBQLt4y5OrvI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF61F139B3
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IPqUKC0zWmQSMwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 May 2023 11:49:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: remove write_and_map_eb()
Date:   Tue,  9 May 2023 19:48:40 +0800
Message-Id: <0a9ad4e9b35b144d8de24de2ab01d59744a027b8.1683632614.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683632614.git.wqu@suse.com>
References: <cover.1683632614.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function write_and_map_eb() is quite abused as a way to write any
generic buffer back to disk.

But we have a more situable function already, write_data_to_disk().

This patch would remove the abused write_data_to_disk() calls, and
convert the only three valid call sites to write_data_to_disk() instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c     | 48 +++++++++++++++++++++++----------------
 convert/main.c            | 19 +++++++---------
 convert/source-reiserfs.c | 10 +-------
 kernel-shared/disk-io.c   | 23 +------------------
 kernel-shared/disk-io.h   |  1 -
 mkfs/rootdir.c            | 41 ++++++++++++---------------------
 6 files changed, 53 insertions(+), 89 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 98cfe598320a..9bbebf25d4b7 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -38,40 +38,47 @@
 
 #define FIELD_BUF_LEN 80
 
-static int debug_corrupt_block(struct extent_buffer *eb,
-		struct btrfs_root *root, u64 bytenr, u32 blocksize, u64 copy)
+static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror)
 {
+	const u32 sectorsize = root->fs_info->sectorsize;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 	int num_copies;
 	int mirror_num = 1;
+	void *buf;
+
+	buf = malloc(root->fs_info->sectorsize);
+	if (!buf) {
+		error_msg(ERROR_MSG_MEMORY, "allocating memory for bytenr %llu",
+			  logical);
+		return -ENOMEM;
+	}
 
 	while (1) {
-		if (!copy || mirror_num == copy) {
-			u64 read_len = eb->len;
+		if (!mirror || mirror_num == mirror) {
+			u64 read_len = sectorsize;
 
-			ret = read_data_from_disk(eb->fs_info, eb->data,
-						  eb->start, &read_len,
-						  mirror_num);
-			if (read_len < eb->len)
+			ret = read_data_from_disk(fs_info, buf, logical,
+						  &read_len, mirror_num);
+			if (read_len < sectorsize)
 				ret = -EIO;
 			if (ret < 0) {
 				errno = -ret;
-				error("cannot read eb bytenr %llu: %m", eb->start);
+				error("cannot read bytenr %llu: %m", logical);
 				return ret;
 			}
-			printf("corrupting %llu copy %d\n", eb->start,
+			printf("corrupting %llu copy %d\n", logical,
 			       mirror_num);
-			memset(eb->data, 0, eb->len);
-			ret = write_and_map_eb(eb->fs_info, eb);
+			memset(buf, 0, sectorsize);
+			ret = write_data_to_disk(fs_info, buf, logical, sectorsize);
 			if (ret < 0) {
 				errno = -ret;
-				error("cannot write eb bytenr %llu: %m", eb->start);
+				error("cannot write bytenr %llu: %m", logical);
 				return ret;
 			}
 		}
 
-		num_copies = btrfs_num_copies(root->fs_info, eb->start,
-					      eb->len);
+		num_copies = btrfs_num_copies(root->fs_info, logical, sectorsize);
 		if (num_copies == 1)
 			break;
 
@@ -157,7 +164,7 @@ static void corrupt_keys(struct btrfs_trans_handle *trans,
 		u16 csum_type = fs_info->csum_type;
 
 		csum_tree_block_size(eb, csum_size, 0, csum_type);
-		write_and_map_eb(eb->fs_info, eb);
+		write_data_to_disk(eb->fs_info, eb->data, eb->start, eb->len);
 	}
 }
 
@@ -878,7 +885,7 @@ static int corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
 		btrfs_set_header_generation(eb, bogus);
 		csum_tree_block_size(eb, fs_info->csum_size, 0,
 				     fs_info->csum_type);
-		ret = write_and_map_eb(fs_info, eb);
+		ret = write_data_to_disk(fs_info, eb->data, eb->start, eb->len);
 		free_extent_buffer(eb);
 		if (ret < 0) {
 			errno = -ret;
@@ -1607,8 +1614,11 @@ int main(int argc, char **argv)
 				goto out_close;
 			}
 
-			debug_corrupt_block(eb, root, logical,
-					    root->fs_info->sectorsize, copy);
+			ret = debug_corrupt_sector(root, logical, (int)copy);
+			if (ret < 0) {
+				ret = 1;
+				goto out_close;
+			}
 			free_extent_buffer(eb);
 		}
 		logical += root->fs_info->sectorsize;
diff --git a/convert/main.c b/convert/main.c
index 46c6dfc571ff..134b44d55f2c 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -367,7 +367,6 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 	u64 hole_len;
 	struct cache_extent *cache;
 	struct btrfs_key key;
-	struct extent_buffer *eb;
 	int ret = 0;
 
 	/*
@@ -378,6 +377,8 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 	 * migrate ranges that covered by old fs data.
 	 */
 	while (cur_off < range_end(range)) {
+		void *buf;
+
 		cache = search_cache_extent(used, cur_off);
 		if (!cache)
 			break;
@@ -399,25 +400,21 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 		if (ret < 0)
 			break;
 
-		eb = malloc(sizeof(*eb) + cur_len);
-		if (!eb) {
+		buf = malloc(cur_len);
+		if (!buf) {
 			ret = -ENOMEM;
 			break;
 		}
 
-		ret = pread(fd, eb->data, cur_len, cur_off);
+		ret = pread(fd, buf, cur_len, cur_off);
 		if (ret < cur_len) {
 			ret = (ret < 0 ? ret : -EIO);
-			free(eb);
+			free(buf);
 			break;
 		}
-		eb->start = key.objectid;
-		eb->len = key.offset;
-		eb->fs_info = root->fs_info;
-
+		ret = write_data_to_disk(root->fs_info, buf, key.objectid, key.offset);
 		/* Write the data */
-		ret = write_and_map_eb(root->fs_info, eb);
-		free(eb);
+		free(buf);
 		if (ret < 0)
 			break;
 
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index ceb50b6af093..35fd01050c7a 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -352,7 +352,6 @@ static int convert_direct(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	u32 sectorsize = root->fs_info->sectorsize;
 	int ret;
-	struct extent_buffer *eb;
 
 	BUG_ON(length > sectorsize);
 	ret = btrfs_reserve_extent(trans, root, sectorsize,
@@ -360,14 +359,7 @@ static int convert_direct(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	eb = alloc_extent_buffer(root->fs_info, key.objectid, sectorsize);
-
-	if (!eb)
-		return -ENOMEM;
-
-	write_extent_buffer(eb, body, 0, length);
-	ret = write_and_map_eb(root->fs_info, eb);
-	free_extent_buffer(eb);
+	ret = write_data_to_disk(root->fs_info, body, key.objectid, sectorsize);
 	if (ret)
 		return ret;
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 51fa4fdca7a7..f3b7631c385f 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -462,27 +462,6 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	return eb;
 }
 
-int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
-{
-	int ret;
-	u64 *raid_map = NULL;
-	struct btrfs_multi_bio *multi = NULL;
-
-	/* write_data_to_disk() will handle all mirrors and RAID56. */
-	ret = write_data_to_disk(fs_info, eb->data, eb->start, eb->len);
-	if (ret < 0) {
-		errno = -ret;
-		error("failed to write bytenr %llu length %u: %m",
-			eb->start, eb->len);
-		goto out;
-	}
-
-out:
-	kfree(raid_map);
-	kfree(multi);
-	return ret;
-}
-
 int write_tree_block(struct btrfs_trans_handle *trans,
 		     struct btrfs_fs_info *fs_info,
 		     struct extent_buffer *eb)
@@ -500,7 +479,7 @@ int write_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
 	csum_tree_block(fs_info, eb, 0);
 
-	return write_and_map_eb(fs_info, eb);
+	return write_data_to_disk(fs_info, eb->data, eb->start, eb->len);
 }
 
 void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 6baa4a806b78..3a31667967cc 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -222,7 +222,6 @@ int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid);
 int write_tree_block(struct btrfs_trans_handle *trans,
 		     struct btrfs_fs_info *fs_info,
 		     struct extent_buffer *eb);
-int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb);
 int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index aa2577addc0f..5fd3c6feea5c 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -316,7 +316,7 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 	u64 file_pos = 0;
 	u64 cur_bytes;
 	u64 total_bytes;
-	struct extent_buffer *eb = NULL;
+	void *buf = NULL;
 	int fd;
 
 	if (st->st_size == 0)
@@ -358,12 +358,8 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 	/* round up our st_size to the FS blocksize */
 	total_bytes = (u64)blocks * sectorsize;
 
-	/*
-	 * do our IO in extent buffers so it can work
-	 * against any raid type
-	 */
-	eb = calloc(1, sizeof(*eb) + sectorsize);
-	if (!eb) {
+	buf = malloc(sectorsize);
+	if (!buf) {
 		ret = -ENOMEM;
 		goto end;
 	}
@@ -385,37 +381,28 @@ again:
 
 	while (bytes_read < cur_bytes) {
 
-		memset(eb->data, 0, sectorsize);
+		memset(buf, 0, sectorsize);
 
-		ret_read = pread(fd, eb->data, sectorsize, file_pos +
-				   bytes_read);
+		ret_read = pread(fd, buf, sectorsize, file_pos + bytes_read);
 		if (ret_read == -1) {
 			error("cannot read %s at offset %llu length %u: %m",
 				path_name, file_pos + bytes_read, sectorsize);
 			goto end;
 		}
 
-		eb->start = first_block + bytes_read;
-		eb->len = sectorsize;
-		eb->fs_info = root->fs_info;
-
-		/*
-		 * we're doing the csum before we record the extent, but
-		 * that's ok
-		 */
-		ret = btrfs_csum_file_block(trans,
-				first_block + bytes_read + sectorsize,
-				first_block + bytes_read,
-				eb->data, sectorsize);
-		if (ret)
-			goto end;
-
-		ret = write_and_map_eb(root->fs_info, eb);
+		ret = write_data_to_disk(root->fs_info, buf,
+					 first_block + bytes_read, sectorsize);
 		if (ret) {
 			error("failed to write %s", path_name);
 			goto end;
 		}
 
+		ret = btrfs_csum_file_block(trans,
+				first_block + bytes_read + sectorsize,
+				first_block + bytes_read, buf, sectorsize);
+		if (ret)
+			goto end;
+
 		bytes_read += sectorsize;
 	}
 
@@ -434,7 +421,7 @@ again:
 		goto again;
 
 end:
-	free(eb);
+	free(buf);
 	close(fd);
 	return ret;
 }
-- 
2.40.1

