Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC846D853C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjDERvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDERvh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 13:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5586196
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7479162588
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 17:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAFFC433D2
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680717094;
        bh=sNovJIbJ4mSDw3sTkMRduVi2MaV84trqC1FaVmufVOA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qV5828fhugqLa9uD9W0zLLyrARr+k9Bd70IyDwW0sW5Cj8+xoHwJJ1i6NmRvE60GV
         uBTe1WG+aAQd0WG2tBNRX2a0WM64/rIYvN8SjptF1toCuf/df/Z6LzBOSGCcv36fUU
         j1xKToYkQxGKYjfTdIHSNo8RSXLwtes1wQjjMYKoOrU6W8C5FNj1wOOTa7tO2OsX3T
         XEY+KKifygPMQDK/vaVSd+hLyNVI0j0lmoZki/BDUNGEwzD0oPCBPALSLUlckJ9kZY
         TYKGUNl3qVvnGwBPWK1Jcschzq76MIUMPstSVslMH+WRdGevk/WYNdbir/mJJcsndq
         8Zvo2GLGUgrTw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: avoid iterating over all indexes when logging directory
Date:   Wed,  5 Apr 2023 18:51:29 +0100
Message-Id: <2ec7d969f48957e97799a4526b7e2ff3737cd2c5.1680716778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1680716778.git.fdmanana@suse.com>
References: <cover.1680716778.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a directory, after copying all directory index items from the
subvolume tree to the log tree, we iterate over the subvolume tree to find
all dir index items that are located in leaves COWed (or created) in the
current transaction. If we keep logging a directory several times during
the same transaction, we end up iterating over the same dir index items
everytime we log the directory, wasting time and adding extra lock
contention on the subvolume tree.

So just keep track of the last logged dir index offset in order to start
the search for that index (+1) the next time the directory is logged, as
dir index values (key offsets) come from a monotonically increasing
counter.

The following test measures the difference before and after this change:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nullb0
  MNT=/mnt/nullb0

  umount $DEV &> /dev/null
  mkfs.btrfs -f $DEV
  mount -o ssd $DEV $MNT

  # Time values in milliseconds.
  declare -a fsync_times
  # Total number of files added to the test directory.
  num_files=1000000
  # Fsync directory after every N files are added.
  fsync_period=100

  mkdir $MNT/testdir

  fsync_total_time=0
  for ((i = 1; i <= $num_files; i++)); do
        echo -n > $MNT/testdir/file_$i

        if [ $((i % fsync_period)) -eq 0 ]; then
                start=$(date +%s%N)
                xfs_io -c "fsync" $MNT/testdir
                end=$(date +%s%N)
                fsync_total_time=$((fsync_total_time + (end - start)))
                fsync_times[i]=$(( (end - start) / 1000000 ))
                echo -n -e "Progress $i / $num_files\r"
        fi
  done

  echo -e "\nHistogram of directory fsync duration in ms:\n"

  printf '%s\n' "${fsync_times[@]}" | \
     perl -MStatistics::Histogram -e '@d = <>; print get_histogram(\@d);'

  fsync_total_time=$((fsync_total_time / 1000000))
  echo -e "\nTotal time spent in fsync: $fsync_total_time ms\n"
  echo

  umount $MNT

The test was run on a non-debug kernel (Debian's default kernel config)
against a 15G null block device.

Result before this change:

   Histogram of directory fsync duration in ms:

   Count: 10000
   Range:  3.000 - 362.000; Mean: 34.556; Median: 31.000; Stddev: 25.751
   Percentiles:  90th: 71.000; 95th: 77.000; 99th: 81.000
      3.000 -    5.278:  1423 #################################
      5.278 -    8.854:  1173 ###########################
      8.854 -   14.467:   591 ##############
     14.467 -   23.277:  1025 #######################
     23.277 -   37.105:  1422 #################################
     37.105 -   58.809:  2036 ###############################################
     58.809 -   92.876:  2316 #####################################################
     92.876 -  146.346:     6 |
    146.346 -  230.271:     6 |
    230.271 -  362.000:     2 |

   Total time spent in fsync: 350527 ms

Result after this change:

   Histogram of directory fsync duration in ms:

   Count: 10000
   Range:  3.000 - 1088.000; Mean:  8.704; Median:  8.000; Stddev: 12.576
   Percentiles:  90th: 12.000; 95th: 14.000; 99th: 17.000
      3.000 -    6.007:  3222 #################################
      6.007 -   11.276:  5197 #####################################################
     11.276 -   20.506:  1551 ################
     20.506 -   36.674:    24 |
     36.674 -  201.552:     1 |
    201.552 -  353.841:     4 |
    353.841 - 1088.000:     1 |

   Total time spent in fsync: 92114 ms

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 32 +++++++++++++++++++++++++++-----
 fs/btrfs/tree-log.c    | 31 +++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9dc21622806e..f1e087994f87 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -142,11 +142,22 @@ struct btrfs_inode {
 	/* a local copy of root's last_log_commit */
 	int last_log_commit;
 
-	/*
-	 * Total number of bytes pending delalloc, used by stat to calculate the
-	 * real block usage of the file. This is used only for files.
-	 */
-	u64 delalloc_bytes;
+	union {
+		/*
+		 * Total number of bytes pending delalloc, used by stat to
+		 * calculate the real block usage of the file. This is used
+		 * only for files.
+		 */
+		u64 delalloc_bytes;
+		/*
+		 * The lowest possible index of the next dir index key which
+		 * points to an inode that needs to be logged.
+		 * This is used only for directories.
+		 * Use the helpers btrfs_get_first_dir_index_to_log() and
+		 * btrfs_set_first_dir_index_to_log() to access this field.
+		 */
+		u64 first_dir_index_to_log;
+	};
 
 	union {
 		/*
@@ -247,6 +258,17 @@ struct btrfs_inode {
 	struct inode vfs_inode;
 };
 
+static inline u64 btrfs_get_first_dir_index_to_log(const struct btrfs_inode *inode)
+{
+	return READ_ONCE(inode->first_dir_index_to_log);
+}
+
+static inline void btrfs_set_first_dir_index_to_log(struct btrfs_inode *inode,
+						    u64 index)
+{
+	WRITE_ONCE(inode->first_dir_index_to_log, index);
+}
+
 static inline struct btrfs_inode *BTRFS_I(const struct inode *inode)
 {
 	return container_of(inode, struct btrfs_inode, vfs_inode);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9ab793b638a7..c2a467276071 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3648,6 +3648,9 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 		ret = BTRFS_LOG_FORCE_COMMIT;
 	else
 		inode->last_dir_index_offset = last_index;
+
+	if (btrfs_get_first_dir_index_to_log(inode) == 0)
+		btrfs_set_first_dir_index_to_log(inode, batch.keys[0].offset);
 out:
 	kfree(ins_data);
 
@@ -5406,6 +5409,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	LIST_HEAD(dir_list);
 	struct btrfs_dir_list *dir_elem;
 	u64 ino = btrfs_ino(start_inode);
+	struct btrfs_inode *curr_inode = start_inode;
 	int ret = 0;
 
 	/*
@@ -5420,18 +5424,22 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
+	ihold(&curr_inode->vfs_inode);
+
 	while (true) {
+		struct inode *vfs_inode;
 		struct extent_buffer *leaf;
 		struct btrfs_key min_key;
+		u64 next_index;
 		bool continue_curr_inode = true;
 		int nritems;
 		int i;
 
 		min_key.objectid = ino;
 		min_key.type = BTRFS_DIR_INDEX_KEY;
-		min_key.offset = 0;
+		min_key.offset = btrfs_get_first_dir_index_to_log(curr_inode);
+		next_index = min_key.offset;
 again:
-		btrfs_release_path(path);
 		ret = btrfs_search_forward(root, &min_key, path, trans->transid);
 		if (ret < 0) {
 			break;
@@ -5456,6 +5464,8 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				break;
 			}
 
+			next_index = min_key.offset + 1;
+
 			di = btrfs_item_ptr(leaf, i, struct btrfs_dir_item);
 			type = btrfs_dir_ftype(leaf, di);
 			if (btrfs_dir_transid(leaf, di) < trans->transid)
@@ -5496,12 +5506,16 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			break;
 		}
 
+		btrfs_release_path(path);
+
 		if (continue_curr_inode && min_key.offset < (u64)-1) {
 			min_key.offset++;
 			goto again;
 		}
 
 next:
+		btrfs_set_first_dir_index_to_log(curr_inode, next_index);
+
 		if (list_empty(&dir_list))
 			break;
 
@@ -5509,9 +5523,22 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 		ino = dir_elem->ino;
 		list_del(&dir_elem->list);
 		kfree(dir_elem);
+
+		btrfs_add_delayed_iput(curr_inode);
+		curr_inode = NULL;
+
+		vfs_inode = btrfs_iget(fs_info->sb, ino, root);
+		if (IS_ERR(vfs_inode)) {
+			ret = PTR_ERR(vfs_inode);
+			break;
+		}
+		curr_inode = BTRFS_I(vfs_inode);
 	}
 out:
 	btrfs_free_path(path);
+	if (curr_inode)
+		btrfs_add_delayed_iput(curr_inode);
+
 	if (ret) {
 		struct btrfs_dir_list *next;
 
-- 
2.34.1

