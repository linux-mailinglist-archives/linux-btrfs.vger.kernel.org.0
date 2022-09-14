Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9155B8B6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiINPHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiINPHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:07:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9B77EA9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id h28so11108738qka.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=WE5yyR2/yyrY9ObqId9PLRQjaATSkEj8NZdExG30XmE=;
        b=f178a+48KCN2F2kbPvTOK8hWj9Sr8D7wZnMMLtgWHmCPI4Ey4OWRsKKLaZFR83x1RK
         fsH4n05/tAuKVGLSK/2SA074m/+JKPsew4yJ9BhNb5VmojHN6THKSvQvmzH5/KPHtloj
         dTe4I6YiURkB/1u3kf6ry5q1i+/Rd2lWyIL1A9vY8uPZjRSIRfSghBtYkOKXs4WCdXr5
         Ryj4bq4zBHqhaBh9Slben07Vto4bRHMEPUhw/i1eqvCRVkjCC0Gptx1E6pRTTfo4zfpd
         HAwp7jNFhMQ+LlZmJm+Ld5NzJFxBwbnd8rUD2zzRysClxr3v49QIWsPtEas3FB9S4MeG
         xLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WE5yyR2/yyrY9ObqId9PLRQjaATSkEj8NZdExG30XmE=;
        b=iVHRiEAejwlyKZ2+ELmkB9gN00JAeAM6RejF19Op9Tji7qy2IktU9hBcA8nIu1H2ze
         piDFMNr0EF8CzcbIzSS/m7lxDOZHKZUZI7+gdekjMnqauyMVi7VmrNkA0a7HCwmMDagT
         m2zQHM9jnNzoLs+sL60zau8bJCu2W/AKPnAjwcS8LS+PHzXPk1w6d5wY6oE4UpWDfGaN
         q9Q/BHX5bol8GCX5JjlO4fLJ48+uY+kLksDeSmAdCS9Bt8wdwnCr0MBlbdQL09l30xe1
         NOYw52a2zGIKzpBNcWDxuyCS1bk7txshUhDkyLsScn6C1SMo9d3l0mCAzum3BpE+/IPW
         66qw==
X-Gm-Message-State: ACgBeo3BF3N9S01DKXYUcSdZz7fy73t2LSvEiljJLrNjiQuQ9lLOnOG9
        OAobDEtFjF4tsu5ql7rcQ/Ok5oO+kur8HQ==
X-Google-Smtp-Source: AA6agR560Q6xCyuLClyT8YOB/szS39n0IdoRTajKz2Q6KzOzSrBt1xczdQF9oqI/DkV5UD+9nT8CaA==
X-Received: by 2002:a05:620a:1189:b0:6cb:c4ae:9057 with SMTP id b9-20020a05620a118900b006cbc4ae9057mr22640954qkk.601.1663168021345;
        Wed, 14 Sep 2022 08:07:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j22-20020ac85516000000b0035ba5af2a75sm1692340qtq.16.2022.09.14.08.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:07:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/17] btrfs: move btrfs_print_data_csum_error into inode.c
Date:   Wed, 14 Sep 2022 11:06:36 -0400
Message-Id: <95d99a944771363259f2de25de22dffd7867d127.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

This isn't used outside of inode.c, there's no reason to define it in
btrfs_inode.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h | 26 --------------------------
 fs/btrfs/inode.c       | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 108af52ba870..890c9f979a3d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -426,30 +426,4 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
-
-static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
-		u64 logical_start, u8 *csum, u8 *csum_expected, int mirror_num)
-{
-	struct btrfs_root *root = inode->root;
-	const u32 csum_size = root->fs_info->csum_size;
-
-	/* Output minus objectid, which is more meaningful */
-	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID)
-		btrfs_warn_rl(root->fs_info,
-"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
-			root->root_key.objectid, btrfs_ino(inode),
-			logical_start,
-			CSUM_FMT_VALUE(csum_size, csum),
-			CSUM_FMT_VALUE(csum_size, csum_expected),
-			mirror_num);
-	else
-		btrfs_warn_rl(root->fs_info,
-"csum failed root %llu ino %llu off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
-			root->root_key.objectid, btrfs_ino(inode),
-			logical_start,
-			CSUM_FMT_VALUE(csum_size, csum),
-			CSUM_FMT_VALUE(csum_size, csum_expected),
-			mirror_num);
-}
-
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6fde13f62c1d..998d1c7134ff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -125,6 +125,31 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 ram_bytes, int compress_type,
 				       int type);
 
+static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
+		u64 logical_start, u8 *csum, u8 *csum_expected, int mirror_num)
+{
+	struct btrfs_root *root = inode->root;
+	const u32 csum_size = root->fs_info->csum_size;
+
+	/* Output minus objectid, which is more meaningful */
+	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID)
+		btrfs_warn_rl(root->fs_info,
+"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
+			root->root_key.objectid, btrfs_ino(inode),
+			logical_start,
+			CSUM_FMT_VALUE(csum_size, csum),
+			CSUM_FMT_VALUE(csum_size, csum_expected),
+			mirror_num);
+	else
+		btrfs_warn_rl(root->fs_info,
+"csum failed root %llu ino %llu off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
+			root->root_key.objectid, btrfs_ino(inode),
+			logical_start,
+			CSUM_FMT_VALUE(csum_size, csum),
+			CSUM_FMT_VALUE(csum_size, csum_expected),
+			mirror_num);
+}
+
 /*
  * btrfs_inode_lock - lock inode i_rwsem based on arguments passed
  *
-- 
2.26.3

