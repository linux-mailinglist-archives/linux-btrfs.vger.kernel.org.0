Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF25B8E04
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiINRSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiINRSn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA283F26
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:42 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id ml1so12277711qvb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=op8xEoZpsFCV7/af0SnEP+7KJ13/88i8jm6fa9osLmA=;
        b=bCe6CGGMZ007q+HW0CfrdwzqD9QhSjGNSjMebDYHmmiTy0djTYZ+kKV8CX0o1X53ei
         xX33o8QNaR85Z2xD/bOeK6Fyu0Jhhge7XJCrQb/t5iCcrY4A0yg0+t3EnntwPjUCIwUo
         j3IKWR8bb01EJyPsWolX/BE4PbdUwJJuaD2G6qdAJuhG/ranpcjuY6T2EJ1AhtqaO2tj
         WNEz13Fi+kRmO5wfV5PTZTWJ9TC+RokE7rxVzd78pywNp5awmdPHuwV8fALU53rSw376
         sQs3NWdWV08MLKJ5aIge79nEeRSoclHGvCNmIuMXVWrZVmhZfCEAqhA2ienckcBytfVD
         6tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=op8xEoZpsFCV7/af0SnEP+7KJ13/88i8jm6fa9osLmA=;
        b=F7EgQsFCzqGYpbTD+Hc9uuI7WvXHFGVHChdQJOdZH4N8YkPVUE6k6SXWheDMaaEl2a
         0X0syK+YteeKCQSl/xBc261Yy9lgbKE5IMyfSKSjVWRxmwFZW/FKIjX6gUkxiz2l8Wsa
         Ar7/GAkMB6JJ/t+rGoM7LjWWBZz0v/HUOT9Dt9bUA0rxgPswm4+XoAei6SkgG4hOxUcI
         egxYfqrmIHkKcZwkJu4v3T6eoqZorHvIUnjkdm1s/SCuQbO1TOLebgo/ukpOIbqQxJzN
         pcQUq1oDN4CYJcDVs42qCZEYlgTo+d95gfHWlBsfRpe60wKi+DA46gJXpxhQ1eWabE24
         POqQ==
X-Gm-Message-State: ACgBeo1YHPAOw1AJwTBv2ivO5G7Qxp4Lcef/V1pcVZ82WtocH0K/xgiC
        8WPMV6dl7cskUwAkM+wfI7S187dKOFBq1A==
X-Google-Smtp-Source: AA6agR5O6NnDUk+lvswuV4Mx5xAfyyKmiHBMpc+T2iTclkaDLe6DPHBEm4+dqM49ri7q27Gn9g4cFw==
X-Received: by 2002:a05:6214:c4d:b0:4aa:b47f:98ce with SMTP id r13-20020a0562140c4d00b004aab47f98cemr31779365qvj.25.1663175921295;
        Wed, 14 Sep 2022 10:18:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id fb24-20020a05622a481800b0035ba7012724sm1873417qtb.70.2022.09.14.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/16] btrfs: move the compat/incompat flag masks to fs.h
Date:   Wed, 14 Sep 2022 13:18:18 -0400
Message-Id: <ab63f545063c7003c5ed94c3d8d6102275f785e6.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is fs wide information, move it out of ctree.h into fs.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 57 ------------------------------------------------
 fs/btrfs/fs.h    | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f44c744fe7a2..b6e86c1bc4b2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -65,63 +65,6 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  */
 #define BTRFS_DEVICE_RANGE_RESERVED			(SZ_1M)
 
-/*
- * Compat flags that we support.  If any incompat flags are set other than the
- * ones specified below then we will fail to mount
- */
-#define BTRFS_FEATURE_COMPAT_SUPP		0ULL
-#define BTRFS_FEATURE_COMPAT_SAFE_SET		0ULL
-#define BTRFS_FEATURE_COMPAT_SAFE_CLEAR		0ULL
-
-#define BTRFS_FEATURE_COMPAT_RO_SUPP			\
-	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
-	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
-	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
-	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
-
-#define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
-#define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
-
-#ifdef CONFIG_BTRFS_DEBUG
-/*
- * Extent tree v2 supported only with CONFIG_BTRFS_DEBUG
- */
-#define BTRFS_FEATURE_INCOMPAT_SUPP			\
-	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
-	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
-	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
-	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
-	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
-	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
-	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
-	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
-	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
-	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
-	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
-#else
-#define BTRFS_FEATURE_INCOMPAT_SUPP			\
-	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
-	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
-	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
-	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
-	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
-	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
-	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
-	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
-	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
-	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
-	 BTRFS_FEATURE_INCOMPAT_ZONED)
-#endif
-
-#define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
-	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-#define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
-
 /* Read ahead values for struct btrfs_path.reada */
 enum {
 	READA_NONE,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 6181657bdc90..f120e931ce85 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -139,6 +139,63 @@ enum {
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
 };
 
+/*
+ * Compat flags that we support.  If any incompat flags are set other than the
+ * ones specified below then we will fail to mount
+ */
+#define BTRFS_FEATURE_COMPAT_SUPP		0ULL
+#define BTRFS_FEATURE_COMPAT_SAFE_SET		0ULL
+#define BTRFS_FEATURE_COMPAT_SAFE_CLEAR		0ULL
+
+#define BTRFS_FEATURE_COMPAT_RO_SUPP			\
+	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
+	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
+	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
+
+#define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
+#define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
+
+#ifdef CONFIG_BTRFS_DEBUG
+/*
+ * Extent tree v2 supported only with CONFIG_BTRFS_DEBUG
+ */
+#define BTRFS_FEATURE_INCOMPAT_SUPP			\
+	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
+	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
+	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
+	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
+	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
+	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+#else
+#define BTRFS_FEATURE_INCOMPAT_SUPP			\
+	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
+	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
+	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
+	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
+	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
+	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
+#endif
+
+#define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
+	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
+#define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
+
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
 
-- 
2.26.3

