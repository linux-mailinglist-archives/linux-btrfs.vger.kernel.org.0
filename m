Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2834D0A99
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbiCGWMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242951AbiCGWMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:12 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1608B7C14F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:17 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id gm1so13231794qvb.7
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vcnkNpHq8iGohwqPC87N9z9rchCUMzxRHnySeUQY7jQ=;
        b=KCAhez/k4/BkYQe3KQXDBZURqs1/Yg9rFsxWzB2Cci/wQXlmfbvv0zsAi6lrw2Ksl1
         HWWEdqWubH9U2otIl+vuxFXz1mvUxI4X5LxC1ER0BuHb2cATvghurDiTngQvdZktFIw+
         ORwONVEhofh9i9CJfx0kTAKtZL4QRhrHJUihm28EGNrMPnrVFP4gqIagHA2XgMbsjxIm
         SvU9ieef94jro3T74bQcA5GRdne2C1ghjxndUsnLRgRu0/YVcfMYYYiokHU4cB2EdNog
         U9pCVi8JwJwN1Rh1xGWc9YgNOrfOM/SquOrMHFdvofQpfbpAwMyShvFNTJAq1wdjoDym
         EYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcnkNpHq8iGohwqPC87N9z9rchCUMzxRHnySeUQY7jQ=;
        b=p+6xy8zib/R2E8Ds2aNsL7KlWWpMPrmIrBmSlhMg9uho2BxYieSzzsih/NDuLTvFat
         KXVdIZlfvwFCQtcH/4NBMzYDa68pdPWTQLkdYPWNNdFB3YwfJ/2X+j0TF077i/WPw/4H
         DpZFZv75plXBJTN9OXlDrC7iSeGDhMwv1/3gGkyrCG0GCj/b7hto0sxmo3/Y8CWJ+jeE
         3Em8CcgaEMyRdr5nYR+bED8vxUzoQmxAUxGC9FpIlhnrlkvMZrivQTriFWDBRQ7+Vdr0
         kx2HdAyF5SYip6X4sozIXS5/yQIe48OwO8AJsYSQGEolJ3s0z7W/h/hwvNMXNF8qzApT
         pu7Q==
X-Gm-Message-State: AOAM532Zhh0sk7cwu/nkOpXO77o9aNSCpuk9fRRLNep6t1mkN4tac6Uc
        RzO9SR+ad3VcAO1RBvsIveC/DrMeIbF0eVr4
X-Google-Smtp-Source: ABdhPJwZzkgr03L+ayx5018f1xzHofNOuEZgiOgJQjILBmWZsGUjzbCuMXMqEoL3qkgpWjmz1W5Gzg==
X-Received: by 2002:a05:6214:27c6:b0:435:50fe:ca with SMTP id ge6-20020a05621427c600b0043550fe00camr9957380qvb.10.1646691075915;
        Mon, 07 Mar 2022 14:11:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o19-20020a05620a22d300b0046d7f2a6841sm6792096qki.74.2022.03.07.14.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 07/19] btrfs-progs: check: add block group tree support
Date:   Mon,  7 Mar 2022 17:10:52 -0500
Message-Id: <0b11442be8e21daa294119b381673e1bf727d859.1646690972.git.josef@toxicpanda.com>
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
index 6ddfd18a..a0f4ee91 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6268,10 +6268,17 @@ static int check_type_with_root(u64 rootid, u8 key_type)
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
@@ -9492,6 +9499,18 @@ again:
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
index 8535e684..68c1adfd 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5540,7 +5540,7 @@ int check_chunks_and_extents_lowmem(void)
 	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key, &path, 0, 0);
 	if (ret) {
 		error("cannot find extent tree in tree_root");
 		goto out;
@@ -5575,7 +5575,7 @@ int check_chunks_and_extents_lowmem(void)
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

