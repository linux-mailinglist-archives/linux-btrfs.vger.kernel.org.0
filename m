Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C422C550C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbgKZNKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 08:10:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:58908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389879AbgKZNKm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 08:10:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606396241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22TzdYMAeUCHgKpKrHUbP/2lzsFKBdQxXTb8xYTqSzY=;
        b=NvDPG4jB5BdGZaJV0obvIx3oOWswNOoHqecf+nz79OGfBPVzlQGFykh3/vgQI4dbfLNI/Z
        jOofzxMnA9LzqUOfZmon5UCYazlHBhwAz/f/iJGSoiFyDESWK3Y4VGecuGOFKiDT/maVvA
        +L935rhE0yoCCH5y3tkB1bfBGStL0OQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0126AD87;
        Thu, 26 Nov 2020 13:10:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Replace calls to btrfs_find_free_ino with btrfs_find_free_objectid
Date:   Thu, 26 Nov 2020 15:10:38 +0200
Message-Id: <20201126131039.3441290-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126131039.3441290-1-nborisov@suse.com>
References: <20201126131039.3441290-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The former is going away as part of the inode map removal so switch
callers to btrfs_find_free_objectid. No functional changes since with
INODE_MAP disabled (default) find_free_objectid was called anyway.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 748fb21e8180..70d964170497 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6349,7 +6349,7 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_ino(root, &objectid);
+	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -6413,7 +6413,7 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_ino(root, &objectid);
+	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -6557,7 +6557,7 @@ static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_ino(root, &objectid);
+	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
 		goto out_fail;
 
@@ -9057,7 +9057,7 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	u64 objectid;
 	u64 index;
 
-	ret = btrfs_find_free_ino(root, &objectid);
+	ret = btrfs_find_free_objectid(root, &objectid);
 	if (ret)
 		return ret;
 
@@ -9520,7 +9520,7 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_ino(root, &objectid);
+	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -9854,7 +9854,7 @@ static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_find_free_ino(root, &objectid);
+	ret = btrfs_find_free_objectid(root, &objectid);
 	if (ret)
 		goto out;
 
-- 
2.25.1

