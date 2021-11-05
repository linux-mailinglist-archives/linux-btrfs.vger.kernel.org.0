Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31E64469DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhKEUno (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhKEUnn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:43 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2699C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:03 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g25so8025190qvf.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NgjFqZGVD9HRaKdcAlbgdVyDXPsWjIlOZJ4QF7DdavQ=;
        b=X4E7XR+Onretol8ftjkpU20vMi1K6xIIup3XQX6m1aoW8QD/ATqebvutDICow9MnKb
         krO3Knfll+YZjyG05F9/8e2EtPSw4GmZzDzOYZsoa5htruAUgJiaSTICD1b2nRq1vJHK
         sheNyOaJbrJjDusAGxjIu7gfirMi7FPHpbwzCOj+uvuhyrI09mxQbbDiw/ONGSQjgWIu
         3YldFAry7S+5rsx3m69Z5FSsDHA0gDQVwfj+s6BWlZogtejEIf1qCOs84bZLaPDRp5FL
         hwM1UPWRoCvV56zYhnXqJ2Fq1b2W0/VX1witlcwu06nD3uO8RpAdl80BBj+A4VK8UXoD
         9/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgjFqZGVD9HRaKdcAlbgdVyDXPsWjIlOZJ4QF7DdavQ=;
        b=obxLDUnyLYfmxrBcxyFQMhTSqbWVuLXfmcNqNxMlSuFQLlfk+MDl+9tGYhNZjg/o1I
         z58JN8L4wHtAdfIeonmuyEYKFlV8yBuZx6UdkKkxqdbF3CHM8ptkOoAtNQa5ckYRcN+C
         qlP+WkR6LLPD4dz4vqb4eiKwVxfl0sKCdPxvRsoWX4WUj0nKFYmTurZrUfZA1GEMmFq5
         KtKBB2YEnvnIXMfLNZyPepPEc7hcx48d6n/6Sm6Igu1pN0F7EwfcA6zZh24h30aIjkJU
         HQBmT9mjd3HEdPlMkvzKAuXTH7gD/ZsIKEwk63NVIpkUbtym384w5YEFLwFGL6ez1N0A
         c64Q==
X-Gm-Message-State: AOAM532Rrt5g58+xnrlB2drH6tzoYdPsfaYzOiGZtEIIvgLzbwgjdfpe
        gik4JP3Bmg9VVxkPXj7SMEWBkpII0udArA==
X-Google-Smtp-Source: ABdhPJz6t7oIJ8FhVme4rPf480MOCNGFqcED/PzzgaXzcq8M0haKlgMjHAlvpWRl/gXPCSSUZ9fQ1w==
X-Received: by 2002:a05:6214:16ca:: with SMTP id d10mr15865185qvz.14.1636144862721;
        Fri, 05 Nov 2021 13:41:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 13sm5813040qkc.40.2021.11.05.13.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/22] btrfs-progs: check: add block group tree support
Date:   Fri,  5 Nov 2021 16:40:36 -0400
Message-Id: <13b95fc146d37942685812ed8b8a911d2e01a379.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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

