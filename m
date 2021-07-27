Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E973D73AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhG0Kus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236293AbhG0Kur (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 107B56127A;
        Tue, 27 Jul 2021 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383048;
        bh=yBGEZWAFbvq0+wr0cNMlYxsgRhz7Sxt0c6lFc4zuToM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sJXjAsR8uXw6tLjVLBX0edW5aN0brd6pR2TAjFbKlMLONAkdf3fe1zAd5vqQmGn07
         lCJSIyhCF3qh98532sGuRV5yMPHcxy0C9N3T+3GX+NMVaGHtFR75LmCrfNVbwGabrV
         /GCV8o2s+dTLYbE7HADUnaYs8A/CQVtTuUQvr4xgPyrD3Vlc1INcz02ylfqHeuqOP/
         essScixhfPp/4SRxA1zAOLptLAG+0FOVRVx7zZNZpB1Dxg1sxP49h7HqzD2di2vqxe
         dSctc/oGKUbehdIwXj2WRx4BwIq3SfytFpDHgCijSfc1rByMMSOTbZwTjCWnm91IUZ
         Iek4JHcPyn7Iw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 08/21] btrfs/inode: allow idmapped symlink iop
Date:   Tue, 27 Jul 2021 12:48:47 +0200
Message-Id: <20210727104900.829215-9-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; h=from:subject; bh=cMU5ah3suWizVZyyWlmmd+ojZq9IfXsaiH0ENqOcKew=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzJZ5Aen3NHM08+P7Td5t//oSq+23ODIE/orhX4lLzx1 iPlec0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBELnsy/E+aeyV0va/mrrhnJc9Nsx oW7osuDLv9dOlW472ba2v0H11k+O93Ln+RhK2byeJfc6+Jb9W1K5GanSTJfO3omgJfk0Nz7VgB
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_symlink() to handle idmapped mounts. This is just a matter of
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
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bb50e21a4569..5c133280375e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9947,7 +9947,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name, dentry->d_name.len,
 				btrfs_ino(BTRFS_I(dir)), objectid,
 				S_IFLNK | S_IRWXUGO, &index);
-- 
2.30.2

