Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1F19138F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 15:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgCXOr4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 10:47:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36000 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgCXOr4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 10:47:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id d11so19479763qko.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=drapNqszRyP4Dt0YRp+IYjSiIUe77VDjMxH9ymRAgi4=;
        b=jm69WoD1yGTnkNXGQ1JNUuIXPhgNxE1fg2WLgf1+szZE8ylk6NdQ55iXS40A65E/LM
         m2B83dt8ChmjpyJo2xb9jucUFQnKopCYNNt5utmnwvd7BGWoQV1+g62flYNBjV3V+k5S
         Xw9b/1bdCD23q4lydP94+WH6vbze3t8sM2XNJkCj+UlebEEi7BHW/Qms4TpDl5lmOOK0
         f4F0YXUhXTv9q6KC195HyNhB6eM0XkESq6+BSqffyI6wLzeYnCQT44T7ScLOCPJvT7Bq
         KJ6OAeR4AKu+/CQDicJzuy8GdN3VEo13gO0VtVbn2LokSl/W1YBAOt4lE22Y9wVprvWC
         rj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=drapNqszRyP4Dt0YRp+IYjSiIUe77VDjMxH9ymRAgi4=;
        b=PqAxuNJEf5axoPdJrAcHxjP/E8TPcJ2qybqS1puTr8G03IHXQ3w406dWanBhmNK1Wg
         FaO6Wnn49OZIoduR5w9xyXuOQ+74K+j6ZpGLsmKLKEaEzUqmeDInIr1l35Vh7PqyPJ09
         0Bvs9r6c4wCv43fF0zxQqHKVOIhkHYQt/+t+zxwKJzhzainWhentsauuDNnMrsvDXxtu
         aF+fPQrQLUedOBhsvBRzmlGF946CWpM88lHSMXyvWk/kdI2VgYRhXsLYDJYIeZ5mM0VN
         iC3NSeLRd4zmpADwLM1UfS3SHOSXxC8Uu5nSfVW/OaO9Lx1aTVDwOiJFaGqmwiN3SgPv
         T+5g==
X-Gm-Message-State: ANhLgQ3sr7yiPf9yYKKpyFGbcrYmRHg1rheCIlcdvPbkdLZDrl9tGrOW
        WCJ9JLklQDv0DFf7JWQO/HFumthEVAksWg==
X-Google-Smtp-Source: ADFU+vu7fBO4J+zFAY39LAamAjVIu5a3sbTYAoTCKnv18oeQSeEhvuM8TTFjpkrVtypLgwF/2ROrwA==
X-Received: by 2002:a37:2713:: with SMTP id n19mr25513068qkn.230.1585061275203;
        Tue, 24 Mar 2020 07:47:55 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m1sm14411542qtk.16.2020.03.24.07.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:47:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: drop logs when we've aborted a transaction
Date:   Tue, 24 Mar 2020 10:47:52 -0400
Message-Id: <20200324144752.9541-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dave reported a problem where we were panicing with generic/475 with
misc-5.7.  This is because we were doing IO after we had stopped all of
the worker threads, because we do the log tree cleanup on roots at drop
time.  Cleaning up the log tree may need to do reads if we happened to
have evicted the blocks from memory.

Because of this simply add a helper to btrfs_cleanup_transaction() that
will go through and drop all of the log roots.  This gets run before we
do the close_ctree() work, and thus we are allowed to do any reads that
we would need.  I ran this through many iterations of generic/475 with
constrained memory and I did not see the issue.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>

---
 fs/btrfs/disk-io.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6cb5cbbdb9f..d10c7be10f3b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2036,9 +2036,6 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 		for (i = 0; i < ret; i++)
 			btrfs_drop_and_free_fs_root(fs_info, gang[i]);
 	}
-
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
-		btrfs_free_log_root_tree(NULL, fs_info);
 }
 
 static void btrfs_init_scrub(struct btrfs_fs_info *fs_info)
@@ -3888,7 +3885,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
-		btrfs_free_log(NULL, root);
+		ASSERT(root->log_root == NULL);
 		if (root->reloc_root) {
 			btrfs_put_root(root->reloc_root);
 			root->reloc_root = NULL;
@@ -4211,6 +4208,36 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
 	up_write(&fs_info->cleanup_work_sem);
 }
 
+static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *gang[8];
+	u64 root_objectid = 0;
+	int ret;
+
+	spin_lock(&fs_info->fs_roots_radix_lock);
+	while ((ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+					     (void **)gang, root_objectid,
+					     ARRAY_SIZE(gang))) != 0) {
+		int i;
+
+		for (i = 0; i < ret; i++)
+			gang[i] = btrfs_grab_root(gang[i]);
+		spin_unlock(&fs_info->fs_roots_radix_lock);
+
+		for (i = 0; i < ret; i++) {
+			if (!gang[i])
+				continue;
+			root_objectid = gang[i]->root_key.objectid;
+			btrfs_free_log(NULL, gang[i]);
+			btrfs_put_root(gang[i]);
+		}
+		root_objectid++;
+		spin_lock(&fs_info->fs_roots_radix_lock);
+	}
+	spin_unlock(&fs_info->fs_roots_radix_lock);
+	btrfs_free_log_root_tree(NULL, fs_info);
+}
+
 static void btrfs_destroy_ordered_extents(struct btrfs_root *root)
 {
 	struct btrfs_ordered_extent *ordered;
@@ -4603,6 +4630,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_delayed_inodes(fs_info);
 	btrfs_assert_delayed_root_empty(fs_info);
 	btrfs_destroy_all_delalloc_inodes(fs_info);
+	btrfs_drop_all_logs(fs_info);
 	mutex_unlock(&fs_info->transaction_kthread_mutex);
 
 	return 0;
-- 
2.17.1

