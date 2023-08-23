Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0B785AA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjHWOdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjHWOdn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:43 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED5E5F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7225259f52so5632873276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801220; x=1693406020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBf1nGxn9VxkTM3VNbcdt8zSGbcHJ2jgNvEYTlFSjtM=;
        b=wa7Fw8aSzrgGQOXy1gQVcpbZtnr3VP3x5aHkJ61cIBOwUJhUTLWmtos/JvsXnpmQqr
         EvyTuza8MU2YZqPv2r0qGyFPpFlQeUlFTXwkUZtVe+OAotbnzPaK/DQLZEtf9GJybqk8
         8ju38DCDrwSIY7pWkVXI2rxYX0vR/EMfExiZ9SNt9MS+Xvj9aGzziHK13XPjDwqZ9cvN
         pmB2l78CzjJQ0XJF433UDRG/rfCRmAqW/W3Or1bs4PjNnM8K3mKHbwPI6UfQjfnkTzTJ
         daIABTZET8jMmKkv/jq9JB5JEK8b4mk0ooaF8QgPFuGoM7DHoG8Ws/Z18dsX4iqI8Vep
         9drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801220; x=1693406020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBf1nGxn9VxkTM3VNbcdt8zSGbcHJ2jgNvEYTlFSjtM=;
        b=B+Erkw/p/BaAIv70eJY1Vv4T1SEGdBvF2wongGYz5N74WInyYcohdFcoIx9hWRo1el
         DwV9BWy6R+2hR56QymY0dQ3qBW4SedhsOvQluHSq0D51bE4xKZoAg2NFZkZ9vFAhKBZR
         X9l6VACJ7VZ/G5UNeuMXju4cF/cjd2Y78TNtW7tRCqBCSYegsTBM75gRtVh8g/YAZICJ
         PEg/5nj/UnubC97dddrydfqN7HNV00g6L1/aQli+eq3bZyQ5Zje2NM//hr0pWkTZwgD4
         mulXHwrx+GXyXBgVttwxkigRKUYuis9WLDwczdE1K53uRbeC3JbCAqytZgne8twRqjXC
         waRg==
X-Gm-Message-State: AOJu0Yxer82i2dD0wFa7yP679KHwBMy8WuhNusdCdWfa8S1UhkrE6zRN
        CW5z2jgzgDj1RrTxFVaph9UHizJBbSvJPQUSWGs=
X-Google-Smtp-Source: AGHT+IHjUcs4ooo10HL86bg7P2LytYH40a6oXD2Vbxb3JVAsSOhAlaL81vp6VZOcJF5N8UIP30cGNA==
X-Received: by 2002:a25:b208:0:b0:d49:4869:1bd1 with SMTP id i8-20020a25b208000000b00d4948691bd1mr11276442ybj.6.1692801220616;
        Wed, 23 Aug 2023 07:33:40 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 203-20020a2501d4000000b00d4fc4132653sm2852195ybb.11.2023.08.23.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 27/38] btrfs-progs: add commit_root_sem to btrfs_fs_info
Date:   Wed, 23 Aug 2023 10:32:53 -0400
Message-ID: <c9846fce420a83114423ee84cd82e0987d95a54c.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is used in ctree.c around getting the old root, add this to our
btrfs_fs_info to make it more straightforward to sync ctree.c into
btrfs-progs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h   | 1 +
 kernel-shared/disk-io.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 6ceae3e9..2f6a0cab 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -325,6 +325,7 @@ struct btrfs_fs_info {
 	struct extent_io_tree *excluded_extents;
 
 	spinlock_t trans_lock;
+	struct rw_semaphore commit_root_sem;
 
 	struct rb_root block_group_cache_tree;
 	/* logical->physical extent mapping */
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4f87b6fb..092b54af 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -871,6 +871,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	INIT_LIST_HEAD(&fs_info->recow_ebs);
 
 	spin_lock_init(&fs_info->trans_lock);
+	init_rwsem(&fs_info->commit_root_sem);
 
 	if (!writable)
 		fs_info->readonly = 1;
-- 
2.41.0

