Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2425244CA60
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhKJUSD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhKJUSC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:02 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957ADC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:14 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c12so3288685qtd.5
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NgjFqZGVD9HRaKdcAlbgdVyDXPsWjIlOZJ4QF7DdavQ=;
        b=Qk8uLO9R1IBWkaxhsn74Y4bfexmxfNH7Dv6NXlftEBS/wuQSeFGD7iSAMGZ7s8ACsw
         hKj5MKRcqxPlZGUbItqPyx723xr41P32836GsPk7GaWGdjOx/aaSGPiyCRJ5p9MbAiVE
         kIEzGBPqBrQgKzithpeUK7+lFoMVR6I3xK7eggue7KD6dT6U49p6UaawInfAVOBHMDuf
         gvsRjZqil5s7zE+YbjM6FoBaxUx7AD2QmCaxKWzIy1N+cLDA7W6pa50uhj7XQAgfaE4W
         naQkpcq+tvF4uDW4lm6wPvnzLBNwFJwB7sBjErdnITfGkUex0a+vcCGm0se7/smfL2yy
         hCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgjFqZGVD9HRaKdcAlbgdVyDXPsWjIlOZJ4QF7DdavQ=;
        b=UV3olwWXt5xHCZ1YC1Fcsrt845g3dBV3FedbmwPitqdTBkGyh3tA9hC/MLYcYh5OPw
         BsjLL5FM1qfxo82+XLCVMoidXsOqSAZujfeGaUPw3A4EznDpKAbBRvQqOq/kws6ZVHNW
         cco6nVT6D4fzXi2JKE8u5D1UCsSiHLRCY67vSQixKZ4xt1Wc2gUGP2gKIhbYNDwVHAhW
         DZIoUExlt7dLCrlv4i9/mc5Tr+/QtZUC0l1pgNYJ6iNVGYggH6XIHQ8CRFH+v0djl9vV
         DnktiPNxQOsW2SbfntomxDJ9bnUCDi0ysCNLFuIYBd6sRgMjkA/mqxTZsURHYFTE0VfM
         92hA==
X-Gm-Message-State: AOAM533fuCwggmVoqfHwnLkF+UkuTSY1qJ/o1/q4MEw1VMYS4q4R8L08
        BYIvTfgwnSTv9Kanp+JIc6BehsSCaLd5eQ==
X-Google-Smtp-Source: ABdhPJwdUcVNxBkMffQuo93VaMuZNd7E9L1YerFtAIBo9nkvGWT8CWe7x1dJKvOgYHla/yhBrS+eIA==
X-Received: by 2002:a05:622a:410:: with SMTP id n16mr1841348qtx.369.1636575313505;
        Wed, 10 Nov 2021 12:15:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r10sm511249qta.27.2021.11.10.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 18/30] btrfs-progs: check: add block group tree support
Date:   Wed, 10 Nov 2021 15:14:30 -0500
Message-Id: <fca643a57ba1ec4cd2c74d27ca77f10b5893a047.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This makes the appropriate changes to enable the block group tree
checking for both lowmem and normal check modes.  This is relatively
straightforward, simply need to use the helper to get the right root for
dealing with block groups.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c        | 21 ++++++++++++++++++++-
 check/mode-lowmem.c |  4 ++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 7735cce1..46d08040 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6229,10 +6229,17 @@ static int check_type_with_root(u64 rootid, u8 key_type)
 		break;
 	case BTRFS_EXTENT_ITEM_KEY:
 	case BTRFS_METADATA_ITEM_KEY:
-	case BTRFS_BLOCK_GROUP_ITEM_KEY:
 		if (rootid != BTRFS_EXTENT_TREE_OBJECTID)
 			goto err;
 		break;
+	case BTRFS_BLOCK_GROUP_ITEM_KEY:
+		if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2)) {
+			if (rootid != BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+				goto err;
+		} else if (rootid != BTRFS_EXTENT_TREE_OBJECTID) {
+			goto err;
+		}
+		break;
 	case BTRFS_ROOT_ITEM_KEY:
 		if (rootid != BTRFS_ROOT_TREE_OBJECTID)
 			goto err;
@@ -9453,6 +9460,18 @@ again:
 		return ret;
 	}
 
+	/*
+	 * If we are extent tree v2 then we can reint the block group root as
+	 * well.
+	 */
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2)) {
+		ret = btrfs_fsck_reinit_root(trans, gfs_info->block_group_root);
+		if (ret) {
+			fprintf(stderr, "block group initialization failed\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * Now we have all the in-memory block groups setup so we can make
 	 * allocations properly, and the metadata we care about is safe since we
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 263b56d1..7be12e6b 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5530,7 +5530,7 @@ int check_chunks_and_extents_lowmem(void)
 	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key, &path, 0, 0);
 	if (ret) {
 		error("cannot find extent tree in tree_root");
 		goto out;
@@ -5565,7 +5565,7 @@ int check_chunks_and_extents_lowmem(void)
 		if (ret)
 			goto out;
 next:
-		ret = btrfs_next_item(root, &path);
+		ret = btrfs_next_item(gfs_info->tree_root, &path);
 		if (ret)
 			goto out;
 	}
-- 
2.26.3

