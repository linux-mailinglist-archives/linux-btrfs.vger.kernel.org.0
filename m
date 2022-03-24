Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08294E6AFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 00:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346914AbiCXXGO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 19:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbiCXXGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 19:06:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA807BB08B
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 16:04:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bc27so5016427pgb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2PEw7wMWxJDaP6A1hYmFPFOgTZxEsbHC5buvVLZg/8=;
        b=J6NTmXhYtbONxfBf3fCZWW4oYHbEobf1oLz3KMQDOBX6UHq9GNM1W6l+feGYDG3zSW
         dGBOWWGJE2aVJcDX9+6DZasOUl0rv8SriaaTJgFU1dorler/zc2wvKITu3gYMkS2vq2U
         l3dqSLwLdx1dLlTfHZEadlcW6lYJlmZoHZoy1TpDcpd0zlbdCs9sRQSGWlxoUXwRGZuC
         9SCl8n3OH0QzuzrpCKvXunZJSvZhE2qmEFdNWQ7emijeEtQNDECe41KrKcaF4EB/MUBB
         atSUN6PLdh/wkELjsMlbXxK+BxC5+F4ZQXD+hMAjETll+0zN+hSf93aAyrrwK5PmI0Lk
         p3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2PEw7wMWxJDaP6A1hYmFPFOgTZxEsbHC5buvVLZg/8=;
        b=2+peXe0TYZVRA3457V0QTLN78Np+Q+KNwgL1EeNJ6Nj6f70ZvcqSlXGY9ZGuS9bhIv
         TYnfP1866S5JaFvt66PYnTaXC7UHnmTfKLIHSciEb3/MkmLGgw2kdCzYMq8tCyqUUEye
         vzv+mC98P3M45tgGIvva1D7Ba5trAiyeBxGALAsKQhyEmW6D+45DyrwRcNGGw+OjuKKw
         eh9YZT9RMjf8/8Qu/5zNGX+0w44AN72UzbA3cRHtK3MNSop8OFMGOVgtYvHVJqOnC9oF
         wEomss8bSUygd9rkzzGCwwkNrwHamxozGEY0ovwUShSJ+1LJeWElXAKP3oetaYH6+VR+
         47fQ==
X-Gm-Message-State: AOAM5327jN4GmfDSImbiwrNHo0+kaluFAfLoJz3OQWCEYlCg0Eb/SsAx
        yWQ7dLh4Y9G9u5FGDUqqZPiBRVZC+7/uZ5gJ
X-Google-Smtp-Source: ABdhPJxTUgF/5ZZT3NYVtGeyGWjLrqCCD1pASqGKuVwQnfPeHEOOmJot7G6Xsbqx2MxRRDayeTl7+Q==
X-Received: by 2002:a65:424a:0:b0:375:6d8b:8d44 with SMTP id d10-20020a65424a000000b003756d8b8d44mr5830161pgq.170.1648163080101;
        Thu, 24 Mar 2022 16:04:40 -0700 (PDT)
Received: from banyan.jof.github.beta.tailscale.net (192-184-176-137.fiber.dynamic.sonic.net. [192.184.176.137])
        by smtp.gmail.com with ESMTPSA id d80-20020a621d53000000b004fae1119955sm4435275pfd.213.2022.03.24.16.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:04:39 -0700 (PDT)
From:   Jonathan Lassoff <jof@thejof.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.cz>,
        Jonathan Lassoff <jof@thejof.com>
Subject: [PATCH v2] Add Btrfs messages to printk index
Date:   Thu, 24 Mar 2022 16:04:17 -0700
Message-Id: <b16ccc0d48d9a25fd001f57eaeb3066055ac17a4.1648162972.git.jof@thejof.com>
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

PATCH v1
  - Fix conditional: CONFIG_PRINTK should be CONFIG_PRINTK_INDEX
  - Fix whitespace
PATCH v2 -- Minimize the btrfs ctree.h changes

Signed-off-by: Jonathan Lassoff <jof@thejof.com>
---
 fs/btrfs/ctree.h | 32 +++++++++++++++++++++++++++-----
 fs/btrfs/super.c |  6 +++---
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ebb2d109e8bb..2d5c14003a2f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3343,10 +3343,21 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 {
 }
 
-#ifdef CONFIG_PRINTK
+#ifdef CONFIG_PRINTK_INDEX
+#define btrfs_printk(fs_info, fmt, args...)				\
+do {									\
+	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);\
+	_btrfs_printk(fs_info, fmt, ##args);				\
+} while (0)
+__printf(2, 3)
+__cold
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+#elif defined(CONFIG_PRINTK)
+#define btrfs_printk(fs_info, fmt, args...) \
+	_btrfs_printk(fs_info, fmt, ##args)
 __printf(2, 3)
 __cold
-void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 #else
 #define btrfs_printk(fs_info, fmt, args...) \
 	btrfs_no_printk(fs_info, fmt, ##args)
@@ -3598,11 +3609,22 @@ do {								\
 				  __LINE__, (errno));		\
 } while (0)
 
+#ifdef CONFIG_PRINTK_INDEX
 #define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
-do {								\
-	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,	\
-			  (errno), fmt, ##args);		\
+do {									\
+	printk_index_subsys_emit(					\
+		"BTRFS: error (device %s) in %s:%d: errno=%d %s",	\
+		KERN_CRIT, fmt);				\
+	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
+			  (errno), fmt, ##args);			\
+} while (0)
+#else
+#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
+do {									\
+	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
+			  (errno), fmt, ##args);			\
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

