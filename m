Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBB9557E63
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiFWPBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiFWPBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 11:01:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1070A26577
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 08:01:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C0EFF1F909;
        Thu, 23 Jun 2022 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655996497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgF+Qi5PVFNCtInXcQeikrbtKe/s6vRWINGXQ+NumuE=;
        b=ZSY7o78iPXmWPDWjSDwSfVr7vS3EQXJNzo1UkhZeiOxEkBm5GRrDgfMzeqwsprDYh5nbhG
        12Ny9x5aV8JnHT9kvERT0S9JibufoJOk3QbGI2brjIyxNqhztnPY0FUa1qFJsr/uS17I2o
        e5TzLk/YSUjAeooGXUDPXqheaG7AKwY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B9B962C142;
        Thu, 23 Jun 2022 15:01:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4601DA82F; Thu, 23 Jun 2022 16:57:00 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: use mask for all RAID1* profiles in btrfs_calc_avail_data_space
Date:   Thu, 23 Jun 2022 16:57:00 +0200
Message-Id: <7adddc7ae13ff938578eacb6d3335d70720785dc.1655996117.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655996117.git.dsterba@suse.com>
References: <cover.1655996117.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a sequence of hard coded values for RAID1 profiles that are
already stored in the raid_attr table that should be used instead.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 41652dcd16f4..4c7089b1681b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2243,12 +2243,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 
 	if (type & BTRFS_BLOCK_GROUP_RAID0)
 		num_stripes = nr_devices;
-	else if (type & BTRFS_BLOCK_GROUP_RAID1)
-		num_stripes = 2;
-	else if (type & BTRFS_BLOCK_GROUP_RAID1C3)
-		num_stripes = 3;
-	else if (type & BTRFS_BLOCK_GROUP_RAID1C4)
-		num_stripes = 4;
+	else if (type & BTRFS_BLOCK_GROUP_RAID1_MASK)
+		num_stripes = rattr->ncopies;
 	else if (type & BTRFS_BLOCK_GROUP_RAID10)
 		num_stripes = 4;
 
-- 
2.36.1

