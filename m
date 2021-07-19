Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E33CD388
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhGSKal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKak (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A8C361165;
        Mon, 19 Jul 2021 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693080;
        bh=GlTbanHlGqytxA7VyiW6PfWTtYO1uQSd3xXy3D6Md+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKM2vAgDIt152NLEDEOFvzI8I4Cntaef3YiV/HzntT1aRgd+rPyvbq7aB30tto0/e
         thN6yZ+SxOt9lNNGbAMYv32p2Q3VAWvUv5m4R5mFovMUrJ3BYdVMb7VVASDYrZnZFb
         pNTDGGpYM97OpdGN5pI2o5OZf+Ov1FANL8PyGwQEg6lhBFuWO/ONEgN1HdVct941S2
         MB7qScNxO5Qax2XVixq59X++SNpPQHWJ7V/DdiANPbO+lMwjBKpw40wu0J3Rtqel2s
         EU8DVjs6cF2aaiQt3EBzJEA+ccRP4rG4byR+i2AaS6dTUCzjv8Oyghvp8vsDdebLtC
         TZeUvFmkCQuWQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 08/21] btrfs/inode: allow idmapped symlink iop
Date:   Mon, 19 Jul 2021 13:10:39 +0200
Message-Id: <20210719111052.1626299-9-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; h=from:subject; bh=mbPwWxbkNbTxpdh5z2P8s+TG3a/hIPCFOcR0hSm3Rkw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd36qcxvSsBxXsYppxO0srYcXbGwRD6zqUJeSdl3srYz C49WRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES6oxkZVnZ15Na4cG8vtXicwdV2JX Qf09+3UgKlFnFfZJOVuCYsYWS4/ezVbPfXbz8ymVqryxprvX2gz28pra7f27A8r3z3p2QmAA==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_symlink() to handle idmapped mounts. This is just a matter of
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
index 9f0af257f89f..d7ccbd9a2723 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9947,7 +9947,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name, dentry->d_name.len,
 				btrfs_ino(BTRFS_I(dir)), objectid,
 				S_IFLNK | S_IRWXUGO, &index);
-- 
2.30.2

