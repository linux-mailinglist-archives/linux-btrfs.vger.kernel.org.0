Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27E83D577E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhGZJsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232453AbhGZJsb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55D2F60F56;
        Mon, 26 Jul 2021 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295340;
        bh=1CDMCDmZRtq+M5MA+OFxWLDj01b9pbjhDSzC2XO1Yqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9yXa1wwK3x2aIjzK7H6dxi271R69WjqZUPQnYd9ys9Jz1fxPmJqmw2HhEZeKkj0I
         oUnAC9xrl2ldNFNW7iBsYKN6IyW5FBh+fZ5z7KSYVuORKBnd/BrxhboAu1q96Rx1g4
         11MJlsTrfGMjiAMycTrvwBlql5zElxWslH0vpSOx2W7ZfH7/ApXtf5mSmDvcR+ri2I
         L54z4dWeiT29hwxGF2f0zquRzmhX56/Z9vrJMe8+r5UNMDbYY1U/Mib9b/NkxPtnbR
         sjJzJKtCWnSxCqn/tXu6Mw7gMzgRrfvVuNd1b+ogsxUXIKa4/ZLyenmhTTkPr/X9Sa
         fPtVTCq6sWLcg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 04/21] btrfs/inode: allow idmapped getattr iop
Date:   Mon, 26 Jul 2021 12:27:59 +0200
Message-Id: <20210726102816.612434-5-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; h=from:subject; bh=l6wkerxVBoxvyXKw1y2h5evJrMKJx9iq19n2UV1jl+g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zOMruoT5fkWdtD285sJl5skHrH3bPFcLPbzwElNXotL C8W2dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwktJvhD88+89rP65wuP6kp4p7YV/ HcYikT57IDHobGM2alMFVvEmX475wZeY4xI0xi2fsCa+s3jA9a8/cLlH5pXbYk9mGzG4s5NwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_getattr() to handle idmapped mounts. This is just a matter of
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
index ddb60462f5f0..e6cc2b155b7e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9195,7 +9195,7 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(mnt_userns, inode, stat);
 	stat->dev = BTRFS_I(inode)->root->anon_dev;
 
 	spin_lock(&BTRFS_I(inode)->lock);
-- 
2.30.2

