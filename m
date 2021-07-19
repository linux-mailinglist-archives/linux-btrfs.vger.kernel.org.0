Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461A53CD392
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhGSKbD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236405AbhGSKbC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13C4A600EF;
        Mon, 19 Jul 2021 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693102;
        bh=ccO7bD571pZuz4XLMjKf9TMYDBuf0k09Wn8M9r4fG/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+eOoaQ0KS4FLSgOyOjDeaWUaPtxpmeHt5oP0GkD6s3IEhA6zZ7fBq6SdRD7vVkOd
         SkREoj9vMC37iJfWuzYCN4iTkbT8jGTZZewW9o5r4Z92xieOAQokYxjMyLTLbXcKvR
         9gWrZd9fC3IAlW7fTHHGdcMlClsky8DfHdkKojC9LD1BP7UJGdk8xNDZH2RXvweAJC
         2q0sH6kPPwgQpOzOLJhgeQBXgITM+1H+Y8VrD5DraAyTK6+ESzYG31vdj12GZz0swq
         qjPL5r1ot7NN45/PSdJsnVcqP/lb0Sz92hXC1YK2aOfaIEPQjkd3VnykrtV8HIuZl2
         TsQ/CwrdPK04w==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 17/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SUBVOL_SETFLAGS ioctl
Date:   Mon, 19 Jul 2021 13:10:48 +0200
Message-Id: <20210719111052.1626299-18-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; h=from:subject; bh=wBBRnXynCMgW/zQ4GNupvoxQkjtO0Uw0TI/aFXGcBJ8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd2xVZNDTiupT4MtYrlbrnHBlZ6ZqeZnPqrnaNvOVEv5 8DGpo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIcnowMGzr+H1R8uXajQ1eOqc/6R+ 38qRGM50/+0+Y8erGmJsEkiZHh3uq9UwWeBGc+0rnacH7VDLWnLgrcJ9Y3b+64ILP5/85ERgA=
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d631a1cb621d..73a477ead145 100644
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

