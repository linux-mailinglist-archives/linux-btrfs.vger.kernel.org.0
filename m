Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1F3D73AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhG0Kup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236227AbhG0Kum (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 545C7611C5;
        Tue, 27 Jul 2021 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383043;
        bh=tykS0pNTe28EHku2KT+uX8JjxtrLcHfmZ/1zjva7qPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozxtQszXNgkYPA+hdvhTbHZu3KbkU0/xA0Vk+CZARidWMGaMahxGjP+YmxP3Wr4gU
         w3zdjdsAZe8oY43op3rVZFqkCdamTD5wyR3UerEziY/AZUjNiWrqFVvjC+FcvkXH5P
         SeZm1WQXwotiGSJ969WuDXiesXHmxWFzWYXn2fiRYiecbqYh4D4kQBMNqn4+OPa72j
         U3Kpo9lJEdug0fcCpV/RqF1arKFEaB8RjugHIILv4Qk/zQlVYf4E6G9Q7R7QbJrhEo
         hG0EnuZRumXhFXppRaaJROrwzM//LeZjb2ITz5AG7i6mqvDDeFq3oYPf4XK2QYqlDE
         l/kUbMXFnwWmQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 06/21] btrfs/inode: allow idmapped create iop
Date:   Tue, 27 Jul 2021 12:48:45 +0200
Message-Id: <20210727104900.829215-7-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; h=from:subject; bh=BT9Cf+qB2KXe6FKBUwilUEsXMNwVTCmukMKssLxXn/8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzJ5x/7sa5u0Fb9LBU4PWJN1+/zZuXlHljrPWdlyrnrt TedJ6zpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAm8uQow39/p6Uv+Bo5L/pYFO1d7H tzbU3WIpZ8s/wnwvus/wfF8r1l+F/TFrXAS7FFfcZd1caoY1texJT5yTLvS7A8vXFJ46TlWbwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_create() to handle idmapped mounts. This is just a matter of
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
index 95068a7dd9c8..ffbb995de590 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6729,7 +6729,7 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
-- 
2.30.2

