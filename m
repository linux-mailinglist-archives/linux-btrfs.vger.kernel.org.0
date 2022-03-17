Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1501C4DBE95
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 06:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiCQFn7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 01:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCQFn6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 01:43:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF15E886C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 22:13:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso374203pjb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gG0FA13sGmpIrJJjd67FlvXdhhK6l9woGsFobs+hR+M=;
        b=w/uoDBarwqg0Br4mJOmiatfyHg7zYPf2bnLLwfeHwXX1rEt1cLEp2R9/OZfe43kLBN
         FhBzlSbl1lGtHrU/noiX0sR5UjpVxwA6Crsu72FZmD2hkrAFnVyHhiEwJQI2XrvirLa4
         c4+CQbJzHvXlJJUomAitqLzh8Vn02AdY9ieusSkdmYjoIh1koB/pNEA3ne6w+P9fhZEB
         TwZjx11bz6mYUD5IyC2zqrp46quDFFmrgxy6+71l2K9etvMMGQuH2i1KoNM1qHtjYhVq
         phCF+j++6fMQdy/bgWfFMYPKCodMI0BOsRuoZFypa9U64vewivzWuOyMeuwx2zZ/iXXz
         aOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gG0FA13sGmpIrJJjd67FlvXdhhK6l9woGsFobs+hR+M=;
        b=Hi9E7TybsICuUQU6syObMzo280GU7iYCtkz8ZhhJGBvSsLAAX6jw0yFNEzPR7s140c
         eHgXOU0FL5lPkegGA5Gufkxb3LH6ZV387eccEnzhEsjvcdm66ArlKE2L4rEHuL7HVB6e
         OQ2QmksoXG/Q3FOV8MjMb8N8crbI3ODdberqeGUJjcu3fyj0wgW7g77m699iihWwsNeW
         8/c2DBUOp5xnQsk+xrbND0irolaM1jGyn/ZK8KqVgtDy8JeVT26qNGhHusI6o+U3+0iP
         KJFx0cMKwZFmxzTxZAjWCmrqjSROg5RomfdR4x2V9dfnJ+yehiK72E03uPxiPx1U1Oba
         1z+Q==
X-Gm-Message-State: AOAM533P908n26yKCmkQTt0PjUvtNWm7UJDkae2HBGIm1MB4xTlr7bwc
        9r8GOyUuk0lj0bGQ995JIDF8K6M2sbWkzDUA0DNQdg==
X-Google-Smtp-Source: ABdhPJzm/4aHK6/2nLW93YbGpaLsr/9DcHeZ9Scy5pdiwvAU5s/SC8r17VrCSRFOcAfcz+Zdq2ewEg==
X-Received: by 2002:a17:903:2342:b0:152:249:ea71 with SMTP id c2-20020a170903234200b001520249ea71mr3371317plh.129.1647494023285;
        Wed, 16 Mar 2022 22:13:43 -0700 (PDT)
Received: from banyan.jof.github.beta.tailscale.net ([2600:1700:2f74:11f:a6ae:11ff:fe14:a442])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a00190f00b004f7e6d14bc2sm5339057pfi.86.2022.03.16.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 22:13:42 -0700 (PDT)
From:   Jonathan Lassoff <jof@thejof.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Jonathan Lassoff <jof@thejof.com>
Subject: [PATCH v0 0/1] Add Btrfs messages to printk index
Date:   Wed, 16 Mar 2022 22:13:35 -0700
Message-Id: <fe7dcb58ac812fb6c37a92a1f74a42890c8c0bc8.1647493897.git.jof@thejof.com>
X-Mailer: git-send-email 2.35.1
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

In order for end users to quickly react to new issues that come up in
production, it is proving useful to leverage this printk indexing system. This
printk index enables kernel developers to use calls to printk() with changable
ad-hoc format strings, while still enabling end users to detect changes and
develop a semi-stable interface for detecting and parsing these messages.

So that detailed Btrfs messages are captured by this printk index, this patch
wraps btrfs_printk and btrfs_handle_fs_error with macros.

Signed-off-by: Jonathan Lassoff <jof@thejof.com>
---
 fs/btrfs/ctree.h | 28 ++++++++++++++++++++++++++--
 fs/btrfs/super.c |  6 +++---
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ebb2d109e8bb..cc768f71d0a5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3344,9 +3344,22 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 }
 
 #ifdef CONFIG_PRINTK
+#define btrfs_printk(fs_info, fmt, args...)                          \
+do {                                                                 \
+	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt); \
+	_btrfs_printk(fs_info, fmt, ##args);                             \
+} while (0)
 __printf(2, 3)
 __cold
-void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+#elif defined(CONFIG_PRINTK)
+#define btrfs_printk(fs_info, fmt, args...)                          \
+do {                                                                 \
+	_btrfs_printk(fs_info, fmt, ##args);                             \
+} while (0)
+__printf(2, 3)
+__cold
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 #else
 #define btrfs_printk(fs_info, fmt, args...) \
 	btrfs_no_printk(fs_info, fmt, ##args)
@@ -3598,11 +3611,22 @@ do {								\
 				  __LINE__, (errno));		\
 } while (0)
 
+#ifdef CONFIG_PRINTK
+#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)  \
+do {								                         \
+	printk_index_subsys_emit(                                \
+		"BTRFS: error (device %s) in %s:%d: errno=%d %s",    \
+		KERN_CRIT, fmt, ##args);                             \
+	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,	 \
+			  (errno), fmt, ##args);		                 \
+} while (0)
+#else
 #define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
-do {								\
+do {								                            \
 	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,	\
 			  (errno), fmt, ##args);		\
 } while (0)
+#endif
 
 #define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
 						   &(fs_info)->fs_state)))
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4d947ba32da9..4eff3e20f55a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -213,7 +213,7 @@ static struct ratelimit_state printk_limits[] = {
 	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100),
 };
 
-void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 {
 	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
 	struct va_format vaf;
@@ -241,10 +241,10 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
 
 	if (__ratelimit(ratelimit)) {
 		if (fs_info)
-			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
+			_printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
 				fs_info->sb->s_id, &vaf);
 		else
-			printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
+			_printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
 	}
 
 	va_end(args);
-- 
2.35.1

