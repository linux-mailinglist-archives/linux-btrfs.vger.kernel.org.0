Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375C77AB120
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjIVLp3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjIVLp2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:45:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831FFB;
        Fri, 22 Sep 2023 04:45:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26891C433C8;
        Fri, 22 Sep 2023 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695383122;
        bh=DMobzPB7Mh+U/9SkuKK6FKc9DEMpktLiCagzj++F7Ew=;
        h=From:To:Cc:Subject:Date:From;
        b=ITSLUwS6ESUfMQwhWhRIA+Gri0NrR0RXrsoC9SXoGEVUeAM5CO4iThHxNByOHcyyp
         8vIwNPSvCkBi5n0WUtu8JDgnOXBBEJeJO3rR8ZXLJP2nvw7QLjdEc7wTR1verm2icE
         kY8TjBENEUE1h6S26dngFfXzOQKgGod8Tw3pTsXWNLl2Sdx3Y9w9qh9nAEAv4wzt4R
         DEtlA3Iy7eOmKVbtPf9PVIzFejwNrrhbWnE4fZR72jZu4XduXyLiGqM04J2dg8359+
         YAkqlMhcjvNYU1Y8g+rWoMNExYG7XqCOjIugupwhT9pItpISg5/kiiO4rqmW4zd32e
         /EIMDTO3TOSLw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/287: filter snapshot IDs to avoid failures when using some features
Date:   Fri, 22 Sep 2023 12:45:17 +0100
Message-Id: <99982dd613b5bb2d693b0491af873e1e7291dd4b.1695383059.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When running btrfs/287 with features that create extra trees or don't
the need to create some trees, such as when using the free space tree
(default for several btrfs-progs releases now) versus when not using
it (by passing -R ^free-space-tree in MKFS_OPTIONS), the test can fail
because the IDs for the two snapshots it creates changes, and the golden
output is requiring the numeric IDs of the snapshots.

For example, when disabling the free space tree, the test fails like this:

  $ MKFS_OPTIONS="-R ^free-space-tree" ./check btrfs/287
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.6.0-rc2-btrfs-next-138+ #1 SMP PREEMPT_DYNAMIC Thu Sep 21 17:58:48 WEST 2023
  MKFS_OPTIONS  -- -R ^free-space-tree /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/287 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
      --- tests/btrfs/287.out	2023-09-22 12:39:43.060761389 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad	2023-09-22 12:40:54.238849251 +0100
      @@ -44,52 +44,52 @@
       Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
       Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
       resolve first extent:
      -inode 257 offset 16777216 root 257
      -inode 257 offset 8388608 root 257
      -inode 257 offset 16777216 root 256
      -inode 257 offset 8388608 root 256
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        0cad8f14d70c btrfs: fix backref walking not returning all inode refs

  Ran: btrfs/287
  Failures: btrfs/287
  Failed 1 of 1 tests

So add a filter to logical reserve calls to replace snapshot root IDs with
a logical name (snap1 and snap2).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/287     | 24 ++++++++++++++-----
 tests/btrfs/287.out | 56 ++++++++++++++++++++++-----------------------
 2 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/tests/btrfs/287 b/tests/btrfs/287
index cac96a23..04871d46 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -27,6 +27,15 @@ query_logical_ino()
 	$BTRFS_UTIL_PROG inspect-internal logical-resolve -P $* $SCRATCH_MNT
 }
 
+# The IDs of the snapshots (roots) we create may vary if we are using the free
+# space tree or not for example (mkfs options -R free-space-tree and
+# -R ^free-space-tree). So replace their IDs with names so that we don't get
+# golden output mismatches if we are using features that create other roots.
+filter_snapshot_ids()
+{
+	sed -e "s/root $snap1_id\b/snap1/" -e "s/root $snap2_id\b/snap2/"
+}
+
 _scratch_mkfs >> $seqres.full || _fail "mkfs failed"
 _scratch_mount
 
@@ -107,16 +116,19 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
 	| _filter_scratch
 
+snap1_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
+snap2_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
+
 # Query for the first extent (at offset 0). Should give two entries for each
 # root - default subvolume and the 2 snapshots, for file offsets 8M and 16M.
 echo "resolve first extent:"
-query_logical_ino $first_extent_bytenr
+query_logical_ino $first_extent_bytenr | filter_snapshot_ids
 
 # Query for the first extent (at offset 0) with the ignore offset option.
 # Should give 3 entries for each root - default subvolume and the 2 snapshots,
 # for file offsets 2M, 8M and 16M.
 echo "resolve first extent with ignore offset option:"
-query_logical_ino -o $first_extent_bytenr
+query_logical_ino -o $first_extent_bytenr | filter_snapshot_ids
 
 # Now lets punch a 1M hole at file offset 4M. This changes the second file
 # extent item to point to the second extent with an offset of 1M and a length
@@ -126,14 +138,14 @@ query_logical_ino -o $first_extent_bytenr
 # return file offsets 12M and 20M.
 $XFS_IO_PROG -c "fpunch 4M 1M" $SCRATCH_MNT/foo
 echo "resolve second extent after punching hole at file range [4M, 5M):"
-query_logical_ino $second_extent_bytenr
+query_logical_ino $second_extent_bytenr | filter_snapshot_ids
 
 # Repeat the query but with the ignore offset option. We should get 3 entries
 # for each root. For the snapshot roots, we should get entries for file offsets
 # 4M, 12M and 20M, while for the default subvolume (root 5) we should get for
 # file offsets 5M, 12M and 20M.
 echo "resolve second extent with ignore offset option:"
-query_logical_ino -o $second_extent_bytenr
+query_logical_ino -o $second_extent_bytenr | filter_snapshot_ids
 
 # Now delete the first snapshot and repeat the last 2 queries.
 $BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/snap1 | _filter_scratch
@@ -142,13 +154,13 @@ $BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/snap1 | _filter_scratch
 # and 20M for the default subvolume (root 5) and file offsets 4M, 12M and 20M
 # for the second snapshot root.
 echo "resolve second extent:"
-query_logical_ino $second_extent_bytenr
+query_logical_ino $second_extent_bytenr | filter_snapshot_ids
 
 # Query the second extent with the ignore offset option, should return file
 # offsets 5M, 12M and 20M for the default subvolume (root 5) and file offsets
 # 4M, 12M and 20M for the second snapshot root.
 echo "resolve second extent with ignore offset option:"
-query_logical_ino -o $second_extent_bytenr
+query_logical_ino -o $second_extent_bytenr | filter_snapshot_ids
 
 status=0
 exit
diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
index 683f9875..0d694733 100644
--- a/tests/btrfs/287.out
+++ b/tests/btrfs/287.out
@@ -44,52 +44,52 @@ inode 257 offset 2097152 root 5
 Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
 Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
 resolve first extent:
-inode 257 offset 16777216 root 257
-inode 257 offset 8388608 root 257
-inode 257 offset 16777216 root 256
-inode 257 offset 8388608 root 256
+inode 257 offset 16777216 snap2
+inode 257 offset 8388608 snap2
+inode 257 offset 16777216 snap1
+inode 257 offset 8388608 snap1
 inode 257 offset 16777216 root 5
 inode 257 offset 8388608 root 5
 resolve first extent with ignore offset option:
-inode 257 offset 16777216 root 257
-inode 257 offset 8388608 root 257
-inode 257 offset 2097152 root 257
-inode 257 offset 16777216 root 256
-inode 257 offset 8388608 root 256
-inode 257 offset 2097152 root 256
+inode 257 offset 16777216 snap2
+inode 257 offset 8388608 snap2
+inode 257 offset 2097152 snap2
+inode 257 offset 16777216 snap1
+inode 257 offset 8388608 snap1
+inode 257 offset 2097152 snap1
 inode 257 offset 16777216 root 5
 inode 257 offset 8388608 root 5
 inode 257 offset 2097152 root 5
 resolve second extent after punching hole at file range [4M, 5M):
-inode 257 offset 20971520 root 257
-inode 257 offset 12582912 root 257
-inode 257 offset 4194304 root 257
-inode 257 offset 20971520 root 256
-inode 257 offset 12582912 root 256
-inode 257 offset 4194304 root 256
+inode 257 offset 20971520 snap2
+inode 257 offset 12582912 snap2
+inode 257 offset 4194304 snap2
+inode 257 offset 20971520 snap1
+inode 257 offset 12582912 snap1
+inode 257 offset 4194304 snap1
 inode 257 offset 20971520 root 5
 inode 257 offset 12582912 root 5
 resolve second extent with ignore offset option:
-inode 257 offset 20971520 root 257
-inode 257 offset 12582912 root 257
-inode 257 offset 4194304 root 257
-inode 257 offset 20971520 root 256
-inode 257 offset 12582912 root 256
-inode 257 offset 4194304 root 256
+inode 257 offset 20971520 snap2
+inode 257 offset 12582912 snap2
+inode 257 offset 4194304 snap2
+inode 257 offset 20971520 snap1
+inode 257 offset 12582912 snap1
+inode 257 offset 4194304 snap1
 inode 257 offset 20971520 root 5
 inode 257 offset 12582912 root 5
 inode 257 offset 5242880 root 5
 Delete subvolume (commit): 'SCRATCH_MNT/snap1'
 resolve second extent:
-inode 257 offset 20971520 root 257
-inode 257 offset 12582912 root 257
-inode 257 offset 4194304 root 257
+inode 257 offset 20971520 snap2
+inode 257 offset 12582912 snap2
+inode 257 offset 4194304 snap2
 inode 257 offset 20971520 root 5
 inode 257 offset 12582912 root 5
 resolve second extent with ignore offset option:
-inode 257 offset 20971520 root 257
-inode 257 offset 12582912 root 257
-inode 257 offset 4194304 root 257
+inode 257 offset 20971520 snap2
+inode 257 offset 12582912 snap2
+inode 257 offset 4194304 snap2
 inode 257 offset 20971520 root 5
 inode 257 offset 12582912 root 5
 inode 257 offset 5242880 root 5
-- 
2.40.1

