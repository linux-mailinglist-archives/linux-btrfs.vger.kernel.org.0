Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF2C4469BE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhKEUbx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhKEUbw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:52 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4E7C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:12 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id r8so9848091qkp.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QgMOTazHwFNx2BLBLMTC6pSXDQZeaqM4d4JNoJSwriQ=;
        b=wd4VQDZ0Tb0FXKiVvPsC4y6iXCjfatvA2JqTZUYJ3YAZek1hN8sQRFMeMuWqmfSOE1
         4Pl0zqW8A65MyICHwpu9kTFRE4u4iPN8cUs+RlhuZEw5v7mQFXB0RJZKx+0I062GFm+p
         7spm/DpyQJOg0c36JPFXABuCQ0TTLffEOyU0CTGJA/MB9mjgfe74Alrczkw7gmbV9KjF
         yfyr1hh1P+Dc2O1PMlaApunPFf6cYoYnGfIfjrUZzFA/MBEK3J1hd7crtdBkzHCiqcgs
         H+29ELgmvG0VVpEFifpqSptegstAJ3SYjiosiMouuLOAN2vBKWFOAG93F0kGeXGrVUKy
         Mnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgMOTazHwFNx2BLBLMTC6pSXDQZeaqM4d4JNoJSwriQ=;
        b=cHNOLB5uDl6KZNyFd76VSUdrc6hR+owBdmcLuIGUsTqkCyBwB8HFQXWiIKBLbYKQ9q
         enIonSmTHP+Vw0oA3e/4SSxh9/ALyofR5x2A1exvYDqEz+QKbSd8ASQn8GcmWDhKTvLd
         FUGQi2mGPRzf7Ef0pez0QvVD2M5zRTHHTU+t/JMq4C/AlMarkE2Lrqwj8eaPbuAzIpAI
         ato2rvG4+1TykhYlVELQLNWlo7TnYIn5nk472HKk9HYPDC8rizLkUqCAN9ZB+vvW/zIw
         /l5b6ZfzI1M0KhDTY0bC41YtotWg4j1qZ7FMo4EHU7imiUvnEs8vwUyYY43G2VRM0x81
         TzIg==
X-Gm-Message-State: AOAM531d4GjxISQPAcS8zEWhfFc/4mDER0Eexvaq8OLhrTlMzFJBFJe0
        EkSc1hrQySYQjCfZbhhRQ1CyNdARwdLFxg==
X-Google-Smtp-Source: ABdhPJx60osNkF2VsP1EAQZvAvSQR83ySX8vxYkQvuqJBJLi0BE1xy4PVZ76uDrI/DL1jz5hfVda1g==
X-Received: by 2002:a05:620a:25c7:: with SMTP id y7mr48314841qko.437.1636144151087;
        Fri, 05 Nov 2021 13:29:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h20sm6544145qtk.93.2021.11.05.13.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/20] btrfs-progs: check: make reinit work per found root item
Date:   Fri,  5 Nov 2021 16:28:41 -0400
Message-Id: <5c9c58dcb7ee9fe68b6c848a1f2df67e318edcb1.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of looking for the first extent root or csum root in memory,
scan through the tree root and re-init any root items that match the
given objectid.  This will allow reinit to work with both extent tree v1
and extent tree v2 global roots when using the --reinit option.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index e3e5a336..140cd427 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9319,6 +9319,52 @@ out:
 	return ret;
 }
 
+static int reinit_global_roots(struct btrfs_trans_handle *trans, u64 objectid)
+{
+	struct btrfs_key key = {
+		.objectid = objectid,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_path path;
+	struct btrfs_root *tree_root = gfs_info->tree_root;
+	struct btrfs_root *root;
+	int ret;
+
+	btrfs_init_path(&path);
+	while (1) {
+		ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
+		if (ret) {
+			if (ret == 1) {
+				/* We should at least find the first one. */
+				if (key.offset == 0)
+					ret = -ENOENT;
+				else
+					ret = 0;
+			}
+			break;
+		}
+
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.objectid != objectid)
+			break;
+		btrfs_release_path(&path);
+		root = btrfs_read_fs_root(gfs_info, &key);
+		if (IS_ERR(root)) {
+			error("Error reading global root [%llu %llu]",
+			      key.objectid, key.offset);
+			ret = PTR_ERR(root);
+			break;
+		}
+		ret = btrfs_fsck_reinit_root(trans, root);
+		if (ret)
+			break;
+		key.offset++;
+	}
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static int reinit_extent_tree(struct btrfs_trans_handle *trans, bool pin)
 {
 	u64 start = 0;
@@ -9375,7 +9421,7 @@ again:
 	}
 
 	/* Ok we can allocate now, reinit the extent root */
-	ret = btrfs_fsck_reinit_root(trans, btrfs_extent_root(gfs_info, 0));
+	ret = reinit_global_roots(trans, BTRFS_EXTENT_TREE_OBJECTID);
 	if (ret) {
 		fprintf(stderr, "extent root initialization failed\n");
 		/*
@@ -10699,8 +10745,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 
 		if (init_csum_tree) {
 			printf("Reinitialize checksum tree\n");
-			ret = btrfs_fsck_reinit_root(trans,
-						btrfs_csum_root(gfs_info, 0));
+			ret = reinit_global_roots(trans,
+						  BTRFS_CSUM_TREE_OBJECTID);
 			if (ret) {
 				error("checksum tree initialization failed: %d",
 						ret);
-- 
2.26.3

