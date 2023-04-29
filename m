Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E96F2636
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjD2UHu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjD2UHp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:45 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9938126AD
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so14180033276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798860; x=1685390860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ifif1Z1yD2qw5ylIpKzZ/EvAQTj9EHFzqF9TLYsPJVs=;
        b=KDraS2za8zmEvIxrIsiB6fZ07wPBC9cx8Rt6UVwiwZDtF7+R6d4TXCmbRjafMHmMoa
         xyE3P2ptzkjkQttE6aNzRKeL2TbG+O7woXaEGRF2jL5373aOU0YQte0SJW6SiYthhN3j
         x//yvLorJp1d3Y6U10X3WOzeWk9dkWjkRDqfVAdKOY4EjYPjvE+CKzIrvdLPZdCaYIBw
         vFJn6eDXCOs4rpPL1zdxcsr89TUNBcKCFbpr9m9Y64Kd+1aZp3NFlSIhai0bf7reGNs4
         +HExKgJzIZNjX5hnRpgzVI6MrBDyOaPO7RajjxTweBnZ8Vok4vE/JZLlDlI/PqNr1roU
         3n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798860; x=1685390860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ifif1Z1yD2qw5ylIpKzZ/EvAQTj9EHFzqF9TLYsPJVs=;
        b=bJYjSg6nqVEH0YiPMCN+WtaqbrsNWoHHS/j3guI0FHYTkydNgAB+45S5ujDq5s/hgA
         uuuV+BI7UxcC51Oc3i8SqK4sFdQCM7zuadOcOOKm6seE5gOCeFY5GZ0zRnJolPuQiUvd
         B9BDjZA1cSqfi72K2Pcymp47/nbAJOWd9JE1UVfNbmBTeBsEJ19iY/4jGs+L7mN61aMl
         TrbT/cHoOR9FbCv0oHS4T9t6m5Wu7KJS+TdjY0CU/0PDPRSVQnfdddntjaphJz4xEmJU
         hCudUSszjuQEJpAsHmgnnXvYoq4LNj/BIKA296olofzt9hE59QlOm/224kr/2Eoml1WE
         ar3w==
X-Gm-Message-State: AC+VfDxvkiXh48eu8jc+6TusDgymvTZ9j5S0Gsjo1d5KQzzCCntcp6ao
        tA6+p4WYtdz6flfdWmejea49mD9mgdbtZrrXcraRPQ==
X-Google-Smtp-Source: ACHHUZ5Nao0BtfPeDT0617lCmUnTYDt1dN2VeRAOMOli4zBj9ua+ydvxr5Yi19eCWduahrN/Fzb0hQ==
X-Received: by 2002:a0d:cb41:0:b0:550:4d9f:3a3a with SMTP id n62-20020a0dcb41000000b005504d9f3a3amr8135972ywd.19.1682798860268;
        Sat, 29 Apr 2023 13:07:40 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i205-20020a0ddfd6000000b00545a08184a9sm6316974ywe.57.2023.04.29.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/12] btrfs: move split_flags/combine_flags helpers to inode-item.h
Date:   Sat, 29 Apr 2023 16:07:18 -0400
Message-Id: <5deb90b337e17e2236dc2349fdbf4fb216146551.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

These are more related to the inode item flags on disk than the
in-memory btrfs_inode, move the helpers to inode-item.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h  | 16 ----------------
 fs/btrfs/inode-item.h   | 16 ++++++++++++++++
 fs/btrfs/tree-checker.c |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index ec2ae4406c16..9e8038273cdc 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -407,22 +407,6 @@ static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
 	return true;
 }
 
-/*
- * btrfs_inode_item stores flags in a u64, btrfs_inode stores them in two
- * separate u32s. These two functions convert between the two representations.
- */
-static inline u64 btrfs_inode_combine_flags(u32 flags, u32 ro_flags)
-{
-	return (flags | ((u64)ro_flags << 32));
-}
-
-static inline void btrfs_inode_split_flags(u64 inode_item_flags,
-					   u32 *flags, u32 *ro_flags)
-{
-	*flags = (u32)inode_item_flags;
-	*ro_flags = (u32)(inode_item_flags >> 32);
-}
-
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index b80aeb715701..ede43b6c6559 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -60,6 +60,22 @@ struct btrfs_truncate_control {
 	bool clear_extent_range;
 };
 
+/*
+ * btrfs_inode_item stores flags in a u64, btrfs_inode stores them in two
+ * separate u32s. These two functions convert between the two representations.
+ */
+static inline u64 btrfs_inode_combine_flags(u32 flags, u32 ro_flags)
+{
+	return (flags | ((u64)ro_flags << 32));
+}
+
+static inline void btrfs_inode_split_flags(u64 inode_item_flags,
+					   u32 *flags, u32 *ro_flags)
+{
+	*flags = (u32)inode_item_flags;
+	*ro_flags = (u32)(inode_item_flags >> 32);
+}
+
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
 			       struct btrfs_truncate_control *control);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a1038156d57d..d38f54efd443 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -25,10 +25,10 @@
 #include "compression.h"
 #include "volumes.h"
 #include "misc.h"
-#include "btrfs_inode.h"
 #include "fs.h"
 #include "accessors.h"
 #include "file-item.h"
+#include "inode-item.h"
 
 /*
  * Error message should follow the following format:
-- 
2.40.0

