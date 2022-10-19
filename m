Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75100604A1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJSO6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiJSO5g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:36 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E212742A
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:09 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s3so11783396qtn.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cs/XdTV43YB+F7SqNGEkidHffTnMxmeODs94xd6e8Js=;
        b=61rMvGnKggy232EQlc6BF73mFkDrPk823WOUgPbamASlS+I1eRuzFqyW9x+MAYFDu2
         lAv87OE0bLBmYq0SbmohFFgeW4sVJpTOT2u5GH7urUZ2yYk7KXH06ZtOnNOVDy8VoJPb
         lhRDklomF0658QH7FLscjRWwlai+090thllrEVodYBOCfDiAmVH+30KnYnYtDWjgQgdw
         57s44X9GKpku6aZB4PkVasuBT0bOu0hlpgOFgVnWQ6EGK982Wis5Vw6p83DFb6QsNXCC
         M3fp1Wrx3ahSwoRngnHYLpkwcX8HwEBtuFHO6tUan2Rf99JJxpF/FY9O1c5VYnKc/3dG
         dYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs/XdTV43YB+F7SqNGEkidHffTnMxmeODs94xd6e8Js=;
        b=dU/TW2vELetpTkOre79FEhWngUOeaKho3g801idt4AVH59bDB41+PPmTjdYah7+vkc
         ArQYrPMmqs6MeFhPMa9TB1BpccA4Yfi8PDPcfzW49tMxfLFCOGCuR13g+Blj1gFuwJJZ
         uV7EM246boWwou2sqzhyvkpFTIqawnvBx4Rg2UwclOl/t1lVhtPQRB2seetc3yM96HmU
         FN2E4Vn3QbfUIH/+RPOE6sNrjtM/L16Rpg9rIet8HJzZ3UxQNx5kw4RfFEaHR33pRVJu
         Gs8HqRT7/q2pfFtco4asKEuQJiskBQl645araZhRk0RPFXEwvBc8rt8eD/EPyOQb+BTO
         4Glw==
X-Gm-Message-State: ACrzQf0sJEFk4ORShSJs/dz2+0XyJXj+F9Ezs7r8tGQ6eaDKVZgHFZ6+
        ofI//kytUKjJ209NI4n1uBaFVH4B72/o4Q==
X-Google-Smtp-Source: AMsMyM4jw+vZjsfTIH/1MqRzNstFlLN9RvOdQat0kqB1+HaV3wjxxvHJLnGJj9GNWsDvPMfpQc9UNQ==
X-Received: by 2002:ac8:5a0f:0:b0:39c:ea8b:8835 with SMTP id n15-20020ac85a0f000000b0039cea8b8835mr6781975qta.599.1666191068125;
        Wed, 19 Oct 2022 07:51:08 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i3-20020a05622a08c300b0039cc665d60fsm4122708qte.64.2022.10.19.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 04/15] btrfs: push printk index code into their respective helpers
Date:   Wed, 19 Oct 2022 10:50:50 -0400
Message-Id: <ee9bced22f908cf5240dcb77e4b9658d4614589a.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

The printk index work can be pushed into the printk helpers themselves,
this allows us to further sanitize btrfs-printk.h, removing the last
include in the header itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/messages.h | 29 +----------------------------
 fs/btrfs/super.c    | 12 +++++++++++-
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 441b112345d0..4c9f4bd3b150 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -13,19 +13,7 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 {
 }
 
-#ifdef CONFIG_PRINTK_INDEX
-
-#define btrfs_printk(fs_info, fmt, args...)					\
-do {										\
-	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);	\
-	_btrfs_printk(fs_info, fmt, ##args);					\
-} while (0)
-
-__printf(2, 3)
-__cold
-void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
-
-#elif defined(CONFIG_PRINTK)
+#ifdef CONFIG_PRINTK
 
 #define btrfs_printk(fs_info, fmt, args...)				\
 	_btrfs_printk(fs_info, fmt, ##args)
@@ -220,25 +208,10 @@ do {								\
 				  __LINE__, (errno), first);	\
 } while (0)
 
-#ifdef CONFIG_PRINTK_INDEX
-
-#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
-do {									\
-	printk_index_subsys_emit(					\
-		"BTRFS: error (device %s%s) in %s:%d: errno=%d %s",	\
-		KERN_CRIT, fmt);					\
-	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
-				(errno), fmt, ##args);			\
-} while (0)
-
-#else
-
 #define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
 	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
 				(errno), fmt, ##args)
 
-#endif
-
 __printf(5, 6)
 __cold
 void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d04d530356dd..daab56b6a582 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -182,6 +182,12 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	const char *errstr;
 #endif
 
+#ifdef CONFIG_PRINTK_INDEX
+	printk_index_subsys_emit(
+		"BTRFS: error (device %s%s) in %s:%d: errno=%d %s",
+		KERN_CRIT, fmt);
+#endif
+
 	/*
 	 * Special case: if the error is EROFS, and we're already
 	 * under SB_RDONLY, then it is safe here.
@@ -207,7 +213,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s\n",
 			sb->s_id, statestr, function, line, errno, errstr);
 	}
-#endif
+#endif /* CONFIG_PRINTK */
 
 	/*
 	 * Today we only save the error info to memory.  Long term we'll
@@ -274,6 +280,10 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 	const char *type = logtypes[4];
 	struct ratelimit_state *ratelimit = &printk_limits[4];
 
+#ifdef CONFIG_PRINTK_INDEX
+	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);
+#endif
+
 	va_start(args, fmt);
 
 	while ((kern_level = printk_get_level(fmt)) != 0) {
-- 
2.26.3

