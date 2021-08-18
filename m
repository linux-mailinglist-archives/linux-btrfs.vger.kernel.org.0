Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0913F0D6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhHRVe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhHRVeR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:17 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8D6C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:41 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p22so4744470qki.10
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pf42gdHdF9kCzySmOegL4kAlHRuKr2qc7mT5MVwLK3A=;
        b=Fxjpt0k7X4AfbRYe3rD7wPQ7QhRhN2Mm0M6B02uLZMYKJ1Ez2QzGMwrQQvGo3s203p
         29emRKHyOjo/FGP/BAVrHkTR49Vo00frDh3zIXI6XbOo/bf72owEfEW7Z6ukLr0t4Ssq
         LZ2YhfUu6OXhN4CLBUwgVe9ZWDSRoT9PyV46mklnfEB6BzMwY4FJdWM/xL5Do6VCJenS
         egA03vFLZL3uXmtwhgMWMrBPPZBEXbBqXYB+M6MLEPTvjnrFIdX9jzRUD27nEnkTK16R
         qdQPRSQciFhDGEKCdYnjJZAakhKK9kMjAnSQ7vuiBADRyuMiZw9iH6+fksMBxOli6ndL
         NWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pf42gdHdF9kCzySmOegL4kAlHRuKr2qc7mT5MVwLK3A=;
        b=T6rGq1zf0TvQYLW/gV6bHTsZ/gLwveQWXtz/NZgQ2msFkYxLvOXrq0sOocJhDp1s3P
         wfKHbwS3z9V+WS494FAMPn42nLXzNGyyJtlh6NOwozuasl9VOX4AdWkWoc4qLEiovRBY
         l/xYQM67rE5elh0yytgMqfHvTmkDkPHv0NbUCb86mxLeQN5ZENXYkTrC/IvIi+UVcciu
         +NohAIRT/YXyIKUDJrzslYFkmPbeP1HIt1yRx3aFzRjQQ1TSB6b5kCQKhmI0PvyKp8mM
         3S4f0XDDXGjE5550cDNcBP7sO5gB7TcvdaB4xgkAo9Iv1eXER6Osb+9V3wrk0Y+0Z7XJ
         LeKg==
X-Gm-Message-State: AOAM533fwX9v7ILQuP7XMeJYbtQoMHKtzmK9iZUGDMyGH6XcPUmFpGFF
        sL5ZziIFlvG/VSQnUwneX7fZBjoQYBcMyA==
X-Google-Smtp-Source: ABdhPJxjebIPvoZ5pMU4PrJfuwU31q+aRilyCm4/WESJSMiS6hmExQHCgVezt4q+OmckPCtzR51twg==
X-Received: by 2002:a37:aa17:: with SMTP id t23mr342956qke.209.1629322420768;
        Wed, 18 Aug 2021 14:33:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j5sm594107qki.80.2021.08.18.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/12] btrfs-progs: make check detect and fix problems with super_bytes_used
Date:   Wed, 18 Aug 2021 17:33:21 -0400
Message-Id: <fd18dba016fbacb15e30c25acc8b0f9e66d10fe0.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not detect problems with our bytes_used counter in the super
block.  Thankfully the same method to fix block groups is used to re-set
the value in the super block, so simply add some extra code to validate
the bytes_used field and then piggy back on the repair code for block
groups.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/check/main.c b/check/main.c
index af9e0ff3..b1b1b866 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8663,12 +8663,14 @@ static int check_block_groups(struct block_group_tree *bg_cache)
 	struct btrfs_trans_handle *trans;
 	struct cache_extent *item;
 	struct block_group_record *bg_rec;
+	u64 used = 0;
 	int ret = 0;
 
 	for (item = first_cache_extent(&bg_cache->tree); item;
 	     item = next_cache_extent(item)) {
 		bg_rec = container_of(item, struct block_group_record,
 				      cache);
+		used += bg_rec->actual_used;
 		if (bg_rec->disk_used == bg_rec->actual_used)
 			continue;
 		fprintf(stderr,
@@ -8678,6 +8680,19 @@ static int check_block_groups(struct block_group_tree *bg_cache)
 		ret = -1;
 	}
 
+	/*
+	 * We check the super bytes_used here because it's the sum of all block
+	 * groups used, and the repair actually happens in
+	 * btrfs_fix_block_accounting, so we can kill both birds with the same
+	 * stone here.
+	 */
+	if (used != btrfs_super_bytes_used(gfs_info->super_copy)) {
+		fprintf(stderr,
+			"super bytes used %llu mismatches actual used %llu\n",
+			btrfs_super_bytes_used(gfs_info->super_copy), used);
+		ret = -1;
+	}
+
 	if (!repair || !ret)
 		return ret;
 
-- 
2.26.3

