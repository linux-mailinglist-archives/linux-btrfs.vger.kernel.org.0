Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9A31008D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 00:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBDXWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 18:22:37 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48951 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhBDXWf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 18:22:35 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 340995C0093;
        Thu,  4 Feb 2021 18:21:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 18:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=58Zunp3Tg7bESTzisIrnIibyce
        waRC6z+Qrcg47W84Y=; b=mi1Hsvo9t5DqIjLnx0Qaz65H/4+XFM+dImefY/1gWn
        9HLd6d2qNZtZbF4IWJ6XRmkea4Wu0YANK0IYWNZxSpe4hctGPBwqCfJpz/o7vAN6
        V1kwVDKAT3+83PgMjVY3eM7iUFuc0PhpRsg9ITNw+icR45v7e0g/741ENg7+Ier+
        z3stjyu5YJXLw/1RaYM6uYgi2jx6wdoJiPlEhTdMIqnpssnNbYcz8xrVxisELW3z
        08il2uB5FaNbK1zGO/MF5uB/xl2TCHrPiiAFTW6VS9OOc3cBbKren0SGyQneNCWo
        qhi3I2fVS/nVgvV+lyTiwWOwVCf0PMy6CpGx0odyXBDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=58Zunp3Tg7bESTzisIrnIibycewaRC6z+Qrcg47W84Y=; b=mXzuMBqh
        zPa8p4ujUQoJffcQrvUFZJuRt6fUAi0+aYRxUIuT8zN+5tcZ7akhc0GPWISPP3mX
        LC0NYDoolpBZO9gqTrad4QURw1XfEwGGGywlfH8nA+z5cL00C3usFbpK+erdL4S8
        hhr88scvr3P1BN4s4yb2c4rrP7SUr7n86EICSfsCGAyyYBcOKL6TS2VPK/CYVYYC
        6xhltFSM9V5PaZ/UE/bN+ztS+vwyWr9OLQJz6WxFXhaPD+UTxXK8rvbfJGqaRdsZ
        mKLI5Vfxu2skH76MucqEK6vP0NpaHF8JWgzlT95ZAzCeqgPUU5rnwO4CgHbbL5y1
        DgwKRRXcCAhuSQ==
X-ME-Sender: <xms:jIEcYI32B9yxhQIewcsbVEZ20aMMEJIiaEnZxep-7lFtUB3KP9X0wg>
    <xme:jIEcYDHE2K6pYQ1DiWMOV7aig4pIZ51GvS6Ku-B3sP9oHoh7JSUgmewGSWwT1Ef6M
    8xZcQFbIQucb3BxLXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiue
    ffuedvieeujefhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:jIEcYA7nG4U2MeAh2Bymqwn53hMygqOrSa5yCww-VRjzp_4julpSIw>
    <xmx:jIEcYB1hQyjPMupZExARL7O0E8Mcw6JToECz8AWuCVBncTN0DmADxA>
    <xmx:jIEcYLEr8JZMvm8jtMy6YWLPEd3fssWSPMY8t34Zf_xJHkKqPSvpKQ>
    <xmx:jIEcYOOXbbz6N3hWGpyx8GE8j6Qd-BOUKco1EprgrB-Oahd2Vdp6oA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7273024005B;
        Thu,  4 Feb 2021 18:21:47 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/5] btrfs: add compat_flags to btrfs_inode_item
Date:   Thu,  4 Feb 2021 15:21:37 -0800
Message-Id: <568a9a7bd49ce818fe1847640acf7fbf2d1861af.1612475783.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1612475783.git.boris@bur.io>
References: <cover.1612475783.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree checker currently rejects unrecognized flags when it reads
btrfs_inode_item. Practically, this means that adding a new flag makes
the change backwards incompatible if the flag is ever set on a file.

Take up one of the 4 reserved u64 fields in the btrfs_inode_item as a
new "compat_flags". These flags are zero on inode creation in btrfs and
mkfs and are ignored by an older kernel, so it should be safe to use
them in this way.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/btrfs_inode.h          | 1 +
 fs/btrfs/ctree.h                | 2 ++
 fs/btrfs/delayed-inode.c        | 2 ++
 fs/btrfs/inode.c                | 3 +++
 fs/btrfs/ioctl.c                | 7 ++++---
 fs/btrfs/tree-log.c             | 1 +
 include/uapi/linux/btrfs_tree.h | 7 ++++++-
 7 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 28e202e89660..8b95932f25a8 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -191,6 +191,7 @@ struct btrfs_inode {
 
 	/* flags field from the on disk inode */
 	u32 flags;
+	u64 compat_flags;
 
 	/*
 	 * Counters to keep track of the number of extent item's we may use due
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a9b0521d9e89..2f233591c3e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1752,6 +1752,7 @@ BTRFS_SETGET_FUNCS(inode_gid, struct btrfs_inode_item, gid, 32);
 BTRFS_SETGET_FUNCS(inode_mode, struct btrfs_inode_item, mode, 32);
 BTRFS_SETGET_FUNCS(inode_rdev, struct btrfs_inode_item, rdev, 64);
 BTRFS_SETGET_FUNCS(inode_flags, struct btrfs_inode_item, flags, 64);
+BTRFS_SETGET_FUNCS(inode_compat_flags, struct btrfs_inode_item, compat_flags, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_inode_generation, struct btrfs_inode_item,
 			 generation, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_inode_sequence, struct btrfs_inode_item,
@@ -1769,6 +1770,7 @@ BTRFS_SETGET_STACK_FUNCS(stack_inode_gid, struct btrfs_inode_item, gid, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_inode_mode, struct btrfs_inode_item, mode, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_inode_rdev, struct btrfs_inode_item, rdev, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_inode_flags, struct btrfs_inode_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_compat_flags, struct btrfs_inode_item, compat_flags, 64);
 BTRFS_SETGET_FUNCS(timespec_sec, struct btrfs_timespec, sec, 64);
 BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index ec0b50b8c5d6..6ea9d27b9c9d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1733,6 +1733,7 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_inode_transid(inode_item, trans->transid);
 	btrfs_set_stack_inode_rdev(inode_item, inode->i_rdev);
 	btrfs_set_stack_inode_flags(inode_item, BTRFS_I(inode)->flags);
+	btrfs_set_stack_inode_compat_flags(inode_item, BTRFS_I(inode)->compat_flags);
 	btrfs_set_stack_inode_block_group(inode_item, 0);
 
 	btrfs_set_stack_timespec_sec(&inode_item->atime,
@@ -1791,6 +1792,7 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 	inode->i_rdev = 0;
 	*rdev = btrfs_stack_inode_rdev(inode_item);
 	BTRFS_I(inode)->flags = btrfs_stack_inode_flags(inode_item);
+	BTRFS_I(inode)->compat_flags = btrfs_stack_inode_compat_flags(inode_item);
 
 	inode->i_atime.tv_sec = btrfs_stack_timespec_sec(&inode_item->atime);
 	inode->i_atime.tv_nsec = btrfs_stack_timespec_nsec(&inode_item->atime);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1a160db01878..f97d4d5c03d8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3481,6 +3481,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 
 	BTRFS_I(inode)->index_cnt = (u64)-1;
 	BTRFS_I(inode)->flags = btrfs_inode_flags(leaf, inode_item);
+	BTRFS_I(inode)->compat_flags = btrfs_inode_compat_flags(leaf, inode_item);
 
 cache_index:
 	/*
@@ -3647,6 +3648,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_transid(&token, item, trans->transid);
 	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
 	btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
+	btrfs_set_token_inode_compat_flags(&token, item, BTRFS_I(inode)->compat_flags);
 	btrfs_set_token_inode_block_group(&token, item, 0);
 }
 
@@ -8663,6 +8665,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->defrag_bytes = 0;
 	ei->disk_i_size = 0;
 	ei->flags = 0;
+	ei->compat_flags = 0;
 	ei->csum_bytes = 0;
 	ei->index_cnt = (u64)-1;
 	ei->dir_index = 0;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7f2935ea8d3a..c5e21e564921 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -102,8 +102,9 @@ static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
  * Export internal inode flags to the format expected by the FS_IOC_GETFLAGS
  * ioctl.
  */
-static unsigned int btrfs_inode_flags_to_fsflags(unsigned int flags)
+static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
 {
+	unsigned int flags = binode->flags;
 	unsigned int iflags = 0;
 
 	if (flags & BTRFS_INODE_SYNC)
@@ -156,7 +157,7 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
 static int btrfs_ioctl_getflags(struct file *file, void __user *arg)
 {
 	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
-	unsigned int flags = btrfs_inode_flags_to_fsflags(binode->flags);
+	unsigned int flags = btrfs_inode_flags_to_fsflags(binode);
 
 	if (copy_to_user(arg, &flags, sizeof(flags)))
 		return -EFAULT;
@@ -228,7 +229,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 
 	inode_lock(inode);
 	fsflags = btrfs_mask_fsflags_for_type(inode, fsflags);
-	old_fsflags = btrfs_inode_flags_to_fsflags(binode->flags);
+	old_fsflags = btrfs_inode_flags_to_fsflags(binode);
 
 	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
 	if (ret)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8ee0700a980f..c3169571ee1e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3895,6 +3895,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_transid(&token, item, trans->transid);
 	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
 	btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
+	btrfs_set_token_inode_compat_flags(&token, item, BTRFS_I(inode)->compat_flags);
 	btrfs_set_token_inode_block_group(&token, item, 0);
 }
 
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 58d7cff9afb1..ae25280316bd 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -574,11 +574,16 @@ struct btrfs_inode_item {
 	/* modification sequence number for NFS */
 	__le64 sequence;
 
+	/*
+	 * flags which aren't checked for corruption at mount
+	 * and can be added in a backwards compatible way
+	 */
+	__le64 compat_flags;
 	/*
 	 * a little future expansion, for more than this we can
 	 * just grow the inode item and version it
 	 */
-	__le64 reserved[4];
+	__le64 reserved[3];
 	struct btrfs_timespec atime;
 	struct btrfs_timespec ctime;
 	struct btrfs_timespec mtime;
-- 
2.24.1

