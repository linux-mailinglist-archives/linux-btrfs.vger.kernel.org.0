Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC983CD38D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbhGSKau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236565AbhGSKat (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C10B9611C1;
        Mon, 19 Jul 2021 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693089;
        bh=6pC1/Vg74n3UrLGPxr9y7KPh8T2eieOU7Tbw0Pqaa9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+kEU8CELUb+y5XamMZdUb2lLyXSZWk/iqhvgeCBtl5SY6t9aYRrLUkpIGIajg8yH
         HNfdJgNo8dnvmIiY07YKDrzQ+W9dfAuLsiYStTMPX/zkA8VJv2mlFXhGhoXLMwTqHg
         BY1/Y5G7U6zksyJwTq6cFc98vlophIdG0AkulBLLs8aWye745+nNWqF0oZaHh3EOHD
         OCDKf9nsHdPqVx8FPkcdct0wxrt+8HTIvy0nkNKBzSxjCiQTSxFRRkRiQTI2fgYHgx
         HV9+1Rarl5seka1pUviM5+JFZMhY7bFKcsUB/sg0qBN+K97Y1nuuo1F5GEJFTAx4Cp
         05zTDLuOIZaaw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 12/21] btrfs/ioctl: check whether fs{g,u}id are mapped during subvolume creation
Date:   Mon, 19 Jul 2021 13:10:43 +0200
Message-Id: <20210719111052.1626299-13-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; h=from:subject; bh=h6XmDJ4Nl/4O15SVz//vkf2Wr/ioFFzGSyvbstNw14k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd12wOnTYkOPf34dB0z0fJeqWy6vf/U9xJYtPm9dx+NK eS2+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn84mVkWPX0VEaqOUNd1r+edxufCi kuYpw9+2Nu8to/J9fM4T453ZXhf9XM0+timkvCbt1eIpv/R6Skmy38khi/004hwYP5RX/j2QA=
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
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

