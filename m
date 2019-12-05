Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00127113AD3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfLEE3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45798 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so1347255lfa.12
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvpCphNZyP2oaaPtjxVrPwL1Z76XALw4LzvC5hkUvSk=;
        b=Q2xzbae+RKliQcIimgQe9nDMjWfNw30lX/SPPM1MJ1GI9Qj3c9eajXybw7IVutLHdF
         NasPSqYyC5MJKvJ320iA0a7PPe24t3JmMcR3HX47UBysW2u62GyEfc/lAc9AzF3+/qxW
         OAyeV0BH4fGy4HSzskgCwGTkMwXPc9i+p5Ir3CD1rZm+hxxwB7SU3EScCmVnzc8YN4nI
         8AezXw8SAiGVXicRkAiUv15+TecQIykmkwbPGyKVUBcUbig2BauZos0vF25Dd1XsH0t0
         o2RB2HEsAYm6cFhZjjs7Or7vh/1gnBPOX8XwQoGnE2r08sKx/p5wPsv/BCUFMN5k8D/h
         ox9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvpCphNZyP2oaaPtjxVrPwL1Z76XALw4LzvC5hkUvSk=;
        b=fsNj0cQFKRwMxE9n2sL47t+p7Qs9ccVFlXD7EYqhbJxYsNMqRl73cvPN0p2LRvxmAC
         Y1bYEKx8fj3OgCrG+3zFZDw+aLDfv9Ic3TbcfIrLSGe1l8DJ8+1Uvl22YKTdyHJ2dpGI
         szH151GR0EDpA9IcAVEVxqRirVax2oqhAd3vgIaJRKwFaI3opxslQjHdMo41FRznq11Q
         oNGnSWzXfy5N5N1MnkgjIlR3guJBFvOMVmfUlFx8a2CNxVclzxCsaKGMeeLLLuJCM5yT
         N8StKq+HUg1g1TtSfR+BavhJJO+HsxBWhdSe1jJrFG4z8ud2cGOoSU0265yH6j4fNWN7
         qKxA==
X-Gm-Message-State: APjAAAUpxcaKkyCy1f7LHreBGmqsnEtcTkE78IjXR83aOaIhwh7HiBKR
        ELAZOkmCQ8QrQHChMS5JwiyRybjK4Do=
X-Google-Smtp-Source: APXvYqztvediDqiAauRG99aDIFWQ+2CP5qzxRAR+SvZJKZTmB8ha0acDja9beB360KgRXspcf01v7w==
X-Received: by 2002:ac2:51a6:: with SMTP id f6mr3940153lfk.174.1575520185193;
        Wed, 04 Dec 2019 20:29:45 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:44 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 06/10] btrfs-progs: abstract function btrfs_add_block_group_cache()
Date:   Thu,  5 Dec 2019 12:29:17 +0800
Message-Id: <20191205042921.25316-7-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205042921.25316-1-Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The new function btrfs_add_block_group_cache() abstracts the old
set_extent_bits and set_state_private operations.

Rename the rb tree version to btrfs_add_block_group_cache_kernel().

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 274dfe540b1f..ff3db5ca2e0c 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -164,10 +164,31 @@ err:
 	return 0;
 }
 
+static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
+				       struct btrfs_block_group_cache *cache,
+				       int bits)
+{
+	int ret;
+
+	ret = set_extent_bits(&info->block_group_cache, cache->key.objectid,
+			      cache->key.objectid + cache->key.offset - 1,
+			      bits);
+	if (ret)
+		return ret;
+
+	ret = set_state_private(&info->block_group_cache, cache->key.objectid,
+				(unsigned long)cache);
+	if (ret)
+		clear_extent_bits(&info->block_group_cache, cache->key.objectid,
+				  cache->key.objectid + cache->key.offset - 1,
+				  bits);
+	return ret;
+}
+
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
-static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
+static int btrfs_add_block_group_cache_kernel(struct btrfs_fs_info *info,
 				struct btrfs_block_group_cache *block_group)
 {
 	struct rb_node **p;
@@ -2769,7 +2790,6 @@ error:
 static int read_one_block_group(struct btrfs_fs_info *fs_info,
 				 struct btrfs_path *path)
 {
-	struct extent_io_tree *block_group_cache = &fs_info->block_group_cache;
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_space_info *space_info;
 	struct btrfs_block_group_cache *cache;
@@ -2819,11 +2839,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	}
 	cache->space_info = space_info;
 
-	set_extent_bits(block_group_cache, cache->key.objectid,
-			cache->key.objectid + cache->key.offset - 1,
-			bit | EXTENT_LOCKED);
-	set_state_private(block_group_cache, cache->key.objectid,
-			  (unsigned long)cache);
+	btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
 	return 0;
 }
 
@@ -2875,9 +2891,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	int ret;
 	int bit = 0;
 	struct btrfs_block_group_cache *cache;
-	struct extent_io_tree *block_group_cache;
-
-	block_group_cache = &fs_info->block_group_cache;
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	BUG_ON(!cache);
@@ -2894,13 +2907,8 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	BUG_ON(ret);
 
 	bit = block_group_state_bits(type);
-	ret = set_extent_bits(block_group_cache, chunk_offset,
-			      chunk_offset + size - 1,
-			      bit | EXTENT_LOCKED);
-	BUG_ON(ret);
 
-	ret = set_state_private(block_group_cache, chunk_offset,
-				(unsigned long)cache);
+	ret = btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
 	BUG_ON(ret);
 	set_avail_alloc_bits(fs_info, type);
 
@@ -2950,9 +2958,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	int bit;
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_cache *cache;
-	struct extent_io_tree *block_group_cache;
 
-	block_group_cache = &fs_info->block_group_cache;
 	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	group_align = 64 * fs_info->sectorsize;
 
@@ -2996,12 +3002,8 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 					0, &cache->space_info);
 		BUG_ON(ret);
 		set_avail_alloc_bits(fs_info, group_type);
-
-		set_extent_bits(block_group_cache, cur_start,
-				cur_start + group_size - 1,
-				bit | EXTENT_LOCKED);
-		set_state_private(block_group_cache, cur_start,
-				  (unsigned long)cache);
+		btrfs_add_block_group_cache(fs_info, cache,
+					    bit | EXTENT_LOCKED);
 		cur_start += group_size;
 	}
 	/* then insert all the items */
-- 
2.21.0 (Apple Git-122)

