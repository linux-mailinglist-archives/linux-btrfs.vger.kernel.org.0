Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3CB1715
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 03:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfIMBvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 21:51:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbfIMBvd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 21:51:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23538AD6F
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 01:51:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: qgroup: Fix reserved data space leak if we have multiple reserve calls
Date:   Fri, 13 Sep 2019 09:51:27 +0800
Message-Id: <20190913015127.14953-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913015127.14953-1-wqu@suse.com>
References: <20190913015127.14953-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following script can cause btrfs qgroup data space leak:

  mkfs.btrfs -f $dev
  mount $dev -o nospace_cache $mnt

  btrfs subv create $mnt/subv
  btrfs quota en $mnt
  btrfs quota rescan -w $mnt
  btrfs qgroup limit 128m $mnt/subv

  for (( i = 0; i < 3; i++)); do
          # Create 3 64M holes for latter fallocate to fail
          truncate -s 192m $mnt/subv/file
          xfs_io -c "pwrite 64m 4k" $mnt/subv/file > /dev/null
          xfs_io -c "pwrite 128m 4k" $mnt/subv/file > /dev/null
          sync

          # it's supposed to fail, and each failure will leak at least 64M
          # data space
          xfs_io -f -c "falloc 0 192m" $mnt/subv/file &> /dev/null
          rm $mnt/subv/file
          sync
  done

  # Shouldn't fail after we removed the file
  xfs_io -f -c "falloc 0 64m" $mnt/subv/file

[CAUSE]
Btrfs qgroup data reserve code allows multiple reserve happen on a
single extent_changeset:

The only usage is in btrfs_fallocate():
	struct extent_changeset *data_reserved = NULL;
	btrfs_qgroup_reserve_data(inode, &data_reserved,
				  range_start, range_len);
	...
	btrfs_qgroup_reserve_data(inode, &data_reserved,
				  new_range_start, new_range_len);
	extent_changeset_free(data_reserved);

However in btrfs_qgroup_reserve_data(), if one of the call failed, it
will cleanup all reserved space.
The cleanup itself is OK, but it only cleans up all
EXTENT_QGROUP_RESERVED flag, forget to release the reserved bytes.

So if multiple btrfs_qgroup_reserve_data() get called, and the last one
failed, then previously reserved data space will get leaked.

And due to the fact that EXTENT_QGROUP_RESERVED flag is cleaned
correctly, btrfs_qgroup_check_reserved_leak() won't catch the leakage.

[FIX]
Also free previously reserved data bytes when btrfs_qgroup_reserve_data
fails.

Fixes: 524725537023 ("btrfs: qgroup: Introduce btrfs_qgroup_reserve_data function")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 64bdc3e3652d..59f6a9981087 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3448,6 +3448,9 @@ int btrfs_qgroup_reserve_data(struct inode *inode,
 	while ((unode = ulist_next(&reserved->range_changed, &uiter)))
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, unode->val,
 				 unode->aux, EXTENT_QGROUP_RESERVED, 0, 0, NULL);
+	/* Also free data bytes of already reserved one */
+	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid,
+				  orig_reserved, BTRFS_QGROUP_RSV_DATA);
 	extent_changeset_release(reserved);
 	return ret;
 }
-- 
2.23.0

