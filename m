Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B40604A30
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiJSO63 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiJSO5k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6622962E7
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h24so11455803qta.7
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHKx4XGltpJDGpi25Usx/nl0oNx8nnVwldyJ6+AakUg=;
        b=iBWYNtkuNWBvXF8ZuS85SZ5hmCu5UosrBr9yqnczExi9/mVJD3BYTMiGnwMJzw6oNi
         LWNcVTyBrjueqglIuFcGT7clbw7FeL0HIKokoZRiXX0QxNEvjC10OAdoZkvJQ7AknomL
         CzoeuwcZXUmvWo/2broqrivdO2Ty0EDH5ZsbFJOoKsuvtRcpLfyUC2/0TSGIjFT+Tkae
         TV4/asw2sHRkcOjLF0LYKYDI1Ir092jX5FId3b0ckPdpTdVSMRIkNqi4VjHu5IuyAgop
         06TyQvet6/2vQAzpJW8b8kLIx35k2YiS8DuFJ00PXRxxlJwRtw/vGIE8B9Yh1r9WP+KT
         ZoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHKx4XGltpJDGpi25Usx/nl0oNx8nnVwldyJ6+AakUg=;
        b=vmSj7/J8x2fSQ/YExNR7aC05Mc4FFxGZgOTjndn50faBYntXmIIZmJZLX69+Fp9zAH
         LeInMaA4dsFU0d26Zbqb8J6nIfM9G9HHFZZIxM6Ng8xl7URgz83xO0A3JaTgjZQppOsv
         oCWnRGwmhtzHyKOWlcOpkFrPFxAWcKRjrvkpgVEBOFDmH8V12UomORkLC2c7y2/6PeWo
         y+JbUboIYYsDFsiDNvVRWu17Kj6T8urZaeIfSzAG4zBxCQ+zxnrUJ2mUsJ7UPGYiCRiZ
         EYrxwJMBEzDuy+ipaDC2MCPeE4h61eX8QJiNb28jucFwP4FN9sNFMLnUDTh7Z8HOC8OK
         L8Yg==
X-Gm-Message-State: ACrzQf3ln/ndhJXQB+JB5I0p9Xng8NJ6wQthUk1WJbf1+tkp5usAFWoU
        2IoZm20xNhzQ1O03VNcvROrI/0TmofyMAg==
X-Google-Smtp-Source: AMsMyM6HDFm/LoHHG6z4ZdEcBppzh5ZT/9/aS5F5BN36IIgYZ/aynTB3fNRiFzNyNCaQuTTu2Nof1A==
X-Received: by 2002:a05:622a:15d5:b0:39a:e3c6:6f0f with SMTP id d21-20020a05622a15d500b0039ae3c66f0fmr6583161qty.514.1666191078222;
        Wed, 19 Oct 2022 07:51:18 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006af0ce13499sm5087130qko.115.2022.10.19.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 11/15] btrfs: move the compat/incompat flag masks to fs.h
Date:   Wed, 19 Oct 2022 10:50:57 -0400
Message-Id: <ef3372e9715ddc0aef3f20bab2129cd7b0bdfd80.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is fs wide information, move it out of ctree.h into fs.h.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 57 ------------------------------------------------
 fs/btrfs/fs.h    | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 988a4c176288..2570116aac88 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -70,63 +70,6 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
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
index 7b221d37ad0e..ac223da28576 100644
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

