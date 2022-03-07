Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D784D0AAA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiCGWMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiCGWMU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:20 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917198BE16
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:25 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id a1so14547314qta.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JR5tqSrccSn87B5oEhMRE8w2KwBLkDn+TrvD674ybNc=;
        b=R3yH1uCu1KNaHLXaT/xG/8aqyhdBUH/ufyNo4bnVoQKDO3o9jVY6CR5J+aceIo71oR
         mZB3+vqYwGmoA1Xi0lOsdifnfYYZvb7ruUCEZiBWEMAO8KQvSJEVGQGXr77F2wUqCHxp
         B9xyzyWvP2r671+Xo681Yt42rwwmaKm4QHYpwCIHxzRCYNFYAK7mKftAfkel7kh5uhl2
         Jp0s0gNS6w4X7ufUogqUlNOS09cb9b2rW0NWeyeQluK1snlkidhubtuFxGv0WjMScDe/
         Gyc07eIkB/psWriUCWQ7z0rZm5kUcQ/N8k9Hm0IexkyyNVXQd4HDmXhneNtxZtWf0cVV
         ZkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JR5tqSrccSn87B5oEhMRE8w2KwBLkDn+TrvD674ybNc=;
        b=Rq2uF5eeK9LgAgyeoSi5gLeOrV5t5e+gcTkjKqAk19Bcgni7TcyEhiRyUmyiMeCdVF
         ACdHZvT0gqJSFYTjQK6GvHrTTy5WX0GBTPiHt/uQeDfN8NHYYjKVXdtF9Hzb8cIkCSKD
         g78f1vp3RB4k3RgCANwrdXjPQcDNHe+/Hg2XeLa/NeDSe42jQis6B3OMnCn4wq/c6mD6
         xPvxIJ8PpCfCakxEaRudMUn2VyqP2/reSdnvv86r9zLUj3Q+u+nvZRlu1bnqpHrF603m
         PDs6xH9dSLQ3eTOtmGjNQQBY9V+byxkSWPhrdU5/zdh/FyuQD0Gh+/a5MO/wJu7VCQVA
         cOkQ==
X-Gm-Message-State: AOAM532wSGqn/nNrhKcE6xYjy9yZ5rPZ5uTB0sFlTN2vw0x5+AMLHjtl
        R8BO1WbOu+iKm9+WDZ4NFot5dRqYx4Tu67aA
X-Google-Smtp-Source: ABdhPJwrm+XNHm/NNsi0/zL5VxMtqkeMcTCBvxwTMPiJYN4wavAClynXGg07kevRqM9QfyaCiDCQng==
X-Received: by 2002:a05:622a:1820:b0:2dc:93dd:19f8 with SMTP id t32-20020a05622a182000b002dc93dd19f8mr11298306qtc.301.1646691084414;
        Mon, 07 Mar 2022 14:11:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r21-20020a37a815000000b0067d15afb9ebsm229878qke.90.2022.03.07.14.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 13/19] btrfs-progs: handle the per-block group global root id
Date:   Mon,  7 Mar 2022 17:10:58 -0500
Message-Id: <c4246e5ede41283278368868bdcbfcbe96c5559f.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will now be using block_group->chunk_objectid to point at the global
root id for this particular block group.  For now we'll assign this
based on mod'ing the offset of the block group against the number of
global root id's and handle the block_group_item updating appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h           |  2 ++
 kernel-shared/disk-io.c         | 24 ++++++++++++++++++++++--
 kernel-shared/disk-io.h         |  1 +
 kernel-shared/extent-tree.c     | 24 ++++++++++++++++++++++--
 kernel-shared/free-space-tree.c |  3 +++
 5 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 90de7a65..d79f49c9 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1190,6 +1190,8 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 write_offset;
+
+	u64 global_root_id;
 };
 
 struct btrfs_device;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index fcef6e97..59c46946 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -806,13 +806,33 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 	return NULL;
 }
 
+u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	struct btrfs_block_group *block_group;
+	u64 ret = 0;
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return ret;
+
+	/*
+	 * We use this because we won't have this many global roots, and -1 is
+	 * special, so we need something that'll not be found if we have any
+	 * errors from here on.
+	 */
+	ret = BTRFS_LAST_FREE_OBJECTID;
+	block_group = btrfs_lookup_first_block_group(fs_info, bytenr);
+	if (block_group)
+		ret = block_group->global_root_id;
+	return ret;
+}
+
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
 				   u64 bytenr)
 {
 	struct btrfs_key key = {
 		.objectid = BTRFS_CSUM_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
@@ -824,7 +844,7 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
 	struct btrfs_key key = {
 		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 1e9044f8..81d8670f 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -225,6 +225,7 @@ struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 bytenr);
 struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key);
+u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
 			     struct btrfs_root *root);
 
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index b2b99d4f..697a8a1e 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1561,7 +1561,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_block_group_used(&bgi, cache->used);
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+						   cache->global_root_id);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
 fail:
@@ -2658,6 +2658,7 @@ static int read_block_group_item(struct btrfs_block_group *cache,
 			   sizeof(bgi));
 	cache->used = btrfs_stack_block_group_used(&bgi);
 	cache->flags = btrfs_stack_block_group_flags(&bgi);
+	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(&bgi);
 
 	return 0;
 }
@@ -2765,6 +2766,24 @@ error:
 	return ret;
 }
 
+/*
+ * For extent tree v2 we use the block_group_item->chunk_offset to point at our
+ * global root id.  For v1 it's always set to BTRFS_FIRST_CHUNK_TREE_OBJECTID.
+ */
+static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
+{
+	u64 div = SZ_1G;
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+
+	/* If we have a smaller fs index based on 128m. */
+	if (btrfs_super_total_bytes(fs_info->super_copy) <= (SZ_1G * 10ULL))
+		div = SZ_128M;
+
+	return (div_u64(offset, div) % fs_info->nr_global_roots);
+}
+
 struct btrfs_block_group *
 btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 		      u64 chunk_offset, u64 size)
@@ -2776,6 +2795,7 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	BUG_ON(!cache);
 	cache->start = chunk_offset;
 	cache->length = size;
+	cache->global_root_id = calculate_global_root_id(fs_info, chunk_offset);
 
 	ret = btrfs_load_block_group_zone_info(fs_info, cache);
 	BUG_ON(ret);
@@ -2806,7 +2826,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 
 	btrfs_set_stack_block_group_used(&bgi, block_group->used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+						   block_group->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 896bd3a2..a82865d3 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -34,6 +34,9 @@ static struct btrfs_root *btrfs_free_space_root(struct btrfs_fs_info *fs_info,
 		.offset = 0,
 	};
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		key.offset = block_group->global_root_id;
+
 	return btrfs_global_root(fs_info, &key);
 }
 
-- 
2.26.3

