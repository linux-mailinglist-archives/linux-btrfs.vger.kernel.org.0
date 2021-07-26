Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73373D578F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhGZJtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhGZJtI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:49:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C6AA60F56;
        Mon, 26 Jul 2021 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295377;
        bh=viUypo+OMN3mUNmL9shbhfJJuM+fyjqfdmiq9VVckho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRVc8BcUskiZXISfRYc3iuHIBQHhj8DzGlEf4w2hKgyd/AS8KxtqtcCt3ZRYIYQc+
         VkufH3GY5Lb+jCcaXw4MvU08kiTvXFbpUIBJCAripPmb/Gs9QfEtVo2Yyr9+WXO/Ji
         azjl4b6V7YWq5yX/Up7Iu8sQ1L1LFPXXl97QbrjykHOMmYYjlzATDWnmacceka4zkf
         ZpTN0RIwL4xRpaReCruHqu8Vv/X6JNS9Re39kXz67rrjLLwwACiMcYXNHJyIGg2Uoq
         eU3oYrd1VP8WLh5br16ZeFupqqCHI5miQagdAzeZqXZgCiqfhoLv60fFouzk/Gzh9q
         4XDxwcPRim3aw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 20/21] btrfs/super: allow idmapped btrfs
Date:   Mon, 26 Jul 2021 12:28:15 +0200
Message-Id: <20210726102816.612434-21-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; h=from:subject; bh=JZT0rpw1qASMxVN0tMk7Lr+GQH9r1wKgFAg3opFUEKo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zMzvv5fPWapykKJ9u1bXz1YeKAxcOPDxztEXOY5LWpQ vVTyqaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAinocYGRo/87Bf6zXl/mIe9329mh qj0AKukFMxIlIdkjcl97cqlTMyrJzCuSI8YuunSkdnQ1epA6J1jH0PZ1btcrtk9fS/+wczdgA=
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
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

