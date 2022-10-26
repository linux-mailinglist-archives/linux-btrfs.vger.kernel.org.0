Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB9260E8CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiJZTMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiJZTLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8DB4B4A2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m6so11383487qkm.4
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ga2ZbH1YBunIIF8UNC0ceuxZs/EcOV1ypPtAbo8D48=;
        b=HaNCY0/DGyoTSAXgMtPhscFENMnm1aKcsqfyH3Lcxm2T2qw98B+mVwOm45FUNWIPv+
         iF+hvnsrDznDoXd0rngH+L6ezelM1C5zP9eM1+C1C8jthgvA/yPmD88G2LVuxe+p0Ras
         b1Mc388Ynni6kiMZYGheXPWwB9nkXc4NrpjAPbsA0y482M6ftBUEdxCYlzb3l8rOwr3C
         r8gQJFsSczb/piGH5AKOlmtB8cNcWzxbr1aqwCMq4qCTp95UvnnGZU9b5bFlkSS1GWcz
         2N4IBOIJy2WUVqOQTc4TdSIRWHJa0dPAQpHc2A3rFyn1wB2JYK3OEQ8JuuwDXyL6upmj
         zqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ga2ZbH1YBunIIF8UNC0ceuxZs/EcOV1ypPtAbo8D48=;
        b=aeHxhSFO1TE0ztV+pAnle2CyrJm5y8BPz6VAfGcZPKzcpOhxIHC3hqjM336uafCWKP
         SWcwN9PU+Bvc48HW59XreMiKQydqApAQkgFxLuESAgBMsdV91EFGsHs+we94iu5f5phg
         WXnk7HI5X00Er3BQlScxGNBSEF413UkK9Wd9erY4Nit7LY8rf7mFNT4S1TX06/PTR+Jz
         ypJ8lYzJ/VH7mHhh+FmuSPEFCfqEoLgT3xA0IQ6bXELQE+aeOs97DGoDgMndGvEEFZvV
         N5FoqiAXWHnmNB1MiDEDeiz+JJZRKmK1hGjwyPgGV7ZaTu1k0Y2Ov3DKNX/4e9zaVqXM
         X8+Q==
X-Gm-Message-State: ACrzQf3WyCH3FD+ePS3Yj8bps9iKUs54PoLQKdrZvJxnO5g0KTY94MTP
        4cxkQtrQPb5Qa8chYh5CpMXpIzAv0lZtmA==
X-Google-Smtp-Source: AMsMyM7viC5BtmlQm98EZCBJ6Cj6WDtcL/k94gubL5VVrmO1LVprQtMZpEkpzMcQYqJLrrdmNTFI5g==
X-Received: by 2002:a05:620a:439b:b0:6f8:e1b0:e06d with SMTP id a27-20020a05620a439b00b006f8e1b0e06dmr3996523qkp.629.1666811356232;
        Wed, 26 Oct 2022 12:09:16 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l2-20020a05620a28c200b006e8f8ca8287sm4500199qkp.120.2022.10.26.12.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/26] btrfs: move CONFIG_BTRFS_FS_RUN_SANITY_TESTS checks to fs.h
Date:   Wed, 26 Oct 2022 15:08:38 -0400
Message-Id: <0ff1ac879d15f46afe7cbb515423a7046db1830f.1666811039.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
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

We already have a few of these in fs.h, move the remaining checks out of
ctree.h into fs.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 15 ---------------
 fs/btrfs/fs.h    | 10 +++++++++-
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 15bb90536460..27bfedf3a9fb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -722,16 +722,6 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 	return offset >> PAGE_SHIFT;
 }
 
-/*
- * Use that for functions that are conditionally exported for sanity tests but
- * otherwise static
- */
-#ifndef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-#define EXPORT_FOR_TESTS static
-#else
-#define EXPORT_FOR_TESTS
-#endif
-
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
@@ -741,11 +731,6 @@ static inline int is_fstree(u64 rootid)
 	return 0;
 }
 
-/* Sanity test specific functions */
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-void btrfs_test_destroy_inode(struct inode *inode);
-#endif
-
 static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 {
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f6e70c2b0c82..98efca140435 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -975,15 +975,23 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 			   &(fs_info)->fs_state)))
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+
+#define EXPORT_FOR_TESTS
+
 static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
 {
 	return test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
 }
+
+void btrfs_test_destroy_inode(struct inode *inode);
 #else
+
+#define EXPORT_FOR_TESTS static
+
 static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
 {
 	return 0;
 }
-#endif
+#endif /* CONFIG_BTRFS_FS_RUN_SANITY_TESTS */
 
 #endif
-- 
2.26.3

