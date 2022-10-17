Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3236D6016F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJQTJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJQTJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:30 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F24302
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o22so7271123qkl.8
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bngDR4Esrcd105XqTFg2hcvSyaAzoUZZNh5ZOTsyytU=;
        b=ETFtuqyz1SbTYyJ3KqNah0I6uncfST/KNy3KnDjp10bNLoDoq7iJijL+GBppltwORE
         pg1k2QDHwTn+dmN3DjylCMrFXDNEcqzB6LUGQtzABAJZJVTnNQuqaVFyFDX5IMgRXMYm
         RndnU+pm+XknB/VJpdt9OjkN6J0ZqDFysUuKi0Tfk82nn8SyJH9PJII03MfUS/Hd5AiF
         blxcsGtwssX37o2f9wZH/WlVNGpNfFa3mmxbb+ovJOIt4tVr9M2/Eh4UX5irhlBGtTyC
         Nv247zCk+uLMGRhIIYHZZknbf9GSaJw91l685PikyPHmwDIPisRn3fAJMAGvYHx3kKBw
         D3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bngDR4Esrcd105XqTFg2hcvSyaAzoUZZNh5ZOTsyytU=;
        b=B7TAR3CfoN9OE8nwOd0/1dRU8SBZ8Tz9L9Ux5LMHudBPyYISBllvVst55Ya02lqg28
         W04aXYuj8JSrQgmkl/bJT9xVvQqNmwzkNt3Ty/9IApmSIBH78QrsqkcAOI4Ek8XbuC0N
         rznU09Z/IHHFH1oE4IX7Pbf1Ko/7RUpov+hQbPu4zzipe6wrcHhegyx83U/XIY0zyfif
         riFJgjGwUJwz1YEcg4EWiGdQ+yP9JaJtvfakCY1OFiWaBozoJ0RdoJ0uY/bVjh5xOzgv
         3NBGEesVeRaCB8PkCteL5VjaXLZb7L5Qpw6xz9fVwoOFnsm0rMuU/TahAKpgetpTIpsc
         wGvg==
X-Gm-Message-State: ACrzQf2XV2spi8G3UnqvtSRkIAGSKmknoMQBW6NsLKPIzmk60RqfcQmw
        LcoX9pkmK7/UN7Rnln8Fi+mbEjSAnWXKDA==
X-Google-Smtp-Source: AMsMyM5jJt1ArHbIq7W7I4w8TyGXDyhpi4esHvpvYLJpJrTn0xmjN2HzDp0cXfTsYLlcqPT8K79bYg==
X-Received: by 2002:a05:620a:44c7:b0:6ee:cdc4:bb57 with SMTP id y7-20020a05620a44c700b006eecdc4bb57mr8683891qkp.552.1666033760998;
        Mon, 17 Oct 2022 12:09:20 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bm2-20020a05620a198200b006ce7d9dea7asm490482qkb.13.2022.10.17.12.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/16] btrfs: move assert and error helpers out of messages.h
Date:   Mon, 17 Oct 2022 15:09:01 -0400
Message-Id: <c2a1a41d986d76af2e25e8f3b29d7b9295bf98d6.1666033501.git.josef@toxicpanda.com>
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

These helpers call functions that aren't defined inside of
messages.h, move them into super.c where the rest of the helpers
exist.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/messages.h | 26 +++++---------------------
 fs/btrfs/super.c    | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index e4bf08d4fd54..72fce96cbd77 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -4,7 +4,6 @@
 #define BTRFS_MESSAGES_H
 
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
@@ -261,9 +248,6 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
  * will panic().  Otherwise we BUG() here.
  */
 #define btrfs_panic(fs_info, errno, fmt, args...)			\
-do {									\
-	__btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args);	\
-	BUG();								\
-} while (0)
+	__btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args)
 
 #endif /* BTRFS_MESSAGES_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6fdcb4104dc2..147af57caad1 100644
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
@@ -389,7 +403,7 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 	btrfs_crit(fs_info, "panic in %s:%d: %pV (errno=%d %s)",
 		   function, line, &vaf, errno, errstr);
 	va_end(args);
-	/* Caller calls BUG() */
+	BUG();
 }
 
 static void btrfs_put_super(struct super_block *sb)
-- 
2.26.3

