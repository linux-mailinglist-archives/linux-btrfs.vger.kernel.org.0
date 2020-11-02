Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A02A2D4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKBOtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:39756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgKBOtK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BX+UPhdE28sS5tZrI3WO761zv2IAQOXMSdGR3ml9h0o=;
        b=YihTbadx2H14Kby54eBrmcEpdKxH5wxJ6P1ha0rqKHzuc4D02jnkG7NddTlmshnCxAFUau
        Bb8ATs4r1A365jJrEQ+4a4z4t9J73vb3uyNH6vRYm7IMoDC3yZ5IVYy0z2Xp/CGsirN8Oc
        ZdlN4mSSJcYbowYTCwMAradIVYhDAUw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6A2FB902;
        Mon,  2 Nov 2020 14:49:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 02/14] btrfs: Make insert_prealloc_file_extent take btrfs_inode
Date:   Mon,  2 Nov 2020 16:48:54 +0200
Message-Id: <20201102144906.3767963-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa8c3a73bf1b..f31132106fad 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9566,7 +9566,8 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,

 static struct btrfs_trans_handle *insert_prealloc_file_extent(
 				       struct btrfs_trans_handle *trans_in,
-				       struct inode *inode, struct btrfs_key *ins,
+				       struct btrfs_inode *inode,
+				       struct btrfs_key *ins,
 				       u64 file_offset)
 {
 	struct btrfs_file_extent_item stack_fi;
@@ -9587,13 +9588,13 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
 	/* Encryption and other encoding is reserved and all 0 */

-	ret = btrfs_qgroup_release_data(BTRFS_I(inode), file_offset, len);
+	ret = btrfs_qgroup_release_data(inode, file_offset, len);
 	if (ret < 0)
 		return ERR_PTR(ret);

 	if (trans) {
-		ret = insert_reserved_file_extent(trans, BTRFS_I(inode),
-						  file_offset, &stack_fi, ret);
+		ret = insert_reserved_file_extent(trans, inode, file_offset,
+						  &stack_fi, ret);
 		if (ret)
 			return ERR_PTR(ret);
 		return trans;
@@ -9613,7 +9614,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	if (!path)
 		return ERR_PTR(-ENOMEM);

-	ret = btrfs_replace_file_extents(inode, path, file_offset,
+	ret = btrfs_replace_file_extents(&inode->vfs_inode, path, file_offset,
 				     file_offset + len - 1, &extent_info,
 				     &trans);
 	btrfs_free_path(path);
@@ -9669,7 +9670,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		clear_offset += ins.offset;

 		last_alloc = ins.offset;
-		trans = insert_prealloc_file_extent(trans, inode, &ins, cur_offset);
+		trans = insert_prealloc_file_extent(trans, BTRFS_I(inode),
+						    &ins, cur_offset);
 		/*
 		 * Now that we inserted the prealloc extent we can finally
 		 * decrement the number of reservations in the block group.
--
2.25.1

