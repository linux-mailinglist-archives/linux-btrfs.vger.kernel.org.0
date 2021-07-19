Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE43CD385
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhGSKad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKac (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7617610F7;
        Mon, 19 Jul 2021 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693072;
        bh=C/bfjpvy2X9vKObx4pY1O6Hk4QoLLjdLZoWTFAim0N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwS266Zwn3mM9b96FnNGmSC3hwrg42ARITB2L/zQOUTm6fHJssjDPlMwhUTAFJA0V
         C9/G2C1UhM1vfRUQf/Ackfjdfj222lxA7n6UusF9xET0inTIKORF9lpaKzPSh0tarD
         Qpk0+e1J8GVLrDQEDSIlgOk4NZX6doFcv/p8qjmIbSM7HwBeB7SWfamb6UkV5yF2OV
         52xsJoJ09/b6HPdBFiLV6U9ShSpIZ7/xA/lGw4N0WyX/sQwzuX25xN5lOeNp1nWCcI
         ZmIuaSCu1PAZDu1kWYt2tE5J1FALfJKix9ZBE6e/l6poLII2Zf4rBRNiUgYYMNxln1
         ASiDDug5AKu2w==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 05/21] btrfs/inode: allow idmapped mknod iop
Date:   Mon, 19 Jul 2021 13:10:36 +0200
Message-Id: <20210719111052.1626299-6-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; h=from:subject; bh=APpgDIYKdPKMH3ZuZmxTjcDSjOi/dUdt7nAZdxo1CzY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd3yXy5E5kjeK6enh3cXNPJtuxXifkJE6kXO/DNVUheb Jpxf0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR9FiG/2EeGwqetFf8c2JR8o6/cT Lt3FbL3tlvgg45GZhcMrbMusHIsKYmmePBhemW/Dz+Rn48r+06RTyt5vs4bmLcUuq22rqVDQA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_mknod() to handle idmapped mounts. This is just a matter of
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
index 9b345af1c3e0..1a50a039dc43 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6665,7 +6665,7 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
-- 
2.30.2

