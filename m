Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964E86F2661
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjD2UUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjD2UUa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:30 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804FA211C
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:29 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9a805fd0dcso1562652276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799628; x=1685391628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYR7l0Iu2faBmf0CDEI84J75njZbfj+Kjz8af9wFOME=;
        b=ZhGyEKBgO77vdnSUHD6Qk2uezA38xK4F7JdD8Z5dR1IYtRMOoEER/Gof0vEE70zK1N
         +pru50CIHsBOPrxyphy+9PMYIj+qdV6R6ftXMpyQkxt7Gvbop5QmLOU509hPW/GKcucr
         RokO3YKzh9Jo77G6lFPBHpKJAOgOPiqavisTCanphUZOexBofEJsZjMGW3+Bu4xU9vFU
         fwCpQAgZxOLuAWHR8rVR8zcV2i8jHkcc1VqhTHLKjRuLk9l1xwyHmd1uaYRFKVt+VIoW
         9XETutNoAnRfkKGzRn14BCMOYewumUnkqir/TzIYmP6KbPIz7qup5zsQ6GwoVy6Lz36l
         KJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799628; x=1685391628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYR7l0Iu2faBmf0CDEI84J75njZbfj+Kjz8af9wFOME=;
        b=V7afPTpsrWRc0l790ta+LoGFVQoeiSUnCxvwdkV/5dGlnPEsRB0oYeI6Zs/VGojitK
         Zw9K+u0wJXzsGRiQ41UU3UlXQRG1h3ZXqPApxQvvYYvpnSTBOt1nituNxUsDyb0zi3zt
         9J8iorP1C6OhcgeNBuHWn/1qyVs/3k/s5MhnMeHJHVbDm1f8MqNpPixZJFP84mwIf1az
         nyDZTSrhR2HrPx/LUTKTqALWnXVDkROaErVEX71b6/IOKz2LMzyL01LFDarEl6bRSvKJ
         +oFB20zzDbQkkiQfh1ZWM4wwRn6HmrQvGE33tGw5HWV75phrW/QJBl/x/w66PSYmnqsh
         6MOQ==
X-Gm-Message-State: AC+VfDyS2VJsRp3GS2aIG8/hdQckytPB3NP2wKuPI3zwuESFdLgg6OsS
        +D4wen5kX6JUE5zszrf+z8FBB/VgNY1NqvG/L4Ud6A==
X-Google-Smtp-Source: ACHHUZ4iSRM4yfvKdE3i/OhoG5AYOHAAHAgJ3dcu4nylwk0Mffg7IbKrs3Eoatf516sM+eWtGiwSVw==
X-Received: by 2002:a25:b120:0:b0:b8f:517c:1c15 with SMTP id g32-20020a25b120000000b00b8f517c1c15mr8632916ybj.11.1682799628395;
        Sat, 29 Apr 2023 13:20:28 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p138-20020a257490000000b00b8be4767167sm5873659ybc.26.2023.04.29.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/26] btrfs-progs: make btrfs_del_ptr a void
Date:   Sat, 29 Apr 2023 16:19:52 -0400
Message-Id: <846c93398a45417a0f9cd0fb8e7bd8aeec2bfa93.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

This always returns 0, and in the kernel is a void.  Update the
definition to match the kernel and then update all of the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          |  7 +++----
 kernel-shared/ctree.c | 16 ++++------------
 kernel-shared/ctree.h |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/check/main.c b/check/main.c
index 5e4f5827..2643244f 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3569,9 +3569,8 @@ static int repair_btree(struct btrfs_root *root,
 					     path.slots[level]);
 
 		/* Remove the ptr */
-		ret = btrfs_del_ptr(root, &path, level, path.slots[level]);
-		if (ret < 0)
-			goto out;
+		btrfs_del_ptr(root, &path, level, path.slots[level]);
+
 		/*
 		 * Remove the corresponding extent
 		 * return value is not concerned.
@@ -7829,7 +7828,7 @@ again:
 
 del_ptr:
 	printk("deleting pointer to block %llu\n", corrupt->cache.start);
-	ret = btrfs_del_ptr(extent_root, &path, level, slot);
+	btrfs_del_ptr(extent_root, &path, level, slot);
 
 out:
 	btrfs_release_path(&path);
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 9cb58908..f9cf78da 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -685,9 +685,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_clear_buffer_dirty(trans, right);
 			free_extent_buffer(right);
 			right = NULL;
-			wret = btrfs_del_ptr(root, path, level + 1, pslot + 1);
-			if (wret)
-				ret = wret;
+			btrfs_del_ptr(root, path, level + 1, pslot + 1);
 
 			root_sub_used(root, blocksize);
 			wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
@@ -732,9 +730,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_clear_buffer_dirty(trans, mid);
 		free_extent_buffer(mid);
 		mid = NULL;
-		wret = btrfs_del_ptr(root, path, level + 1, pslot);
-		if (wret)
-			ret = wret;
+		btrfs_del_ptr(root, path, level + 1, pslot);
 
 		root_sub_used(root, blocksize);
 		wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
@@ -2557,12 +2553,11 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root
  * continuing all the way the root if required.  The root is converted into
  * a leaf if all the nodes are emptied.
  */
-int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
+void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot)
 {
 	struct extent_buffer *parent = path->nodes[level];
 	u32 nritems;
-	int ret = 0;
 
 	nritems = btrfs_header_nritems(parent);
 	if (slot < nritems - 1) {
@@ -2586,7 +2581,6 @@ int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
-	return ret;
 }
 
 /*
@@ -2607,9 +2601,7 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	int ret;
 
 	WARN_ON(btrfs_header_generation(leaf) != trans->transid);
-	ret = btrfs_del_ptr(root, path, 1, path->slots[1]);
-	if (ret)
-		return ret;
+	btrfs_del_ptr(root, path, 1, path->slots[1]);
 
 	root_sub_used(root, leaf->len);
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 40b8854c..88a105ab 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -941,7 +941,7 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
 
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
-int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
+void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
 struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 					   int slot);
-- 
2.40.0

