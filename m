Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A925B8E12
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiINRSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiINRSc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:32 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BF816B6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:31 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k12so11384370qkj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=VlVSxudB9Fr0L74MAkJhjQ5LhuPeA6JWryoMNYxFSU8=;
        b=rG0LKRTS1oUchlRmQKXVjDI398ElcHbBQ5qnCaJiv2tmmjgmoOWDgm62LboEUBjq8i
         ZvH5LfiRmODocS+9UZxvxwFzzXl+oKpFw126x4HI2PBLLDUb8DSIMxQxwPx2ddYGKvob
         xnOE6zg7g5dtMxw8dOUDWTshOIQiwFgbPBt022ibIwjG/V1tocAW9LF7iDBtjraK+mCi
         Z2ZBIYK3y++qBJSZ8Iprdx74wuIv/V/OIAYIN8PMGaUtNZzAUN2NPa9PApB3xFKMDHCr
         Ya731qsuh8syA1nz5VGNUw32DjJCh2MD4NMYEixjms+VV34aLKdTbz2/I2mxMBoUQc98
         aNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VlVSxudB9Fr0L74MAkJhjQ5LhuPeA6JWryoMNYxFSU8=;
        b=zHjWRvMsJ8ezXkR4TZjZYMYFviSVS9N4Dz1Q7KZafpBa0K1kcOylcaXzZGu7T/AZyI
         2Y9J7b2gyR2Kagw3penbOKPnmT4LiefPVqJJ/4vk42t4wUthebZ5bIuK4qcHbB7ZG1oF
         94uZmL4MvEIr613y4uESx8tDU5l72IjF5oTB3K5+hugw73RPJNMIwwPQLfYdMOHwzqP1
         HKxYkftAHAyUx40gmWYGER1k0EJ6P8fvpuVikTr7sBsBPPpay6eaknZ//+sKm3BKl/x4
         S9Lv+itAvvA62PnW/h2G8pLE8qeJwapFuJu7YWpZ2Dhgfcb6jm6K0SmdRw41MPh3MF8o
         113g==
X-Gm-Message-State: ACgBeo1gOH8plSzfh/VMPUK7HbccP3mp/IXsROW3HtQkAKULfDojCKI6
        C8eB3cA0gzgVyxd93nZvzMRghmOIuOtBRg==
X-Google-Smtp-Source: AA6agR7MHv7K/tG9K8oJhgI1xLohFE6HPT/X9D0fUDp7JlMT5IUcLx91MOl/o0LqhWl/PQAW7RWxzQ==
X-Received: by 2002:a05:620a:472b:b0:6ce:6189:74f5 with SMTP id bs43-20020a05620a472b00b006ce618974f5mr7391608qkb.455.1663175910339;
        Wed, 14 Sep 2022 10:18:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l2-20020a37f902000000b006b9c355ed75sm2148843qkj.70.2022.09.14.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/16] btrfs: move assert and error helpers out of btrfs-printk.h
Date:   Wed, 14 Sep 2022 13:18:10 -0400
Message-Id: <c4f2113c748ba79e0e0b19da6fa5bca14b3d14ca.1663175597.git.josef@toxicpanda.com>
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

These helpers call functions that aren't defined inside of
btrfs-printk.h, move them into super.c where the rest of the helpers
exist.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs-printk.h | 26 +++++---------------------
 fs/btrfs/super.c        | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/btrfs-printk.h b/fs/btrfs/btrfs-printk.h
index 7fd7c547c935..87e46d24b4ad 100644
--- a/fs/btrfs/btrfs-printk.h
+++ b/fs/btrfs/btrfs-printk.h
@@ -4,7 +4,6 @@
 #define BTRFS_PRINTK_H
 
 #include <linux/printk.h>
-#include <asm/bug.h>
 
 struct btrfs_fs_info;
 struct btrfs_trans_handle;
@@ -174,27 +173,15 @@ do {								\
 } while (0)
 
 #ifdef CONFIG_BTRFS_ASSERT
-__cold __noreturn
-static inline void assertfail(const char *expr, const char *file, int line)
-{
-	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
-	BUG();
-}
-
+__cold
+void btrfs_assertfail(const char *expr, const char *file, int line);
 #define ASSERT(expr)						\
-	(likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
-
+	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
 #else
-static inline void assertfail(const char *expr, const char* file, int line) { }
 #define ASSERT(expr)	(void)(expr)
 #endif
 
-__cold
-static inline void btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
-{
-	btrfs_err(fs_info,
-"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
-}
+__cold void btrfs_print_v0_err(struct btrfs_fs_info *fs_info);
 
 __printf(5, 6)
 __cold
@@ -243,9 +230,6 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
  * will panic().  Otherwise we BUG() here.
  */
 #define btrfs_panic(fs_info, errno, fmt, args...)			\
-do {									\
-	__btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args);	\
-	BUG();								\
-} while (0)
+	__btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args)
 
 #endif /* BTRFS_PRINTK_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6d5e161d94e1..781e5faf83d5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -307,6 +307,20 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 }
 #endif
 
+#ifdef CONFIG_BTRFS_ASSERT
+void __cold btrfs_assertfail(const char *expr, const char *file, int line)
+{
+	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
+	BUG();
+}
+#endif
+
+void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
+{
+	btrfs_err(fs_info,
+"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
+}
+
 #if BITS_PER_LONG == 32
 void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
 {
@@ -402,7 +416,7 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 	btrfs_crit(fs_info, "panic in %s:%d: %pV (errno=%d %s)",
 		   function, line, &vaf, errno, errstr);
 	va_end(args);
-	/* Caller calls BUG() */
+	BUG();
 }
 
 static void btrfs_put_super(struct super_block *sb)
-- 
2.26.3

