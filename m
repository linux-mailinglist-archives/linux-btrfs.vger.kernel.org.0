Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BD3CD387
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhGSKai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKah (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDE6B61164;
        Mon, 19 Jul 2021 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693078;
        bh=eYLJ17pWsfGbJMXLUA7WIN1te8q8LYuL3ubXp53nkEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBTy0MrhQc41/mhaf1Un/tm0AFzuMoyOvGFuvr+MklpyeLLwRVnKDw50wXcrJmb30
         9O7qvqkBTNo2IeBcB2aIA6XTv0mSXYm1PZ+t8gyskdCblpasnpn59IishU658B5DzR
         8u5G+juoMZ/sp3iB5D9KXwmnZD2/sZyKJerovVhkLbVWatNeacGlYnqgsaG1OWxC2U
         MCrWND9D9gQT4lHNeGpuBnBvKAAbpLiftkp6RFfo2SB5qbAt5zvev6QVSa23iwdBH4
         M1pBtW324raK77jM5l2SKgxPxUhD/mj89DQQHGFF6vh/HZ/wBKp4bgTDL2Rvygst22
         GjK/V1lQWMBsQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 07/21] btrfs/inode: allow idmapped mkdir iop
Date:   Mon, 19 Jul 2021 13:10:38 +0200
Message-Id: <20210719111052.1626299-8-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; h=from:subject; bh=kgLQNybeZskpDLxMR1mPPzmKcyFOn39hYXRVzLKQOGw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd0q/Jf70u+tv/esvLk7+tp0mU/3ko0uLDTXPTJT3o1X LH3l145SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJsAsx/E/scSmdFvh6WezxmSyyLJ P3bj315hz7/LQ0+3n3dkuv+qPO8E/J9nFJ1+M3xgYN82+kvORe5+O/NUVxjqaWVuFG6+sv5rIAAA==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_mkdir() to handle idmapped mounts. This is just a matter of
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
index 1fa290bb5272..9f0af257f89f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6874,7 +6874,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid,
 			S_IFDIR | mode, &index);
-- 
2.30.2

