Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62484742E0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjF2T6h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjF2T6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:58:24 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D773585
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:58:24 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id AA62580AE0;
        Thu, 29 Jun 2023 15:58:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688068704; bh=eiPkmhJ/0kTTt/2ieHVJm4oDVxiTiwMRmaWQdcSS1XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HP8rF8jZIxcd+b7mOIaBQILb+nmZ+LHQT9ib0Y8h6gPvQ5bYLY6AR6XHCJQcGs1rO
         CV/sElqe7W4yYZrQsENTVd7Ey8CULvPDaoceyY8Lar1e4AQscICdK5dCeZO6dugqzV
         ahaoGc+FAK7xZqkrtL6mjc4W98eg07tTmc/mURFXspkMlZKCBw/37rSdG3WjQge4lN
         FUoefyz2tYTFhJHlQtQyPCQinpLYwuNjK0Hgl5eY4W8rtHCO+jgMtZc2GDl5mOyrET
         1S2x9burCdhV6ze/j+jmdthafgjE3Nr7FepN41z5mwgVRht0E6Nhj78b01pRq1JhTO
         JIi9N3uBNlXwA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 1/8] progs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date:   Thu, 29 Jun 2023 15:58:00 -0400
Message-Id: <5fbf8d6827c91bae6a31f03c1f017eada9226c90.1688068150.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1688068150.git.sweettea-kernel@dorminy.me>
References: <cover.1688068150.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Matches kernel change by the same name.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/ctree.h      | 3 ++-
 kernel-shared/uapi/btrfs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 59533879..6c9ff866 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -103,7 +103,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
 	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |	\
+	 BTRFS_FEATURE_INCOMPAT_ENCRYPT)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 85b04f89..e347cceb 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -356,6 +356,7 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_ENCRYPT		(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.40.1

