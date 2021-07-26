Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9583D5780
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhGZJsh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232508AbhGZJsg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BF2E60F55;
        Mon, 26 Jul 2021 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295345;
        bh=tLSen11iAR9GdQZv6PpVB/AxFlVu0VG8XYvXJXlyW74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cdyij6PYZ5iFWr0Ng+x5JANHLjZOtVcmle0nFhT8fGfcRtHTPRE3Nn5a6uB5INxbR
         j9fjkUcowhKU02aEHy90/zhdPzu52IJgc0Y/POsaB6OjCksay7WRo9FsoUT/kUBWs3
         DdCeqcbaNwvbKQnmElGS+aeA2bhNEmUMhkuEcW5V/T05NrFgGpaux5xlJd8ryGXdbr
         zs8vIQ44R0LXJSDLGm32qzlf8o1GMi47P+mu3Himu8e9EIbqzI3ZdwP/wQzzJI1i+g
         xVTGeirKyXoPC2A+3fJQINitE81Pf1jKh+pNh5RH+iOpTcBn5DOKQ9VfrSPt9qXuW4
         ftLzEi3QyX88g==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 06/21] btrfs/inode: allow idmapped create iop
Date:   Mon, 26 Jul 2021 12:28:01 +0200
Message-Id: <20210726102816.612434-7-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; h=from:subject; bh=Fxd4ihntjwBZvMhLCDp2LbIgtdbDP7kXZd04ZOSOtso=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zNavonz5b2rk1h61Yr4nvhOOPDN+DOXyIvye7u0ltgx 7+ue1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLmNGhm4Vmz3WufEFvnrhNkczO+ WDjh6pCIvpTllz4vq5Rcl8+gx/BT8scL4ul7zWLZltW1eE7MbTx9RNT7xQE9Ytl4l5bqTLDAA=
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

