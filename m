Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104B604A1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiJSO56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiJSO5g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:36 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB831057D0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 8so10839937qka.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voTr2GO8SVnCSnxDAlFLbVK0GmHiQc9snb4mEd4kVyw=;
        b=gi/KS/0HHolirtfdlWH59mrtBZnP2BqrnDRVphSxpFuTv1Qrok7TflVfLTpa1n5uQo
         0vl/akY5BPeB9hA/OyOF5fbHw0R97HBr1aQhJ2rCjIfPrbgF0KHO9dTAP0mWxVa6Nysx
         CWKoo8dC8U31Oph0ayiyo6qlgZ+FQmIlz2jwsBGOc5jDiV+m3i407VV7UGcTMpcqcgqS
         1yfWZKFXwi/BBSNQ3w499crmiVohc/2jHG6ZphJ2ANv2fu1uQkxhQeQqWCwwvEHvG2Fm
         7qpZEP/FvlDXNCVq+1lpFyTVGwIOsHGZ2V3fVPCUXbC3azdYnIff2TNEjvc1xnxdgVA1
         TNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voTr2GO8SVnCSnxDAlFLbVK0GmHiQc9snb4mEd4kVyw=;
        b=6SqFOHmmhhvN3yyDEKzpC6+cWldZ1xWEE9qG6+00Fa4LzlPc/XF798qgFt+sHuWAWY
         qrGHAuI/AZob0LfRGJYlSIc5l5/a7xEZBE1juBDtQHzzgyrJaj0q9f+Rfwba5V38RPTf
         28gjnK96yTIpjxx6RACoe2TWOzuO7GzZzioalsyEvgIe2iFRI7tgrK7kvH7CcCTXo3TE
         vIh9PYOG2S7nzfnJnV4t/5IhoM6aBw4GEf89sobG4oFCJ57xDTBZbv41aANnNYqdLdds
         av2vXu33UwyuLAqoWrhTWPhQxMELlQCZO0XYQ+8Kxi1bzrkCwyu9GMlHybR1P9lg4wKe
         1TDw==
X-Gm-Message-State: ACrzQf1ZmZ/Nb+pauarzXV7K33kC9afs4ykgHHc4ZnbdUkVGOJnj7aDx
        wviWW1nI7glP4vUocI2l3mxo5AA7NHg4sw==
X-Google-Smtp-Source: AMsMyM4h6fWaZ6mQbDrRmFr6xoTJ7ex4of+17zdenPKw5GwgIWjjt4Qidmstsf8ECrRbx3YCsQRlpQ==
X-Received: by 2002:a37:b2c5:0:b0:6df:f8d6:6ea0 with SMTP id b188-20020a37b2c5000000b006dff8d66ea0mr5801860qkf.386.1666191065229;
        Wed, 19 Oct 2022 07:51:05 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id cq10-20020a05622a424a00b0035cf0f50d7csm4176104qtb.52.2022.10.19.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 02/15] btrfs: move assert helpers out of ctree.h
Date:   Wed, 19 Oct 2022 10:50:48 -0400
Message-Id: <d89ffe6bc0dd3fa90d5567a9a790a00acbf3d1e9.1666190849.git.josef@toxicpanda.com>
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

These call functions that aren't defined in, or will be moved out of,
ctree.h  Move them to super.c where the other assert/error message code
is defined.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 18 +++---------------
 fs/btrfs/super.c | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 52987ee61c72..c97a02a81517 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3320,18 +3320,11 @@ do {								\
 } while (0)
 
 #ifdef CONFIG_BTRFS_ASSERT
-__cold __noreturn
-static inline void assertfail(const char *expr, const char *file, int line)
-{
-	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
-	BUG();
-}
+void __cold btrfs_assertfail(const char *expr, const char *file, int line);
 
 #define ASSERT(expr)						\
-	(likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
-
+	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
 #else
-static inline void assertfail(const char *expr, const char* file, int line) { }
 #define ASSERT(expr)	(void)(expr)
 #endif
 
@@ -3391,12 +3384,7 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 #define EXPORT_FOR_TESTS
 #endif
 
-__cold
-static inline void btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
-{
-	btrfs_err(fs_info,
-"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
-}
+void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info);
 
 __printf(5, 6)
 __cold
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ebd59dc448dd..9aa14ac3a7ff 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -306,6 +306,20 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
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
-- 
2.26.3

