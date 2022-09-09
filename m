Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E45B41E6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiIIVyT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiIIVyS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:18 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BF10B009
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:17 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m9so2282977qvv.7
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=2UMxDY5tG/hRohwsBIr2XSsC2j+BTvTFcC+qsCsUO8M=;
        b=ZuECmMlvkBFrlaf6zjW2SzhltTr/MB7Y3a3352hXKIYj7OUaJbRMvgorI2rLuA9Efc
         upjAsA6c7Dw5a7X5FuokdWe07DNfnv1axLpcyTn/ebXKhfO/Z9TCrt3SLBCklAUGd1zt
         fxE17iNeAKdyhO+vH8WrGsINa/a87P9uc8biXiuoMPmSs79zmIUeNmttelQA1HIxX9gB
         cgvCp6VgrXlHYjkTMo2urR0Gp9I6WnM7EtVKQn2MPeCF4omGgfUV5KM8a+Gz7WOF0TNX
         iDsxdKZr379c93Kb/+SFXqIGIO04k5RUntXdhnfQHNdrqtF8dv8/zLNdIUHXZofEEirP
         Q9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2UMxDY5tG/hRohwsBIr2XSsC2j+BTvTFcC+qsCsUO8M=;
        b=gj/7pX+ChJABoqYfLrHVdFwS/7Ze+IhJ39xiWbwSHmU0oNlwXYbNo8fj85M+WaSCiw
         8Y8cHRGgLjgAWk6jxw4dNtVRTOVlsdssUc6+bmLnacnJ+xinnLkmq1EQ6kh7dzB3CBVM
         6duzFxQn6gMzgJ+xMs/ZdHBLLH4B3KDV1NH6+Ph/TaXzeJ2yuZGi179O3uped558F7Dl
         huP11HgoWxo+o2KU7T3zSlnbmVT0bet2usV4YXIuAjFvEH4Y5h+FS1JAwfn5ck1Ae4Za
         ypJcXfrt5o5IuJscxEXcKEY4LzZ6jNMGJbatufhPeNIll5LmCwuHXifcVKS8xvKvpFen
         K8Dw==
X-Gm-Message-State: ACgBeo0HV1FLaqJ0eTQ1gPSFUwyp9bI18YizEcFbCDlzTmsiTaLXxQd6
        EBekdxLdFn951I/FjyRTD5dsPuKmo+sM0w==
X-Google-Smtp-Source: AA6agR5wN5CEH3ezYIdwv57/51zae/00tCxpTfQAmqZM27Yy1BIJZ/QCyztfvi2x6Qa+xwSFhzjFgw==
X-Received: by 2002:ad4:5ce9:0:b0:49f:ee02:50c7 with SMTP id iv9-20020ad45ce9000000b0049fee0250c7mr13851759qvb.105.1662760455804;
        Fri, 09 Sep 2022 14:54:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a9-20020a05622a02c900b00344fbd8270bsm1262617qtx.42.2022.09.09.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 17/36] btrfs: unexport btrfs_debug_check_extent_io_range
Date:   Fri,  9 Sep 2022 17:53:30 -0400
Message-Id: <889cfbc7e78e7cb4c0919ddd65caa101c2b91963.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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

We no longer need to export this as all users are in extent-io-tree.c,
remove it from the header and put it into extent-io-tree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c |  9 ++++++---
 fs/btrfs/extent-io-tree.h | 10 ----------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 322909cf3040..6e1945fef01f 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -46,9 +46,11 @@ static inline void btrfs_extent_state_leak_debug_check(void)
 	}
 }
 
-void __btrfs_debug_check_extent_io_range(const char *caller,
-					 struct extent_io_tree *tree, u64 start,
-					 u64 end)
+#define btrfs_debug_check_extent_io_range(tree, start, end)		\
+	__btrfs_debug_check_extent_io_range(__func__, (tree), (start), (end))
+static inline void __btrfs_debug_check_extent_io_range(const char *caller,
+						       struct extent_io_tree *tree,
+						       u64 start, u64 end)
 {
 	struct inode *inode = tree->private_data;
 	u64 isize;
@@ -67,6 +69,7 @@ void __btrfs_debug_check_extent_io_range(const char *caller,
 #define btrfs_leak_debug_add_state(state)		do {} while (0)
 #define btrfs_leak_debug_del_state(state)		do {} while (0)
 #define btrfs_extent_state_leak_debug_check()		do {} while (0)
+#define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
 /*
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 251f1fc9a5b7..d01aba02ae2f 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -269,16 +269,6 @@ static inline bool extent_state_in_tree(const struct extent_state *state)
 	return !RB_EMPTY_NODE(&state->rb_node);
 }
 
-#ifdef CONFIG_BTRFS_DEBUG
-void __btrfs_debug_check_extent_io_range(const char *caller,
-					 struct extent_io_tree *tree, u64 start,
-					 u64 end);
-#define btrfs_debug_check_extent_io_range(tree, start, end)		\
-	__btrfs_debug_check_extent_io_range(__func__, (tree), (start), (end))
-#else
-#define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
-#endif
-
 struct tree_entry {
 	u64 start;
 	u64 end;
-- 
2.26.3

