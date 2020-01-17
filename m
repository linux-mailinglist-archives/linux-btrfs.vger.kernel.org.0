Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895A8140BEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgAQOCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:02:37 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38180 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgAQOCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:02:37 -0500
Received: by mail-qv1-f66.google.com with SMTP id t6so10725796qvs.5
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwHpQ413Hm/y0P5R5ufAdcEpaHVwZAli8ugQdFTKWMQ=;
        b=FAHbOwj2ey+0wvdl44mh98RAATRTGj1keetoUDBwbgG5z/GWQrC858L9lvYdKgtyE+
         kaZSKsKovP7mVL3lwRVmmaMB23qh7kReky5cOrnNcopQjMvfGJ3IObhFKttG4Sx1c2N/
         f0I02xJY0Ov0AFPlF5l1ImxpP3UNP+4oYxs3u5TgEMmAlluzHTVKURkz+5jKZrVyH3bf
         mqWSViNwIpMcJImavLHDwo1+SKG3STFGIRozDkn7sGilIu8IbYDuyajGaUu7h9sMS7rl
         sfgneNogDBNUzb+8V/WKNy5RnQVD1FRd/G6iCLj2PkxRxXaM30ToheHyHNeCKg2iU+zA
         +RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwHpQ413Hm/y0P5R5ufAdcEpaHVwZAli8ugQdFTKWMQ=;
        b=CjQ2McgsTxeFoTnF4gBZ5Qhn7fmi+zw8XNdU8n7wvOIDXni2Ly8O1j4X99olaPRkTS
         sA+pRZ4V4Q19uKGK+XmnuKb8l0M5qhzVQd8jBBLfnc/sOIllJAeirqDnCro6mM/kzsgB
         6U/xj5+/mw1LABKrPGf4NF630SbCVs56VVGdZ/oMtzevf35h1gHJUjL/W8Kj9eCEOn+k
         YiwTIBQwvEVazhoDK1rDa609qKgkK0Eib+HWv9qbQL1KquNF3+s3Mb1BTPMe/kjZ9ioJ
         d7f8guB4UtWYABkuSaV1RC4aoLggRbmdPN7AloDp1xpZdXaL72lo2pdg9xJ43oVvVOiD
         TUrw==
X-Gm-Message-State: APjAAAXNE1waorK9XccZoQ6iK/lxcpjwNv275u/GtZcaw9sNvsPtYuMh
        8JJM6ShA3h89ImkD6HJgsb7aBq1s9QrfRA==
X-Google-Smtp-Source: APXvYqzj8209Exck7S2WmpmO+wQ7mk8jFB9ObMSKvoZtUssjoyIPx7UMiMxxEqGqRX6UBU7Xj/kJKA==
X-Received: by 2002:ad4:518b:: with SMTP id b11mr8006347qvp.195.1579269755896;
        Fri, 17 Jan 2020 06:02:35 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 65sm12947420qtf.95.2020.01.17.06.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:02:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 5/6] btrfs: replace all uses of btrfs_ordered_update_i_size
Date:   Fri, 17 Jan 2020 09:02:23 -0500
Message-Id: <20200117140224.42495-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117140224.42495-1-josef@toxicpanda.com>
References: <20200117140224.42495-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a safe way to update the i_size, replace all uses of
btrfs_ordered_update_i_size with btrfs_inode_safe_disk_i_size_write.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c  |  2 +-
 fs/btrfs/inode.c | 12 ++++++------
 fs/btrfs/ioctl.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f72fb38e9aaa..ac838cb50bea 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2937,7 +2937,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 
 	inode->i_ctime = current_time(inode);
 	i_size_write(inode, end);
-	btrfs_ordered_update_i_size(inode, end, NULL);
+	btrfs_inode_safe_disk_i_size_write(inode, 0);
 	ret = btrfs_update_inode(trans, root, inode);
 	ret2 = btrfs_end_transaction(trans);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 21fb80292256..da31571b150b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2479,7 +2479,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		 */
 		btrfs_qgroup_free_data(inode, NULL, start,
 				       ordered_extent->num_bytes);
-		btrfs_ordered_update_i_size(inode, 0, ordered_extent);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		if (freespace_inode)
 			trans = btrfs_join_transaction_spacecache(root);
 		else
@@ -2550,7 +2550,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	btrfs_ordered_update_i_size(inode, 0, ordered_extent);
+	btrfs_inode_safe_disk_i_size_write(inode, 0);
 	ret = btrfs_update_inode_fallback(trans, root, inode);
 	if (ret) { /* -ENOMEM or corruption */
 		btrfs_abort_transaction(trans, ret);
@@ -4337,7 +4337,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		ASSERT(last_size >= new_size);
 		if (!ret && last_size > new_size)
 			last_size = new_size;
-		btrfs_ordered_update_i_size(inode, last_size, NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, last_size);
 	}
 
 	btrfs_free_path(path);
@@ -4666,7 +4666,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		}
 
 		i_size_write(inode, newsize);
-		btrfs_ordered_update_i_size(inode, i_size_read(inode), NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, inode);
 		btrfs_end_write_no_snapshotting(root);
@@ -8651,7 +8651,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 			ret = PTR_ERR(trans);
 			goto out;
 		}
-		btrfs_ordered_update_i_size(inode, inode->i_size, NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 	}
 
 	if (trans) {
@@ -9907,7 +9907,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			else
 				i_size = cur_offset;
 			i_size_write(inode, i_size);
-			btrfs_ordered_update_i_size(inode, i_size, NULL);
+			btrfs_inode_safe_disk_i_size_write(inode, 0);
 		}
 
 		ret = btrfs_update_inode(trans, root, inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index db95144e4f22..ecb6b188df15 100644
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
2.24.1

