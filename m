Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F0785AAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbjHWOdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbjHWOdf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:35 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C62FE57
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5925e580f12so8400687b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801212; x=1693406012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMur5JvaWbgPaGGZaTOFjR8ufthd4YpaCdeoWzxIOU4=;
        b=iWTxDE5+phpXnNDLitPLRv/UbLHlVLEEzm0mNOim+5IgSH2zBYpTtBV9uSgDgRZhOO
         nTBCGk96IrwZjhYkEDmjPJYBoBvB6k7gaJBrDlxXeml2SXZmdpWFHBBRDurrH5t/jAMl
         VSlYqGreJj4CaFdM1wbOVigDnaDubLTj03sWDHx111rjJz7SEMKa4j3/qTL7kXO7fGJt
         x2500WYBvaM2E+F7DUpoixZcVA0AvxbjDm33xGLaZJKFqFQju0CBczWnp2o79jzozSOP
         ML6wQwwlJA4yVvO+z/U4XW6/ZeIaeWD9bEXrFOPuJGnRLj3k6EgQNzh7uFhUcome929I
         7fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801212; x=1693406012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMur5JvaWbgPaGGZaTOFjR8ufthd4YpaCdeoWzxIOU4=;
        b=Ba4eNfiZipdqYaFYtPkTabChk359eE//GfyL6DQ+x8rTbqbChy2VIO9a70Zs4cKY09
         vl+SCLarvGZhzBuitovIji2Er9ZCM+soL162k6Gud2P5JQ1R3elR3h66Z+ayJtUYb21r
         qo4I2QwQrxXpwuWTML+8htpvSOxhZF6B20qeoiOvKd3J6WiME2/+5g34cbRZD685sEcO
         YvzrecXMuwtgrY61LbrnXjiKSCeEV1ltET/lSoHg42mUHZOwS6nfws/nONqeYCXSegpV
         Ta6GWPNzilp8oCU3OxDnKCsUPItEKOCZt+es4pPTWkYGpXGaXgWz39mPCvyLLQJLV1Rx
         RcPA==
X-Gm-Message-State: AOJu0YzBP90LBNnkYjT1aAcCwEc00jeo0kfZDwY4hkzMTg6XAf31q1Et
        M6+biVGy8iQm/xdNyH8v42zMS/wMspISwwkz3is=
X-Google-Smtp-Source: AGHT+IFUATgpmvG0J8B1TMIuKnMdbu477qMCom6wDbRRIyB5jywAWPBtntkYtzNpKAwdDlTkB2XtIQ==
X-Received: by 2002:a0d:cf44:0:b0:56f:ff55:2b7d with SMTP id r65-20020a0dcf44000000b0056fff552b7dmr12531177ywd.17.1692801212611;
        Wed, 23 Aug 2023 07:33:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w67-20020a818646000000b0054f50f71834sm3367990ywf.124.2023.08.23.07.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/38] btrfs-progs: make btrfs_del_ptr a void
Date:   Wed, 23 Aug 2023 10:32:46 -0400
Message-ID: <3d784e00931075ead1acad5165be616c8f3bd898.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index b8bcf5c3..a33a300a 100644
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
index ae6c03f9..91127933 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -853,9 +853,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_clear_buffer_dirty(trans, right);
 			free_extent_buffer(right);
 			right = NULL;
-			wret = btrfs_del_ptr(root, path, level + 1, pslot + 1);
-			if (wret)
-				ret = wret;
+			btrfs_del_ptr(root, path, level + 1, pslot + 1);
 
 			root_sub_used(root, blocksize);
 			wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
@@ -900,9 +898,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_clear_buffer_dirty(trans, mid);
 		free_extent_buffer(mid);
 		mid = NULL;
-		wret = btrfs_del_ptr(root, path, level + 1, pslot);
-		if (wret)
-			ret = wret;
+		btrfs_del_ptr(root, path, level + 1, pslot);
 
 		root_sub_used(root, blocksize);
 		wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
@@ -2716,12 +2712,11 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root
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
@@ -2745,7 +2740,6 @@ int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
-	return ret;
 }
 
 /*
@@ -2766,9 +2760,7 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	int ret;
 
 	WARN_ON(btrfs_header_generation(leaf) != trans->transid);
-	ret = btrfs_del_ptr(root, path, 1, path->slots[1]);
-	if (ret)
-		return ret;
+	btrfs_del_ptr(root, path, 1, path->slots[1]);
 
 	root_sub_used(root, leaf->len);
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index ec81a46c..a1c09d97 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -942,7 +942,7 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
 
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
-int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
+void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
 struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 					   int slot);
-- 
2.41.0

