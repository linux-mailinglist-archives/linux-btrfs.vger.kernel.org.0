Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3ED5B8E05
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiINRSq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiINRSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:35 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA78169E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c6so12251276qvn.6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=2ysYYFFsPSYxGxRXxzyUi20oLEqjEPSpSjuRCs+0koI=;
        b=mouz6IzbZ+l7HT76465jYXAu5zknTlc0MPw5xJHbzcT3iUceebOrBMD13ARltKZEiH
         lGg+qqDfBWoYWfUGbNKXJSClRI06CrlY5uCfx+8AVuzF8QGqsa5ZdFuHQECwxAEKYn6R
         aPHqA1x6ybksR++kahbXt+1940F+meY7c1zu6n55gdBSWlfJKrwCNgPiza31Ys5cOqrI
         fXcQWBVuJV8SigxJETnwm/nU4I1NMWnaHCKcRO8L8d09yj8SPQFtacYbyZxaQPZ5VJep
         3sDRYAXxIucrDJ9fn83mtddVcOKgb1Qk01pkzAM3F9Bcrj6JyU4QaBE2l7ju1lo/4wSz
         Lotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2ysYYFFsPSYxGxRXxzyUi20oLEqjEPSpSjuRCs+0koI=;
        b=5W1xATGW4hbLAERVkLpYuRjYuyWhavVauIw4HYkMDR+yxIMe6MVWrmnSd4/yqKA5RP
         HMsDsRrPZcRoD8ky78ZO7/doW8pJ/X1LV3G8RsRAflFeGUM19Ird87omP/GoNSEj/7/N
         VmKdKpDYpyLoeG6vMq7tXZyHt9FmM5mO2rGDje2ayOy7EzF5Z7nC5xrDAR5t0r05F2Ol
         fJRTG8Sa3Tkh7gxnzUv7Lp9Y3ad3k31ECJb7uGW+VEEzoFUZzetFr2qnMLD/yOBGkfKK
         YHXCeYE1WSxn+JgvWbmUlV6GJnH3Fj/l9AaqW6AhDFnsaq4M04R6FlRSRmksLfn0wZzj
         Appw==
X-Gm-Message-State: ACgBeo0NkSXLEVm/iXxfEA3OCMWWwErSLxmXxRZxLamW7+cobwCeGUEk
        EbENDRwBDhSy9Pby3zhkLmriv6k1kfvtFw==
X-Google-Smtp-Source: AA6agR6ZnNbI88WVveDbAxbX04x1BkC8n6oKk3hUlQ9U8VkwPw1VlAQmMrbP34Mcf8+U+MF/6M/PCA==
X-Received: by 2002:a05:6214:76d:b0:4ac:a40a:a5c9 with SMTP id f13-20020a056214076d00b004aca40aa5c9mr17286874qvz.118.1663175911702;
        Wed, 14 Sep 2022 10:18:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id az6-20020a05620a170600b006b919c6749esm2228910qkb.91.2022.09.14.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/16] btrfs: push printk index code into their respective helpers
Date:   Wed, 14 Sep 2022 13:18:11 -0400
Message-Id: <ddcbbcbb41a182baf036d39a6a70e51bbe599f26.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/btrfs-printk.h | 31 +------------------------------
 fs/btrfs/super.c        | 12 +++++++++++-
 2 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/btrfs-printk.h b/fs/btrfs/btrfs-printk.h
index 87e46d24b4ad..e2fd6bbc7aa1 100644
--- a/fs/btrfs/btrfs-printk.h
+++ b/fs/btrfs/btrfs-printk.h
@@ -3,8 +3,6 @@
 #ifndef BTRFS_PRINTK_H
 #define BTRFS_PRINTK_H
 
-#include <linux/printk.h>
-
 struct btrfs_fs_info;
 struct btrfs_trans_handle;
 
@@ -13,19 +11,7 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
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
@@ -202,25 +188,10 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 #define btrfs_abort_transaction(trans, errno)				\
 	__btrfs_abort_transaction((trans), __func__, __LINE__, (errno))
 
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
index 781e5faf83d5..2865676b8327 100644
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

