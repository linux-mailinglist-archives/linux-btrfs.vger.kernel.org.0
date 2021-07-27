Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB593D73B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhG0Ku6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236434AbhG0Ku6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F36A600CD;
        Tue, 27 Jul 2021 10:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383058;
        bh=Dh7XOP/FJ/SYcaAMmFbAGhF7YtATOmtd9+KPUrsPpwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afHo67rLuQHhWKlvfhOxmoWMfXz9zQK0aO/ePIfSYdEi8QrdH78KgjtdWTxYQzlRl
         gSL3q88BCRfjjpFtibY2gwazPeKokcAf7K3RdPWn14TaXJss98liADJkTa73Y7vGbb
         mL60PAkn2//JfxHJmJqeDdd4rNhXIxpZjejzfCgwuz19Hcq40cDIDvrSK9+kHKroLQ
         TCrhHPFJppqgV9ruVoG1MVUTc1XUvGxJO4x/usZO9uYZvNo1UhMzfOM+qTZdTqviCD
         YgYti/YrQF1nP8dlbyTdTAwryRxRvaqD1KxM0+vXhXkiUW8eQAlc5ZR7BoS37/pM4y
         z8+z68sDzpWUw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 12/21] btrfs/ioctl: check whether fs{g,u}id are mapped during subvolume creation
Date:   Tue, 27 Jul 2021 12:48:51 +0200
Message-Id: <20210727104900.829215-13-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; h=from:subject; bh=BgunXVJFNVa/wuJS4n0aobSThxeR7C5BLjftXo3Q3QE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzI1wX96/pkDfD/mvjJL0ZeonVe5ODJlH9tLMa+FDufu lDw53FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARJ0mG/xGrBP86abRZuPYf91ofu+ LBy7SX8WW+M1edU9vxJDT38EyG/6HPNfVX8n0Wkuhzvap4+hfnvN8hm1K6pj34oPe9Jrn7BQsA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

When a new subvolume is created btrfs currently doesn't check whether the
fs{g,u}id of the caller actually have a mapping in the user namespace attached
to the filesystem. The vfs always checks this to make sure that the caller's
fs{g,u}id can be represented on-disk. This is most relevant for filesystems
that can be mounted inside user namespaces but it is in general a good
hardening measure to prevent unrepresentable {g,u}ids from being written to
disk.
Since we want to support idmapped mounts for btrfs ioctls to create subvolumes
in follow-up patches this becomes important since we want to make sure the
fs{g,u}id of the caller as mapped according to the idmapped mount can be
represented on-disk. Simply add the missing fsuidgid_has_mapping() line from
the vfs may_create() version to btrfs_may_create().

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
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..7a6a886df7c4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -870,6 +870,8 @@ static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
+	if (!fsuidgid_has_mapping(dir->i_sb, &init_user_ns))
+		return -EOVERFLOW;
 	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 }
 
-- 
2.30.2

