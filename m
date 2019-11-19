Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36AE102C36
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 19:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfKSS7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 13:59:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44214 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKSS7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 13:59:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id m16so18820553qki.11
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2019 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUAv+1JZVWCnK47S5RY03BIVAUv7V2/G3MnCEai+BZs=;
        b=TuZa/bOfpktHjbntYx+LAmmH6vWwV2ZH6hOgHAnM3Rvq9iZ7pyzgdCoUTGGFTtwQdY
         SGPBMmV4vnnTD+cZ8UXAkHcnkC+MAX0ayJm6WuQtHadqe2nQWCCLZ4x4E7M/P/za5mbP
         Ja3JaEbDWbx0MkSFn7HD0TRzWgbGayoEpUF5VfP5tedcdaBE+nNgGLO7IXA2vRzjYM5J
         7pJv6g+Df6WcDPLPWZYs729jhqHe+04fa+EuIDl+V0rHxypgvNbrSZJeCAuMZWWnHkcz
         kTGdf0M0R5ZZJ0K80Pqz+mnbnR7sCRhOKkCdg38hZwYUtO+tpHUHWO/M2Bh6KLN/q8o5
         A6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUAv+1JZVWCnK47S5RY03BIVAUv7V2/G3MnCEai+BZs=;
        b=ttCHgtRslbTFRJUk6puLYFJS3uhq+Lu4hRS014ZCoUq2cpqNvt3wpC2jX13rd15XQw
         lPTmGLWf+hgwyIJ5xLZT/sgWCHLhGuu/KkiapdUeve5ZwmupKTiqgz7WH98opsRZi3oS
         mpZkPC/8+I9+nvgnq4zc2Ujq1pB/757vQ4+NqMBbPuCN78E1DDMtAUMT0ydVrg2tM9xT
         rAWvLnBtvI29nEmBOJCbYWGZhXXlkQJfPD2N392exj0+YIqr2dXlE38fgZWgoF7cnryk
         dYwnsLpXfdtfrMkorOeR52VQf5YDxhs3eWo4RkbujvYWGbYkxIOS87LQBc4KWQbhef37
         nOJA==
X-Gm-Message-State: APjAAAXodUlJCKEjvo4l0mMKDKOzJ4RBLtA+clyoZcBgir928/4NOkZS
        Y2g4NntCuBXNlkM3av4otI1/a2WOvoVmKQ==
X-Google-Smtp-Source: APXvYqzkY40iUtA+ZuoBkTxAuQbLJn649rg2Mt0Z6WrC9WxTvyOvqtkeOPLX/vR+OmnBWOdXLbRSiQ==
X-Received: by 2002:a37:a54c:: with SMTP id o73mr31914954qke.164.1574189977308;
        Tue, 19 Nov 2019 10:59:37 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o1sm3498074qkm.5.2019.11.19.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:59:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not call synchronize_srcu() in inode_tree_del
Date:   Tue, 19 Nov 2019 13:59:35 -0500
Message-Id: <20191119185935.3079-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Testing with the new fsstress uncovered a pretty nasty deadlock with
lookup and snapshot deletion.

Process A
unlink
 -> final iput
   -> inode_tree_del
     -> synchronize_srcu(subvol_srcu)

Process B
btrfs_lookup  <- srcu_read_lock() acquired here
  -> btrfs_iget
    -> find inode that has I_FREEING set
      -> __wait_on_freeing_inode()

We're holding the srcu_read_lock() while doing the iget in order to make
sure our fs root doesn't go away, and then we are waiting for the inode
to finish freeing.  However because the free'ing process is doing a
synchronize_srcu() we deadlock.

Fix this by dropping the synchronize_srcu() in inode_tree_del().  We
don't need people to stop accessing the fs root at this point, we're
only adding our empty root to the dead roots list.

A larger much more invasive fix is forthcoming to address how we deal
with fs roots, but this fixes the immediate problem.

Fixes: 76dda93c6ae2 ("Btrfs: add snapshot/subvolume destroy ioctl")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8db7455fee38..fc0624fbe387 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5729,7 +5729,6 @@ static void inode_tree_add(struct inode *inode)
 
 static void inode_tree_del(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int empty = 0;
 
@@ -5742,7 +5741,6 @@ static void inode_tree_del(struct inode *inode)
 	spin_unlock(&root->inode_lock);
 
 	if (empty && btrfs_root_refs(&root->root_item) == 0) {
-		synchronize_srcu(&fs_info->subvol_srcu);
 		spin_lock(&root->inode_lock);
 		empty = RB_EMPTY_ROOT(&root->inode_tree);
 		spin_unlock(&root->inode_lock);
-- 
2.23.0

