Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736773CD395
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhGSKbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236330AbhGSKbJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 362906108B;
        Mon, 19 Jul 2021 11:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693109;
        bh=PTaGzLX7fN0h31uKp1jMHT/xI+goUxgq9qJg6/EfR3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBvkRLs530p6A8j5sUUq7RZYBs0Yij/jE33x9MWkx7+6XeXFOJs5sslE8XZ4W2Ays
         OKlegYlHzxfyL49scGg9YWv+4A9Y2R0ct6k8yGx5Tr5bx5YZZWNDscdzE1z2i3syo1
         FppiIetqjIN5Ef6b7kEfqAm1hIoCmQoATZ2x5tnUPQAmYFemrUA/pASTfE3exMT8xA
         IL1CeaLXGQc9CMWmBR6jAR9zEHvUMGYOqZzUdNwuCzmdnUiQPHMCy8/J5VHTjCRBN0
         MagnrT2f4WJXdRxP7wTpaMkywyfiYjA1Zk2THaSJp7djwOOWo8q6ip6KdLFR3Qt6jF
         1s1NgYnSmnZYw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 20/21] btrfs/super: allow idmapped btrfs
Date:   Mon, 19 Jul 2021 13:10:51 +0200
Message-Id: <20210719111052.1626299-21-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; h=from:subject; bh=MOSTOzkgOTVD0G5k35yE//SJXfgr9c6/6BdDJfFuedE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd1xZVVm4R6ZukNLNrrclHp991u/mVDbAz77jitXlZ3e Tq2701HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRI24M/4yW8/e+rPtoGLjitMKUM3 GrukISRK9kvdn4SiN76slNV/UYGTY9FY6uz3D5w3yl8sDx5v9r2yZNjUr9NG0Nbwx7x/zV6qwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we converted btrfs internally to account for idmapped mounts allow the
creation of idmapped mounts on btrfs by setting the FS_ALLOW_IDMAP flag.  We
only need to raise this flag on the btrfs_root_fs_type filesystem since
btrfs_mount_root() is ultimately responsible for allocating the superblock and
is called into from btrfs_mount() associated with btrfs_fs_type.

The conversion of the btrfs inode operations was straightforward. Regarding
btrfs specific ioctls that perform checks based on inode permissions only those
have been allowed that are not filesystem wide operations and hence can be
reasonably charged against a specific mount.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d07b18b2b250..5ba21f6b443c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2381,7 +2381,7 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
 };
 
 MODULE_ALIAS_FS("btrfs");
-- 
2.30.2

