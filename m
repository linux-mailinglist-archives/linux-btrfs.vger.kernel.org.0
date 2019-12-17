Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11D11230B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLQPoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:44:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37631 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfLQPoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:44:17 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so9074323qtk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zPyzRtXrlrV5hNjtM57qkNcFV1toapd2jYelIQaSUe8=;
        b=TT48LN3xIbWdZ40DAiagelP9KOZGK7UePI5hTgJJg+ddH/GFAv0IkTmDQhfFwT7fcv
         np35OSfNsqy0Mk4WwqLoEX4Qj0pYoAxJunEm00MnmL9qd7QCMFZPs6mWKl7/z7YtF42T
         K+IqzqXX258Mp7HUdmQYx3vTQaY5HuOzGzuDlUib9gn6e7b8Rk70tqmgIZrnvBsz5iHy
         UkjyXdZHhDWyiPWE82ghJhG1wfwsHHFrd2QmAdRm8s7pO+QNSUU2xpR+udtnz4Ih9AvG
         BTGvwf6lEvId+AOHLFyQdFhe2Xq386xHRCsUvBOECYaXEm/SwNxuVsZ6wKR7BwWiM3em
         QFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPyzRtXrlrV5hNjtM57qkNcFV1toapd2jYelIQaSUe8=;
        b=jHOKQugQMJoUHFC/U14vA8tqC5GSSHw46q5f2O1znsoDlpVFlfCWGC/7OCt1mdpTmX
         E+jBxKAhPwBrag2d8ziyvbXsdcT21phEtrd/HxZklmZ113N+Ze8x0oeNI11I3sAms0dv
         v6JflfT2c1JzpMXH1MsUsOfE21Cj5k3m9AZkOLiB02zOX5QX9dABJgwCRbH+iIlcGtVt
         Zs0nMcr0VrHV00D4RK9RR5eYLC5I190wQbQQEr7EgCHN/GB670X+YHAzJtKopPM6H9rO
         rAqYXy4DJ+QRLEjBc8ytKrMNNkfD+3IzW2LD5Gmgbe0judhO/TzEeQHWeDR687RsHHQi
         OJ/A==
X-Gm-Message-State: APjAAAVk92fMMChKcurOF4RutSQrwsLmRDkH4mDZxsZLgMlLUoSYq6tv
        WkQHdNOWLec+9AX62mK8rYmbbubXPYsFFA==
X-Google-Smtp-Source: APXvYqzgP129FJLOJXFH7kYVxHotuvlbCzhZGpRZFgRTmUGrnU8MrwbNjYGgqnCZ5Cf0Rzs7In8MrQ==
X-Received: by 2002:ac8:46da:: with SMTP id h26mr5042064qto.167.1576597456114;
        Tue, 17 Dec 2019 07:44:16 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y184sm7125747qkd.128.2019.12.17.07.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:44:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/7] btrfs: don't take an extra root ref at allocation time
Date:   Tue, 17 Dec 2019 10:44:02 -0500
Message-Id: <20191217154404.44831-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217154404.44831-1-josef@toxicpanda.com>
References: <20191217154404.44831-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that all the users of roots take references for them we can drop the
extra root ref we've been taking.  Before we had roots at 2 refs for the
life of the file system, one for the radix tree, and one simply for
existing.  Now that we have proper ref accounting in all places that use
roots we can drop this extra ref simply for existing as we no longer
need it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c            | 20 ++++++--------------
 fs/btrfs/tests/qgroup-tests.c |  2 ++
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ac96214bb5d9..b99eab5381bf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1649,22 +1649,11 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	if (ret == 0)
 		set_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state);
 
-	/*
-	 * All roots have two refs on them at all times, one for the mounted fs,
-	 * and one for being in the radix tree.  This way we only free the root
-	 * when we are unmounting or deleting the subvolume.  We get one ref
-	 * from __setup_root, one for inserting it into the radix tree, and then
-	 * we have the third for returning it, and the caller will put it when
-	 * it's done with the root.
-	 */
-	btrfs_grab_root(root);
 	ret = btrfs_insert_fs_root(fs_info, root);
 	if (ret) {
 		btrfs_put_root(root);
-		if (ret == -EEXIST) {
-			btrfs_put_root(root);
+		if (ret == -EEXIST)
 			goto again;
-		}
 		goto fail;
 	}
 	return root;
@@ -3898,11 +3887,13 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				  struct btrfs_root *root)
 {
+	bool drop_ref = false;
+
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	radix_tree_delete(&fs_info->fs_roots_radix,
 			  (unsigned long)root->root_key.objectid);
 	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
-		btrfs_put_root(root);
+		drop_ref = true;
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
 	if (btrfs_root_refs(&root->root_item) == 0)
@@ -3920,7 +3911,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		__btrfs_remove_free_space_cache(root->free_ino_pinned);
 	if (root->free_ino_ctl)
 		__btrfs_remove_free_space_cache(root->free_ino_ctl);
-	btrfs_put_root(root);
+	if (drop_ref)
+		btrfs_put_root(root);
 }
 
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 09aaca1efd62..0689f69545a4 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -507,6 +507,7 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 		test_err("couldn't insert fs root %d", ret);
 		goto out;
 	}
+	btrfs_put_root(tmp_root);
 
 	tmp_root = btrfs_alloc_dummy_root(fs_info);
 	if (IS_ERR(tmp_root)) {
@@ -521,6 +522,7 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 		test_err("couldn't insert fs root %d", ret);
 		goto out;
 	}
+	btrfs_put_root(tmp_root);
 
 	test_msg("running qgroup tests");
 	ret = test_no_shared_qgroup(root, sectorsize, nodesize);
-- 
2.23.0

