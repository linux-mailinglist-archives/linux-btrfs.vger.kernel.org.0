Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD493D73AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhG0Kuh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236387AbhG0Kuh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6392B61220;
        Tue, 27 Jul 2021 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383037;
        bh=lsrOjRk2ULaBez7/7RkgcdIM+9HOAemrUoy01OqIqPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BP7Ha7GhunPuwr72yjvVglgZDxB9TdP0lFmKTfErq9dyHoIAdqotOXLQzPWNpDL/n
         4cNmESAWsXcMjfEhn99btbch37XgoFTu02SmZB//olyvU9Mc48In6/D9YDtKaBGpiI
         jnVTehEhgs0PAUoEv+odWEQ7Ew2lGzjYlaV/GE9wTnMRciglYd5mxqMyAL2QvnxJzI
         FxNiLJjAAwOkqmAI3fm3xq3Fxw4xMEh3rM62ddlPGy4ur17pQUl4W0qpUdGufnkJHl
         V622omYt5JY2wV/F14p5uLhwbyyqqr+JlsrP1valfrHLUX43aAMceIA2Hl0eB7sHj4
         o5t1IKNAB6WEw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 04/21] btrfs/inode: allow idmapped getattr iop
Date:   Tue, 27 Jul 2021 12:48:43 +0200
Message-Id: <20210727104900.829215-5-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; h=from:subject; bh=knsOklAN7VAasC8TC+bYMG37et4GTZWW3cNbMQoEYsU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzJJ6nNi/m4Xi2Kfzys3nYs/andwSkl/ysFnCmcWvtb4 38q3o6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiU6oY/vDVbWhaNFFDPMpNW7dRb9 4la9cHq070BEpvl7r/eUpJQgcjw0SjpSlN7VZ3lU4d90zNeCG5fIbdcSeOq/u9bpX3LDXOYgYA
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

/* v4 */
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

