Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0BF12D4B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 22:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfL3Vba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 16:31:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46201 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3Vb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 16:31:29 -0500
Received: by mail-qt1-f195.google.com with SMTP id g1so23556313qtr.13
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xaCphDu8isH+0R3TXU1WOLK3VnETnY1E9yt3zFz0ccA=;
        b=16cIKPSS3end2QtFl4Dh/Bo3qJo6Clno3R47Y7Nh+ZOCViPqiY+ArCrQitW+k+ildX
         g6tT+lMpX3pX0m+4ybbB36lTxMDKjHuNlsG6Ol6SwKojIiixAPpZCumCMv3E/Vmoa3/W
         g49s/JDk2Mqs+TxHNpZEIy9kn3hPLM9zVPtSBXYwuTHymmXl7z6mIQyWAgYLwMImxvf1
         mfoJVCWeYqvSgW7/LcKPhz3IJ/KbmCUgDKQZrz9697mVXRwDHpA6VM6ZvWDd3terBBES
         +qBc/mWpU1HyMHO2hdnRKl0MTgGekrwgL7HpjMTCtZAHl7+N2zPPNNiPBPwctcjPy2jX
         rlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xaCphDu8isH+0R3TXU1WOLK3VnETnY1E9yt3zFz0ccA=;
        b=ou68gUoqelgkyu1FNVpuS1Hz6anEy8ExTD8s1Qnns1+e8br7ZmOeK7G3AgRwBDTGXR
         yehNWg+T3ZH+qAja4RbUzJIKe7ivrWqJmfo1u1rWhhwUOBh0iR/vlLdFssIfeTMjo3Di
         agCC32HCi08UTMqWnUPzS5hiGtvMBD8vHuTxcmYi3oVWudjM5rrWhu3UASmOr0CAswiv
         nlztgdUQwKzdzzHlRbhNV/vkje5e3RWj0O2aPGfMOpkOie/qqcTCQl5q7Wg/3DcKRAqW
         4IoTa4uheYCjK5bFxd1VuysnhjUK1O1MbHyCxuyfD2bpT3ncmmsuSmmAg9D0XnBMqKLV
         2kwA==
X-Gm-Message-State: APjAAAUQlELnDDnQENpMcjIrZrSqnZUwzaK/OiujPp0sSdxhndOHy1a5
        Ghcw45HCDbM195JybNNg8+Y/YtILgEOQ8g==
X-Google-Smtp-Source: APXvYqx+rGCa6SIcnFJrFOB7e82pXZPkDvNOpjgHcHOuMyV8J8D98kmEdKuwSXeRLyP3tMOCS3g6SA==
X-Received: by 2002:aed:3b79:: with SMTP id q54mr39927795qte.187.1577741488499;
        Mon, 30 Dec 2019 13:31:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n4sm14094859qti.55.2019.12.30.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 13:31:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: replace all uses of btrfs_ordered_update_i_size
Date:   Mon, 30 Dec 2019 16:31:17 -0500
Message-Id: <20191230213118.7532-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191230213118.7532-1-josef@toxicpanda.com>
References: <20191230213118.7532-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a safe way to update the i_size, replace all uses of
btrfs_ordered_update_i_size with btrfs_inode_safe_disk_i_size_write.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c  |  2 +-
 fs/btrfs/inode.c | 12 ++++++------
 fs/btrfs/ioctl.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f1c880c06ca2..35fdc5b99804 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2941,7 +2941,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 
 	inode->i_ctime = current_time(inode);
 	i_size_write(inode, end);
-	btrfs_ordered_update_i_size(inode, end, NULL);
+	btrfs_inode_safe_disk_i_size_write(inode, 0);
 	ret = btrfs_update_inode(trans, root, inode);
 	ret2 = btrfs_end_transaction(trans);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eaf81129817d..2df54486d0e4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3119,7 +3119,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		 */
 		btrfs_qgroup_free_data(inode, NULL, ordered_extent->file_offset,
 				       ordered_extent->len);
-		btrfs_ordered_update_i_size(inode, 0, ordered_extent);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		if (freespace_inode)
 			trans = btrfs_join_transaction_spacecache(root);
 		else
@@ -3207,7 +3207,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	btrfs_ordered_update_i_size(inode, 0, ordered_extent);
+	btrfs_inode_safe_disk_i_size_write(inode, 0);
 	ret = btrfs_update_inode_fallback(trans, root, inode);
 	if (ret) { /* -ENOMEM or corruption */
 		btrfs_abort_transaction(trans, ret);
@@ -5000,7 +5000,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		ASSERT(last_size >= new_size);
 		if (!ret && last_size > new_size)
 			last_size = new_size;
-		btrfs_ordered_update_i_size(inode, last_size, NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, last_size);
 	}
 
 	btrfs_free_path(path);
@@ -5330,7 +5330,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		}
 
 		i_size_write(inode, newsize);
-		btrfs_ordered_update_i_size(inode, i_size_read(inode), NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, inode);
 		btrfs_end_write_no_snapshotting(root);
@@ -9312,7 +9312,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 			ret = PTR_ERR(trans);
 			goto out;
 		}
-		btrfs_ordered_update_i_size(inode, inode->i_size, NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 	}
 
 	if (trans) {
@@ -10571,7 +10571,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			else
 				i_size = cur_offset;
 			i_size_write(inode, i_size);
-			btrfs_ordered_update_i_size(inode, i_size, NULL);
+			btrfs_inode_safe_disk_i_size_write(inode, 0);
 		}
 
 		ret = btrfs_update_inode(trans, root, inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 291dda3b6547..2a02a21cac59 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3334,7 +3334,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 		endoff = destoff + olen;
 	if (endoff > inode->i_size) {
 		i_size_write(inode, endoff);
-		btrfs_ordered_update_i_size(inode, endoff, NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 	}
 
 	ret = btrfs_update_inode(trans, root, inode);
-- 
2.23.0

