Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C9785ABA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjHWOdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjHWOdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D3E68
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5921a962adfso35230047b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801231; x=1693406031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsQcvJy6IvGA3FUYeG4qX/Sves1np50ycXSgLGGwSCQ=;
        b=N4BUWs688l5E8SaScRJ+Hs+cECSKWdNnGHbqlsFao3UffMvq/iGa5+HrGzhNQn5HoD
         DpsHwOMmArOo5ozNjU8Y75cpWa5p+k/upfQdHChSfcqWF7hTPbT2nhLsmDTpWYcZnO2R
         PECLrDAyBCjNaxkJlxhmz3a2Z3pSjpxbViDRdj9+rcgeWXDiFpmqEwBvzoX/bHAQEshX
         RcYhH1uQd0XRe2ZfUKcbomu4eTofGugMOr2yxxW2k+tRNocoK44cnLyWTRQS9Lx7eS55
         gDEmpeAcgfI9Dyjx02KK//lULY8n+LCCiSmO0RU2xRc/w6d+pq10N6d5c3SDHgHY12nB
         IR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801231; x=1693406031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsQcvJy6IvGA3FUYeG4qX/Sves1np50ycXSgLGGwSCQ=;
        b=ZGWgRKIPcgOlrI3F1x1fF8NQ/pokwIN7xWi6bk5Xqsw53GeWc77qNhb7Mvf00Cfuee
         qPuH9afoHLPMThniyBmavW4zausTshKUZANvNxmqGBHkcTdqI8b/prnH78Y0Vhi7pIYF
         Os0fPWBBKn4gT6ykJLEmsXoLGRNsxxKUHJOkbjsnpcEGCPNGJPZDGoUvWD7eawp9oRSX
         MoVuRYfzRpwcbShFveEPGKgrSUvdMvhlFDjXqo8rBqW7TLCWlOBATde7YfpO+h75HhUN
         Agwelg9pHsHILac+tRldSlQ0RNk4k13gYH2GPVzD87DdT1KMJwAWA6rbLmiPMgeG2nSV
         pbtQ==
X-Gm-Message-State: AOJu0YyOGfsUeRDL6VlW2w5ofqG6t5lsgHrKo02rDzW5aGSvY8lfkQs3
        gOcwOTob2qzgVlGVDe1Xp2WnN/M/iaoroUBR3e0=
X-Google-Smtp-Source: AGHT+IHnfEZgmo8Yg0raenuVZ7/EZgrV0w7VioHTe8H8NeCHJUyODwFJ4WcaqpUusrDpRV5c7hR3QQ==
X-Received: by 2002:a81:4843:0:b0:561:cb45:d7de with SMTP id v64-20020a814843000000b00561cb45d7demr12938757ywa.31.1692801231362;
        Wed, 23 Aug 2023 07:33:51 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q62-20020a815c41000000b0057736c436f1sm3321994ywb.141.2023.08.23.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 36/38] btrfs-progs: inline btrfs_name_hash and btrfs_extref_hash
Date:   Wed, 23 Aug 2023 10:33:02 -0400
Message-ID: <be9c4bebbc502233f94879c61dcc8b7a30f34317.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the opposite of what we do in the kernel, however in the kernel
we put the helpers in dir-item.h and inode-item.h respectively.  Those
do not exist in btrfs-progs right now, so instead of doing all that work
right now simply inline them in ctree.h to make it easier to sync
ctree.c from the kernel.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 14 --------------
 kernel-shared/ctree.h | 16 ++++++++++++++--
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index fb3b9899..0bfebdc2 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -24,7 +24,6 @@
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/tree-checker.h"
 #include "kernel-shared/volumes.h"
-#include "crypto/crc32c.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
@@ -188,19 +187,6 @@ u16 btrfs_csum_type_size(u16 csum_type)
 	return btrfs_csums[csum_type].size;
 }
 
-u64 btrfs_name_hash(const char *name, int len)
-{
-	return crc32c((u32)~1, name, len);
-}
-
-/*
- * Figure the key offset of an extended inode ref
- */
-u64 btrfs_extref_hash(u64 parent_objectid, const char *name, int len)
-{
-	return (u64)crc32c(parent_objectid, name, len);
-}
-
 struct btrfs_path *btrfs_alloc_path(void)
 {
 	might_sleep();
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 67c5a6f8..7ffef9fa 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -25,6 +25,7 @@
 #include "kernel-lib/rbtree.h"
 #include "kerncompat.h"
 #include "common/extent-cache.h"
+#include "crypto/crc32c.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "kernel-shared/extent_io.h"
@@ -869,8 +870,19 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
 }
 
-u64 btrfs_name_hash(const char *name, int len);
-u64 btrfs_extref_hash(u64 parent_objectid, const char *name, int len);
+static inline u64 btrfs_name_hash(const char *name, int len)
+{
+	return crc32c((u32)~1, name, len);
+}
+
+/*
+ * Figure the key offset of an extended inode ref
+ */
+static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
+				    int len)
+{
+	return (u64)crc32c(parent_objectid, name, len);
+}
 
 /* extent-tree.c */
 int btrfs_reserve_extent(struct btrfs_trans_handle *trans,
-- 
2.41.0

