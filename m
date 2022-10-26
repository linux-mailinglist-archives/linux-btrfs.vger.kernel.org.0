Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D611C60E8C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiJZTL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiJZTLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F5134AA8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id s17so11357601qkj.12
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8YglGpbE55Rqd/iCI0sfMvhxPfxiH7wsrhrbjOX68Y=;
        b=0z7Eb7pZnXjaoZR3fznL+flumPWLzJVxkvJ5fLzLBME2YSqni/DcklX2Hr9RJOyCjr
         neY7Vi6PKsiimMiPfDFfEMmgVbOmeuKxnCYs/uP1FprDPTxAr0GRBwW8cBjvhAiVrJGo
         ajuG/u43finpFg7UmRsMwkeRAkIKWf3GaxbAdHkurkCly2GadWSEEmkxFRnbHeiRlQ95
         ilVZa6y/T67lg9Qy5vjKwkXh+cr3vdkk5Lmo3F96hnKJLjNkXpEPMCauqKUrgiIj354O
         ZbgXv4Yeg37Aoz/6Z8a5uo/dOdmF9sZ2xC6WMy0/9ToH7yLrItCx68tGzCcQ7ohWI91l
         tffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8YglGpbE55Rqd/iCI0sfMvhxPfxiH7wsrhrbjOX68Y=;
        b=FOj2ebACNF9+rNbfv3ZxHxgM3TObjOl0WApxSADhJ+2q6fWj3dlGBDLY7CNzwRRTm0
         g9BxeqEoTviWDe+kFz8cbI+A8RGCz834AOUWdWS4/RQ0SYvfr8nF4OLXriEXtHA5zPMh
         Lv0WG7/YOlJisxbWZwWWs4TkdFf3kxCS+TMFzOZdIYLt2pWZTfoyMQ0ybkKF9QWtkUon
         GHHbVpEnGCaPQbknRdsvmaw0oXywWYHqjtuFlF4M3l50DI8+133QqD2zqS8QsGVDTrAV
         I1NWD58FfCx7/la4W+Zq3d8YOeVDg/m8lipabdJv/iVC783kwVOoMJKHsOJ2OPDQ7NoG
         L+VA==
X-Gm-Message-State: ACrzQf2/60ova0tBSjdwISXaw5T3+H+XhW0hQKbz9KlX4AwzNP+DWZkp
        Et7yp7FhWS5vBbBEohd/3fxMOZyI7cpSOg==
X-Google-Smtp-Source: AMsMyM5QGFkZrAVSTzOd2jbfn2P3STwsOr5I35gtMEtnKmp2cttXKEudLpcTki/6m3XF9RfRYZcmRg==
X-Received: by 2002:a05:620a:2991:b0:6ee:92ee:5165 with SMTP id r17-20020a05620a299100b006ee92ee5165mr32263937qkp.177.1666811346064;
        Wed, 26 Oct 2022 12:09:06 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bj22-20020a05620a191600b006f956766f76sm1184423qkb.1.2022.10.26.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/26] btrfs: move the 32bit warn defines into messages.h
Date:   Wed, 26 Oct 2022 15:08:31 -0400
Message-Id: <17591700d3d77aa81c2e32d3e010c44782e257fa.1666811039.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The code for these functions are in messages.c, move the defines and
prototypes to messages.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h    | 13 -------------
 fs/btrfs/messages.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3a46b5b688e3..ae2af0aeebc4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -695,19 +695,6 @@ int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
 
-#if BITS_PER_LONG == 32
-#define BTRFS_32BIT_MAX_FILE_SIZE (((u64)ULONG_MAX + 1) << PAGE_SHIFT)
-/*
- * The warning threshold is 5/8th of the MAX_LFS_FILESIZE that limits the logical
- * addresses of extents.
- *
- * For 4K page size it's about 10T, for 64K it's 160T.
- */
-#define BTRFS_32BIT_EARLY_WARN_THRESHOLD (BTRFS_32BIT_MAX_FILE_SIZE * 5 / 8)
-void btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info);
-void btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info);
-#endif
-
 /*
  * Get the correct offset inside the page of extent buffer.
  *
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 4c9f4bd3b150..89abbb62ad22 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -226,4 +226,17 @@ do {									\
 	BUG();								\
 } while (0)
 
+#if BITS_PER_LONG == 32
+#define BTRFS_32BIT_MAX_FILE_SIZE (((u64)ULONG_MAX + 1) << PAGE_SHIFT)
+/*
+ * The warning threshold is 5/8th of the MAX_LFS_FILESIZE that limits the logical
+ * addresses of extents.
+ *
+ * For 4K page size it's about 10T, for 64K it's 160T.
+ */
+#define BTRFS_32BIT_EARLY_WARN_THRESHOLD (BTRFS_32BIT_MAX_FILE_SIZE * 5 / 8)
+void btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info);
+void btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info);
+#endif
+
 #endif /* BTRFS_MESSAGES_H */
-- 
2.26.3

