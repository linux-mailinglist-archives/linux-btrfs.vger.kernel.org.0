Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0D125694
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLRWUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 17:20:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32831 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRWUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 17:20:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so3308882qto.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 14:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wwpCBdz/UNy2gEku8xMraGS0RW7roLWFiOvYwKlPotU=;
        b=CuVWAfL6PRtkkpcYIzBixmT+v5g9HwKXcXn9J28iwLWqWZC0bxi3Z2COiKEPPvxAXn
         xuKJB1lBBTh4H3eICnUSYx2npjXm/STA/MhXoLPFDv4+F4e3aT3JDszQkeC0BCtYe3X+
         Jyid3HxTwHpOL7tIzWM0m5oFzAgoP+1xx52p9CY3+LIH8Ttuk1jqe79Y1YOeE0WvLtnm
         ONGCGv/aceTh5Vs5yxsWJ6n9Zl/5XT46zq2LOcKcFFwjcVMPYKzOLKt+nVpqvNKw9y0m
         OCMcJJ03Az4F5PB+gm9QtmKiXpEMrWyPxv6GwbtBMV2J7q//d+cHa06l8ojwouqlM3/3
         XUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwpCBdz/UNy2gEku8xMraGS0RW7roLWFiOvYwKlPotU=;
        b=Z7LHzGp33tyhwHXuGFDhd7iOJf5M+jko6DpRMjnDlDrfUnnu9Czosq29chH4u2CpRq
         JR5mt+HitMzbYvfEWEQbjaxfhi4c1WkbOWnCp78veOq94o2PZDsA6C3CSG9VDG0oR5lY
         omN5cMF+Wkz1DdQHjReklMJcxuHYkWNJY/dYCKWvHtcfuJ9TkK1TWaDGumMv5P4p58hK
         cH9E7oVgKKfeMy9SEHPFPZoG/C9IhqQ8pEjUu2CmymE+a13oCKo2ZOBYGnlT9kcOjIrW
         /23W+iTOWmLpr1Sktmi6yzdm5mV0L4TfOIdA2sfSp+7BC9i6I3TM6D2taA2lUIaQEZWf
         c3QA==
X-Gm-Message-State: APjAAAWfGHnzkXDaQxJlnnVPplE4JPDoytzRoT5DdPkkk0085mS+TNPI
        7wvi+xQjFvEnLUdXG2Gcu+rTZtp5LS3esw==
X-Google-Smtp-Source: APXvYqzNt5X3EHIQY6J/26UKuPlCYjWwmQ80PzxGWvsLGLLWEEHKk4HIqID5ZgaD8OfIbmjdesBxLQ==
X-Received: by 2002:ac8:4509:: with SMTP id q9mr4348841qtn.353.1576707635138;
        Wed, 18 Dec 2019 14:20:35 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s63sm1085062qkf.129.2019.12.18.14.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:20:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: fix invalid removal of root ref
Date:   Wed, 18 Dec 2019 17:20:28 -0500
Message-Id: <20191218222029.49178-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218222029.49178-1-josef@toxicpanda.com>
References: <20191218222029.49178-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have the following sequence of events

btrfs sub create /a
btrfs sub create /a/b
btrfs sub snap /a /c
mkdir /c/foo
mv /a/b /mnt/test/c/foo
rm -rf /mnt/test/*

We will end up with a transaction abort.

The reason for this is because we create a root ref for b pointing to a.
When we create a snapshot of c we still have b in our tree, but because
the root ref points to a and not c we will make it appear to be empty.
The problem happens when we move b into c.  This removes the root ref
for b pointing to a and adds a ref of b pointing to c.  When we rmdir c
we'll see that we have a ref to our root and remove the root ref,
despite not actually matching our reference name.

Now btrfs_del_root_ref() allowing this to work is a bug as well, however
we know that this inode does not actually point to a root ref in the
first place, so we shouldn't be calling btrfs_del_root_ref() in the
first place and instead simply look up our dir index for this item and
do the rest of the removal.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3cbdca2749bd..db67e1984c91 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4279,13 +4279,16 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 
-	ret = btrfs_del_root_ref(trans, objectid, root->root_key.objectid,
-				 dir_ino, &index, name, name_len);
-	if (ret < 0) {
-		if (ret != -ENOENT) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
+	/*
+	 * This is a placeholder inode for a subvolume we didn't have a
+	 * reference to at the time of the snapshot creation.  In the meantime
+	 * we could have renamed the real subvol link into our snapshot, so
+	 * depending on btrfs_del_root_ref to return -ENOENT here is incorret.
+	 * Instead simply lookup the dir_index_item for this entry so we can
+	 * remove it.  Otherwise we know we have a ref to the root and we can
+	 * call btrfs_del_root_ref, and it _shouldn't_ fail.
+	 */
+	if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
 		di = btrfs_search_dir_index_item(root, path, dir_ino,
 						 name, name_len);
 		if (IS_ERR_OR_NULL(di)) {
@@ -4300,8 +4303,16 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		index = key.offset;
+		btrfs_release_path(path);
+	} else {
+		ret = btrfs_del_root_ref(trans, objectid,
+					 root->root_key.objectid, dir_ino,
+					 &index, name, name_len);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 	}
-	btrfs_release_path(path);
 
 	ret = btrfs_delete_delayed_dir_index(trans, BTRFS_I(dir), index);
 	if (ret) {
-- 
2.23.0

