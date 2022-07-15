Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C505767AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiGOTpn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiGOTpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9655D67CA2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o26so4385786qkl.6
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pTL/gws/HcwLA59W8+SQPp3eLX0uaPOaqnwCOAGLWlE=;
        b=UcaqhzXiGx9NGtuhUDQKXIKK/r9ueEnUPRGqN/P5CRGc56K8702z+ydrwOMmuQlIqY
         dTeDbG+d8g2BO1iJYvILzlFqm4TeyUJyHGovxiO/ozZODmHyMRvErknDHtNW70+DnlzV
         +0//d/MlD4O7cgnJLuebWBpgHYKw+MrvxYXjO01g7+U60BP9usn+hrcZXiwaCyt7d1ug
         4axCu/oPW1pboYCqklOy8rwzKcVugiuLnPoOAnMV6Xqgt9hWbQQENL5dC02aUgI0tY9m
         bc3pmpOqaCfjDEiAswBGK3cWkpyWr3SOVRBz/QzW2PTpjorh6arLHb0ZVO+xAVwqjbCI
         xRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTL/gws/HcwLA59W8+SQPp3eLX0uaPOaqnwCOAGLWlE=;
        b=IzEMYwVUuQnboKN1HFD2d5cfvxPhBQ39sTsIqoKTdToCjjwnPPKq8EuhJftjpSSY3j
         zQzaJTCcIyDqq7F/SlrWWr5Wz0DQpEPySO600uWFvvrgOKZNnfVKDsiRx6I6DZbBwpFi
         t0u3/lFAA8Nxin6A0Iit5HOaj97I0wvyZ6N+zIRTpal9KRa8K6FXJbvf7QNiEQVXIU9w
         ltfRuk2W6AP0rSA9TCyrml4CexUYxcUrl4Vg25vULajc/kBF0UkzBoKIlehdhtbYS+R1
         CjlvMbRQShwsGdT7ceBgF/o6L2532hDVDgJ0XIW/KEVeh41LDHaotG1FupedtyzfF81J
         7YJA==
X-Gm-Message-State: AJIora+edyJ0trfenL/VWxHH6SxdzT9HQUmdPAbPaTqnL7F6CHwbFHRU
        ckjMmvnBCtmM6z/iGHoJp0Cl2MvrYFC2mw==
X-Google-Smtp-Source: AGRyM1stRMDFE9lt4J1eJRJ72ElxaKDl+3M0aOntrhXeWnPkRd31Y1l26jxZXT7Fwuw+3o35Xz9Tgg==
X-Received: by 2002:a05:620a:2453:b0:6af:6f18:b432 with SMTP id h19-20020a05620a245300b006af6f18b432mr10879171qkn.54.1657914339375;
        Fri, 15 Jul 2022 12:45:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a449200b006b5988b2ca8sm4863068qkp.40.2022.07.15.12.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 6/9] btrfs: simplify btrfs_put_block_group_cache
Date:   Fri, 15 Jul 2022 15:45:26 -0400
Message-Id: <691375dceb9807a317cae8e6d2623d6d114cd5c7.1657914198.git.josef@toxicpanda.com>
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

We're breaking out and re-searching for the next block group while
evicting any of the block group cache inodes.  This is not needed, the
block groups aren't disappearing here, we can simply loop through the
block groups like normal and iput any inode that we find.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2aa756a0d56d..0fd6b9b8dae5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3961,36 +3961,24 @@ void btrfs_reserve_chunk_metadata(struct btrfs_trans_handle *trans,
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 {
 	struct btrfs_block_group *block_group;
-	u64 last = 0;
 
-	while (1) {
-		struct inode *inode;
-
-		block_group = btrfs_lookup_first_block_group(info, last);
-		while (block_group) {
-			btrfs_wait_block_group_cache_done(block_group);
-			spin_lock(&block_group->lock);
-			if (test_bit(BLOCK_GROUP_FLAG_IREF,
-				     &block_group->runtime_flags))
-				break;
+	block_group = btrfs_lookup_first_block_group(info, 0);
+	while (block_group) {
+		btrfs_wait_block_group_cache_done(block_group);
+		spin_lock(&block_group->lock);
+		if (test_and_clear_bit(BLOCK_GROUP_FLAG_IREF,
+				       &block_group->runtime_flags)) {
+			struct inode *inode = block_group->inode;
+
+			block_group->inode = NULL;
 			spin_unlock(&block_group->lock);
-			block_group = btrfs_next_block_group(block_group);
-		}
-		if (!block_group) {
-			if (last == 0)
-				break;
-			last = 0;
-			continue;
-		}
 
-		inode = block_group->inode;
-		clear_bit(BLOCK_GROUP_FLAG_IREF, &block_group->runtime_flags);
-		block_group->inode = NULL;
-		spin_unlock(&block_group->lock);
-		ASSERT(block_group->io_ctl.inode == NULL);
-		iput(inode);
-		last = block_group->start + block_group->length;
-		btrfs_put_block_group(block_group);
+			ASSERT(block_group->io_ctl.inode == NULL);
+			iput(inode);
+		} else {
+			spin_unlock(&block_group->lock);
+		}
+		block_group = btrfs_next_block_group(block_group);
 	}
 }
 
-- 
2.26.3

