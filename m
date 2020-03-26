Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADE2193B0F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgCZIev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgCZIev (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C089EAC46
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 39/39] btrfs: qgroup: Use backref cache to speed up old_roots search
Date:   Thu, 26 Mar 2020 16:33:16 +0800
Message-Id: <20200326083316.48847-40-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now use the backref cache backed backref walk mechanism.

This mechanism is trading memory usage for faster, and more qgroup
specific backref walk.

Compared to original btrfs_find_all_roots(), it has the extra behavior
difference:
- Skip non-subvolume tress from the very beginning
  Since only subvolume trees contribute to qgroup numbers, skipping them
  would save us time.

- Skip reloc trees earlier
  Reloc trees doesn't contribute to qgroup, and btrfs_find_all_roots()
  also doesn't account them, thus we don't need to account them.
  Here we use the detached nodes in backref cache to skip them faster
  and earlier.

- Cached results
  Well, backref cache is obviously cached, right.

The major performance improvement happens for backref walk in commit
tree, one of the most obvious user is qgroup rescan.

Here is a small script to test it:

  mkfs.btrfs -f $dev
  mount $dev -o space_cache=v2 $mnt

  btrfs subvolume create $mnt/src

  for ((i = 0; i < 64; i++)); do
          for (( j = 0; j < 16; j++)); do
                  xfs_io -f -c "pwrite 0 2k" \
			$mnt/src/file_inline_$(($i * 16 + $j)) > /dev/null
          done
          xfs_io -f -c "pwrite 0 1M" $mnt/src/file_reg_$i > /dev/null
          sync
          btrfs subvol snapshot $mnt/src $mnt/snapshot_$i
  done
  sync

  btrfs quota enable $mnt
  btrfs quota rescan -w $mnt

Here is the benchmark for above small tests.
The performance material is the total execution time of get_old_roots()
for patched kernel (*), and find_all_roots() for original kernel.

*: With CONFIG_BTRFS_FS_CHECK_INTEGRITY disabled, as get_old_roots()
   will call find_all_roots() to verify the result if that config is
   enabled.

		|  Number of calls | Total exec time |
------------------------------------------------------
find_all_roots()|  732		   | 529991034ns
get_old_roots() |  732		   | 127998312ns
------------------------------------------------------
diff		|  0.00 %	   | -75.8 %

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ab19b2bfa112..4f36206a96aa 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2054,8 +2054,9 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_fs_info *fs_info,
 	u64 bytenr = qrecord->bytenr;
 	int ret;
 
-	ret = btrfs_find_all_roots(NULL, fs_info, bytenr, 0, &old_root, false);
-	if (ret < 0) {
+	old_root = get_old_roots(fs_info, bytenr);
+	if (IS_ERR(old_root)) {
+		ret = PTR_ERR(old_root);
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 		btrfs_warn(fs_info,
 "error accounting new delayed refs extent (err code: %d), quota inconsistent",
@@ -3001,12 +3002,12 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 			 * extent record
 			 */
 			if (WARN_ON(!record->old_roots)) {
-				/* Search commit root to find old_roots */
-				ret = btrfs_find_all_roots(NULL, fs_info,
-						record->bytenr, 0,
-						&record->old_roots, false);
-				if (ret < 0)
+				record->old_roots = get_old_roots(fs_info,
+						record->bytenr);
+				if (IS_ERR(record->old_roots)) {
+					ret = PTR_ERR(record->old_roots);
 					goto cleanup;
+				}
 			}
 
 			/* Free the reserved data space */
@@ -3585,10 +3586,11 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 		else
 			num_bytes = found.offset;
 
-		ret = btrfs_find_all_roots(NULL, fs_info, found.objectid, 0,
-					   &roots, false);
-		if (ret < 0)
+		roots = get_old_roots(fs_info, found.objectid);
+		if (IS_ERR(roots)) {
+			ret = PTR_ERR(roots);
 			goto out;
+		}
 		/* For rescan, just pass old_roots as NULL */
 		ret = btrfs_qgroup_account_extent(trans, found.objectid,
 						  num_bytes, NULL, roots);
-- 
2.26.0

