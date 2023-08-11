Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76B8778510
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 03:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjHKBo5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 21:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHKBo4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 21:44:56 -0400
Received: from trager.us (trager.us [52.5.81.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019AC10D
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 18:44:55 -0700 (PDT)
Received: from [163.114.132.6] (helo=localhost)
        by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lee@trager.us>)
        id 1qUHCx-0006Tx-42; Fri, 11 Aug 2023 01:44:55 +0000
From:   Lee Trager <lee@trager.us>
To:     linux-btrfs@vger.kernel.org
Cc:     Lee Trager <lee@trager.us>
Subject: [PATCH] btrfs: Copy dir permission and time when creating a stub subvolume
Date:   Thu, 10 Aug 2023 18:44:35 -0700
Message-Id: <20230811014435.1963948-1-lee@trager.us>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs supports creating nested subvolumes however snapshots are not recursive.
When a snapshot is taken of a volume which contains a subvolume the subvolume
is replaced with a stub subvolume which has the same name and uses inode
number 2[1]. The stub subvolume kept the directory name but did not set the
time or permissions of the stub subvolume. This resulted in all time information
being the current time and ownership defaulting to root. When subvolumes and
snapshots are created using unshare this results in a snapshot directory the
user created but has no permissions for.

Test case:
[vmuser@archvm ~]# sudo -i
[root@archvm ~]# mkdir -p /mnt/btrfs/test
[root@archvm ~]# chown vmuser:users /mnt/btrfs/test/
[root@archvm ~]# exit
logout
[vmuser@archvm ~]$ cd /mnt/btrfs/test
[vmuser@archvm test]$ unshare --user --keep-caps --map-auto --map-root-user
[root@archvm test]# btrfs subvolume create subvolume
Create subvolume './subvolume'
[root@archvm test]# btrfs subvolume create subvolume/subsubvolume
Create subvolume 'subvolume/subsubvolume'
[root@archvm test]# btrfs subvolume snapshot subvolume snapshot
Create a snapshot of 'subvolume' in './snapshot'
[root@archvm test]# exit
logout
[vmuser@archvm test]$ tree -ug
[vmuser   users   ]  .
├── [vmuser   users   ]  snapshot
│   └── [vmuser   users   ]  subsubvolume  <-- Without patch perm is root:root
└── [vmuser   users   ]  subvolume
    └── [vmuser   users   ]  subsubvolume

5 directories, 0 files

[1] https://btrfs.readthedocs.io/en/latest/btrfs-subvolume.html#nested-subvolumes
Signed-off-by: Lee Trager <lee@trager.us>
---
 fs/btrfs/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6a68d5a3ed20..7a288cd6f815 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5592,11 +5592,11 @@ struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root
 	return btrfs_iget_path(s, ino, root, NULL);
 }
 
-static struct inode *new_simple_dir(struct super_block *s,
+static struct inode *new_simple_dir(struct inode *dir,
 				    struct btrfs_key *key,
 				    struct btrfs_root *root)
 {
-	struct inode *inode = new_inode(s);
+	struct inode *inode = new_inode(dir->i_sb);
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
@@ -5615,9 +5615,11 @@ static struct inode *new_simple_dir(struct super_block *s,
 	inode->i_fop = &simple_dir_operations;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
 	inode->i_mtime = current_time(inode);
-	inode->i_atime = inode->i_mtime;
-	inode->i_ctime = inode->i_mtime;
+	inode->i_atime = dir->i_atime;
+	inode->i_ctime = dir->i_ctime;
 	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	inode->i_uid = dir->i_uid;
+	inode->i_gid = dir->i_gid;
 
 	return inode;
 }
@@ -5676,7 +5678,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		if (ret != -ENOENT)
 			inode = ERR_PTR(ret);
 		else
-			inode = new_simple_dir(dir->i_sb, &location, root);
+			inode = new_simple_dir(dir, &location, root);
 	} else {
 		inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
 		btrfs_put_root(sub_root);
-- 
2.34.1

