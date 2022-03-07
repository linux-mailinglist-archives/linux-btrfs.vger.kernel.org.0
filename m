Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C314D0ADC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbiCGWS4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244771AbiCGWSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:55 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBF8403E9
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:17:59 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b67so2425698qkc.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nx+OAHeAKqAX0976oKSPZ0EOj6KM5KHb5r0GQHN2Zhc=;
        b=Hl/tMqKSy4lrcMWVD6e8RRwnLGgsl4qdxvJi3gBEgqt9Opn0CbOpuG3pIdF0GJElba
         1NiGKYstTjUH4iTer5tQdaKKu/snFfsE4a39nkOD3OxG7UHYikcFaQCZp7rOdr36V+Fe
         fcCnbWVbn0EtoAsZDRhs3AQmJMU97+/MCvtjCBhIERqmM7KJr1KLBXwrJXj1RVEFDsOv
         n6tK5BFDmSjl0ik0T3jAG/g7W5YVs0C9wouaT1kDY77o3EptClPtX5iGTBXClVhRBiix
         qZLC+H4CzeDFG9mYghLHU+zn3JJbR5aKHetCwNx6Cm4RCfodJXIpitPQHHZNJ+sxTvyo
         o6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nx+OAHeAKqAX0976oKSPZ0EOj6KM5KHb5r0GQHN2Zhc=;
        b=6yMqqg2DdHlxgBnr7GCbEs9MeGYiOZL3TtP8hE8fSu2uhibKk1gMgcfhABNgHj9Jkg
         akMP42RxRRxBZ5sx6Wrv/Nz1cJoC3Noi9CM2jcDnLA5lA7WEmTZoDcT72eLL/sJ0R6W3
         R3O87+M2ryIN8e0KXKCAIb2DQKCBz+MEFEExpN5IXeoH+wpogFFWzzWg2/f58aRg9oQc
         wHm7PZ8qeg9mijX1nkp3P0zw7QLvlT8ecmWIVVjJgZMQLpeThyFIJOxmUnKAvNsI043K
         k7ettRZkVLDJscRhkXkjPDrxoYOMyB5DtumHAN+GINAeas3JtUDybsLUZ7vgD1R8MxGb
         XapQ==
X-Gm-Message-State: AOAM532EOOfMZC60WiOnkXO3+EKaNFb86PntzU87S4T6eueu6x+0JRW9
        UdMNw/AOERz710gbSwk3YBDMoWG18WQo/cUI
X-Google-Smtp-Source: ABdhPJypkG1WGT9Q9B2MYK//eoQSBepOnsRzjPPo9Ja2tr1i4vfL0csT85tNoOwPtPSGiHxLRfFMMQ==
X-Received: by 2002:a37:8d83:0:b0:663:330e:3cfc with SMTP id p125-20020a378d83000000b00663330e3cfcmr8256628qkd.223.1646691477927;
        Mon, 07 Mar 2022 14:17:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s7-20020a05622a018700b002dfed15c9edsm9675756qtw.74.2022.03.07.14.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:17:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/15] btrfs-progs: move the buffer init code to btrfs_alloc_free_block
Date:   Mon,  7 Mar 2022 17:17:39 -0500
Message-Id: <a962a2bec2984ad38c93c5216643a876237d3218.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

We are copying this init code everywhere we call btrfs_alloc_free_block,
fix this by putting it inside the helper itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c                | 14 ----------
 kernel-shared/ctree.c       | 51 -------------------------------------
 kernel-shared/disk-io.c     | 10 --------
 kernel-shared/extent-tree.c | 11 ++++++++
 4 files changed, 11 insertions(+), 75 deletions(-)

diff --git a/check/main.c b/check/main.c
index c5ffd652..869acf67 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9246,20 +9246,6 @@ static struct extent_buffer *btrfs_fsck_clear_root(
 		return c;
 	}
 
-	memset_extent_buffer(c, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_level(c, 0);
-	btrfs_set_header_bytenr(c, c->start);
-	btrfs_set_header_generation(c, trans->transid);
-	btrfs_set_header_backref_rev(c, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(c, key->objectid);
-
-	write_extent_buffer(c, gfs_info->fs_devices->metadata_uuid,
-			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
-
-	write_extent_buffer(c, gfs_info->chunk_tree_uuid,
-			    btrfs_header_chunk_tree_uuid(c),
-			    BTRFS_UUID_SIZE);
-
 	btrfs_mark_buffer_dirty(c);
 
 	/*
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 8846836b..6a578a41 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -237,18 +237,6 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 	}
 	new_root->node = node;
 
-	memset_extent_buffer(node, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(node, node->start);
-	btrfs_set_header_generation(node, trans->transid);
-	btrfs_set_header_backref_rev(node, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(node, objectid);
-	write_extent_buffer(node, fs_info->fs_devices->metadata_uuid,
-			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
-	write_extent_buffer(node, fs_info->chunk_tree_uuid,
-			    btrfs_header_chunk_tree_uuid(node),
-			    BTRFS_UUID_SIZE);
-	btrfs_set_header_nritems(node, 0);
-	btrfs_set_header_level(node, 0);
 	ret = btrfs_inc_ref(trans, new_root, node, 0);
 	if (ret < 0)
 		goto free;
@@ -1751,23 +1739,9 @@ static int noinline insert_new_root(struct btrfs_trans_handle *trans,
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
-	memset_extent_buffer(c, 0, 0, sizeof(struct btrfs_header));
 	btrfs_set_header_nritems(c, 1);
-	btrfs_set_header_level(c, level);
-	btrfs_set_header_bytenr(c, c->start);
-	btrfs_set_header_generation(c, trans->transid);
-	btrfs_set_header_backref_rev(c, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(c, root->root_key.objectid);
-
 	root_add_used(root, root->fs_info->nodesize);
 
-	write_extent_buffer(c, root->fs_info->fs_devices->metadata_uuid,
-			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
-
-	write_extent_buffer(c, root->fs_info->chunk_tree_uuid,
-			    btrfs_header_chunk_tree_uuid(c),
-			    BTRFS_UUID_SIZE);
-
 	btrfs_set_node_key(c, &lower_key, 0);
 	btrfs_set_node_blockptr(c, 0, lower->start);
 	lower_gen = btrfs_header_generation(lower);
@@ -1876,18 +1850,6 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
-	memset_extent_buffer(split, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_level(split, btrfs_header_level(c));
-	btrfs_set_header_bytenr(split, split->start);
-	btrfs_set_header_generation(split, trans->transid);
-	btrfs_set_header_backref_rev(split, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(split, root->root_key.objectid);
-	write_extent_buffer(split, root->fs_info->fs_devices->metadata_uuid,
-			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
-	write_extent_buffer(split, root->fs_info->chunk_tree_uuid,
-			    btrfs_header_chunk_tree_uuid(split),
-			    BTRFS_UUID_SIZE);
-
 	root_add_used(root, root->fs_info->nodesize);
 
 	copy_extent_buffer(split, c,
@@ -2445,19 +2407,6 @@ again:
 		return PTR_ERR(right);
 	}
 
-	memset_extent_buffer(right, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(right, right->start);
-	btrfs_set_header_generation(right, trans->transid);
-	btrfs_set_header_backref_rev(right, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(right, root->root_key.objectid);
-	btrfs_set_header_level(right, 0);
-	write_extent_buffer(right, root->fs_info->fs_devices->metadata_uuid,
-			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
-
-	write_extent_buffer(right, root->fs_info->chunk_tree_uuid,
-			    btrfs_header_chunk_tree_uuid(right),
-			    BTRFS_UUID_SIZE);
-
 	root_add_used(root, root->fs_info->nodesize);
 
 	if (split == 0) {
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 35422d8c..e5ad2c82 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2458,17 +2458,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	memset_extent_buffer(leaf, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(leaf, leaf->start);
-	btrfs_set_header_generation(leaf, trans->transid);
-	btrfs_set_header_backref_rev(leaf, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(leaf, root->root_key.objectid);
 	root->node = leaf;
-	write_extent_buffer(leaf, fs_info->fs_devices->metadata_uuid,
-			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
-	write_extent_buffer(leaf, fs_info->chunk_tree_uuid,
-			    btrfs_header_chunk_tree_uuid(leaf),
-			    BTRFS_UUID_SIZE);
 	btrfs_mark_buffer_dirty(leaf);
 
 	extent_buffer_get(root->node);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 933e8209..0361ec97 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2588,6 +2588,17 @@ struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
 	}
 	btrfs_set_buffer_uptodate(buf);
 	trans->blocks_used++;
+	memset_extent_buffer(buf, 0, 0, sizeof(struct btrfs_header));
+	btrfs_set_header_level(buf, level);
+	btrfs_set_header_bytenr(buf, buf->start);
+	btrfs_set_header_generation(buf, trans->transid);
+	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);
+	btrfs_set_header_owner(buf, root_objectid);
+	write_extent_buffer(buf, root->fs_info->fs_devices->metadata_uuid,
+			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
+	write_extent_buffer(buf, root->fs_info->chunk_tree_uuid,
+			    btrfs_header_chunk_tree_uuid(buf),
+			    BTRFS_UUID_SIZE);
 
 	return buf;
 }
-- 
2.26.3

