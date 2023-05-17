Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A30706151
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjEQHgx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjEQHgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 03:36:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8007526E
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 00:36:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C9641FF66
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684308966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmFoY+Py4viPmGF+xDWbAea3mgtjMM1fZ7ep1ABYKxU=;
        b=nk3hoFydtP1WtUAPMrRQbukg82dFzY4F/tKm366dE47oB/I57YE/9lnSmXnn9MDPHL+v/C
        u3cXnBW/L4AtdPiIeR78TLGsH09MQhSjj9YtfSPPQ8Ij5ByypfxLvcbUiNRXW1He68Z1s+
        Izt7Jq/fNVcHwjU7vnBwwBKm+pgWKr0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88F8413358
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UJe/EuWDZGQkEQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs-progs: tune: add the ability to generate new data checksums
Date:   Wed, 17 May 2023 15:35:39 +0800
Message-Id: <03dc355cd17236651c57b4d18210a2a74ee3129e.1684308139.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684308139.git.wqu@suse.com>
References: <cover.1684308139.git.wqu@suse.com>
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

This patch would modify btrfs_csum_file_block() to handle csum type
other than the one used in the current fs.

The new data checksum would use a different objectid (-13) to
distinguish with the existing one (-10).
This needs to change tree-checker accept such new key objectid and skip
the item size checks, since new csum can be larger than the original
csum.

After this stage, the resulted csum tree would look like this:

	item 0 key (CSUM_CHANGE EXTENT_CSUM 13631488) itemoff 8091 itemsize 8192
		range start 13631488 end 22020096 length 8388608
	item 1 key (EXTENT_CSUM EXTENT_CSUM 13631488) itemoff 7067 itemsize 1024
		range start 13631488 end 14680064 length 1048576

Note the itemsize is 8 times the original one, as the original csum is
CRC32, while target csum is SHA256, which is 8 times the size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c          | 11 ++++++-----
 convert/main.c               | 12 ++++++------
 kernel-shared/file-item.c    | 34 ++++++++++++++++++----------------
 kernel-shared/file-item.h    |  4 ++--
 kernel-shared/tree-checker.c | 12 ++++++++----
 mkfs/rootdir.c               | 11 ++++++-----
 tune/change-csum.c           | 10 +++++++++-
 7 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index a38d2afc6b6f..175e90f78bdc 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1209,18 +1209,19 @@ static int populate_csum(struct btrfs_trans_handle *trans,
 			 struct btrfs_root *csum_root, char *buf, u64 start,
 			 u64 len)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	u64 offset = 0;
-	u64 sectorsize;
+	u64 sectorsize = fs_info->sectorsize;
 	int ret = 0;
 
 	while (offset < len) {
-		sectorsize = gfs_info->sectorsize;
-		ret = read_data_from_disk(gfs_info, buf, start + offset,
+		ret = read_data_from_disk(fs_info, buf, start + offset,
 					  &sectorsize, 0);
 		if (ret)
 			break;
-		ret = btrfs_csum_file_block(trans, start + len, start + offset,
-					    buf, sectorsize);
+		ret = btrfs_csum_file_block(trans, start + offset,
+					    BTRFS_EXTENT_CSUM_OBJECTID,
+					    fs_info->csum_type, buf);
 		if (ret)
 			break;
 		offset += sectorsize;
diff --git a/convert/main.c b/convert/main.c
index 9781200d7e42..0a62101d7e48 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -182,7 +182,8 @@ static int csum_disk_extent(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    u64 disk_bytenr, u64 num_bytes)
 {
-	u32 blocksize = root->fs_info->sectorsize;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	u32 blocksize = fs_info->sectorsize;
 	u64 offset;
 	char *buffer;
 	int ret = 0;
@@ -193,7 +194,7 @@ static int csum_disk_extent(struct btrfs_trans_handle *trans,
 	for (offset = 0; offset < num_bytes; offset += blocksize) {
 		u64 read_len = blocksize;
 
-		ret = read_data_from_disk(root->fs_info, buffer,
+		ret = read_data_from_disk(fs_info, buffer,
 					  disk_bytenr + offset, &read_len, 0);
 		if (ret)
 			break;
@@ -203,10 +204,9 @@ static int csum_disk_extent(struct btrfs_trans_handle *trans,
 			ret = -EIO;
 			break;
 		}
-		ret = btrfs_csum_file_block(trans,
-					    disk_bytenr + num_bytes,
-					    disk_bytenr + offset,
-					    buffer, blocksize);
+		ret = btrfs_csum_file_block(trans, disk_bytenr + offset,
+					    BTRFS_EXTENT_CSUM_OBJECTID,
+					    fs_info->csum_type, buffer);
 		if (ret)
 			break;
 	}
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 9b59a4b7a9ae..1a2f5f147328 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -134,7 +134,7 @@ static struct btrfs_csum_item *
 btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 		  struct btrfs_root *root,
 		  struct btrfs_path *path,
-		  u64 bytenr, int cow)
+		  u64 bytenr, u64 csum_objectid, u16 csum_type, int cow)
 {
 	int ret;
 	struct btrfs_key file_key;
@@ -142,10 +142,10 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 	struct btrfs_csum_item *item;
 	struct extent_buffer *leaf;
 	u64 csum_offset = 0;
-	u16 csum_size = root->fs_info->csum_size;
+	u16 csum_size = btrfs_csum_type_size(csum_type);
 	int csums_in_item;
 
-	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+	file_key.objectid = csum_objectid;
 	file_key.offset = bytenr;
 	file_key.type = BTRFS_EXTENT_CSUM_KEY;
 	ret = btrfs_search_slot(trans, root, &file_key, path, 0, cow);
@@ -159,7 +159,8 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 			goto fail;
 		path->slots[0]--;
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-		if (found_key.type != BTRFS_EXTENT_CSUM_KEY)
+		if (found_key.type != BTRFS_EXTENT_CSUM_KEY ||
+		    found_key.objectid != csum_objectid)
 			goto fail;
 
 		csum_offset = (bytenr - found_key.offset) /
@@ -182,10 +183,10 @@ fail:
 	return ERR_PTR(ret);
 }
 
-int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
-			  u64 alloc_end, u64 bytenr, char *data, size_t len)
+int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
+			  u64 csum_objectid, u32 csum_type, const char *data)
 {
-	struct btrfs_root *root = btrfs_csum_root(trans->fs_info, bytenr);
+	struct btrfs_root *root = btrfs_csum_root(trans->fs_info, logical);
 	int ret = 0;
 	struct btrfs_key file_key;
 	struct btrfs_key found_key;
@@ -199,18 +200,18 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 	u32 sectorsize = root->fs_info->sectorsize;
 	u32 nritems;
 	u32 ins_size;
-	u16 csum_size = root->fs_info->csum_size;
-	u16 csum_type = root->fs_info->csum_type;
+	u16 csum_size = btrfs_csum_type_size(csum_type);
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-	file_key.offset = bytenr;
+	file_key.objectid = csum_objectid;
+	file_key.offset = logical;
 	file_key.type = BTRFS_EXTENT_CSUM_KEY;
 
-	item = btrfs_lookup_csum(trans, root, path, bytenr, 1);
+	item = btrfs_lookup_csum(trans, root, path, logical, csum_objectid,
+				 csum_type, 1);
 	if (!IS_ERR(item)) {
 		leaf = path->nodes[0];
 		ret = 0;
@@ -241,7 +242,7 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 			slot = 0;
 		}
 		btrfs_item_key_to_cpu(path->nodes[0], &found_key, slot);
-		if (found_key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
+		if (found_key.objectid != csum_objectid ||
 		    found_key.type != BTRFS_EXTENT_CSUM_KEY) {
 			found_next = 1;
 			goto insert;
@@ -270,7 +271,7 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 	csum_offset = (file_key.offset - found_key.offset) / sectorsize;
-	if (found_key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
+	if (found_key.objectid != csum_objectid ||
 	    found_key.type != BTRFS_EXTENT_CSUM_KEY ||
 	    csum_offset >= MAX_CSUM_ITEMS(root, csum_size)) {
 		goto insert;
@@ -290,7 +291,7 @@ insert:
 	btrfs_release_path(path);
 	csum_offset = 0;
 	if (found_next) {
-		u64 tmp = min(alloc_end, next_offset);
+		u64 tmp = min(logical + sectorsize, next_offset);
 		tmp -= file_key.offset;
 		tmp /= sectorsize;
 		tmp = max((u64)1, tmp);
@@ -314,7 +315,8 @@ csum:
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
-	btrfs_csum_data(root->fs_info, csum_type, (u8 *)data, csum_result, len);
+	btrfs_csum_data(root->fs_info, csum_type, (u8 *)data, csum_result,
+			sectorsize);
 	write_extent_buffer(leaf, csum_result, (unsigned long)item,
 			    csum_size);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
diff --git a/kernel-shared/file-item.h b/kernel-shared/file-item.h
index 25dfecca3429..efbe5f2093aa 100644
--- a/kernel-shared/file-item.h
+++ b/kernel-shared/file-item.h
@@ -80,8 +80,8 @@ int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     u64 objectid, u64 pos, u64 offset,
 			     u64 disk_num_bytes, u64 num_bytes);
-int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
-			  u64 alloc_end, u64 bytenr, char *data, size_t len);
+int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
+			  u64 csum_objectid, u32 csum_type, const char *data);
 int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root, u64 objectid,
 			       u64 offset, const char *buffer, size_t size);
diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index b28e42821533..8a1675749769 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -367,10 +367,12 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	u32 sectorsize = fs_info->sectorsize;
 	const u32 csumsize = fs_info->csum_size;
 
-	if (unlikely(key->objectid != BTRFS_EXTENT_CSUM_OBJECTID)) {
+	if (unlikely(key->objectid != BTRFS_EXTENT_CSUM_OBJECTID &&
+		     key->objectid != BTRFS_CSUM_CHANGE_OBJECTID)) {
 		generic_err(leaf, slot,
-		"invalid key objectid for csum item, have %llu expect %llu",
-			key->objectid, BTRFS_EXTENT_CSUM_OBJECTID);
+		"invalid key objectid for csum item, have %llu expect %llu or %llu",
+			key->objectid, BTRFS_EXTENT_CSUM_OBJECTID,
+			BTRFS_CSUM_CHANGE_OBJECTID);
 		return -EUCLEAN;
 	}
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
@@ -385,7 +387,9 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			btrfs_item_size(leaf, slot), csumsize);
 		return -EUCLEAN;
 	}
-	if (slot > 0 && prev_key->type == BTRFS_EXTENT_CSUM_KEY) {
+	if (slot > 0 && prev_key->type == BTRFS_EXTENT_CSUM_KEY &&
+	    !(key->objectid == BTRFS_CSUM_CHANGE_OBJECTID ||
+	      prev_key->objectid == BTRFS_CSUM_CHANGE_OBJECTID)) {
 		u64 prev_csum_end;
 		u32 prev_item_size;
 
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 5fd3c6feea5c..4f7feb529998 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -306,12 +306,13 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 			  struct btrfs_inode_item *btrfs_inode, u64 objectid,
 			  struct stat *st, const char *path_name)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret = -1;
 	ssize_t ret_read;
 	u64 bytes_read = 0;
 	struct btrfs_key key;
 	int blocks;
-	u32 sectorsize = root->fs_info->sectorsize;
+	u32 sectorsize = fs_info->sectorsize;
 	u64 first_block = 0;
 	u64 file_pos = 0;
 	u64 cur_bytes;
@@ -332,7 +333,7 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 	if (st->st_size % sectorsize)
 		blocks += 1;
 
-	if (st->st_size <= BTRFS_MAX_INLINE_DATA_SIZE(root->fs_info) &&
+	if (st->st_size <= BTRFS_MAX_INLINE_DATA_SIZE(fs_info) &&
 	    st->st_size < sectorsize) {
 		char *buffer = malloc(st->st_size);
 
@@ -397,9 +398,9 @@ again:
 			goto end;
 		}
 
-		ret = btrfs_csum_file_block(trans,
-				first_block + bytes_read + sectorsize,
-				first_block + bytes_read, buf, sectorsize);
+		ret = btrfs_csum_file_block(trans, first_block + bytes_read,
+					    BTRFS_EXTENT_CSUM_OBJECTID,
+					    fs_info->csum_type, buf);
 		if (ret)
 			goto end;
 
diff --git a/tune/change-csum.c b/tune/change-csum.c
index 9d1b529e9c34..a30d142c1600 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -21,6 +21,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/file-item.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/transaction.h"
 #include "common/messages.h"
@@ -180,7 +181,14 @@ static int generate_new_csum_range(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 		/* Calculate new csum and insert it into the csum tree. */
-		ret = -EOPNOTSUPP;
+		ret = btrfs_csum_file_block(trans, cur,
+				BTRFS_CSUM_CHANGE_OBJECTID, new_csum_type, buf);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to insert new csum for data at logical %llu: %m",
+			      cur);
+			goto out;
+		}
 	}
 out:
 	free(buf);
-- 
2.40.1

