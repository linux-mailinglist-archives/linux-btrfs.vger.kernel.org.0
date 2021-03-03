Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA732C4F8
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhCDASq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:18:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:40968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1842793AbhCCINR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 03:13:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614759149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIeRUC4Xz5nUe+cn2fSGODwwohV/zKhXXchpgESZLFg=;
        b=f1Dy6JBwmyyoujNTD1U+88Z99EF8tQLvcfuPBx8Ywn8fguNsts7LkgNQp3MZqyeZWMKk61
        gfoCJR6L3OM0qOWqEDdyJoC2YHt3aemqg4P8iG6sAky++QX9/ZRnmX8daE7m6SXirUexrH
        7KgrpJrjJ7OMAyYyjv5rBJStGKjNBVw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53602B030;
        Wed,  3 Mar 2021 08:12:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>, David Sterba <dsterba@suse.cz>
Subject: [PATCH 2/2] btrfs: fix qgroup data rsv leak caused by falloc failure
Date:   Wed,  3 Mar 2021 16:12:20 +0800
Message-Id: <20210303081220.80913-2-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303081220.80913-1-wqu@suse.com>
References: <20210303081220.80913-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running fsstress with only falloc workload, and a very low qgroup
limit set, we can get qgroup data rsv leak at unmount time.

 BTRFS warning (device dm-0): qgroup 0/5 has unreleased space, type 0 rsv 20480
 BTRFS error (device dm-0): qgroup reserved space leaked

The minimal reproducer looks like:

  #!/bin/bash
  dev=/dev/test/test
  mnt="/mnt/btrfs"
  fsstress=~/xfstests-dev/ltp/fsstress
  runtime=8

  workload()
  {
          umount $dev &> /dev/null
          umount $mnt &> /dev/null
          mkfs.btrfs -f $dev > /dev/null
          mount $dev $mnt

          btrfs quota en $mnt
          btrfs quota rescan -w $mnt
          btrfs qgroup limit 16m 0/5 $mnt

          $fsstress -w -z -f creat=10 -f fallocate=10 -p 2 -n 100 \
  		-d $mnt -v > /tmp/fsstress

          umount $mnt
          if dmesg | grep leak ; then
		echo "!!! FAILED !!!"
  		exit 1
          fi
  }

  for (( i=0; i < $runtime; i++)); do
          echo "=== $i/$runtime==="
          workload
  done

Normally it would fail before round 4.

[CAUSE]
In function insert_prealloc_file_extent(), we first call
btrfs_qgroup_release_data() to know how many bytes are reserved for
qgroup data rsv.

Then use that @qgroup_released number to continue our work.

But after we call btrfs_qgroup_release_data(), we should either queue
@qgroup_released to delayed ref or free them manually in error path.

Unfortunately, we lack the error handling to free the released bytes,
leaking qgroup data rsv.

All the error handling function outside won't help at all, as we have
released the range, meaning in inode io tree, the EXTENT_QGROUP_RESERVED
bit is already cleared, thus all btrfs_qgroup_free_data() call won't
free any data rsv.

[FIX]
Add free_qgroup tag to manually free the released qgroup data rsv.

Fixes: 9729f10a608f ("btrfs: inode: move qgroup reserved space release to the callers of insert_reserved_file_extent()")
Reported-by: Nikolay Borisov <nborisov@suse.com>
Reported-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4e9717c29451..9ffa1b1f3b82 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9910,17 +9910,30 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.insertions = 0;
 
 	path = btrfs_alloc_path();
-	if (!path)
-		return ERR_PTR(-ENOMEM);
+	if (!path) {
+		ret = -ENOMEM;
+		goto free_qgroup;
+	}
 
 	ret = btrfs_replace_file_extents(&inode->vfs_inode, path, file_offset,
 				     file_offset + len - 1, &extent_info,
 				     &trans);
 	btrfs_free_path(path);
 	if (ret)
-		return ERR_PTR(ret);
-
+		goto free_qgroup;
 	return trans;
+free_qgroup:
+	/*
+	 * We have released qgroup data range at the beginning of the function,
+	 * and normally @qgroup_released bytes will be freed when committing
+	 * transaction.
+	 * But if we error out early, we have to free what we have released
+	 * or we leak qgroup data rsv.
+	 */
+	btrfs_qgroup_free_refroot(inode->root->fs_info,
+			inode->root->root_key.objectid, qgroup_released,
+			BTRFS_QGROUP_RSV_DATA);
+	return ERR_PTR(ret);
 }
 
 static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
-- 
2.30.1

