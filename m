Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137512AEFC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 12:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgKKLif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 06:38:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:49532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgKKLiZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 06:38:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605094704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BM4kcyPFZ7IenQ1EAycFPjy9puGJXsZS6489AyfW4Ak=;
        b=MERsP5MDimnWWp+vxqr/oZ/00X35TUKXz2gLJlsLAr6pwUH+lRblv2caHR4Z0HWOqycTYY
        InTZgu33VB/o9/e0ENflBbmIEUt1NqedbCp4aWSDf/CEXCbYXmY17h3V9u0T1zm5S8i1+Q
        IS5ox4wZ8vTscko8PuIqt2bj8lbVx7k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 047ECACE6;
        Wed, 11 Nov 2020 11:38:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: qgroup: don't commit transaction when we have already hold a transaction handler
Date:   Wed, 11 Nov 2020 19:38:18 +0800
Message-Id: <20201111113818.137633-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running the following script, btrfs will trigger an ASSERT():

  #/bin/bash
  mkfs.btrfs -f $dev
  mount $dev $mnt
  xfs_io -f -c "pwrite 0 1G" $mnt/file
  sync
  btrfs quota enable $mnt
  btrfs quota rescan -w $mnt

  # Manually set the limit below current usage
  btrfs qgroup limit 512M $mnt $mnt

  # Crash happens
  touch $mnt/file

The dmesg looks like this:

  assertion failed: refcount_read(&trans->use_count) == 1, in fs/btrfs/transaction.c:2022
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.h:3230!
  invalid opcode: 0000 [#1] SMP PTI
  RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
   btrfs_commit_transaction.cold+0x11/0x5d [btrfs]
   try_flush_qgroup+0x67/0x100 [btrfs]
   __btrfs_qgroup_reserve_meta+0x3a/0x60 [btrfs]
   btrfs_delayed_update_inode+0xaa/0x350 [btrfs]
   btrfs_update_inode+0x9d/0x110 [btrfs]
   btrfs_dirty_inode+0x5d/0xd0 [btrfs]
   touch_atime+0xb5/0x100
   iterate_dir+0xf1/0x1b0
   __x64_sys_getdents64+0x78/0x110
   do_syscall_64+0x33/0x80
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7fb5afe588db

[CAUSE]
In try_flush_qgroup(), we assume we don't hold a transaction handler at
all.
This is true for data reservation and mostly true for metadata.
Since data space reservation always happens before we start a
transaction, and for most metadata operation we reserve space in
start_transaction().

But there is an exception, btrfs_delayed_inode_reserve_metadata().
It holds a transaction handler, while still try to reserve extra
metadata space.

When we hit -EDQUOT inside btrfs_delayed_inode_reserve_metadata(), we
will join into current transaction, and commit current transaction,
while we still have transaction handler out of qgroup code.

[FIX]
Let's check current->journal before we join the transaction.

If current->journal is empty or BTRFS_SEND_TRANS_STUB, it means
ourselves are not holding a transaction, thus is able to join and then
commit transaction.

If current->journal is a valid transaction handler, we avoid committing
transaction, but just end current transaction.

This is less effective than committing current transaction, as it won't
free metadata reserved space, but we may still free some data space by
the incoming data write.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1178634
Fixes: c53e9653605d ("btrfs: qgroup: try to flush qgroup space when we get -EDQUOT")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
Changelog:
v2:
- Add the reproducer for the crash
---
 fs/btrfs/qgroup.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index bf4b02a40ecc..e320bb574421 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3478,6 +3478,7 @@ static int try_flush_qgroup(struct btrfs_root *root)
 {
 	struct btrfs_trans_handle *trans;
 	int ret;
+	bool can_commit = true;
 
 	/*
 	 * We don't want to run flush again and again, so if there is a running
@@ -3489,6 +3490,19 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		return 0;
 	}
 
+	/*
+	 * If current process holds a transaction, we shouldn't flush, as we
+	 * assume all space reservation happens before a trans handler is hold.
+	 *
+	 * But there are cases like btrfs_delayed_item_reserve_metadata() where
+	 * we try to reserve space with one trans handler already hold.
+	 * In that case we can't commit transaction. but at most end
+	 * transaction, and hope the started data writes can free some space.
+	 */
+	if (current->journal_info &&
+	    current->journal_info != BTRFS_SEND_TRANS_STUB)
+		can_commit = false;
+
 	ret = btrfs_start_delalloc_snapshot(root);
 	if (ret < 0)
 		goto out;
@@ -3500,7 +3514,10 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		goto out;
 	}
 
-	ret = btrfs_commit_transaction(trans);
+	if (can_commit)
+		ret = btrfs_commit_transaction(trans);
+	else
+		ret = btrfs_end_transaction(trans);
 out:
 	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
 	wake_up(&root->qgroup_flush_wait);
-- 
2.29.2

