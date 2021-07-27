Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088AF3D73AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhG0Kul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236288AbhG0Kuk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4F956127B;
        Tue, 27 Jul 2021 10:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383040;
        bh=/i5vJIpPu8ukaqj/aX/I/eRmg1JJj+YZ/WL/9zSFiv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4WcuiYm+sPRjqNGgLV2Ym77cM5f6/k+PlNqj9pnTtrm+X8qmT0IIBaQ1Id4jesxz
         ryXhEEYYXxbGQ3bDf3ZsxGbXipXK/+E6HY3wEGuOS1vBb5O/g0bE3GDaZhk93Sn8vT
         POM/5mkxpGKCXt7cT67u7syfioIA6wsL1SnsqiYG94XGVs1XnxG75Qu7VMRl8JCpw5
         /bWX2HeNjM1Kge0fkjiP/WbhbFZzzidnwq2btnv9Mp4Lc9Z0l4R0An+JVQLkdz56Up
         ihl7Mo8YX72A0u5LsVztiNzDpqiXx6zDbqPY04wiZhjodGQLWjm+IkSzuxfbcVe1m/
         h6bnpQx5JX0Fg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 05/21] btrfs/inode: allow idmapped mknod iop
Date:   Tue, 27 Jul 2021 12:48:44 +0200
Message-Id: <20210727104900.829215-6-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; h=from:subject; bh=LFsY+R5040o95Dc/o+RtcKiCtko40CMHwbhP8rIKUdY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzJ5tff+uJIdonvnT81j1n1ou+ye7+yDtgpNr6fMF0qP 4iko7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIjniG/7G7lqVYhr1nPGCm0XjsQt hzE4lY9hzWrLTLc47uVNX5EcTIsPH3d4sdDQnrJByvmjUosPCsSfTZZ7vAUHrxZH6pDTsk2QA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_mknod() to handle idmapped mounts. This is just a matter of
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
index e6cc2b155b7e..95068a7dd9c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6665,7 +6665,7 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
-- 
2.30.2

