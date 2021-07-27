Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F393D73BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhG0KvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236401AbhG0KvR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:51:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E62B60FED;
        Tue, 27 Jul 2021 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383077;
        bh=8/wdpW6ZRfdpLUMDczSPKfKC3lOy1ruGV34bYfkEt4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loc51CdlEAFymJ9/izSZXNviv6TA/CPCjFlsrwveNta0XxwuWtN1IiXJzYndEDBS3
         FIl2hnnSzZgGX5l+dQakMX66v8qWqYI1RO4Er4lL08O6GDKJJtn7n1nlFVctabBwYh
         BE8DPoNF3Za85os7QU3hbG5DhzA/dKaH1NVHmyC+A7mc2pfQWvnNrFGTC4SMic8bRj
         hqm6POLVvOHoa/q/Pa5rVS1y+4dM+TF7ufWs+ckNiePvrLCm6+lVVGyT97eV7dBJ06
         4peCu+2KVrxyjvocKCmNU5ZaNu/OMO3I5pZRYXcvRAijx1rCcFA4CG6KvH0W/Kb/0l
         LmMtNtOna2bFg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 20/21] btrfs/super: allow idmapped btrfs
Date:   Tue, 27 Jul 2021 12:48:59 +0200
Message-Id: <20210727104900.829215-21-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586; h=from:subject; bh=Ol0dO5u99pcXu3/4DfTR8pullkZ/fw2iVQq3txGXh28=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzI9W6+K+fXT5+URgp5bb5e5zRb5lyseZ+gy6Vs287+g xNz7HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJPcjIcHV5WNd2u91uf849uh290H zJo9n+7F/W1Md6/U+6anHxpTgjw1yziWy84cJ3J17mTlSdtSfw0E+JDLmk0nAF+9trPf+m8gIA
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

/* v4 */
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

