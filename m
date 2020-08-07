Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8EA23F4AF
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Aug 2020 00:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHGWAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Aug 2020 18:00:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60915 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgHGWAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Aug 2020 18:00:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B7765C015E;
        Fri,  7 Aug 2020 18:00:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 07 Aug 2020 18:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=la2J6WBQqE3gCiGapCFxt3APWq
        IS7VzrPNSqaFtbVA0=; b=M+5cld+ty8ekZyZcCy4u/HS/kOQEPmTSxRO5Dphz5g
        DC0RDhctuVw51M/w9ofo36CNOOSosSZy602mYcox6MSGEv+8VUOYV8PvIl/rVdc0
        rzjpkDSir8Y2zr5d6OaOjmJOB6jWClmEIcLngbcmrsA3MHQ7WZayVPfdSKiRkle5
        S69MiUEcaHLRDDKtIOJsGRyA1IO88XhHk3YopgVLMf01LZHGqrBBuA09s9Xv/1Dn
        DvxtPM9VsAqm2ccdHkPYOyCKRfiqtM9f742dYjc2cIsmRGP8XxpVBIBn/9qsCX4A
        UUHk5vOtRrJrACNf84wRrT8TmjGtGn9WdIqCqREB/glA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=la2J6WBQqE3gCiGap
        CFxt3APWqIS7VzrPNSqaFtbVA0=; b=ccBvc2f+uDAmQigZtMDPt5qPP/icFhE7r
        SxpiYF/y/x4jAS4D1APg/8ZuQdGofU0Ttz7wBtnJhuL3Nzaxa9e9hJGyk45UC2hl
        wfAoY8vKOqRWfnjFkp2EwuzZ7mPIYpofEU/+Y9LIAW/Hl74VSw8nJOXFwf2FcHJJ
        jslYNi5Y0eVJujKncEMS0yRZE12+Z6ZxrRvnmEF5XDuDDAtpiQD3S4yGl7P3FHmb
        Jpp5yWyBYvkDiqniEAyQLjre1uTGJ42BgELI91sv1a2n/hXyO8sZRt3CLaqB1fYO
        Z0K7vao0LCyQB1J3CwMi9IFM7CosGsepY4Vps/U4K81pwB1G51Jng==
X-ME-Sender: <xms:5c4tX4i0pbO39o_fyJGAVdxTm1pY1M5-3GsUCZWIAZHGX4rM1MFitA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehu
    rhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtle
    euieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphepudei
    fedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:5c4tXxAqFgNqz0mGOyyHvHVJxJk7VOCbPOSA7hFcF6hpUgzzlLdGPQ>
    <xmx:5c4tXwGhWtjOVTjRybBI3ta98V7qsIepXaPSTD8MDd8kVRaUE9rAmA>
    <xmx:5c4tX5TfDBt3nb5incH9K7LcAd_ie-3fZt2kEf3CqmVaEHY7UQ4wsA>
    <xmx:5s4tXw_r7YJ8ZJAIm4-o8QbSMM8ithR13HEluSaVLX8VX7hJ4-VCNA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 26E63328006B;
        Fri,  7 Aug 2020 18:00:05 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs: relax conditions on user subvolume delete
Date:   Fri,  7 Aug 2020 14:59:54 -0700
Message-Id: <20200807215954.697124-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the user_subvol_rm_allowed mount flag set, it is possible for non
root users to delete subvolumes. Currently, the conditions to do so
diverge from the conditions for root. Specifically, there is an
additional check on the ability to write to the subvolume to be deleted,
not just its containing directory. As a result, we see weird behavior
like root being able to delete a read only subvolume it doesn't have
write permissions for, but a user not being able to delete a read only
subvolume it does otherwise have write permissions for.

Furthermore, the existing comments make allusions to rmdir being allowed
as a standard, and rmdir only checks permissions on the containing
directory, as in the root case.

To streamline this, make user subvolume deletes with the mount flag set
match the behavior for root. For increased security, it is simple to
just mount without user_subvol_rm_allowed.

To put it plainly, the risk is that a non-root user who has write access
to a parent directory will be able to delete a subvolume in the parent,
even if they don't have write access to the subvolume. Currently, only
root can do that.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ioctl.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bd3511c5ca81..475b99241564 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2835,7 +2835,6 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
 	struct inode *inode;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *dest = NULL;
 	struct btrfs_ioctl_vol_args *vol_args = NULL;
 	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
@@ -2964,37 +2963,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	inode = d_inode(dentry);
 	dest = BTRFS_I(inode)->root;
 	if (!capable(CAP_SYS_ADMIN)) {
-		/*
-		 * Regular user.  Only allow this with a special mount
-		 * option, when the user has write+exec access to the
-		 * subvol root, and when rmdir(2) would have been
-		 * allowed.
-		 *
-		 * Note that this is _not_ check that the subvol is
-		 * empty or doesn't contain data that we wouldn't
-		 * otherwise be able to delete.
-		 *
-		 * Users who want to delete empty subvols should try
-		 * rmdir(2).
-		 */
+		/* Regular user.  Only allow this with a special mount option */
 		err = -EPERM;
 		if (!btrfs_test_opt(fs_info, USER_SUBVOL_RM_ALLOWED))
 			goto out_dput;
-
-		/*
-		 * Do not allow deletion if the parent dir is the same
-		 * as the dir to be deleted.  That means the ioctl
-		 * must be called on the dentry referencing the root
-		 * of the subvol, not a random directory contained
-		 * within it.
-		 */
-		err = -EINVAL;
-		if (root == dest)
-			goto out_dput;
-
-		err = inode_permission(inode, MAY_WRITE | MAY_EXEC);
-		if (err)
-			goto out_dput;
 	}
 
 	/* check if subvolume may be deleted by a user */
-- 
2.24.1

