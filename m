Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975153D578C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhGZJtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbhGZJtB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:49:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D70C960F6E;
        Mon, 26 Jul 2021 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295370;
        bh=y6KzHjWlmnsTGV4uyTXZCdodPVX0VoMo30cGiTB2UlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbZ722++LAmCZmeFS9/LqU6S4k8gyEIX3PBCtaamByYONkw7LGqseMHDkfyr/LUUw
         Djd78xDJZEoEnddFSmjThlDFeRJ+hWoHawHne+MSOj9SSKXWdLlsc1u7DVWgt7LPTS
         pi3ctXOYFiNr//Sdt/GVspReCjfgfPntazI5l8/VHoOlwq+CmXsMGuqFbAUD8Aclmv
         tGw/iZ9+TeysK/TFT639KHcCy2qLGKS4T8yvKM0uVHPshM0NIZ7/Anjcf2sxSS8480
         pAgD+uMsbf9YsOGSUxTPiLOLk+Vo8ml2OCTluqyeV5EQ/kRrWOeVswpcXYNdVEwlyc
         mLqYqeyA0T4XQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 17/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SUBVOL_SETFLAGS ioctl
Date:   Mon, 26 Jul 2021 12:28:12 +0200
Message-Id: <20210726102816.612434-18-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; h=from:subject; bh=sSu4N2VK497MAT0dv+v5wLFFUYg0vay7OWqfzmUN778=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zOVWpmtnRf1ni90rUtzdonNopbQtUze97Xk/pe9FRD1 utHUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGrLgz/dGedO7FGcL+Oyow1BZLyYb uWcOuZ63gppf7d3ls9ofpVLSPD/rp6wfd3Z67Ze4bl0WHex28NJAS/LuNgsPZ1nznX/TcbHwA=
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
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 983d91429099..e4571522427a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1982,7 +1982,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	u64 flags;
 	int ret = 0;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(file_mnt_user_ns(file), inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
-- 
2.30.2

