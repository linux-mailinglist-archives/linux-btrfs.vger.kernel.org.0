Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECF5B90D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiINXIG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiINXIC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:08:02 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F887081
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:01 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c6so12923465qvn.6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=ifsE12uS/h9wkhPyzkOPzi10gC3ipxyRSfEZFKcDH8g=;
        b=mQlwuytm+TrYLmqpi3mX7tPyj17qL3nnRRVmOZq16QrPbF20v6CaYLj/PYO2OFaH0K
         pv3zl+LhiD8a+FSsc2T74s1oOhxJCKuidDfWKsVcOBJyALPMgRtEZFYlLHV5+ujcAzcH
         lPQ1LqGLhht5/TCySxSuJ4iSSJzUQXFredNup1Cqwvz2Zk95CgVNGo8GzlTmFTGp5zZx
         DC5H8T0+No23Ziv6umqlMzjc21jly2QT1hyz+mzb94DOCH2j2otSNv32Hi8dG2+iL67l
         vY+uZeBd1Gn49wzdgqtgdxDQNXAmmRsaEV2kDnWk8/NLdYfvEn8A+Nj3h0HN/HwqM+Pl
         Mxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ifsE12uS/h9wkhPyzkOPzi10gC3ipxyRSfEZFKcDH8g=;
        b=UP66S8zVhI7m3N/icct3qPdOZ/YEFXsZ+mrLwM1pnrdl1IFgt9PvrlizskuUqqCKsY
         sk/4qMwTJBcMjpzSXjBj0Ovx+anccPITxWLhdLceOykJ/ZXGA7niIOJh7HM33zQOHWUE
         L+2M9qGumuB2bZM/InxJyLg4UVc1qo3MZ4e3fI0Ke8j5eUBjCGw27aB/6frxwi7khNWE
         OKMNkhmxs6dcADb1pglQw/Dd5Hj04m5e+3PIca0hKCGS10DooJeIjgFU2M9BXii7XhFO
         JtBtQ4Sa0gKtMrF/pu4uOBdlbY8KF+/pGNOUgI4ergbuXjXUYE6yyoA+0BB6HOJLuQvl
         p/2g==
X-Gm-Message-State: ACgBeo2JkgXEwJG0ZgjLCf3SwPznbisg/qPLBFzqvI2hIvyqcpUt3q21
        H2AsrNDg62en2wbXTwO5071AvKumI7d6aQ==
X-Google-Smtp-Source: AA6agR5vJ7BOxHbWSYlKgJDcXJMA6rasc61Eg8m49i0HrWwcok9Lgx9pt1Rps8h6U0C3fe4nTCL6vQ==
X-Received: by 2002:ad4:5c4d:0:b0:4ac:942f:78b0 with SMTP id a13-20020ad45c4d000000b004ac942f78b0mr22076885qva.48.1663196880006;
        Wed, 14 Sep 2022 16:08:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 79-20020a370452000000b006ce441816e0sm2670487qke.15.2022.09.14.16.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:07:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/10] btrfs: move btrfs_clear_treelog_bg to extent-tree.c
Date:   Wed, 14 Sep 2022 19:07:46 -0400
Message-Id: <4d12140ef58244d81f2888e8d9e585c268f01911.1663196746.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196746.git.josef@toxicpanda.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
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

This function uses a lot of code that isn't defined inside of zoned.h,
so move it to extent-tree.c where the other functions that use these
members are.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 12 ++++++++++++
 fs/btrfs/zoned.h       | 15 ++-------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0785c1491313..9c4ce3c100ec 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3731,6 +3731,18 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
  *   block_group::lock
  *     fs_info::treelog_bg_lock
  */
+void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	spin_lock(&fs_info->treelog_bg_lock);
+	if (fs_info->treelog_bg == bg->start)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
+}
 
 /*
  * Simple allocator for sequential-only block group. It only allows sequential
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index af7eebe4f405..bd2b3fee4f2d 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -31,6 +31,8 @@ struct btrfs_zoned_device_info {
 	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
 };
 
+void btrfs_clear_treelog_bg(struct btrfs_block_group *bg);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
@@ -311,19 +313,6 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
-static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
-{
-	struct btrfs_fs_info *fs_info = bg->fs_info;
-
-	if (!btrfs_is_zoned(fs_info))
-		return;
-
-	spin_lock(&fs_info->treelog_bg_lock);
-	if (fs_info->treelog_bg == bg->start)
-		fs_info->treelog_bg = 0;
-	spin_unlock(&fs_info->treelog_bg_lock);
-}
-
 static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
-- 
2.26.3

