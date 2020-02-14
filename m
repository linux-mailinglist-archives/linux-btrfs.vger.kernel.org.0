Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8D15F877
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgBNVMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39135 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbgBNVMB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:12:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id a141so719233qkg.6
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lZfPgPVcYn3p+RFS9O6KYcfg3w0RJRr/p9TUbzPHW50=;
        b=C+eJqCRX8Xm2xVFx+vD1OIIhHgMTbeIKmOvMXEX7e5EaBuubfW3PTNjicYort0MNlE
         p6PmoNkAPct2wjIkAepjiMVCte6bMTJ9naldDCFGtdEDlhqMlIeBW5+URecbHOnhuCaI
         nBIJtAG6ewtcbe+hbAXNY+QkpmWuU2C0a4bDlnV7OLmDkRPV45UzWJlWGUJ8iuf6MdH3
         KK4NMiAtDjjV1oS6FoQ5QXOdbsd1ecPXWiukBtB7i7S1oT9hotDzT82inEIgswrfR7DG
         dI3BLoL6p6fenZSxQiPrb8GmRtUHFSOx28nwQPfgnbqrsyxYtEYVNMLkeUTXC87dVD9/
         3mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZfPgPVcYn3p+RFS9O6KYcfg3w0RJRr/p9TUbzPHW50=;
        b=kW+wH3lQJcR1+npdnWI6o7DatItdkQH/y1dT333GJi8xVhXE4PFwP2TZHqmHWRItLc
         Dcbhmfg+LItK3E8acd/E77G3Afp0hVPTmH1w5UGRcIPebSiMmioDNYLr9JExzrxGJdsA
         FqPd0OQRfSN6GuG4/dASpqSq7ZKYCwL0JJsY/meOD46cw3o3AW/MShRyMwzNls6SKL11
         ieInvo7CJkhVNax1k8YkOZcdt47SCU6o//b8FvvwIkThLfMoy2ftjcauD6vLpIAhxvWB
         Cb7T5vGQdWeP3PVN+AT35K2UwBrlM7t6HeQR8oUza4ZyWfbEzzQFW6CqrLXW9tYxWpVq
         fNNA==
X-Gm-Message-State: APjAAAXO882DMJuOH/+N/0qtjxcsY9fpm8TB7iQcKkrDkgow7bOpdcis
        KkqLB8HONayWbBwYsY431y1+EGDsxiA=
X-Google-Smtp-Source: APXvYqyXAewV2YhPnYxsy8u3Jrz6S85+SzBGRFj9fE8c+48w7qwXzgBgbqYy5ND9pYLA2rU2xm2rZA==
X-Received: by 2002:a05:620a:89e:: with SMTP id b30mr4379976qka.398.1581714720063;
        Fri, 14 Feb 2020 13:12:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t29sm3962222qkt.36.2020.02.14.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:11:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: don't take an extra root ref at allocation time
Date:   Fri, 14 Feb 2020 16:11:45 -0500
Message-Id: <20200214211147.24610-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214211147.24610-1-josef@toxicpanda.com>
References: <20200214211147.24610-1-josef@toxicpanda.com>
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
index ffbc4c6c17fe..052690799d64 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1645,22 +1645,11 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
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
@@ -3896,11 +3885,13 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
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
@@ -3922,7 +3913,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		iput(root->ino_cache_inode);
 		root->ino_cache_inode = NULL;
 	}
-	btrfs_put_root(root);
+	if (drop_ref)
+		btrfs_put_root(root);
 }
 
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index ac035a6fa003..ce1ca8e73c2d 100644
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
2.24.1

