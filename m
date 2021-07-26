Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E133D5786
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhGZJsw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232702AbhGZJsu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 031C160F6B;
        Mon, 26 Jul 2021 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295359;
        bh=GsGtyy96wqnROlp2/bZoRye9OVCjTkpIpqpGkIk4cCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lViMR8Ay2QRlxKnznOClQ7bQllNwz46EXJVEvfVWkXvCpYY/AmndSMCbatAn2e0rF
         3pfg4g6uRqjUZY6KXFYc9btb1g/ZrKWGgTBT6wIWUBiQNwnnGHsPqOiYlvVWh8gt4K
         brr0gsNDDAVdc27qqRMvDV5FzyRzEATCt08xbzzV/RnjEYF1LcOURGVwIgAmmTt6UX
         0YdiOE1m1px18umYXyMkq+uyunHO/VE4aLAwO8SydeNh1ITjCHV3xjo1QvS3YMhZjT
         pgi0Xa+1gdEqDqHCiZOgMAR+cwyYd9T+V4fPmC8olX1K/j6FA/iqUy4V59akms53Cx
         Ahc1FYJKj6PEw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 12/21] btrfs/ioctl: check whether fs{g,u}id are mapped during subvolume creation
Date:   Mon, 26 Jul 2021 12:28:07 +0200
Message-Id: <20210726102816.612434-13-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711; h=from:subject; bh=xz/8Sa8HC1Rq1Hy4H8Ifh+XNuNCa36O1jKpi/ZdNlmk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zOxTl9VopScblv1LGIZX1ykwFKuj6HbItgZLh00/2l+ 4dejjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsWcPI8EB3ipxIw9YQ36+JBvc3Cj zfxWbm/o/vyAGOSpcjfztjnRgZFv+Z8+hA2oKHqx5wSKQnN30XLT4Ved+zvVwu5fCXur9FnAA=
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

