Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0E6774450
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjHHSQ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbjHHSQV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:16:21 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEBE7C701
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 10:23:00 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 889A98354E;
        Tue,  8 Aug 2023 13:23:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515380; bh=joEF3+va5Af010dXO69Cn6ETWbAgY5KWCyraZTJkzRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbzusW0R+YQ0Z8VvGwkY42k43/DcTazrnoiGaa9PvjUbstybtU6TtLRbbf343HwcF
         O08S7QhXOzoWiXQdJXvltuN+bAS2gqcmEoZy8Ic+z7+T/QH0LWhZS56lGPx6N9U5tJ
         j8o3IDKZ8g1zICr/0KkFB/E12/1kFnn9/ZWhFQQ0pNCfbABXeynBzYH4RW0VIsl7Hp
         AyjVZcet0hviZdWKQigYfeMEBqpyQgIqrMnyxwNRXEYWi3EtxaPaPjiufPzSwgIiII
         25MQrkj1CZpFHCqdG3NBuJ9pJrt6GnS834kkKxwwK710XIx7x3wDnSLO+Ur1RLb2qy
         MufpwIpILyJ9Q==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 1/8] btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date:   Tue,  8 Aug 2023 13:22:20 -0400
Message-ID: <9e6e697ccd73915b237fe1caefc55afa0dc95de9.1691520000.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1691520000.git.sweettea-kernel@dorminy.me>
References: <cover.1691520000.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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
index 59533879b..6c9ff866f 100644
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
index 85b04f89a..e347cceb0 100644
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
2.41.0

