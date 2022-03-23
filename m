Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726634E4D18
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 08:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiCWHNE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiCWHND (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 03:13:03 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDBA71EF8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 00:11:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.212])
        by synology.com (Postfix) with ESMTPA id DAB3F12A08891;
        Wed, 23 Mar 2022 15:11:31 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1648019492; bh=L04BlgACg40pDvEzE1pz5yukZT1YvurV8A7ouNjHBFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JZYrogJ4KJAenqqEiDhtYZaFQ2Yk0WlQdRnnU3MQeDDI0EE2mKn0Cu2SzlMlVqPX3
         XPE+nRXQKWS6tlPIdQheIsmZQ3J5qhLKfCFbtYRX+QtHUYMJS3rtT1IZuaa8CVmB3x
         neb1dA77fSpCeL3ON2necBKHvfFtmHJH47w316/w=
From:   Kaiwen Hu <kevinhu@synology.com>
To:     quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
Cc:     robbieko@synology.com, cccheng@synology.com, seanding@synology.com,
        Kaiwen Hu <kevinhu@synology.com>
Subject: [PATCH v2] btrfs: prevent subvol with swapfile from being deleted
Date:   Wed, 23 Mar 2022 15:10:32 +0800
Message-Id: <20220323071031.1398152-1-kevinhu@synology.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <89f67d6a-2574-0ad0-625c-c921adf3a4f6@gmx.com>
References: <89f67d6a-2574-0ad0-625c-c921adf3a4f6@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch prevent subvol being deleted when the subvol contains
any active swapfile.

Since the subvolume is deleted, we cannot swapoff the swapfile in
this deleted subvolume.  However, the swapfile is still active,
we unable to unmount this volume.  Let it into some deadlock
situation.

The test looks like this:
	mkfs.btrfs -f $dev > /dev/null
	mount $dev $mnt

	btrfs sub create $mnt/subvol
	touch $mnt/subvol/swapfile
	chmod 600 $mnt/subvol/swapfile
	chattr +C $mnt/subvol/swapfile
	dd if=/dev/zero of=$mnt/subvol/swapfile bs=1K count=4096
	mkswap $mnt/subvol/swapfile
	swapon $mnt/subvol/swapfile

	btrfs sub delete $mnt/subvol
	swapoff $mnt/subvol/swapfile  // failed: No such file or directory
	swapoff --all

	unmount $mnt  // target is busy.

To prevent above issue, we simply check that whether the subvolume
contains any active swapfile, and stop the deleting process.  This
behavior is like snapshot ioctl dealing with a swapfile.

Reviewed-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: Kaiwen Hu <kevinhu@synology.com>
---

Add comment on it.

 fs/btrfs/inode.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bbea5ec31fc..b32def311f44 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4460,6 +4460,12 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 			   dest->root_key.objectid);
 		return -EPERM;
 	}
+	if (atomic_read(&dest->nr_swapfiles)) {
+		spin_unlock(&dest->root_item_lock);
+		btrfs_warn(fs_info,
+			   "attempt to delete subvolume with active swapfile");
+		return -ETXTBSY;
+	}
 	root_flags = btrfs_root_flags(&dest->root_item);
 	btrfs_set_root_flags(&dest->root_item,
 			     root_flags | BTRFS_ROOT_SUBVOL_DEAD);
@@ -10418,8 +10424,22 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	 * set. We use this counter to prevent snapshots. We must increment it
 	 * before walking the extents because we don't want a concurrent
 	 * snapshot to run after we've already checked the extents.
+	 *
+	 * It is possible that subvolume is marked for deletion but still not
+	 * remove yet. To prevent this race, we check the root's mark before
+	 * activating swapfile.
 	 */
+	spin_lock(&root->root_item_lock);
+	if (btrfs_root_dead(root)) {
+		spin_unlock(&root->root_item_lock);
+		btrfs_exclop_finish(fs_info);
+		btrfs_warn(fs_info,
+	   "cannot activate swapfile because subvolume is marked for deletion");
+		return -EINVAL;
+	}
 	atomic_inc(&root->nr_swapfiles);
+	spin_unlock(&root->root_item_lock);
+
 
 	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
 
-- 
2.25.1

