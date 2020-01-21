Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88488143F35
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 15:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAUORJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 09:17:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34288 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUORJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 09:17:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so2714074qtz.1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 06:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ag4oI6KBx3FJ4Ncfn5yX6ZuIHFGW+Au3X/wQSsh1740=;
        b=Alh5iavJuBIxmLqBcns7HIs/g0oxLBv5SPvvYRnzMllJHv9WE3zBlkYyBa4kaVT1DD
         kxBwvosfAekQa78q6JIhIpV5t+jQIypY/55buFr8JUw+LXK38aB8ZQslA17/9IFAXh0w
         IjAjpmcZzMVf4BV1RoC44NpXEetVuVjhhv2wC6U9Aew5lwybGIxEla4lw5pOtvEdSeuG
         yQ8V1jKlpDEUrLdIOBTL1tmoXLaiknduEc5+DlPBqTpk+Bf8HtxQbH9gr9bNKRpKbiJA
         OJvOJDhfI850t3978yR/PGFxZRqCjEK1nZiyQnJawMqi2AUGfIVMGuK+UZyRD6CyHLDI
         1c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ag4oI6KBx3FJ4Ncfn5yX6ZuIHFGW+Au3X/wQSsh1740=;
        b=ra9bMgW1sjjkPRIcOqDoSovozLpjppzrShcSh2HDrH/+G6C26vxqtMJhjTcbheDQmw
         lj/ky7sQmdqSwqOIXgFTPymTifj0n0hditi0/3Go4T4azIZzBGCZr4mHKMoidNiLGafg
         51qBX2NWy21ese/fthVgLQfU9prV6E8YslCLuFKLU7rpolqzzb4EZ5lWGWgRbMHOv08U
         2F7XQa0aLJfKbkF4W2nxkhwjxsCqqtIby11eJQbcPVbFV7AFGKlBQJwUlKoJiE1Nccdd
         MC5/uoapWL+YA15xy9N64HVYiMgxTWhkdZbOFxTe66mcyz5svmH8tCEC4rwj4YswPGbb
         uHRw==
X-Gm-Message-State: APjAAAVhcsZUSvQE2WJn+4DZ6E+Q+RTM8Ito32fWg6l3TV15Dy88KOXV
        dp7l22c1I/nB5y6aoeprkJxhXyOEXbmAuw==
X-Google-Smtp-Source: APXvYqxeu7s59zq0LQfGbDpR79L102KVLxz3/5ruKEZAeoZG1UYcZLzMv600HWuILXC60W7Uqq4VDQ==
X-Received: by 2002:ac8:5159:: with SMTP id h25mr4691303qtn.249.1579616227981;
        Tue, 21 Jan 2020 06:17:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f97sm19607820qtb.18.2020.01.21.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 06:17:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v2] btrfs: free block groups after free'ing fs trees
Date:   Tue, 21 Jan 2020 09:17:06 -0500
Message-Id: <20200121141706.2173895-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sometimes when running generic/475 we would trip the
WARN_ON(cache->reserved) check when free'ing the block groups on umount.
This is because sometimes we don't commit the transaction because of IO
errors and thus do not cleanup the tree logs until at umount time.
These blocks are still reserved until they are cleaned up, but they
aren't cleaned up until _after_ we do the free block groups work.  Fix
this by moving the free after free'ing the fs roots, that way all of the
tree logs are cleaned up and we have a properly cleaned fs.  A bunch of
loops of generic/475 confirmed this fixes the problem.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Add a comment to make sure we don't re-order the block group freeing.

 fs/btrfs/disk-io.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d453bdc74e91..56d0a24aec74 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4056,12 +4056,19 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 	btrfs_stop_all_workers(fs_info);
 
-	btrfs_free_block_groups(fs_info);
-
 	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	free_root_pointers(fs_info, true);
 	btrfs_free_fs_roots(fs_info);
 
+	/*
+	 * We must free the block groups after dropping the fs_roots as we could
+	 * have had an IO error and have left over tree log blocks that aren't
+	 * cleaned up until the fs roots are freed.  This makes the block group
+	 * accounting appear to be wrong because there's pending reserved bytes,
+	 * so make sure we do the block group cleanup afterwards.
+	 */
+	btrfs_free_block_groups(fs_info);
+
 	iput(fs_info->btree_inode);
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-- 
2.24.1

