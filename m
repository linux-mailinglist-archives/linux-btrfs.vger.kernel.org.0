Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844AC3D577F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhGZJsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhGZJse (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E764A60F59;
        Mon, 26 Jul 2021 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295342;
        bh=kpx5QYBXpn0Br9PAnUYNdx1tMbbnHY1puQW3yLcxeF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AweUurYe6GPwirSj0X4cgTO6znpCaR2RmWtROV9ncStrlK70UW7FKmol/NBYPD8XY
         NChQSe7LWcdxisqVb3cenS/SDFdw+1aZyT12HVCu45rfNGqiKlVIA8ofMCxYK8fcyO
         E/Ay3M3BrbZE/2Q8UTkm76INjNSrl94ibLgH/t6VnrIa+txUkhoUEc5aO5oyguWBKC
         dDhCztm6Y09p0QHWpgMFlUWYJfk0nR1QQ2JbQ4ns5+CDh6l00TK+q1L4gf52nnuQ4v
         YCIE9Q1I0kEgPD69mZ1XaQ7JYimU6Cs5xm3Hfad0Ay8R3QU+cmSBrZcWdWokx2wHB8
         98nEJdMlo4STQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 05/21] btrfs/inode: allow idmapped mknod iop
Date:   Mon, 26 Jul 2021 12:28:00 +0200
Message-Id: <20210726102816.612434-6-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; h=from:subject; bh=GAvlJHhe9fXm4U2xSff3aw9XTnhJbq+w9VI6tjK3rXs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zPKj2tvXFYp+czhd4iB6CkZfpHFDk0G/WuV6vS1D2T6 r9fqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEhXFyPDkVMiqms7p2m1/BQxVkzlev uyZ8XWih9e1tKveWIki/OUGX6zbL1grVdtc+bCgsrfszPKffWsovsfTzizImjl6Ts/QioYAQ==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_mknod() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

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
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e6cc2b155b7e..95068a7dd9c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6665,7 +6665,7 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
-- 
2.30.2

