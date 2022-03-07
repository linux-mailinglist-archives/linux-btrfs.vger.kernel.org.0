Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3354D0A9C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245741AbiCGWMS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiCGWMR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:17 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8517C14F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:22 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id b12so13250936qvk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mRmNZiVAWQGD1tPwurtto/oOanj+/iIrZoM7LI/sj2E=;
        b=Sg35GjLFHDdMAr++BPKR/RnGHqgSTzupLN1EEwJ65UAjiyixPE0U4Db2NPfRiCBXMF
         dY59yXd7GxnBsEno4qZZZe37xnpVrm3yW/9XrIbBTJJWoC9QDEaeGCqbnXTeXbPRCMQb
         3FdKYF1GjCVXrmzp/ZqVYJUH6ip3yJTTQzfpuIgrcJucdVBfEH2kQ1bu47FqQ0bPOjfP
         ImZD6Wcq5J9vQ/HQwBMw2LE1sbtBX+aRyAoJtBQDje3U+9yMul/zIWU64pk01lnT8if5
         bSquqcnKEFkYLWclbyiFUXxSBQ+j0Kf2FQ6UmDg+xbasVEaQLhKp6+liWkme+9mAPi41
         ju3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRmNZiVAWQGD1tPwurtto/oOanj+/iIrZoM7LI/sj2E=;
        b=WuC038hD6MJZb3ST1xxmPQebVrmRxXXm0LFA7J455MMc+zR1qN9FKIY/TtNtUVd5Rw
         OcV7Uv9GfGHohgnGKFygkaQt+hQAA7dtxJqtUu7AcPimvHUu2x4N7y9NomwUJgh+/58v
         s155lWc/9S+A1JW6m+NbgdDBRWhDtkulo7+5dXse/KPSem57x0CSfnFRgOSTZkF7PPa7
         0C7hnKOXtFrsu2H1Pd7W+hnhO6s9HFj5uLw4jAezrVI0aFJTwGr4B4KdksX5peQEbArM
         BXHB5sS9qV3Qq4eRpBlXVSbBTqTLsJza8TnAA+YPYmtWM1jy3iKZdfZa6GLIYKhj13h1
         YuBA==
X-Gm-Message-State: AOAM530s45z47mLEK2Yh4fk99owLhaDhkXNRb8B4psaPFmidvAJOZGGF
        50bgbEt4qO6MtdD1kmx7/kI9Kgx4Qcizf/ot
X-Google-Smtp-Source: ABdhPJwj/OR6INCa9x5e97lb8+VDZPuPRXyuxidICnR7AfdHovEBtRLjARHOBsEorMERj1ODiVb6tQ==
X-Received: by 2002:a05:6214:234b:b0:435:6bb4:d58a with SMTP id hu11-20020a056214234b00b004356bb4d58amr10221937qvb.47.1646691081654;
        Mon, 07 Mar 2022 14:11:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i192-20020a379fc9000000b0067b314c0ff3sm1652256qke.43.2022.03.07.14.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 11/19] btrfs-progs: check: handle the block group tree properly
Date:   Mon,  7 Mar 2022 17:10:56 -0500
Message-Id: <c6d511438b1a9ccab5c0ab73dd7620f05cdbd36d.1646690972.git.josef@toxicpanda.com>
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

We need to make sure we process the block group root, and mark its
blocks as used for the free space tree checking.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c    | 27 +++++++++++++++++----------
 common/repair.c |  3 +++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/check/main.c b/check/main.c
index 5b700350..45065989 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8947,6 +8947,18 @@ out:
 	return ret;
 }
 
+static int load_super_root(struct list_head *head, struct btrfs_root *root)
+{
+	u8 level;
+
+	if (!root)
+		return 0;
+
+	level = btrfs_header_level(root->node);
+	return add_root_item_to_list(head, root->root_key.objectid,
+				     root->node->start, 0, level, 0, NULL);
+}
+
 static int check_chunks_and_extents(void)
 {
 	struct rb_root dev_cache;
@@ -8965,9 +8977,7 @@ static int check_chunks_and_extents(void)
 	int bits_nr;
 	struct list_head dropping_trees;
 	struct list_head normal_trees;
-	struct btrfs_root *root1;
 	struct btrfs_root *root;
-	u8 level;
 
 	root = gfs_info->fs_root;
 	dev_cache = RB_ROOT;
@@ -9000,16 +9010,13 @@ static int check_chunks_and_extents(void)
 	}
 
 again:
-	root1 = gfs_info->tree_root;
-	level = btrfs_header_level(root1->node);
-	ret = add_root_item_to_list(&normal_trees, root1->root_key.objectid,
-				    root1->node->start, 0, level, 0, NULL);
+	ret = load_super_root(&normal_trees, gfs_info->tree_root);
+	if (ret < 0)
+		goto out;
+	ret = load_super_root(&normal_trees, gfs_info->chunk_root);
 	if (ret < 0)
 		goto out;
-	root1 = gfs_info->chunk_root;
-	level = btrfs_header_level(root1->node);
-	ret = add_root_item_to_list(&normal_trees, root1->root_key.objectid,
-				    root1->node->start, 0, level, 0, NULL);
+	ret = load_super_root(&normal_trees, gfs_info->block_group_root);
 	if (ret < 0)
 		goto out;
 
diff --git a/common/repair.c b/common/repair.c
index a73949b0..37a6943f 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -149,6 +149,9 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
 	ret = traverse_tree_blocks(tree, fs_info->chunk_root->node, 0);
 	if (!ret)
 		ret = traverse_tree_blocks(tree, fs_info->tree_root->node, 1);
+	if (!ret && fs_info->block_group_root)
+		ret = traverse_tree_blocks(tree,
+					   fs_info->block_group_root->node, 0);
 	return ret;
 }
 
-- 
2.26.3

