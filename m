Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45784BC0BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiBRT4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 14:56:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbiBRT4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 14:56:35 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019CD7E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 11:56:18 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id t21so2636823qkg.6
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 11:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NQ5Y2GfwuSt/qhFaPL3713XhyINx4WuyHU5trrXite4=;
        b=Pbm3gHY/Cc5WvZEW7IsWwm55dGDow6LMqF2yrstKDCPWIcMOlmM8EZMiZQPs+ipgcB
         d/pz9C/K2yHqIYCMMbR77w3+dmMqsKMzWkb/z+fR4W1/1QWMZLgVeyz5126tL8kJLzWc
         onGOLRbGJKuBzB7coVDAxqQRjHGCkwbYm6a1itRv7/PKMZtX4Wn3AXsdjNdbfr1X/c7H
         3k8ih2rtAbcCp5DIWqXTHvg/T6BOKlSiwM36cRFwRo4hckSTRslTeOKfb1kregDvrESC
         tC2ETrj9uLV3yOHbqfpjGQVnlnkCTOw9KOAiMqrqKSML0tcCqBUN1y2yzn2V2U3+GaQN
         iXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQ5Y2GfwuSt/qhFaPL3713XhyINx4WuyHU5trrXite4=;
        b=lAW8ViX9sTYC63E0x4tiTTwCN9icOExz0ESZeH91pezYtJrhvtenfGz5uobMrgmC30
         AdQny86m/MM36iUe6K8Bc9QZiAK1+CpQXWO+ETjFucA8wA64Q415yjJGI5Ih7qGLJAOv
         sCxulaLSVwY2jmK3kJFNm0IGoIJG7VoqdfTPmH/Z/PTqFXetbfchRMbISoKfhaYsBT90
         EGcno12lR8kdUcqVEerXET2dfst34xNjZv/jLwLoPCToNxjXHr1eoalcSz7UstSFm1FP
         In/x++GPacAvSQMgGp1Snov7eARTrP+TCNqVXsPLoqAnQyaMg490XhHuBQgpYMyMcBMC
         fCyA==
X-Gm-Message-State: AOAM532mGfI6D8NYxc1owEH9Jqn/wh10GZqDyb5RgjoCcMhgUZ5+MF6+
        3yJYWKW0zXM3l4PnqgriJtVRkcWNde8Qpp8n
X-Google-Smtp-Source: ABdhPJyLnUFUhn4l37D4GRu2F2EqM/UTefsrs+fcowvoFn9vyLlp2KAI/m5tVVqlKdZJFMmBMDeK3Q==
X-Received: by 2002:a37:8dc5:0:b0:60d:eb45:75dd with SMTP id p188-20020a378dc5000000b0060deb4575ddmr4788280qkd.121.1645214177723;
        Fri, 18 Feb 2022 11:56:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 16sm26309782qty.86.2022.02.18.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:56:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/3] btrfs: pass btrfs_fs_info to btrfs_recover_relocation
Date:   Fri, 18 Feb 2022 14:56:12 -0500
Message-Id: <3aaba7fc1861004693fdc02ca5df300cd6773273.1645214059.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645214059.git.josef@toxicpanda.com>
References: <cover.1645214059.git.josef@toxicpanda.com>
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

We don't need a root here, we just need the btrfs_fs_info, we can just
get the specific roots we need from fs_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 2 +-
 fs/btrfs/disk-io.c    | 2 +-
 fs/btrfs/relocation.c | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1e238748dc73..ca411a42bccf 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3845,7 +3845,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root);
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
-int btrfs_recover_relocation(struct btrfs_root *root);
+int btrfs_recover_relocation(struct btrfs_fs_info *fs_info);
 int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len);
 int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, struct extent_buffer *buf,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 183baeffd9c9..6a0b4dbd70e9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3379,7 +3379,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	up_read(&fs_info->cleanup_work_sem);
 
 	mutex_lock(&fs_info->cleaner_mutex);
-	ret = btrfs_recover_relocation(fs_info->tree_root);
+	ret = btrfs_recover_relocation(fs_info);
 	mutex_unlock(&fs_info->cleaner_mutex);
 	if (ret < 0) {
 		btrfs_warn(fs_info, "failed to recover relocation: %d", ret);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f528c5283f25..7dc6f29a6094 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4124,9 +4124,8 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
  * this function resumes merging reloc trees with corresponding fs trees.
  * this is important for keeping the sharing of tree blocks
  */
-int btrfs_recover_relocation(struct btrfs_root *root)
+int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	LIST_HEAD(reloc_roots);
 	struct btrfs_key key;
 	struct btrfs_root *fs_root;
@@ -4167,7 +4166,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		    key.type != BTRFS_ROOT_ITEM_KEY)
 			break;
 
-		reloc_root = btrfs_read_tree_root(root, &key);
+		reloc_root = btrfs_read_tree_root(fs_info->tree_root, &key);
 		if (IS_ERR(reloc_root)) {
 			err = PTR_ERR(reloc_root);
 			goto out;
-- 
2.26.3

