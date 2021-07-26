Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6569C3D5785
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhGZJst (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232702AbhGZJss (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6C8560F5E;
        Mon, 26 Jul 2021 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295357;
        bh=MPAYMfsjQv0SZVImWw98zWa582VM6UUm7VzLB113aAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O01Omb/Vn+fcUu+CfB+N0kC8kiK0jMZU6E5QBSfXOa0nsk35GNwt+At7AzCsgsguJ
         uH3Rwxl8ZZfT5IQcmGw1BH0uw1yzcdEyjN1nIV1f/63ZGZe7MPfPmeiqke2t2fVRVB
         Nv/e5YHCr1u32VrzhoLuvWnzDL4Qz68hbSpvqYd/BTG9pkhIuNZCVbXFKjdSwLYTFi
         M8NDEIPq6QcMG96w1h9gm3QXmAVsUsWx6XhI4i/Ow4ZqnU854szHw5jvFfHMITI5wr
         Zb7oJki9Mz3hf0VeJszElEpSw++37gtei0EosEqrzsh2xxW3Mt2IMaqbn7XjNiNgm2
         rvt23pUGWki1w==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 11/21] btrfs/inode: allow idmapped permission iop
Date:   Mon, 26 Jul 2021 12:28:06 +0200
Message-Id: <20210726102816.612434-12-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; h=from:subject; bh=ZFYju59GbQm74bJbcLi8uQ3c4qnWX4CuILf3v68DxcI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zOetjPJgNVjzdlSuy2i85kWME4+Vnb28H9fna4NLTMO SgVO7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI+z9Ghqf5Js+3vr39OOvG4Xe763 cxsX/SqWJi3bd1fZtT00azT3aMDL8MmJpMbsk/uFm/7cxvTfsbX2q9GJhYdwjMWyUVOOnKR04A
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_permission() to handle idmapped mounts. This is just a matter of
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
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2d9717861a6b..5e0b8e394ae1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10274,7 +10274,7 @@ static int btrfs_permission(struct user_namespace *mnt_userns,
 		if (BTRFS_I(inode)->flags & BTRFS_INODE_READONLY)
 			return -EACCES;
 	}
-	return generic_permission(&init_user_ns, inode, mask);
+	return generic_permission(mnt_userns, inode, mask);
 }
 
 static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-- 
2.30.2

