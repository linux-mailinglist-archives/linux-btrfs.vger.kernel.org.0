Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79560BA73
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiJXUh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiJXUgh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:36:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500F115419
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 8so6652727qka.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7U9vJ1S+2YCZX38IBL50e8D2GSKEb1ULkalAktZ3N8Y=;
        b=b8+9Q6RecC9P9y0HJ/g+9hJCyZTPc6Z192KmuivRzLFyifekTZmUYILV96ZIIN9CRD
         ReS7gtXDu+Y0o6P4Rw8ln6r6oOAgvK0LCBVgCh3ELWheX6Xbw5LnsU6Xls8iFWEMIc5h
         euRQ5cB42qC1Nr8kji1tadZUEumSR6hnEwSfd/H+izwU0ppqtBTms38pmL36E84YR6rw
         azFOcxcRNNGSO57ime/ZQR3ilfSRlhVAi21gxoTleB8Yeol3jWuM8cFYB3lmWZfLShjE
         YF/0rw9Ao8CxvD7APcUuKYV36h5Drp7ec1JzQtC8MCPb9SG7ERuVqljjlA0ImlXeQ/vB
         pfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7U9vJ1S+2YCZX38IBL50e8D2GSKEb1ULkalAktZ3N8Y=;
        b=XaDQA1nDCeR1rxGH1BwAQYljEK+Tsbm2UmEsN6GxoNAZXW5AnTH5P2XUQq8hqPrwBl
         BUZi3/8vB+03LKhG1Z5NOOUvknwinRNWP0Oq1MV8K38jGAUC59VEPDdxkgWPc4lwB3fW
         66HblAObfz/af7OAdREmYg9pAfhaIYHbI9DAhkPgTro9fTbF2gwszNY3PT/G8pa6Vwf1
         hw26UF1Do6GhZr04zIUWz+Nqz3RKX1URPgBBgK4DB85xE3R9vnObd7VEXJ2Iymjj1qhl
         2AVIyLtXnFG8Cfs34y4qSujuq/5aXNxU4w1cW5cqJbzuYRa07e+jpnhTKsTVpK8EK8I1
         R4zQ==
X-Gm-Message-State: ACrzQf20QG6VH275r1Jz9MyysyFoutKikX9k1CFueUziFi3QZ+todUho
        mjFGezXMmtxTCNCFjabnUi9D/irJWPkfFQ==
X-Google-Smtp-Source: AMsMyM6WHEEXbG4DvJJtt/Z3LgHGrVMQTdyFgrD3CkODhOKgwV+NrMtyb2DPMtUKkUeoRDxvNveZmA==
X-Received: by 2002:a05:620a:4725:b0:6ee:bf5c:915a with SMTP id bs37-20020a05620a472500b006eebf5c915amr23959233qkb.326.1666637230581;
        Mon, 24 Oct 2022 11:47:10 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fz9-20020a05622a5a8900b00398426e706fsm330781qtb.65.2022.10.24.11.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] btrfs: move btrfs_account_ro_block_groups_free_space into space-info.c
Date:   Mon, 24 Oct 2022 14:46:56 -0400
Message-Id: <f37e23c809dc73fd97bf69ce615e4f6aec08802a.1666637013.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
References: <cover.1666637013.git.josef@toxicpanda.com>
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

This was prototyped in ctree.h and the code existed in extent-tree.c,
but it's space-info related so move it into space-info.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/extent-tree.c | 34 ----------------------------------
 fs/btrfs/space-info.c  | 34 ++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  1 +
 4 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 32c3bd724bc9..514b0eba290c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -567,7 +567,6 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				    u64 disk_num_bytes, bool noflush);
-u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9c242066cf30..db3d417ae9b0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5974,40 +5974,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * helper to account the unused space of all the readonly block group in the
- * space_info. takes mirrors into account.
- */
-u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
-{
-	struct btrfs_block_group *block_group;
-	u64 free_bytes = 0;
-	int factor;
-
-	/* It's df, we don't care if it's racy */
-	if (list_empty(&sinfo->ro_bgs))
-		return 0;
-
-	spin_lock(&sinfo->lock);
-	list_for_each_entry(block_group, &sinfo->ro_bgs, ro_list) {
-		spin_lock(&block_group->lock);
-
-		if (!block_group->ro) {
-			spin_unlock(&block_group->lock);
-			continue;
-		}
-
-		factor = btrfs_bg_type_to_factor(block_group->flags);
-		free_bytes += (block_group->length -
-			       block_group->used) * factor;
-
-		spin_unlock(&block_group->lock);
-	}
-	spin_unlock(&sinfo->lock);
-
-	return free_bytes;
-}
-
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end)
 {
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bf7c5e26dc1e..e4a59d611f07 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1789,3 +1789,37 @@ __cold void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info)
 	}
 	dump_global_block_rsv(fs_info);
 }
+
+/*
+ * helper to account the unused space of all the readonly block group in the
+ * space_info. takes mirrors into account.
+ */
+u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
+{
+	struct btrfs_block_group *block_group;
+	u64 free_bytes = 0;
+	int factor;
+
+	/* It's df, we don't care if it's racy */
+	if (list_empty(&sinfo->ro_bgs))
+		return 0;
+
+	spin_lock(&sinfo->lock);
+	list_for_each_entry(block_group, &sinfo->ro_bgs, ro_list) {
+		spin_lock(&block_group->lock);
+
+		if (!block_group->ro) {
+			spin_unlock(&block_group->lock);
+			continue;
+		}
+
+		factor = btrfs_bg_type_to_factor(block_group->flags);
+		free_bytes += (block_group->length -
+			       block_group->used) * factor;
+
+		spin_unlock(&block_group->lock);
+	}
+	spin_unlock(&sinfo->lock);
+
+	return free_bytes;
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 6e2947688c53..77d83fea84a4 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -218,5 +218,6 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
 void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
+u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.26.3

