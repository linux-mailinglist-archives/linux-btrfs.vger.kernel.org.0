Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4154F5B90C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiINXFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiINXFL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:11 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF3F52474
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:09 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id ml1so12941049qvb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=HDEw59ltZBkoDH4sKgc0vOCz52d8GCWhQ8m8mD8RpKo=;
        b=IE54N4NSwh0nbHZyGhb1t6MmOKP80teQJ0qGACCfI0CPI3rh5i2Oeq/Dg0QoaQ2N47
         DKItxAby8jAnGbBv5Yoj8YuIJD+Yqh5jHU4IkDVjEyTtDD9sazertHEHEj6aP7VXahZj
         PhstAkWcxZB30EpIYl4+bLw2HQJNG1dwBoI7/NSUBhixaYHDY8+PS8GED6D6dzxF+DIc
         5JvTzXWMz58WCBW6bzwm9b0wkCyy2Q5WJgWt7Aavy1qv+MGvQROhkzW20fS246Um3TFK
         IXQM+hkCVJr7KXqs5JqbEAI+UXNQlt7BNxqtrYX3a/5BmMMl68emW8Hj3hKZwQm9AhWG
         Xfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HDEw59ltZBkoDH4sKgc0vOCz52d8GCWhQ8m8mD8RpKo=;
        b=EQfsPDKM9I7+Hyqknmi2Uvp9tgD+X/zUk2tPEmYeLWBa0p5vpoec9V9JVjJjIxMU/H
         7nhBnvUOulGn1+00dayIFhEj9vtFEPGQsTyogF9Xfdznv6OJtZtp+eXU0RK6tmD+DHYf
         z1WHHVfNWuMTXwFIYI/KaRXzbaimKhV69GbrDVRlccx23iHZJOgggzlqnbASUMvVOqM6
         Zbnw4ZvGgfhfI2PVOSuc/l4hZDy19cJvr/0FdTpRfiYJLAYXxsC1dfLuhSePkYUUqDMG
         0T7SEJyAKJ804ptSWsmwSq5H5Dd63RTFJArvHwQHxc5vrDY7UqsjoxM0ZReYIPbYkB8B
         0GDQ==
X-Gm-Message-State: ACgBeo0D4k6gGk/CzhuuiJ65CeOTVwvnqWS+cXl/7KeS0ys8aK2+ZRnZ
        rIsN1En7cNSdR/DrxPjQ8RIa/0AGPjCkYw==
X-Google-Smtp-Source: AA6agR7qRt29IZj8qNbaX/LKecFMgT/JPL8TT9CKWhB/fkaSjMQJUzMVsWKP1YbkLttjtCiEb71Inw==
X-Received: by 2002:a05:6214:b6a:b0:4ac:6e54:457c with SMTP id ey10-20020a0562140b6a00b004ac6e54457cmr30936226qvb.122.1663196708317;
        Wed, 14 Sep 2022 16:05:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a410f00b006b5df4d2c81sm3139503qko.94.2022.09.14.16.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/15] btrfs: move btrfs_ordered_sum_size into file-item.c
Date:   Wed, 14 Sep 2022 19:04:47 -0400
Message-Id: <7d20c1fad6d774c24413fd43af0c204b53adb814.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
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

This is defined in ordered-data.h, but is only used in file-item.c.
Move this to file-item.c as it doesn't need to be global.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file-item.c    | 12 ++++++++++++
 fs/btrfs/ordered-data.h | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7bd6e1b91495..615e65b15463 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -132,6 +132,18 @@ static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
 	return ncsums * fs_info->sectorsize;
 }
 
+/*
+ * calculates the total size you need to allocate for an ordered sum
+ * structure spanning 'bytes' in the file
+ */
+static inline int btrfs_ordered_sum_size(struct btrfs_fs_info *fs_info,
+					 unsigned long bytes)
+{
+	int num_sectors = (int)DIV_ROUND_UP(bytes, fs_info->sectorsize);
+
+	return sizeof(struct btrfs_ordered_sum) + num_sectors * fs_info->csum_size;
+}
+
 int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     u64 objectid, u64 pos, u64 num_bytes)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 87792f85e2c4..ac6b8ef133aa 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -160,18 +160,6 @@ struct btrfs_ordered_extent {
 	struct block_device *bdev;
 };
 
-/*
- * calculates the total size you need to allocate for an ordered sum
- * structure spanning 'bytes' in the file
- */
-static inline int btrfs_ordered_sum_size(struct btrfs_fs_info *fs_info,
-					 unsigned long bytes)
-{
-	int num_sectors = (int)DIV_ROUND_UP(bytes, fs_info->sectorsize);
-
-	return sizeof(struct btrfs_ordered_sum) + num_sectors * fs_info->csum_size;
-}
-
 static inline void
 btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 {
-- 
2.26.3

