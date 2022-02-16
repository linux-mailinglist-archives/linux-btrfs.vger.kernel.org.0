Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDA4B90FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiBPTHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 14:07:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiBPTHQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 14:07:16 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1422BDF
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:07:02 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id q4so1179068qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ga9lorxBcIzIEkiv2v91I4mVBsCj6HIqBrMhNPX63tc=;
        b=GNZol8+CN+e5rxFBMnPQcKFA0JELl3kQu3LshkeoeLbO2JJpqW2KgzDP9Ke/CIgHAC
         P454H8dpeZFSJ8ZN1JyDLbY3c8TdBca4TcSLBqjK2NqDGYLpPjgQH6OQAl1vzpp5F1Vp
         /rowDBfCTaOQC1bpKE92/jwbeTt1RDBISpIxEk6BVP8g93us6WoZc+8anZeunvGZT9rW
         BKiyCu+/w7EuITtVNmH4enTiUUUVF35IkeJsH5mMDPbwCeuzkfTIRt9XdSb2nthyigUB
         XEfG10J04VGSGi0lj/iAaNSb5m2gB0als7kUFmCu/tLybOXRqb5PkhPamR4qstq6vQ9n
         zOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ga9lorxBcIzIEkiv2v91I4mVBsCj6HIqBrMhNPX63tc=;
        b=dk1yYqMdmDQdSjoRI9jB8H53wglOPFJI82iazYO3gNRzmkobazyPqnH4lFOWqADK5K
         RAsMyZqTitaw4iTjfxxLP5/YQR8whsmDMvx0vvMAdz2aqYye3ng92vxVn3+lHqql4Bzb
         kGE0xvgB0SqgmP5OahU003EpxiiORrPsxMgrIO5XH8AMXKo9dZM4EHe8MdRmNTWHp5ch
         5EWjgUGCK1IDys7iDN3xaFlauYx2QwwyIOMouk3dmLFennb05n97ab3SfEAL07BugEVm
         c5Y5M6rEB0J0Nk1gXne2DpowCxKFifYYXCcTWfX0ihVwcTsqfOXlr8waRlxVcox31rIX
         4Wrw==
X-Gm-Message-State: AOAM533kEE0Mt6HsW/9xy8t/3IfC2rfpPT4UqjxbvhGCqfElQd7rhmEt
        cAb9+RkyfdEYyOoLL8T+woDpzHlXGvF4vZ2+
X-Google-Smtp-Source: ABdhPJxemZwyFtwJqKviprYhCrUE1X3BpNyOgIN/HRw1tTZRLp+B8lcTE3d5UHsHS+xhDhdFX4rl2g==
X-Received: by 2002:a05:620a:1922:b0:5f1:8eef:1160 with SMTP id bj34-20020a05620a192200b005f18eef1160mr2043754qkb.379.1645038421580;
        Wed, 16 Feb 2022 11:07:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s14sm19832896qkp.79.2022.02.16.11.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:07:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: pass btrfs_fs_info to btrfs_recover_relocation
Date:   Wed, 16 Feb 2022 14:06:55 -0500
Message-Id: <f19ac3f97dacaf5c167e19be1e25cf32545d2da3.1645038250.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645038250.git.josef@toxicpanda.com>
References: <cover.1645038250.git.josef@toxicpanda.com>
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
index f870d893d13b..0740d434bee5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3832,7 +3832,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root);
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
-int btrfs_recover_relocation(struct btrfs_root *root);
+int btrfs_recover_relocation(struct btrfs_fs_info *fs_info);
 int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len);
 int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, struct extent_buffer *buf,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4303b996ad2f..08c260a1e948 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3392,7 +3392,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	while (btrfs_clean_one_deleted_snapshot(fs_info))
 		cond_resched();
 
-	ret = btrfs_recover_relocation(fs_info->tree_root);
+	ret = btrfs_recover_relocation(fs_info);
 	mutex_unlock(&fs_info->cleaner_mutex);
 	if (ret < 0) {
 		btrfs_warn(fs_info, "failed to recover relocation: %d", ret);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f5465197996d..b51a11e72b64 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4110,9 +4110,8 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
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
@@ -4153,7 +4152,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		    key.type != BTRFS_ROOT_ITEM_KEY)
 			break;
 
-		reloc_root = btrfs_read_tree_root(root, &key);
+		reloc_root = btrfs_read_tree_root(fs_info->tree_root, &key);
 		if (IS_ERR(reloc_root)) {
 			err = PTR_ERR(reloc_root);
 			goto out;
-- 
2.26.3

