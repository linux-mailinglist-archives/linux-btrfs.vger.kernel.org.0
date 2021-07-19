Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0D3CD38B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhGSKar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236615AbhGSKap (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 543DC61175;
        Mon, 19 Jul 2021 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693085;
        bh=ZuOgNGFu5VtL8lybo20fI0VubHlffH92/itsSCW+9TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzvFk2Cp2OpfFhwf4zYkqv1EnBDJof/IkZr0O5YWsrJ9Qwt6BbhGrEYqq3HWBA6zd
         7EJ8xDkqDauCIN1lWrUKqi3CQTFC4s8mXXsZE7pIAWTrMgFwjIOaqkXecieUPXbNWO
         hlHkm1Ceg6oBSEw9F6ea+IRCXxzxN8OYBTTlCcqWWZURjoM5DIFnRjwaAJlif0XMf3
         A26nYc/IEsCLh29PMi4KIdBFCyg8RSoZGcsdPirS0KdaN6fIdX/Ngjpg6d5TI6tnRt
         GwE1ECetjihPsY+7/lNvhy4fO9WwlJmEMVspzEDlmUilxpnPk41KSutk5ky/n7C0LI
         nGuTNF599qAcw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 10/21] btrfs/inode: allow idmapped setattr iop
Date:   Mon, 19 Jul 2021 13:10:41 +0200
Message-Id: <20210719111052.1626299-11-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; h=from:subject; bh=i9z5ckMKBoh7zmQy2KHIxk/ORQym3WjYxk7MqoB3OHY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd32c/f7ZMf8Rzt5duluurBsZ9KOhAt8e3p9suWON13/ Fuvk3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARnkOMDH9z/v576uoRpLbPdF+cR0 Ny/t4nra2sgR2s0c/61/D92cfIsEFGTmu9/9vtmQEH+Nuf6d7pt/oVmFoz8QfTOhlmxrBMFgA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_setattr() to handle idmapped mounts. This is just a matter of
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
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dc368394722a..53b038029440 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5342,7 +5342,7 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(mnt_userns, dentry, attr);
 	if (err)
 		return err;
 
@@ -5353,12 +5353,12 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	}
 
 	if (attr->ia_valid) {
-		setattr_copy(&init_user_ns, inode, attr);
+		setattr_copy(mnt_userns, inode, attr);
 		inode_inc_iversion(inode);
 		err = btrfs_dirty_inode(inode);
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(&init_user_ns, inode,
+			err = posix_acl_chmod(mnt_userns, inode,
 					      inode->i_mode);
 	}
 
-- 
2.30.2

