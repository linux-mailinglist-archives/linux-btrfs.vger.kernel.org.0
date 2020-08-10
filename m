Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C8240BD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHJRXB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 13:23:01 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46447 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgHJRXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 13:23:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 58B73962;
        Mon, 10 Aug 2020 13:23:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 10 Aug 2020 13:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=cDRrTpLz3ZzBI
        pD6caYFKnPc9BGyZeqj75Ex68CFYYo=; b=XP6RlI2JdC2LYayc3lzZLX1661dxj
        fZs02ckiaSX6wccNVvbXbLBGizT49BYk+NNs7/ok6uDNFO1QbeSCrdmgkGeeIg6g
        oTidYMPRYbsA7n04VLnV1qacv+Hi1oataGXGweJP4wF1XcwSrghzsF19GGDCPX9j
        tXy9mGyBGDbCdJ4fgTaHBEkrPmQBJ0SGlOrUXIenwwQagZMpiI2loU2KslCTPDNh
        OC6ObkJGeBv+I2pEg/Xkfc+dqAca82S2lGYBAa5dNeztEqTWeWgguCGOb38E+efn
        DQ9FTUYUYID2v43lLN0k+bt8a0/Gm+E+pSAsPAR1hZ6KS2WsVp8RjGaSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cDRrTpLz3ZzBIpD6caYFKnPc9BGyZeqj75Ex68CFYYo=; b=jJ8XXjfa
        zCVhCCBXUrA1UD20tNyZ5hCl3Qh0EKjcTTNvGZt/1lng6p1IBINjHVn+6/kUCt4c
        iwO9YwvfbyHCvtMFb7wHbRB1VVvUfiGOfg7bLZsFoLvQ5MeUbcBpIhBMuA3aYNh1
        NRkhccIL8Awrcl3iH7tmYCJN9mWy6uZe9u2dH00OCcv67DEf7uc0+tVku+A7Adof
        kHlKtbTobASqc9X1oKhmsa58BarnUPZQH7+7/h1+UW4SVMzf1HlXiEp1eEB2hZ/d
        Bw1fXHHxG7X14SY2OROrWe/L9UdEgPfTGPei2RiiEqr6Igjhm3k623UPyWiIJSPe
        h9xcoYEyvwzqEw==
X-ME-Sender: <xms:c4IxX_lcE-1FqZuGsBLWGlOEfvC3Z8qhtNyVdlUtornayqQxYkRCbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkeekgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:c4IxXy1oSEIiXlFzu3xPBU3s-xSZV62yw1GQhHqJ624w-DIxPx6VVg>
    <xmx:c4IxX1ohSU34gnaQiTxvGWSs1S9-nawTmNyWWW0ImpMdL6FP7UeYmw>
    <xmx:c4IxX3l79at3Jeq9F3MJl3AQrfaLeTPo9eE-1c16hRHc1i6Yw5lqVw>
    <xmx:c4IxX7D4fioz6ew4-G_Fn2XZ82IQ7lsxU2XMExqHpJPqof1c1EZeHA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2D6543280059;
        Mon, 10 Aug 2020 13:22:59 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs: relax conditions on user subvolume delete
Date:   Mon, 10 Aug 2020 10:22:48 -0700
Message-Id: <20200810172248.1115832-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <202008080847.g20RFYhM%lkp@intel.com>
References: <202008080847.g20RFYhM%lkp@intel.com>
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
- remove unused variable dest caught by kernel test robot
 fs/btrfs/ioctl.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bd3511c5ca81..a7c4dc1f8bca 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2835,8 +2835,6 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
 	struct inode *inode;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct btrfs_root *dest = NULL;
 	struct btrfs_ioctl_vol_args *vol_args = NULL;
 	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
 	char *subvol_name, *subvol_name_ptr = NULL;
@@ -2962,39 +2960,11 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	}
 
 	inode = d_inode(dentry);
-	dest = BTRFS_I(inode)->root;
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

