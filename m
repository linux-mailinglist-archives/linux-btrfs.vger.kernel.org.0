Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE57944CA52
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhKJURm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhKJURl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:41 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BDBC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:53 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t34so3281353qtc.7
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QgMOTazHwFNx2BLBLMTC6pSXDQZeaqM4d4JNoJSwriQ=;
        b=dwDl5sc8MR0ta+8Ti20xtP2YLkZoocmxQEW4p/1+3uxjzxiuLaLViVtpLrUG1jfIQq
         w4vQt+zgf2Tx3Oyp56j3BGTFT2AhTqNlywkpp7IQ47OuYoA8S5iSPy2Lhgw22XnN1ZI7
         YzkrOh25lEaJmHPi/8xDM7gLKBAYn2gziINq+MuJywuYIgiE2Gzox3pMG5IYMOnLGfRw
         gvaAa+15SK8Q/X1N93o/qNoNGGHGBAXzOLKju7YjSz/WyX96B2wOLRVcdkrMvqC3np4M
         HAOdS/RhdixACLoZO6j+gnY+stQbf/e7tqi8EgB2ZNJkQc4gfPFQoxESlEEqMVzjWopF
         qTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgMOTazHwFNx2BLBLMTC6pSXDQZeaqM4d4JNoJSwriQ=;
        b=CKi835pXwbXsoNpaqPxfIG4wCwXXypNTtqaDxYv0Vzqvg66sHrL6gwqfA/pSO65T8E
         jJZW6iPaRd7JDtZN0egUSeyUj77I+mTe9dDcgX4WmKdTrBqjUexYTfDmuuuy4/iFAEux
         uYS4uCbD/s6Mh4K5drVPOn8omXNZQ5mPOMesP8pHy4MG8lwdKGoqtm4fo22SPJ4d30GN
         lngZ1gFAlWEpqQ5u+1rhMiSZb3L9KZzfrAatt9BgmN5zJpYwvpM7BFA0ilqPPu5bUuZk
         tyGa2yxEIZmNP9OHL9Zm0OSC7bUlitX8VLeYu0S1odwVQWP2BDQNT9vaV81MHGtUAwwE
         8+rw==
X-Gm-Message-State: AOAM531s2MvDOY1atwGz9mtD7GXv1iF/j8CJd0I/npZc+1di4SdU8AQs
        WSbZovONRXyk0wnONg+M7M3G5Ion8qycZQ==
X-Google-Smtp-Source: ABdhPJw/2MhYQux5FD/a4x8W8BUYZPIXhWoqbPfAWDF4gTghU+UW4Vg7VpovFB+d5oXlDiAiKdFibQ==
X-Received: by 2002:a05:622a:44e:: with SMTP id o14mr1950790qtx.80.1636575292344;
        Wed, 10 Nov 2021 12:14:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de13sm390436qkb.81.2021.11.10.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/30] btrfs-progs: check: make reinit work per found root item
Date:   Wed, 10 Nov 2021 15:14:16 -0500
Message-Id: <75eb2e354247aa6e9ab3b57083559bc6da131fd9.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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

