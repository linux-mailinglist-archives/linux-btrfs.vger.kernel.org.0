Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1717742DF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjF2T6e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjF2T6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:58:24 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B802A30F0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:58:22 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1CAF280B01;
        Thu, 29 Jun 2023 15:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688068702; bh=eiPkmhJ/0kTTt/2ieHVJm4oDVxiTiwMRmaWQdcSS1XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMnIQQgFOppNsSNeyBSDWPkpjNrJZPtG12P3RojksdndGIU2EMnc4vWWWMnxMvy7z
         k7cztDA0gpsvbF5oJ9JD5AM19f1bI8S8M9HV4Ot5/F/c0amssAb/Fan1/mBPLLx2aZ
         sUDHaYsEduR/c1h8tbA5jZzNiADn2Se/+SNwtGDi3gcB2Zx2a5hxfus3+1j9q2Xw+f
         PQSoHS5C/1/GGvs5ybf15OhRKVLWA3g31mugV4YSzlo4hRg1IMFfCVu9cyQC2jjxRd
         +z1nXf7OHCuKd1zGQxsZupEgTB0MCh6aDeQa218LyuQxhzCVbRcPpyy8Zt8lmsAlc7
         RhO7CK1MzGDIw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 1/8] btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date:   Thu, 29 Jun 2023 15:57:59 -0400
Message-Id: <812e244a1a54bfa9046d36867bf913c9e99e99a3.1688068420.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1688068420.git.sweettea-kernel@dorminy.me>
References: <cover.1688068420.git.sweettea-kernel@dorminy.me>
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

