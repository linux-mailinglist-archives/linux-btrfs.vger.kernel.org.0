Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A377CB266
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjJPSWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjJPSWM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:12 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8C6ED
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:10 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d857c8a1d50so4863608276.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480529; x=1698085329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ943p1j5XH9qWU6rExxiam4puclt+us/2zTj9iFN80=;
        b=VgQQLZKp7CZN90bg1c61lYtwLneSX1feYm2PzB0OZ1jFjOxK3+cf8dqOLLuYB4yfX1
         L6Cgkku4vDxdFHYO+pzafYekOk1xX/nLXq2PET+/dBO6vCjMOZjR9JR21+xEmPPmWPOL
         wBUy/yhQXiWRApRE6GpL7uiu/v4ZZa3dUk/OFIgJ0IQB/IR8Z01lBgTCjJ89nv78XDxT
         DiU/Hni2xiFh9TeYN7krKN23KWK7oRrOg70d5Bn/Uqxuloyu77dicxQhcJnSP2534+zZ
         LVw95nvzRCzKxxMvi4nm62yGrCAla+Y99nteOV6/WaqM2eyy91qVThjttLcqE7rk6+ej
         Llzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480529; x=1698085329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ943p1j5XH9qWU6rExxiam4puclt+us/2zTj9iFN80=;
        b=SsixI1WrD8JSSA5NJF0BxYE/8rwHxg2V4cyzh+FQZh3mM0YlccW2FoiNIeQG1D1OnC
         rw36oILT95G3jt3kGGPWtbx+gFgsC0EBDOb5wano70YzbioblwT/8GXkxN2zYk9t00y9
         4Lbo3rWscMXuVFOYjZKQ/EC+TWH2I/FmvCCMrgcbvUBHzhZXo4G6P6n8+0YfxstfeMau
         9B0jX4owtVI1daZ1S6jG03VafhMkhhSVMgH1uwL1hnsx/giPI3nhOgQ7/hLH20iy0xh9
         5q/XTu7qeaBpqPOOPuzHIIzruUCh2GzdMn00BinZJP2f/5RZa1v8KiI+heoeyTd7s4LJ
         O4zw==
X-Gm-Message-State: AOJu0YzdktBgfFCSECCu+wKYy1eAMDkv4FJfVL6Ml7Cjun7YjLu2GZWE
        nQSfyeyde+VUI9zGDna1BmGx+Q34n66Ow4YXkGj7aQ==
X-Google-Smtp-Source: AGHT+IHAyZP4EPJQFw8nqVTF4C75jVmMENlAEfa9UbvGzvHzAyciUyfR/UMxgbKuAd2e4k66D1KVvA==
X-Received: by 2002:a25:a044:0:b0:d32:cd49:2469 with SMTP id x62-20020a25a044000000b00d32cd492469mr31867797ybh.24.1697480529675;
        Mon, 16 Oct 2023 11:22:09 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ih6-20020a05622a6a8600b004197d6d97c4sm3150673qtb.24.2023.10.16.11.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 11/34] btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date:   Mon, 16 Oct 2023 14:21:18 -0400
Message-ID: <bc9584e4ae4995e5760c31aad31ad558a66ab911.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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

From: Omar Sandoval <osandov@osandov.com>

As encrypted files will be incompatible with older filesystem versions,
new filesystems should be created with an incompat flag for fscrypt,
which will gate access to the encryption ioctls.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fs.h              | 3 ++-
 fs/btrfs/super.c           | 5 +++++
 fs/btrfs/sysfs.c           | 6 ++++++
 include/uapi/linux/btrfs.h | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 318df6f9d9cb..4a3b1bb61849 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -231,7 +231,8 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
 	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_ENCRYPT)
 
 #else
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 9d67fdd47d1d..1e4b536476cd 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2379,6 +2379,11 @@ static int __init btrfs_print_mod_info(void)
 			", fsverity=yes"
 #else
 			", fsverity=no"
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+			", fscrypt=yes"
+#else
+			", fscrypt=no"
 #endif
 			;
 	pr_info("Btrfs loaded%s\n", options);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6b51fb3ddc1..4ece703d9d5f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -304,6 +304,9 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid_stripe_tree, RAID_STRIPE_TREE);
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+BTRFS_FEAT_ATTR_INCOMPAT(encryption, ENCRYPT);
+#endif /* CONFIG_FS_ENCRYPTION */
 
 /*
  * Features which depend on feature bits and may differ between each fs.
@@ -336,6 +339,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+	BTRFS_FEAT_ATTR_PTR(encryption),
+#endif /* CONFIG_FS_ENCRYPTION */
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7c29d82db9ee..6a0f4c0e4096 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -334,6 +334,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
+#define BTRFS_FEATURE_INCOMPAT_ENCRYPT		(1ULL << 15)
 #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
 
 struct btrfs_ioctl_feature_flags {
-- 
2.41.0

