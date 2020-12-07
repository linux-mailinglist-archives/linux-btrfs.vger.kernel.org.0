Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1E2D14CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 16:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgLGPeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 10:34:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGPeO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 10:34:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607355162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcI0RQG8cXJIR0I4XKuFtj/itjwD9kpPOHIS8dSsKis=;
        b=fZZMi7gIC2T+aTxHOsEKMRmy2SrcHq9GiZKQwHVWgA/D1DrqGrO9CZz2tZImTTmD3DPFNW
        I8NDIfjNsdumOuFsBE4IIQ54BPL0Bk6HZ4+5uwy9rmVDYqN1NpYW6fEMJLO1Wi12IgGKXj
        f1H5fJx3xOl9NGCWkR6EwMUQ3ntF9z8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 355EEADAA;
        Mon,  7 Dec 2020 15:32:42 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/6] btrfs: Make free_objectid hold the next available objectid in the root
Date:   Mon,  7 Dec 2020 17:32:36 +0200
Message-Id: <20201207153237.1073887-6-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
References: <20201207153237.1073887-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adjust the way free_objectid is being initialized, it now stores
BTRFS_FIRST_FREE_OBJECTID rather than the, somewhat arbitrary,
BTRFS_FIRST_FREE_OBJECTID - 1. This change also has the added benefit
that now it becomes unnecessary to explicitly initialize free_objectid
for a newly create fs root.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 8 ++++----
 fs/btrfs/inode.c   | 8 ++++++--
 fs/btrfs/ioctl.c   | 4 ----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e96103b1c5db..6a4d7ea61903 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4762,10 +4762,10 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root)
 		slot = path->slots[0] - 1;
 		l = path->nodes[0];
 		btrfs_item_key_to_cpu(l, &found_key, slot);
-		root->free_objectid = max_t(u64, found_key.objectid,
-				  BTRFS_FIRST_FREE_OBJECTID - 1);
+		root->free_objectid = max_t(u64, found_key.objectid + 1,
+				  BTRFS_FIRST_FREE_OBJECTID);
 	} else {
-		root->free_objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
+		root->free_objectid = BTRFS_FIRST_FREE_OBJECTID;
 	}
 	ret = 0;
 error:
@@ -4786,7 +4786,7 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 		goto out;
 	}
 
-	*objectid = ++root->free_objectid;
+	*objectid = root->free_objectid++;
 	ret = 0;
 out:
 	mutex_unlock(&root->objectid_mutex);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0dee1fa29207..aea76abd83ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8583,9 +8583,13 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	struct inode *inode;
 	int err;
 	u64 index = 0;
+	u64 ino;
+
+	err = btrfs_get_free_objectid(new_root, &ino);
+	if (err < 0)
+		return err;
 
-	inode = btrfs_new_inode(trans, new_root, NULL, "..", 2,
-				new_dirid, new_dirid,
+	inode = btrfs_new_inode(trans, new_root, NULL, "..", 2, ino, ino,
 				S_IFDIR | (~current_umask() & S_IRWXUGO),
 				&index);
 	if (IS_ERR(inode))
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 21c0215a0fd0..58b9a27559c0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -724,10 +724,6 @@ static noinline int create_subvol(struct inode *dir,
 		goto fail;
 	}
 
-	mutex_lock(&new_root->objectid_mutex);
-	new_root->free_objectid = new_dirid;
-	mutex_unlock(&new_root->objectid_mutex);
-
 	/*
 	 * insert the directory item
 	 */
-- 
2.25.1

