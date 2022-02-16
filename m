Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6174B90FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiBPTHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 14:07:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiBPTHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 14:07:14 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A161EAD6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:07:01 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d3so3756686qvb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b2Z26vMkOIUtkHckS6T8vkyhhAXjwrMHu7aJruaJmN4=;
        b=gI2/7rj94nfa6CjftJ9ypDI4Qi/JxXbDokr4vGdEdpDKSbp16SiEkN38YtFZaC59H/
         mg1D9h2YZ1SUeVuok4fpfFDSes9VFe8+36OJ0/aC1AP2qGLdQ204E0EvKgFKn28BmZqF
         ESVHWvrFNxpYkkgX3Kzt2nvbJw8n0ZO500NbatFiNVL0dMPM8UL9wo54zBqwrKkZqVhe
         jB6/kQgNxRwwyUhkLA5hYaxWbSnTQicQEaLwcy5EXa+R0PIm77AIeQ6d0m3X9j2MJRfz
         YHAhd3/v9o7hnzaUAyogfv1NKCQJkPmF5ydsYNPnOpLok0gkhrmfwqfvnCXDTR2hnivQ
         vesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2Z26vMkOIUtkHckS6T8vkyhhAXjwrMHu7aJruaJmN4=;
        b=5ZmF6HdJA/1od5LXFXqjRvGlOxl2wu+8WpZT5T0lhXw5ETi1CNwTtrcFTzv5rNIC7o
         ge4n/R4sYi5YCsNCp8Lgdqn/2JcJhC+TwXMwXRM/25YUIH9PxE2+LiWPmhJbOnuj5LV3
         268mL52OMlmzXr67a73asNfeDoY5iA6v6yKw8iibreggYfg244TV01r88240TXXvbYPN
         6KZmJwIC3r9XzD0qnKlxM9Pnonxf96VrteOtAJ+VxV4Q9MZkuNbvhaStyYLidksgMjko
         +/M5O2VqDwdGOFrPmX8JQgpso0la9fA1zmFnaj8Vr08OvhqXaXcy970Klz0I9jNB44Xv
         MJjg==
X-Gm-Message-State: AOAM531XSjN0QltEOH4apB8mO39kaFIcPGdhifdjRm84hY+23ZipWow+
        wdxB0vGNbPaG38OMH4i3OKlYb4wxjhyhh4of
X-Google-Smtp-Source: ABdhPJyIN8bx2333ojUCc3ps+uQgNYcxmLirUAAkDhzF/WD8wYW4nRcf4/RCsVGluz4Dbir9K/yYHg==
X-Received: by 2002:a05:6214:16f:b0:42d:7bff:ffb9 with SMTP id y15-20020a056214016f00b0042d7bffffb9mr3026486qvs.128.1645038420364;
        Wed, 16 Feb 2022 11:07:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d15sm15472478qtx.30.2022.02.16.11.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:07:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: use btrfs_fs_info for deleting snapshots and cleaner
Date:   Wed, 16 Feb 2022 14:06:54 -0500
Message-Id: <0908d58bce2ecb380ea1ff4d0268ff8066f2dc13.1645038250.git.josef@toxicpanda.com>
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

We're passing a root around here, but we only really need the fs_info,
so fix up btrfs_clean_one_deleted_snapshot() to take an fs_info instead,
and then fix up all the callers appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 9 ++++-----
 fs/btrfs/transaction.c | 4 ++--
 fs/btrfs/transaction.h | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ae8c201070f2..4303b996ad2f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1947,8 +1947,7 @@ static void end_workqueue_fn(struct btrfs_work *work)
 
 static int cleaner_kthread(void *arg)
 {
-	struct btrfs_root *root = arg;
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info = (struct btrfs_fs_info *)arg;
 	int again;
 
 	while (1) {
@@ -1981,7 +1980,7 @@ static int cleaner_kthread(void *arg)
 
 		btrfs_run_delayed_iputs(fs_info);
 
-		again = btrfs_clean_one_deleted_snapshot(root);
+		again = btrfs_clean_one_deleted_snapshot(fs_info);
 		mutex_unlock(&fs_info->cleaner_mutex);
 
 		/*
@@ -3390,7 +3389,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	 * starts) the relocation.  So do the cleanup here in order to prevent
 	 * problems.
 	 */
-	while (btrfs_clean_one_deleted_snapshot(fs_info->tree_root))
+	while (btrfs_clean_one_deleted_snapshot(fs_info))
 		cond_resched();
 
 	ret = btrfs_recover_relocation(fs_info->tree_root);
@@ -3819,7 +3818,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
-	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, tree_root,
+	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
 	if (IS_ERR(fs_info->cleaner_kthread))
 		goto fail_sysfs;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c6e550fa4d55..b467570ae58b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2444,10 +2444,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
  * because btrfs_commit_super will poke cleaner thread and it will process it a
  * few seconds later.
  */
-int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
+int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
 {
+	struct btrfs_root *root;
 	int ret;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	spin_lock(&fs_info->trans_lock);
 	if (list_empty(&fs_info->dead_roots)) {
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 9402d8d94484..399efc674f24 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -216,7 +216,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
 
 void btrfs_add_dead_root(struct btrfs_root *root);
 int btrfs_defrag_root(struct btrfs_root *root);
-int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
+int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
 void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
 int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
-- 
2.26.3

