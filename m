Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA8D3CD389
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhGSKap (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKam (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1475D61166;
        Mon, 19 Jul 2021 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693082;
        bh=QCV+GpNkTo0y4JvC9RYQUdviGDle7/zmA60ZHUc524Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neNrqUweAJX+zxaOa1mL6gBXDNImbmbKfJB6Z8mh9x+ROW4X/TqYehlp49fAfQ4qn
         kRTQOTMQ12hreslCITYrtzcuZmAU4D6c9k5xZKE6Lq78+IZA6GA/cyeIFl8hVqZtZx
         01XiUMHovSjbipEpuRFpJAQtGOfgR4wV3qBVQHQoHmBRKeXnx80xvDw+rTPlNj9j/U
         IxrDSvsPd80zi2YhYvnt1YijcwL2m5SqjfuX/4kMAvUZUxe1ZWhfG4NQyBiMfJ3Frf
         cXNlcycMHNGJG8DlMx9sMfQKA7GYJm3oCvvZHWxwEuHDQszUBI9Az5gR7dDG4C3ndV
         MJtQ0Y+u66aug==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 09/21] btrfs/inode: allow idmapped tmpfile iop
Date:   Mon, 19 Jul 2021 13:10:40 +0200
Message-Id: <20210719111052.1626299-10-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; h=from:subject; bh=Ky4zY6yxQDSLvjxKhqLrj2QdxlTIopmvKtTY1x8KkTA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd26Ifuq79OOB/fVrGT+vX2yQWEF31MtH1OOov2KKRef f9SM7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI82uG3+y/uiYY7+EJWeWkaLol26 faZYIwR5CXjdire2eZ22at9mf4Z88l6tCk8dFfwNGoT+5IQvC87tUJec+tNGty2jrOLnPjBwA=
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7ccbd9a2723..dc368394722a 100644
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

