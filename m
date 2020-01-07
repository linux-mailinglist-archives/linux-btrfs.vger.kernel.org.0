Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D551F132FAC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 20:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgAGTms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 14:42:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45814 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgAGTms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 14:42:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so447271qkl.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J5nt0JikFM1EwVaHv1LLQoVpGR0fpJ3Z26VmICyoOls=;
        b=dLQhuiF3/vdBmX7JuDvLAGLYDIy4PXXj0jwfUrZFF7bvjosobbJu10KVjBxeMUNnRd
         Ttcd+wIjYIfk8jGP1wkr4MdkzaeImjwjUlYuSslBgfUrBBKIq2oU+cb+Kpl7g4BES0kM
         qt1vWJpTsKrr2IJW2svMyTd8vdbb3aT48sth+A6OpLYs//LxGpDDI4ZVm1XVXgpsUuTY
         1QvaDztf0Wb++EeOz+0VdDENEjlKDZcgTjrtkVp0mpxEeTfkZhLIlRE1vqmxXZLYjVzW
         2LzyoSxiVscy6G/iezn7uSZwXw5/BovU/YS0fUCcEW6tRcsnTDkE81wtsdN76VGN5s1o
         hHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5nt0JikFM1EwVaHv1LLQoVpGR0fpJ3Z26VmICyoOls=;
        b=WswrT28DbBK+Wbc7iXlna8e7on52OHT7xbqBOGEIc7KFgqpeY9MKglDhKwlplQ1mM7
         CtuDkRIt45QGyNcsj9pdc32VBwkxKG/1Hiei3O+ndykZ8ZheSoWMXLCbLjK9hV968YH+
         d2HOFrmYdqqb4T5X4hMBj7YluMV7i3kx7LuO7Wq4+qvo12KesfGQg0YUqsJwNFIlsM28
         BvJ7xYu7iGo+48kV+/tNFIDCT9l5zxZjKFewL8epWijmXfZyBWWsc7zdfPCkb0eSTVj2
         ewS5IsrEQOZAtvhR0E7o/iwdOETGbeyl9dTiZlABV1hjPuedJhTYL3DlUEsMN/XS1ov6
         yZ0g==
X-Gm-Message-State: APjAAAUK+0uuUanar2umDA0DV/xrGVRDwQw1/sIDfLXEG6+CHJE1OTYP
        vuY+LqGu1/u0Oxxht+tN8hJMmQ3xXMg9aQ==
X-Google-Smtp-Source: APXvYqxoknbO2r4M4P2XjANBxmYLxTGCpxUYE1mFqdSINocQBa716L16OyLsX0aW5nHRvB8QRm7UPQ==
X-Received: by 2002:a37:a807:: with SMTP id r7mr998871qke.346.1578426166721;
        Tue, 07 Jan 2020 11:42:46 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r205sm305117qke.34.2020.01.07.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:42:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: replace all uses of btrfs_ordered_update_i_size
Date:   Tue,  7 Jan 2020 14:42:36 -0500
Message-Id: <20200107194237.145694-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200107194237.145694-1-josef@toxicpanda.com>
References: <20200107194237.145694-1-josef@toxicpanda.com>
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
index 5d34007aa7ec..4a3ef3174d73 100644
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
@@ -5007,7 +5007,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		ASSERT(last_size >= new_size);
 		if (!ret && last_size > new_size)
 			last_size = new_size;
-		btrfs_ordered_update_i_size(inode, last_size, NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, last_size);
 	}
 
 	btrfs_free_path(path);
@@ -5337,7 +5337,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		}
 
 		i_size_write(inode, newsize);
-		btrfs_ordered_update_i_size(inode, i_size_read(inode), NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, inode);
 		btrfs_end_write_no_snapshotting(root);
@@ -9319,7 +9319,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 			ret = PTR_ERR(trans);
 			goto out;
 		}
-		btrfs_ordered_update_i_size(inode, inode->i_size, NULL);
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
 	}
 
 	if (trans) {
@@ -10578,7 +10578,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
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

