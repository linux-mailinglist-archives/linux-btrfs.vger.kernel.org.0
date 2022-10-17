Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C53601700
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJQTJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJQTJb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F05BC8
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:23 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z8so8350296qtv.5
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW1J5UY8kW+QHsw7F9nv2I0f9nr3DWzjfMcntMVrqgc=;
        b=aNYLl47E/xh+qFsDwJvSBT+3C3hnzGe7v319stjf9pYdW8zKmzUJkc6E+613WwKwQI
         w0yGbdz/+GLL5hSVQQmxOfHlyrtaLJCMr1bHsjXlYVkX2e3PG3zUwvOeaDlkqfWeppcs
         LMR7AOg5N55O3QVt3D7FGdTlRsjLAkD/OQwixZR7/zQAYNaHOVRItL0qLzrk5JeJGAUr
         uH0NjMTFamKvAwpEOdmkg3VjvEvpfZPJEGBivAZzr8uJlhQ40uaRdAQrIza/hzBwdBf+
         tYzI9Ch2TnJ538Ir5owrgtGZkivW2uqYpkjQDqT+rV4c9EPxIPsouAdda5hS/2ARGqFX
         oBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW1J5UY8kW+QHsw7F9nv2I0f9nr3DWzjfMcntMVrqgc=;
        b=d2f2RWKabNUr1nedIcpnTNXyIm1rDFkVFag0zwrPcP2eGaSGttuJbtpcKD19D8zXiO
         Z0JN5kUAi97/q2ynH/kInBlOsPyHKk1KFQIDt2UFrf5aieyCWJ16nMxurINVjnxrqNM0
         NaLOf+gnqQZvVZ6NoAEBWUopUFgBF/0G3K4WpZ7hpnJ6JkLVEvBdOZnDn+bhv5yUNZ3c
         4YC90JtZfEOChmqrPmjc9DW6lOM4IBQutrN/Mt+GYRMLsVPtnuVNUjmi+55x8qqHr8AA
         M3KexpqRVhfpNNzhDESsyTn5k2m8RIK/EEX+YfdU6iXV9rwlMLFRhQIgSYf/uoUtG1bD
         K1Sw==
X-Gm-Message-State: ACrzQf1bY9yqFHCn9IfD+RsHJWD3/Iu6ve8U+Y8y2d3LMjdBTqSWw2oI
        5aq2EZaZaSoGQxAD6MsyKxvEhk5vnVEMgg==
X-Google-Smtp-Source: AMsMyM5u34NtC56kmtPtVDooQOze8nvxFQns6FwRrFzyMWrMso3kKXBghIuojuA3pYdC+oFKJ3cRyg==
X-Received: by 2002:a05:622a:43:b0:39c:eb15:c2ee with SMTP id y3-20020a05622a004300b0039ceb15c2eemr5216228qtw.331.1666033762340;
        Mon, 17 Oct 2022 12:09:22 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b006ecdfcf9d81sm398512qkg.84.2022.10.17.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/16] btrfs: push printk index code into their respective helpers
Date:   Mon, 17 Oct 2022 15:09:02 -0400
Message-Id: <fd6038b09212dc525d665e54f13a6c3b52f60d58.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
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
 fs/btrfs/messages.h | 31 ++-----------------------------
 fs/btrfs/super.c    | 12 +++++++++++-
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 72fce96cbd77..2834f674848d 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -3,7 +3,7 @@
 #ifndef BTRFS_MESSAGES_H
 #define BTRFS_MESSAGES_H
 
-#include <linux/printk.h>
+#include <linux/types.h>
 
 struct btrfs_fs_info;
 struct btrfs_trans_handle;
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
index 147af57caad1..6d67d7ae99e9 100644
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

