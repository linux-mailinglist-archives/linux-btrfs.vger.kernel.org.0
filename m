Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51226F907
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 11:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIRJP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 05:15:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgIRJP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 05:15:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600420555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9h5XQL5+aCRI3lgHHDvdJDDca1XOMoD15NTF8F+CaBc=;
        b=EN0bPb3U4v6Kq42UMkOK79kn8pSf8eFseli22N8frtyD4mntZvyNSEaW76tVu/B8PKJr9g
        XD4Kr9NYxIPfaWCVeXYTfUKLxicYLpMpWhN0tQi9bcuu/ZrPiFLuYSfZKiPf073AiiJKyq
        ZSI8APneNRJIeaQ8rGv2dGWXf0cfiPk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 959CEAD6B;
        Fri, 18 Sep 2020 09:16:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/5] btrfs: Remove inode argument from add_pending_csums
Date:   Fri, 18 Sep 2020 12:15:52 +0300
Message-Id: <20200918091553.29584-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918091553.29584-1-nborisov@suse.com>
References: <20200918091553.29584-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's used to reference the csum root which can be done from the trans
handle as well. Simplify the signature and while at it also remove the
noinline attribute as the function uses only at most 16 bytes of stack
space.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7554d7049195..3e203d84d86d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2231,16 +2231,16 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
  * given a list of ordered sums record them in the inode.  This happens
  * at IO completion time based on sums calculated at bio submission time.
  */
-static noinline int add_pending_csums(struct btrfs_trans_handle *trans,
-			     struct inode *inode, struct list_head *list)
+static int add_pending_csums(struct btrfs_trans_handle *trans,
+			     struct list_head *list)
 {
 	struct btrfs_ordered_sum *sum;
 	int ret;
 
 	list_for_each_entry(sum, list, list) {
 		trans->adding_csums = true;
-		ret = btrfs_csum_file_blocks(trans,
-		       BTRFS_I(inode)->root->fs_info->csum_root, sum);
+		ret = btrfs_csum_file_blocks(trans, trans->fs_info->csum_root,
+					     sum);
 		trans->adding_csums = false;
 		if (ret)
 			return ret;
@@ -2668,7 +2668,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	ret = add_pending_csums(trans, inode, &ordered_extent->list);
+	ret = add_pending_csums(trans, &ordered_extent->list);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
-- 
2.17.1

