Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0C3D73B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhG0Kuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236352AbhG0Kuu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95ED5611C5;
        Tue, 27 Jul 2021 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383050;
        bh=RjA1AM8aoqGKhEoIRT6DcHWRTUYoXxPddzNVH9rYXTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0nUl/piU1/TnSB1Vlih/6XsyMvKectqsCetz2RWucLg25hIphspO1OBKsIv38jEh
         touJQzxmphs8TjXpyP9Ld5Pg3Y6WyEC+0vE04RrnoBeKg1ZTd+X6yCmjr60rC/3gK+
         Lz752upiByo1nT1iKgvRLdIC6mv2ObIKOLOOwaufPG7JSL07E5/3VAiIkxmAIBhHZC
         u9kDgO3w3sEteb0ZXO0GnUuC1yZ4Ib5X6v8CX5Mzg+yZ2nicGZUt7VeKGqtIxMUmj7
         tpTSf+DFaeIh5Uis3nOkBOUyfYmyCahUgz1qKDwaiNgOdhIcPIt0gYetlYzdvdlZUt
         q397AMHoe/Cvg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 09/21] btrfs/inode: allow idmapped tmpfile iop
Date:   Tue, 27 Jul 2021 12:48:48 +0200
Message-Id: <20210727104900.829215-10-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; h=from:subject; bh=37UYKbN/aBYXSXKbFV1SSnL0HVJkQAKLFWrm8zEmXVM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzIl1Gfbum9LuRw+Lv/y63umw6OiCSELP8433eU/66jr uydxuh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATkStmZOgMzMxye1dwX83xOnuV4K PvSVGcEwp/Oh18Yz9N/nXb7CKG/7GbNz6S53PNvl9Y/WkD15noI5fiLmX6e5592r7hbcn8Vh4A
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_tmpfile() to handle idmapped mounts. This is just a matter of
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

/* v4 */
unchanged
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5c133280375e..0a45e3152016 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10299,7 +10299,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (ret)
 		goto out;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir, NULL, 0,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir, NULL, 0,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-- 
2.30.2

