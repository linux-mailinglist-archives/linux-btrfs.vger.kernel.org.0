Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A783D73B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhG0Kuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236221AbhG0Kuw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12A5261220;
        Tue, 27 Jul 2021 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383053;
        bh=MwpoHXsjwIzjqq6MD7XpqH6Fj/JBKVG/oSpwj7/Y34I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTBQ/YBWGBu9YVPEjKT0pkYP5ywy0ISfWYCGBBe0uFmDHu457U7OLxRDnOYu1E855
         /n8EfosXvcmK5kdub2Ob83YgO3+gdcVW4PaglM5jZJcpzQ396YVEEbe2yDuFq8nLcD
         WlyG5+BwHzcfUGaL7lA/Ycb+qE1e8jnXcRJa8rVdEO8GX6L7eGt7itFCKCmWis/uR0
         tyJjMeatUqjkfWlEQ2S1D5tXECMtF/nbq1uu5WCADXzH2qYyvkFjydcD9mlWhiT/FT
         la/OyGVH977aa4qIEUBYZ6A2JHmTUlHaxXsBv7dQB+Mm+vElHFJ+PIZJWK1o7a8GEH
         du9Xsv8qEVo4g==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 10/21] btrfs/inode: allow idmapped setattr iop
Date:   Tue, 27 Jul 2021 12:48:49 +0200
Message-Id: <20210727104900.829215-11-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; h=from:subject; bh=3+zZuX1Hq6Qu7bCR0H+pKUUhTQ0C1HBYfr5glA7aA8Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzIlp8Dl0eSz/C+vH17pc/5vsL/di/xpEqw9SgYeRTVC j7xrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai48vwP+Dvhd03LT5v931eym/80b TQIOiXq/1mufLTq/rXhicweDL8M0vaa3dhBsetdY3Onn3hTVulzHZxWD9f2TN17eIdvsc5eAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_setattr() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
unchanged
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a45e3152016..2d9717861a6b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5342,7 +5342,7 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(mnt_userns, dentry, attr);
 	if (err)
 		return err;
 
@@ -5353,12 +5353,12 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	}
 
 	if (attr->ia_valid) {
-		setattr_copy(&init_user_ns, inode, attr);
+		setattr_copy(mnt_userns, inode, attr);
 		inode_inc_iversion(inode);
 		err = btrfs_dirty_inode(inode);
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(&init_user_ns, inode,
+			err = posix_acl_chmod(mnt_userns, inode,
 					      inode->i_mode);
 	}
 
-- 
2.30.2

