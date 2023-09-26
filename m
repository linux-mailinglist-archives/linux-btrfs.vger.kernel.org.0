Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC8E7AF22A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjIZSDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjIZSDf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A713A
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:28 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77428510fe7so287795185a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751407; x=1696356207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAYbZn+3zKESj4+tPdu4mLEyDQiSn3GiMVrnztvdQzY=;
        b=XB6aQRLJv6iyEAFhPfXbHHCMvIDsWdM0m+rk9hl7KPXkjGoi67O4WwzmayPcf7o0f+
         UkbB6xn8cS6hyFAsAT93ZwVZo2gKGxnOtnS3zAlUN/bWaHOkE/mhcaQpVXKguSJPimZ/
         0T/LiugeOPhS1zYbX+NfPolu5J/EcNKYO0t9/C7Ik+wi34P+xljv33MSDH6Co+gsVbTe
         13zoHnKpJADo3ONVflxO6qYQ9KQp0VBVbybL+w6V1sbqTzmwj2wflF568+yzmYziI2Cb
         ivD8xGmuULN2K8fKXjtdP7vDB1JGMbJ3fvxoDHKGWaTmxz47CKuL6zmX3HEIHlceCOqP
         PisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751407; x=1696356207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAYbZn+3zKESj4+tPdu4mLEyDQiSn3GiMVrnztvdQzY=;
        b=HM2m+wxrEE6Ls1zqSa9ojUCqprY2TndeSjHI7J1ySkcDDzJdRp7JWWa8jaI+aY704s
         AjGkSH/NRZOL9vzZ3O1/pluPKzeauFvT8VMABzGeYH6A6sUKfJmWgr0Kza4RuI6jgyJW
         Cx5mLgvx/GeU3Xx9dTVa3+2uzDjz08qaO7b9az+7GX1eMvBSOiHu8s8Pdxtty7W3WoQa
         tT2YatBfIo4lnGcQvnbXqM9zByon7JwhNmjqOZkvvXJ8EemPePDf0Gu0FcxwP7OZBpqS
         V3KzoPrNCh+wnxJ+ckNKomRO4hcUrKIJON3ggSqA9C/+Vr9r2XUQGVHZU3dc2RwowHiz
         Ka9g==
X-Gm-Message-State: AOJu0YwTm8LaSEDQ3DOUsw9KASRTCXitMPECusI/RiRkb15uode1LQW0
        GZ7+C9QWmDDHbP2Pg9sMZCSX0ZjPNUOjzYBjZ+iORg==
X-Google-Smtp-Source: AGHT+IEbYaO+ZErI7gGdpQz7QomtAVCxiQZR0dsAkeisyHYT6gd2TPyQzGCwmAS8C1wREeXEz/SpfQ==
X-Received: by 2002:a05:620a:1a1d:b0:76f:1614:577a with SMTP id bk29-20020a05620a1a1d00b0076f1614577amr4035271qkb.5.1695751407125;
        Tue, 26 Sep 2023 11:03:27 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e14-20020a0ce3ce000000b0065b0771f2edsm2454746qvl.136.2023.09.26.11.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 12/35] btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date:   Tue, 26 Sep 2023 14:01:38 -0400
Message-ID: <98060c8ad3a994a78872f85e0cacce0842c7c0b6.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
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
index 25a43ca4e0dd..cb2b0d442de8 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -232,7 +232,8 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
 	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_ENCRYPT)
 
 #else
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 21c5358e9202..2b5d60cb7fed 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2378,6 +2378,11 @@ static int __init btrfs_print_mod_info(void)
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
index 143f0553714b..409244b569a5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -305,6 +305,9 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid_stripe_tree, RAID_STRIPE_TREE);
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+BTRFS_FEAT_ATTR_INCOMPAT(encryption, ENCRYPT);
+#endif /* CONFIG_FS_ENCRYPTION */
 
 /*
  * Features which depend on feature bits and may differ between each fs.
@@ -338,6 +341,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+	BTRFS_FEAT_ATTR_PTR(encryption),
+#endif /* CONFIG_FS_ENCRYPTION */
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e2c106bb0586..3ff21c95e1bb 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -341,6 +341,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
+#define BTRFS_FEATURE_INCOMPAT_ENCRYPT		(1ULL << 15)
 #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
 
 struct btrfs_ioctl_feature_flags {
-- 
2.41.0

