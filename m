Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B085C4DCCB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiCQRqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiCQRqn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:46:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C93CEE4D9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:45:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z3so5050111plg.8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsXDDfaGeiyC46yzp6Cv85xN4j0NkrXa4CUIh7Nive0=;
        b=QZwa01DIMTTWfTp/EqC7MUWwfbAZ7YAGdlzsLH+w5cql83e66fyJOOH9t/3DInMeh6
         IpDPtCbuqCscmoW/8Mkh5lcqNwyF7Yg/9aewe6rqvuK2XKrPpR6lnqkBmy/p86bZ8b9I
         8TukPcFMFLyDA5m4Wj8chlecDanc6gUmxC2Hi1hHodAzdvf1Fd/qYNu3urvXGlDNTy+T
         3DJzYT25bAttLsf8gNOBQKUkh2jDesnbcrrNJdBDbQETfpTsQQpfjCoNzF6vSlpHMNbZ
         2yuOJVpmC7KjpKUZRDY87sXjJ6eHGKCw/Ql9w6APFHLmtymq2bdE9B7wM6930adhzalV
         9W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsXDDfaGeiyC46yzp6Cv85xN4j0NkrXa4CUIh7Nive0=;
        b=0yamUz1kHseR9HdH97qtgueKj/erUNzvG8AyAUs4NmMSN/Nq293SCx+E7VtcdnqjlB
         nlcmH41Ct0jHMRsyupcaT3TEHJaBee+tfwG9IKdfDEPiCwdPhoAcfV2OVomZL2Ns/5RN
         DGctf8HftPVWYPv512QaNH839e1dlqYFWayqY8jz5e5nHpmHlYToe8KeenF5Q+DzsS0v
         cNs9LHdqh3I3OgEN+bQM0Ds6mGaliH13VPvWAUBjvPkGP8r6txqlkj8FlkLhy6YJNKTt
         so0UXjj0V/Uc4UPqKQOl9kdOlDUDgj5qRDhsI2vv638BYMou4qcs6mDxPYcD6M83mU+U
         FPzw==
X-Gm-Message-State: AOAM532KL+za+nrc52T0nMYCmP01dw3P44VbwwvalnpUvSBgc9ZYSbUj
        keKno9LC45dn591hn/xPTOIDHSl1UN7tKHALz3GWzg==
X-Google-Smtp-Source: ABdhPJzz8geAJ5F2YTC16TVXQYRKKlAT9dFRWjbGoURrgTyh54TQ0Mgx21wYzleXDcqQy4FjJyrpbQ==
X-Received: by 2002:a17:90b:1196:b0:1c6:5474:dc39 with SMTP id gk22-20020a17090b119600b001c65474dc39mr6777901pjb.143.1647539125238;
        Thu, 17 Mar 2022 10:45:25 -0700 (PDT)
Received: from banyan.flat.jof.io ([2600:1700:2f74:11f:a6ae:11ff:fe14:a442])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b004f761a7287dsm7809343pfk.131.2022.03.17.10.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:45:24 -0700 (PDT)
From:   Jonathan Lassoff <jof@thejof.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Jonathan Lassoff <jof@thejof.com>
Subject: [PATCH v1 1/2] Add Btrfs messages to printk index
Date:   Thu, 17 Mar 2022 10:45:08 -0700
Message-Id: <957b1f70097b44c3fba4419bc96c262f720da500.1647539056.git.jof@thejof.com>
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

Signed-off-by: Jonathan Lassoff <jof@thejof.com>
---
 fs/btrfs/ctree.h | 34 +++++++++++++++++++++++++++++-----
 fs/btrfs/super.c |  6 +++---
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ebb2d109e8bb..afb860d0bf89 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3343,10 +3343,23 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
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
+#define btrfs_printk(fs_info, fmt, args...)	\
+do {						\
+	_btrfs_printk(fs_info, fmt, ##args);	\
+} while (0)
 __printf(2, 3)
 __cold
-void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 #else
 #define btrfs_printk(fs_info, fmt, args...) \
 	btrfs_no_printk(fs_info, fmt, ##args)
@@ -3598,11 +3611,22 @@ do {								\
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
+		KERN_CRIT, fmt, ##args);				\
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

