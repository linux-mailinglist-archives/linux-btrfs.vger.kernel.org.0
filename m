Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9D3D73BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhG0KvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236401AbhG0KvJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:51:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4635C60FED;
        Tue, 27 Jul 2021 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383070;
        bh=vYIYQici/uKWm8x8tPQwwBjQaY6o1hk9N+CQmtERywk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYyZrEuKkp6qbfxDLRWoOQ4LeQ7rjVXfuuSZs2+pSshDVvLHhTeSoEzbfF7oc9UFY
         PaOCJZ97izPm/4DuK4kpFJLWgSV7UwUfejsGnkUKnCIeOmRXOF/mgV6YYJEpVBoeHc
         aK48lDoqZknbDcu/yNqAcrFR6VnF58h+9Tu3Wi3BxUtppRndTyU774pEm/tf4JDzL9
         IycLG4aMllDqb/mkQXmjg1MKqgpOCzMMOofDMHFz1phlnywY3FgjOISlogY4Ze8xIZ
         jcX84jnDuF5EJLfpBXJZ7MtBHb8pYOXLEglKN/RAhkwcSu+rxuBtuwgb25y/8uZZr9
         pfmuW7sblYcrA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 17/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SUBVOL_SETFLAGS ioctl
Date:   Tue, 27 Jul 2021 12:48:56 +0200
Message-Id: <20210727104900.829215-18-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; h=from:subject; bh=g3IM86F5Pk9+ZVwvZpOi8+/bGoYPNr5gjHAkgH0Fo1o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzLt4nO+qasCX71g3d8iGP5XV/hft+MvHWMu7wiZaywf M+Rvd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE7CTDX9HirHLXi0zNv+SXlKe7yU 872tR++MUxjjfVZWJ7AlKXCDH8L/2Z/+L+F64axlWz9F8lhFsXsDreWumaJBWttUtxlyg7OwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Setting flags on subvolumes or snapshots are core features of btrfs. The
BTRFS_IOC_SUBVOL_SETFLAGS ioctl is especially important as it allows to make
subvolumes and snapshots read-only or read-write. Allow setting flags on btrfs
subvolumes and snapshots on idmapped mounts. This is a fairly straightforward
operation since all the permission checking helpers are already capable of
handling idmapped mounts. So we just need to pass down the mount's userns.

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
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c330b1b252a1..9858bd84a4f7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1981,7 +1981,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	u64 flags;
 	int ret = 0;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(file_mnt_user_ns(file), inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
-- 
2.30.2

