Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64DA573440
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiGMKb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiGMKb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:26 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A2FD20A
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:24 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 14AC9806E0;
        Wed, 13 Jul 2022 06:31:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708284; bh=VtZ50HmDcmXm/QENpNiEoK7dz/Zvw7+K+TVEVAw66c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgZdISPAUoCu4wtJbqlYPwSpspPk9papq9BuPYwh1k4iB8TMmtG2wGUifBXow6yA7
         DihteQ5N93dzjzABRLIOCC5ZG9f/YN2bPpmF3A0VcDHGEHuyZEujH9kKRorUP5YmfW
         u8NY4x4bnDhq3OsxmvQLYZgvF7joiKrzVQVuKblGieBzXrPB9frI7p2nTpdPLQxT9D
         rNLF/qL5x1RZE+T/yY82x7/Y+gkj+LPd0FBIQ3PZKqEj4pFeevVL/JFoXteoEpq30v
         U8x+cLzmJJnF9eeBm02QtWq8SKLAgDfjzJEX65iUG4ZG2B0Y8dmY460xQ5pOjxmx4M
         OYGV6CVLK/Agw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 19/23] btrfs: Add new FEATURE_INCOMPAT_FSCRYPT feature flag.
Date:   Wed, 13 Jul 2022 06:29:52 -0400
Message-Id: <8584ff55685ae522c65b19e8904db51f16dd964b.1657707687.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

As fscrypt files will be incompatible with older filesystem versions,
new filesystems should be created with an incompat flag for fscrypt.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h           | 6 ++++--
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bed27b91d69e..522bb3452768 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -334,7 +334,8 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
 	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	|	\
+	 BTRFS_FEATURE_INCOMPAT_FSCRYPT)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
@@ -349,7 +350,8 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
-	 BTRFS_FEATURE_INCOMPAT_ZONED)
+	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
+	 BTRFS_FEATURE_INCOMPAT_FSCRYPT)
 #endif
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index f54dc91e4025..b19fc3725769 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -310,6 +310,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_FSCRYPT		(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.35.1

