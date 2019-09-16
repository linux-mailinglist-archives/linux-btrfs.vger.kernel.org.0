Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8350EB39EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfIPMCq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 08:02:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:55136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731501AbfIPMCq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 08:02:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1EC0EAF7C
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 12:02:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: qgroup: Fix reserved data space leak if we have multiple reserve calls
Date:   Mon, 16 Sep 2019 20:02:39 +0800
Message-Id: <20190916120239.12570-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916120239.12570-1-wqu@suse.com>
References: <20190916120239.12570-1-wqu@suse.com>
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
Btrfs qgroup data reserve code allow multiple reservations to happen on
a single extent_changeset:
E.g:
	btrfs_qgroup_reserve_data(inode, &data_reserved, 0, SZ_1M);
	btrfs_qgroup_reserve_data(inode, &data_reserved, SZ_1M, SZ_2M);
	btrfs_qgroup_reserve_data(inode, &data_reserved, 0, SZ_4M);

Btrfs qgroup code has its internal tracking to make sure we don't
double-reserve in above example.

The only pattern utlizing this feature is in the main while loop of
btrfs_fallocate() function.

However btrfs_qgroup_reserve_data()'s error handling has a bug in that
on error it clears all ranges in the io_tree with EXTENT_QGROUP_RESERVED
flag but doesn't free previously reserved bytes.

This bug has a two fold effect:
- Clearing EXTENT_QGROUP_RESERVED ranges
  This is the correct behavior, but it prevents
  btrfs_qgroup_check_reserved_leak() to catch the leakage as the
  detector is purely EXTENT_QGROUP_RESERVED flag based.

- Leak the previously reserved data bytes.

The bug manifests when N calls to btrfs_qgroup_reserve_data are made and
the last one fails, leaking space reserved in the previous ones.

[FIX]
Also free previously reserved data bytes when btrfs_qgroup_reserve_data
fails.

Fixes: 524725537023 ("btrfs: qgroup: Introduce btrfs_qgroup_reserve_data function")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Commit message polishment
  Rephrase the multiple btrfs_qgroup_reserve_data() calls ability.
  Rephrase the effect of the bug.
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

