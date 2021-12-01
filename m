Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B914654FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhLASTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352141AbhLASTB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:19:01 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A2C061763
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:15:19 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b67so31962761qkg.6
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vtdxgy0GqnOb/SZD7Wen/SgzfyQ1XJRJH24ltOw59Dk=;
        b=De1AN27Mt5XLTjam6lr5gJOCP22Os/GoGLSPYH+qQhmEgUrPyKpw5FPugrzfjdaZM6
         Z9q8gLA2BBkJa2N2oDxGDy8OfzafarR49RmF4h7NcvyxQJQyfMi5jmb3pglshMP5vs7s
         zkAV+D0Op3nZWG09h5xCTiEvoAfcaV88mcLsyZVX1fqbJimbgKYj1t2C/Jmjq7SHwzB8
         cYzjdYGB5WMicyS0zNKrbtl5vbqMDdjdu13bfT9P7CaZKPZ+aBRSFbFBP903gJ2OXQWH
         296qRRON2wbahQnZnNY9GjNN5F1anI1fViNuzR+MosMtySoyC+9ILbFOghoj0FEGDHrH
         ZAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vtdxgy0GqnOb/SZD7Wen/SgzfyQ1XJRJH24ltOw59Dk=;
        b=JvsvmY0jhFefhK4/0MvyFlkkmxMY25sxDMnGFBthnjCojbv+CZCkekX08TegDlbGxP
         h9s7SOsJdhOeS1IwZq+pULuHZSdx0g/1h/EH7icu69DkJFJy36ejDcoWrHQEebvJQ/gD
         DG4VUb9aJkHJNf4OUXN4TQuN1h8WAHmYHtF8+OusFuckhj0hyCgFS9CR9CbpA4q2WsWW
         PAOYJKBaoACnYSCKEJRFIoUmanMvJ96AESOX67A60i0aNHsMZqi4KpVU+MMsf9SrZzUv
         uQK9WUWGrudXyo1sZ/SVgvYdfminGqMTVbhazJi/ysM9r+/yamoG0QCDdwA/F5G8ie8p
         eU3Q==
X-Gm-Message-State: AOAM532P6OyQtvW4OpBlEPsG8EXHU6Geexmf/JW0EgiOW4LQKq/67sUq
        ruHYqSDmfO4gN8WiN7b5RgG3FdooXvewOQ==
X-Google-Smtp-Source: ABdhPJzhzmLcUz8EtB5mDNjbz1g4PvdXXG+voeTzDShFZ9cLKXTjTiXQ5WvRMWchaFly4K0d4em10A==
X-Received: by 2002:a37:9c57:: with SMTP id f84mr7889502qke.443.1638382518172;
        Wed, 01 Dec 2021 10:15:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o17sm272503qtv.30.2021.12.01.10.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:15:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/8] btrfs-progs: check: make reinit work per found root item
Date:   Wed,  1 Dec 2021 13:15:06 -0500
Message-Id: <558162364590637400ee13ff43bb65059b2caa8b.1638382443.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382443.git.josef@toxicpanda.com>
References: <cover.1638382443.git.josef@toxicpanda.com>
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
index 8602482e..d296aeda 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9332,6 +9332,52 @@ out:
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
@@ -9388,7 +9434,7 @@ again:
 	}
 
 	/* Ok we can allocate now, reinit the extent root */
-	ret = btrfs_fsck_reinit_root(trans, btrfs_extent_root(gfs_info, 0));
+	ret = reinit_global_roots(trans, BTRFS_EXTENT_TREE_OBJECTID);
 	if (ret) {
 		fprintf(stderr, "extent root initialization failed\n");
 		/*
@@ -10712,8 +10758,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 
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

