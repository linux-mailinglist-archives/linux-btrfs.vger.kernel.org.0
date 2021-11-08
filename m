Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44EF449C76
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhKHT35 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhKHT35 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:57 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8346DC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:12 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d6so12650525qvb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QgMOTazHwFNx2BLBLMTC6pSXDQZeaqM4d4JNoJSwriQ=;
        b=HkJiAtzKC0BsgFRtpaMwu9Wuus0SnhNn0sURaL9DgS0WkTN8QUQYfipP7GS49BHUor
         qg6aSR1rocun5z2GgIWytSJfww8cuIrcY22JbyK8FiMhsEcSUvXTVbOUb2rHhFVMAgMW
         GpZBWrImXrlkAkba5fDmqBLnn/pWrvPrRemItfwZ9PHto+dd5FnqJu2/tOdljB1Ff88v
         Yz7c6zpnCQ6N5v9CvpIARx8tFz8s/z/n0YMbVZfqvHJxVtemZOYukUsSwgRBYZaN61ue
         005C3NoVOqzAAHP8s95wtHFsNJqa4d8bFE+Hd5Oz7OBsMc01rzEuAzx+DG65GvW2Z/tN
         LJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgMOTazHwFNx2BLBLMTC6pSXDQZeaqM4d4JNoJSwriQ=;
        b=CxNFrbWUiJ/bFuXWdG778EskqrZ2I4bUCOK7GvRPOKbluBF99QqduE7MnBZh04UIhC
         crjT840GTeDlrd9ubHS/tXkA2ZeShC0fcE8KDUaQQOAXYE/GSHt+idprc+nyQTWtVdYt
         /BZDeIDjVGXcIMbITLmbaa2NH84PjGpK20qGsbDtn72gXo4+ta7rgvEgJhah86RBJHHa
         Ahzycehwku+FjUZyHyXwKx7z9N/Ewhq88PvigMW2vS7lfxZKDohF9qaPnfXVhHSrH/Sf
         YiRTjz8XQc3Jw+n/tQZHhAGlWXqA6UFRyZ0LMJiYbtLLxEYCTXezeleOoCZ5j2VxF5qI
         QBQQ==
X-Gm-Message-State: AOAM5302/ff/63s1i7gJgJWYJN4xNO/KvEezxFIjxoNDIFBuaIQAwVlD
        duz3pVOgSE4YkiBtJMThDQhK1jFraLXV7g==
X-Google-Smtp-Source: ABdhPJwZ7byU9YlDyxdJg9AybZclfonIsucZ+0PYl0nuvbDjgH/SHEuHW4ea7j7M2Ld15kO9nNVAcQ==
X-Received: by 2002:a05:6214:194e:: with SMTP id q14mr976270qvk.0.1636399631380;
        Mon, 08 Nov 2021 11:27:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w11sm6757451qtk.62.2021.11.08.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 16/20] btrfs-progs: check: make reinit work per found root item
Date:   Mon,  8 Nov 2021 14:26:44 -0500
Message-Id: <be5e33f78b43e35617110bbf90d75ed40e162b82.1636399482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
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

