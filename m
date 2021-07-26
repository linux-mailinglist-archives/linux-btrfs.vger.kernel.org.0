Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB83D5783
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhGZJsq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232792AbhGZJsn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D77B360F5D;
        Mon, 26 Jul 2021 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295352;
        bh=ygTqKOWf4SfH9jIqd4biFcbtKPbw68yJ5OSZL7koLME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhYqhpPjKt1GsjpT/bj/pdX0gfnp8fMQbKi9PyEZVKVv+qIrjzEJ1vyOeQveK7mo5
         oVTv8k1VPiyUBhdTsenhYIn7vBwvGyuskX3dRXLslRaMzT7m5rZqB4+KZ+P9xhw+p6
         W4Fq00xg1LbELPXqoFPudxcDwET1jcT0rges6vSB1IZ/4fotK1DQtOo/3i50fbF8Xc
         4nNNyC9D6BZ05/HkHF5RlZBdYtn9WMaf/AaTbZnqmWKx2uYqLk4pAayujHgRnIEJp9
         wLzza6vkvhYQahVZXK7ia98GaOuQ3M9PlGSS9uq5ighs7vcXFUAOWimIXYaSh0Ukid
         258zXCtMFggXg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 09/21] btrfs/inode: allow idmapped tmpfile iop
Date:   Mon, 26 Jul 2021 12:28:04 +0200
Message-Id: <20210726102816.612434-10-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; h=from:subject; bh=t64Lw20jwnlqigBfE2nBCo7bR8oQt5qNrpJd7XIDeSs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zM2tncJdnVpEpjck9d47UnqBL/nfF+Pbfh8csJn0aCr D7ryO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSs5iRYfG9U82fM3LXz+bwv3AqMC FYqJqTU/fjGiXtM2y2RTdl/Bj+R1fH3PbMlFlQff1dVpfI7vrJ0/SFVvaptkguufxm/+mnbAA=
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

