Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45A4654FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhLASTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352152AbhLASTB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:19:01 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10715C0613D7
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:15:22 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 8so24967762qtx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1gjTOHt4x2VBI2Us4Hv+A+G6+rsdjx3/loORN1qau98=;
        b=Am83Zuuad/LjR8mkXqjuaJpejflZ/BueeEdy+/189N3emurpSKM4LnWoUE4y21S/2k
         hSlT4lTAk45clUwbYdhg8pvbqTgg1rmeyc8XmD/tHAo8JmE0ZVcHTp5iDX0puaCgr0VG
         cTLzGtYKwGGDgX1z3DE9IVHKccx6+HppvloSldLBJBKEDiEp57nL7obNjEn99ZYZKlJy
         /JhXNqeqOZZ7gbRDNR4MqgK1R3FJGanvX2lqWyJ2SlqRvjviaoK7bNpGc4OGamzTdZRg
         48npTvU/K58FUtFDXy50bUhDnx3bdBG+iFnlWNeRTFnfFRJTfX4i6daBwWkFKy/n5KKq
         lX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gjTOHt4x2VBI2Us4Hv+A+G6+rsdjx3/loORN1qau98=;
        b=KRn2jQqfGaXRpxTElf+rIp6sxHa+et9O7i7b7OcSbcNjgoaDSauktRg/y4iPNArbXP
         hTLC1e1p1TWfkC+lutfv3eWFK3KTjcLt/B3yiVVKqqLCnt9zVj+vWVIWV1zvIRj4MhJt
         uLuGEvbj3bIVMgwMjvTSnPU8sxEkCkI+6iLupshYdMuZb+WNhNw+p30k5I7YSoqSc+Gd
         TRJvgftNuwa13vKOgBPftjo1mNQshw/F7sHCYniEs8ZVKiJikB7257gob266h/E/Ke57
         Xjn6rJ9rz95YUmZZ+wyOb/eRT87+hsE3kBU2Jky5FFI8JhteMyUqfnCGAWg8kw2dj/3Q
         VM8w==
X-Gm-Message-State: AOAM5315gTJJgkswqNefgp8KJhZN4dltErl9c9F257vmWyr6eqlzcuNe
        5MYbmfN415YEoaLPZ0OJ6NKNmvHWoRAdoA==
X-Google-Smtp-Source: ABdhPJx0DreGDxFnCru7B6I1ye5rBtqaJ+jiZrbfKubledEACCJv1/Q+3RnHWF3NC4VYeICxdaPfRA==
X-Received: by 2002:ac8:7d83:: with SMTP id c3mr8811867qtd.359.1638382521026;
        Wed, 01 Dec 2021 10:15:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j9sm232950qkp.111.2021.12.01.10.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:15:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 6/8] btrfs-progs: check: check all of the csum roots
Date:   Wed,  1 Dec 2021 13:15:08 -0500
Message-Id: <db97009631aae850e0e243348ff5441606cc2555.1638382443.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382443.git.josef@toxicpanda.com>
References: <cover.1638382443.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the global roots tree to find all of the csum roots in the system
and check all of them as appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index f873de09..337ab82f 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5977,7 +5977,7 @@ out:
 	return ret;
 }
 
-static int check_csums(struct btrfs_root *root)
+static int check_csum_root(struct btrfs_root *root)
 {
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
@@ -5995,7 +5995,6 @@ static int check_csums(struct btrfs_root *root)
 	max_entries = ((BTRFS_LEAF_DATA_SIZE(gfs_info) -
 			(sizeof(struct btrfs_item) * 2)) / csum_size) - 1;
 
-	root = btrfs_csum_root(gfs_info, 0);
 	if (!extent_buffer_uptodate(root->node)) {
 		fprintf(stderr, "No valid csum tree found\n");
 		return -ENOENT;
@@ -6100,6 +6099,27 @@ skip_csum_check:
 	return errors;
 }
 
+static int check_csums(void)
+{
+	struct rb_node *n;
+	struct btrfs_root *root;
+	int ret;
+
+	root = btrfs_csum_root(gfs_info, 0);
+	while (1) {
+		ret = check_csum_root(root);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_CSUM_TREE_OBJECTID)
+			break;
+	}
+	return ret;
+}
+
 static int is_dropped_key(struct btrfs_key *key,
 			  struct btrfs_key *drop_key)
 {
@@ -10912,7 +10932,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		task_start(ctx.info, &ctx.start_time, &ctx.item_count);
 	}
 
-	ret = check_csums(root);
+	ret = check_csums();
 	task_stop(ctx.info);
 	/*
 	 * Data csum error is not fatal, and it may indicate more serious
-- 
2.26.3

