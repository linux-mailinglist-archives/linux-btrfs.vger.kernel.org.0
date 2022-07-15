Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC05767A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiGOTpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGOTpe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:34 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76B61723
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:33 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r17so4532722qtx.6
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3c2liFqiUTLj/7c9QXj7muzA6VTKrrRDMy8LKzdfPMY=;
        b=5GB5k6zLzmMrbusoVa+6cvlmdMZKtJ/0tBqaQIylHOtulOKiWOxQ0E2sCgBA/s9hMu
         NAqip9RdlcwYB+lCJatB45hT/34eBqZyuKq9y+8xG/7dOy+Wm0YiVfimXZh4wj6tdG9u
         YXroQIps5QIquMtUvYMX/e2trV6UOb+Zud7Wk5IO9XN7AZZCrk1ncyeB/X3V3y9qpz/Y
         0SPpks5R/LwS7V/qIDXydDeL05mERbU2RleUAofhxCNM7gnWyse7VEVslNUfgOSZ+NXi
         GvPBeW9NVepW8stzltt8saD0UTAy2amjHEm536Anlw0OtHMZu54KFQ1+cPQOERCtlJ0i
         gdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3c2liFqiUTLj/7c9QXj7muzA6VTKrrRDMy8LKzdfPMY=;
        b=afXqTxfIWecfbgvQzm6+tFxNoVnrMSNSYZDT6tCsjp1X0899V2PbEdIrisn3Op+jbH
         B8pRZf+M63K6zizTwReAjuGenUcF5XUWIVxPPO7Q9SO4d5Fttn87Hrx8Y9HmCPx7SMVe
         ZI6CXzZqWPBvvpyndjP+I1ju1p7CFsB862zr/X+AvmtPlpJVgRtQxsmmGfWbsKZDFEIN
         UdKvl8DGoqBRiXHJ9BNa0tGMfvmokR2KAfUrqim/MLbnzErWSD2kxL7/+BGmPT6Nr+8f
         n2lLImIrMb1k1ySI/XSwMnUbvK1RJVzwjeo6IcFQiaHv/SIMNGbGiYYrKltITOIZjE8E
         WjRA==
X-Gm-Message-State: AJIora/CZT5VFgOOjMvfJxDYR6tQatziHNX+Rqv8/HNnd+YBAW6bt+iN
        Nf2v3asfZl2JCwQf+zlqOM/9KnBTYuZpxw==
X-Google-Smtp-Source: AGRyM1uQkyQm+KtnbYaj6NhLjqYFSLqROUiTesQEsKJ1PzKLQiFRU5hJcawZ+ahsx/QKHhlEIWc6zA==
X-Received: by 2002:a05:622a:1802:b0:31e:af62:5701 with SMTP id t2-20020a05622a180200b0031eaf625701mr13468175qtc.327.1657914332136;
        Fri, 15 Jul 2022 12:45:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a295200b006af0ce13499sm5012897qkp.115.2022.07.15.12.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/9] btrfs: use btrfs_fs_closing for background bg work
Date:   Fri, 15 Jul 2022 15:45:21 -0400
Message-Id: <229802bd630b15eab2029c1b33915c6d6fcc1ffe.1657914198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657914198.git.josef@toxicpanda.com>
References: <cover.1657914198.git.josef@toxicpanda.com>
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

For both the deletion of unused block groups and the async balance work
we'll only skip running if we don't have BTRFS_FS_OPEN set, however
during teardown we park the cleaner kthread and cancel the reclaim work
right away, effectively stopping the work from running.

Fix the condition to bail if btrfs_fs_closing() is true instead of if
!BTRFS_FS_OPEN, which is cleared much further in the process.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c3aecfb0a71d..1e61d967d8be 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1318,7 +1318,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	const bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
 	int ret = 0;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (btrfs_fs_closing(fs_info))
 		return;
 
 	/*
@@ -1557,7 +1557,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (btrfs_fs_closing(fs_info))
 		return;
 
 	if (!btrfs_should_reclaim(fs_info))
-- 
2.26.3

