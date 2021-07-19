Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FB3CD386
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhGSKaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKaf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B5A86115B;
        Mon, 19 Jul 2021 11:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693075;
        bh=iL4KHWPCNL9PVntTO84YtX5UmPi7ZxWMD2s2MdlFlWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iw1IIYX1ztZIhl9PqRNknQUHlsKX42nVSONqHlJ8OnGk67Cnkll26Bwny3JfO7Htj
         erEulbdnGmXidXYBuYXMNM19LPVxxxR4NZsk/krijidmfXq5QiP+itmmapBlJdtve5
         iWLU/Bb4LJZY0b/VOFaukHfsAyyhNnEt17jtFc+nS02SjzlIPknFvaCXUOakyzyHIA
         EAvaVFgpnuYbHarcsQn6T3LUu9YXqa+mR5O9eFLVUeF5hdLzTfOTEDXdicf6VThXCY
         oFckbkvdyCb/vw8rF5o4kb/6Rh1DzZUYJRP3dATfB0WIzK9p37B1aw0PfjULil9JSP
         8iI7Fe+ty+L/Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 06/21] btrfs/inode: allow idmapped create iop
Date:   Mon, 19 Jul 2021 13:10:37 +0200
Message-Id: <20210719111052.1626299-7-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; h=from:subject; bh=8RKG9mSvr0SFetOJO2TELuKVry0Yzw+U+dIyyTPtWM8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd2y491RP7fSiXUv3jAcfGjq5Z+iw/5n5wPe4ANB62oS dz5921HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARQVGG/4UlM7t+T/u064uRd6dRts RpKf6alR7fwy7pLo2SC1Rp+cbwv7w97OjU4mCxtt9Vy1MvK71uZnUu37vQxEB603xp01k2rAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_create() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

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
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1a50a039dc43..1fa290bb5272 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6729,7 +6729,7 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
-- 
2.30.2

