Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6702F4469C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhKEUb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhKEUb6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:58 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66AC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w9so3191955qtk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aBUk2cArVvEwez5VE+87HZJGc9HIWulLuJzNnuBNwzE=;
        b=HF0gOM9T8WB7eMO7k3bl5QBEa1M1AsyRjOKFvj65PXvVcXE9+otcxsSgP3MwBl5ngx
         Tl28sEJ4KDGHBdPtTfQzkdnNgVBw5OlkFPjN5dfl8WJ6i424NWkySoG5aHguvki9ukIf
         A7ulDGVG57pU1qXUKjYqGtJlngb9ZoUcegpP5FGwgB3/x8Qb0qfWxKwsuHEGhEcjGhIU
         cJXxKa7SPxhfJLGqOlZ+a5ThkE8Sk+xs2/2g6/OddenPqzwL3UGBGWr5jdoaEm9fKwl0
         vtMIzEBO6uEVIwslBUofJ/6eJW6qE1WeKSol8SPf/80+KMaezgEkNuui0Adnf56bJYMN
         Rkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBUk2cArVvEwez5VE+87HZJGc9HIWulLuJzNnuBNwzE=;
        b=btGDEB0NSFIgZxn2rY/iy8UB1U3f/mrOHVHP+ftXMB8eMeag0YoyzZ2ngShs7Nkt2Z
         DYhuOx+0hodxuxg+YOU52+F07PYz/VHCA9wCPPixqZvc2iwX5du5Pgzk+9DqRqwSeJTW
         BW8GtCZG52k2g/LkGk4ybPy6cU2IsUZlvdwHV/z88tUi+z2v8OJfAhNZxUodmfh9NmWn
         y2crEzwz3OLJ7w5ZSy+3pImD0FJeUO4R5LYxW0aOinlKkjsRMOVkOvAoIz0IxTnJPuog
         4Hk6S5hey+q0ZddkBVrotRF6bDhtkjCY5wFcte6B7CKjSRNOhLd22xgCvxPdNfoe9oLc
         UQOg==
X-Gm-Message-State: AOAM532YgQ33/DoTQQJ0m56KMKdA6KweAhjfT4SPJPsmL7/IsKOhg6BE
        UXhyhfmmZ7NbX1kDyvwZW5umX/H0FpYliA==
X-Google-Smtp-Source: ABdhPJyp5y6e3Zl0yAn98IPE/KtcikjFdk3dPKsAugWEYYUIDok/JvNX9hfEWO/yxqgJiE8feTwe4w==
X-Received: by 2002:a05:622a:1a9c:: with SMTP id s28mr17783506qtc.406.1636144156033;
        Fri, 05 Nov 2021 13:29:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f7sm6105321qkp.107.2021.11.05.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/20] btrfs-progs: check: fill csum root from all extent roots
Date:   Fri,  5 Nov 2021 16:28:44 -0400
Message-Id: <dc0a4d8d60f88c222e5237a9091a298b4a270793.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We may have multiple extent roots, so cycle through all of the extent
roots and populate the csum tree based on the content of every extent
root we have in the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/check/main.c b/check/main.c
index 175fe616..5fb28216 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9690,9 +9690,9 @@ out:
 	return ret;
 }
 
-static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
+static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
+				      struct btrfs_root *extent_root)
 {
-	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 	struct btrfs_root *csum_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
@@ -9766,10 +9766,26 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
 static int fill_csum_tree(struct btrfs_trans_handle *trans,
 			  int search_fs_tree)
 {
+	struct btrfs_root *root;
+	struct rb_node *n;
+	int ret;
+
 	if (search_fs_tree)
 		return fill_csum_tree_from_fs(trans);
-	else
-		return fill_csum_tree_from_extent(trans);
+
+	root = btrfs_extent_root(gfs_info, 0);
+	while (1) {
+		ret = fill_csum_tree_from_extent(trans, root);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_EXTENT_TREE_OBJECTID)
+			break;
+	}
+	return ret;
 }
 
 static void free_roots_info_cache(void)
-- 
2.26.3

