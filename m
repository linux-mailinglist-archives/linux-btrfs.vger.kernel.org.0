Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FF476270
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhLOUAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbhLOUAH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:07 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B6CC06173E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:07 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o17so23082876qtk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b/3JxMTunHvkJp44kJPP6hAxgUywGrVJukfQuWBTNC4=;
        b=qekWnEGHDjKWU0r1JXq3VLkAGlGW2b1/pJrMoE6NxJrqI64OqbQCxMKIbZ8l6jCCz4
         f/PkjbMUW7ZlsK8s0r6ar6OGlZ5O7RAF7tlz/cvUnYq4QusH0cMhdKezLiczpvTiNxBG
         UFIb5J4pT7iZiLSb8/e2YudekMoDk2i41t/qcz3virbudKVRCuooP2Bh+rUP2v5A55FY
         UZy931pwAevkaogHWTDei603zFinow/SXElsqNJ+E7JK0yU+y+8pq5tSS9G5G9hLWlvg
         TTNfbbUdv7zZf8mAfo79AE/hvzzR8bfvLb1gy2dHBT4oqlQr4h2BJ1NEdB6RWuqeGmpJ
         iMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/3JxMTunHvkJp44kJPP6hAxgUywGrVJukfQuWBTNC4=;
        b=GVHVzrpV2EujZkf1nLoweZrXY1x3/frK+dVKi6UrrkYLoCAwwd9mf/ZeWCVP8E9jTt
         QrXNAbJUEjLvj33evbsrjeONNND6EVjUlWK+chF0EStylcC9FyrG4h4Ng2+zhjqOPcjU
         Vvc479soqXEWBLy4Jr15KGLL4Z5+FfhCjuj/bj2VLquxbj9ZcI+PLeGnPzx/gk2iXVrb
         KsHAdvODicrUcLZZuCgt4cZEr0wRUnVvoGb0josBTu91mF1Q9iKtx/Ei57c8Xg+W+MSf
         Sa5VMkt3Ivww11eP3kVRNMbi7RVrg8sjlD33FwHcAYG/JgY/6QcF+c3FLH84+i5OdpTn
         u2cg==
X-Gm-Message-State: AOAM531zu0vNgmBAtU+Iaaw8dvAoQ/qJkzPDRfXgi7KpKm7l0FJIFEhv
        jPSeWILs643lJaKEpQ4U6XerfAHNYpulfg==
X-Google-Smtp-Source: ABdhPJwHG2Is3Dv1MoEoPYxO8oabh9bSInqs6A2b0WL1iJn7j77pXCT9s/N1SGag5+22se9C9gdflQ==
X-Received: by 2002:a05:622a:554:: with SMTP id m20mr13998176qtx.623.1639598406079;
        Wed, 15 Dec 2021 12:00:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q11sm2210373qtw.26.2021.12.15.12.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 10/22] btrfs-progs: check: add block group tree support
Date:   Wed, 15 Dec 2021 14:59:36 -0500
Message-Id: <829e106e01bfa4bdc76159eb56b2db34d7ac8f03.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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
index d0d52f69..da66735b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6255,10 +6255,17 @@ static int check_type_with_root(u64 rootid, u8 key_type)
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
@@ -9479,6 +9486,18 @@ again:
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
index 5ec3c090..a5a41cdd 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5532,7 +5532,7 @@ int check_chunks_and_extents_lowmem(void)
 	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key, &path, 0, 0);
 	if (ret) {
 		error("cannot find extent tree in tree_root");
 		goto out;
@@ -5567,7 +5567,7 @@ int check_chunks_and_extents_lowmem(void)
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

