Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE83D5782
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhGZJsn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232334AbhGZJsl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EC2960F5B;
        Mon, 26 Jul 2021 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295350;
        bh=u66HxYVe+TyrQ28/KhjZbluzLoh4EA2yocxzmKJkcwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4sVKJ/M76Dm+ItrfFJzrBJsveNnWAGeF3/U6g6WKwu1UD3eyTaWTaUiTaqEnSgvK
         2F5mtHi/RxgnZCspd0OhdEEwRDNjxwWCWe+rv/nx/tcyuM3lJu69j4tVSnJopGoS37
         Ew8X61Bj89QDNcWeuPP9rB/YIXUKpBFaPH+x486eu4J2/0bCKUNx4gap/vohl9k+5l
         U12myPV0EKLQrOCXdrYnI6AVFWfXpF4fRDkoUZVDLLrjbaYmzcxED4OH1u/kCH16k+
         TE+JCRLDpJHazYljJFykBRUX5weTop6DHDwhgub3oaVS7gwRfZEDm93hOhv4nDDN55
         Btq/p/lVORMEw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 08/21] btrfs/inode: allow idmapped symlink iop
Date:   Mon, 26 Jul 2021 12:28:03 +0200
Message-Id: <20210726102816.612434-9-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; h=from:subject; bh=tQ6M7Gi+JCLstzh1ddlt+xZ2WvCl6HfPY1NLHdvxQhw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zNOEzBYFXMvy3qJ6o9jukfWJXru/t9V/3SXy0bbd5eT s/YGdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykMInhn+2voun/p243FC/odwkrX9 h9L0RrYw7D1S/npWQC3i5qP8nIsJyRrZ/jx7vbquY9CWWHpC2myM79dyVXU+/uEddDy51jmAE=
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

