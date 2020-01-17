Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AC140BBA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAQNwv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:52:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36780 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQNwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:52:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id i13so21809074qtr.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/zdI4VuyspYsK8Ci42qtnrQTm+M6cKNrl1u50QcG7C0=;
        b=oU5uA7BJ7mHnzoW1WplRFfF+Siy/Ivi+5IUhKfEB9IfKiBKJjuRGzgk8QlXEDOf1V7
         ZA6XIVknR9Gu1voNxd0gI+Ae8ioh6XdwcEHnsxANnThbG4y/ye5C2ChliGeXYOnEje/A
         6WulbOFeetd0K/lz7XdOWawRCS/QiBSs/nBCz0Rb531ORZwo3F5RHgbWcctXsrojo3GE
         HwQoEQcJYqew63dQ/rdybRXQQ7H9YozQgZw8GJp6JAWzr99xFm/PmgOAusmlgIC4dkRv
         3s92pGIhla2Aa7bJ10v9bV//AcCBahj2NzDfynUrqQBWVVg7rgGfQvXKHH/JTN/WrT1s
         IqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zdI4VuyspYsK8Ci42qtnrQTm+M6cKNrl1u50QcG7C0=;
        b=Bw8uD0b2BR2tf2cekZxE/nyRINck8ocmhSYMcKaoBEDvgQv0t70BLrJNIbqIYYB30h
         3Q9L5xi8H7JsGDVKRY7O9LloUZOyoZJSHAnjGV00pGin9Jn/S2biAAUH8fdMKp2oX27H
         zDr1UauaqFdzYoje2FtorhaF8IrzQpZTDGHO21M8dPGwS+EgTPZbvO0Z7M7CLS6aij2l
         a1vYWZHGT6WnzOY/f4fMokOImmFgBmb5O+Duq/rFTi/2HAOgbEo56KyZRS2ixY5RSltU
         YjpiMEsaiRtfI+v/fDcxGuvNAH7BDPSj/1wEF9bGnXWs54WJvEyThjuJ7StUtWdw8cH+
         UpTA==
X-Gm-Message-State: APjAAAW2ufXayzG6HGRSAZxHULeYhK0K8mrPQJSzwz18UtN7zPi2Ju1+
        2YasQWMKT3tHp5aTDC8Z2MQCEvhDYJv4Bg==
X-Google-Smtp-Source: APXvYqz8FvicBe+tb70MRBY7uVCCt3daNSuWo11VTPyHJ5IQKfOKupKYWzbiJWJOpeI84b62eNDDVA==
X-Received: by 2002:ac8:47c1:: with SMTP id d1mr7374902qtr.84.1579269170506;
        Fri, 17 Jan 2020 05:52:50 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e2sm11555436qkb.112.2020.01.17.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:52:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: don't take an extra root ref at allocation time
Date:   Fri, 17 Jan 2020 08:52:36 -0500
Message-Id: <20200117135238.41601-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117135238.41601-1-josef@toxicpanda.com>
References: <20200117135238.41601-1-josef@toxicpanda.com>
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
index be9b1a1b1a33..42f352dfca45 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1647,22 +1647,11 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
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
@@ -3897,11 +3886,13 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
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
@@ -3923,7 +3914,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
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

