Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47276E59E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjHCK1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjHCK0a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 06:26:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298EA2D5F;
        Thu,  3 Aug 2023 03:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA1E361D07;
        Thu,  3 Aug 2023 10:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A4AC433C9;
        Thu,  3 Aug 2023 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691058329;
        bh=fkO6UXxPQtznX4DEjI5SQ4dJQ3iaIZJKzE2TM1Nh/qc=;
        h=From:To:Cc:Subject:Date:From;
        b=jGZU3Sn1GSPeUPvG3o9fjdn9R9kccTGGrriGxgaOpmtkT1BPMPr3fJCvmGY2m+PGx
         e3hUFlnq8tOZpZdv9cCeUiDqG6i5p+OOTYK8pApRxlZia8NorKOgcWoKJhwv/knxbM
         2NfPVne2JsToZ/hdGdln0J7IzT30g1LXE6XdU8C3zFUeWloSgAb7JgA0/EotirKYyZ
         hPMC+SnySAUB5AuAZUo2flVCrG8v704XE5Bh/hpUe5bvfBR7kIxI6TOrKhslLoF/Kl
         YcCLyu32bK7FebmIpWPUi5Wk+iujTy8SfQ/epbtoDfwu88suoKyzzhifm8WH3265R0
         xsM2pdXPoKaAw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH] btrfs/276: make test accurate regarding number of expected extents
Date:   Thu,  3 Aug 2023 11:25:20 +0100
Message-Id: <c54bf70be6bbeefe440ea5b1341495b16803455c.1691058187.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

btrfs/276 creates a 16G file with compression enabled in order to quickly
and efficiently create a file with many extents and have a fs tree with a
height of 3 (root node at level 2), so that it can test that fiemap is
correctly reporting extent sharedness when we have shared subtrees of the
fs tree due to a snapshot.

Compression results in extents with a maximum size of 128K and the test
is expecting only extents of 128K, which normally happens if the machine
has a large amount of RAM and writeback is not triggered before the xfs_io
command finishes. However if writeback is triggered in the meanwhile, due
to memory pressure for example, then we can get end up with some extents
that are smaller than 128K, therefore increasing the total number of
extents in the test file and make the test fail.

This seems to happen often on test machines with small amounts of RAM,
such as 4G, as reported by Qu in the following thread:

  https://lore.kernel.org/linux-btrfs/20230801065529.50122-1-wqu@suse.com/

So to address this create a file with holes and direct IO to make sure we
always get a specific number of extents in the test file. To speedup the
test create 2000 64K extents, with holes in between them, so that it works
on a fs with any sector size, and then create a bunch of files with large
xattrs to quickly bump the fs tree height to 3 for any node size (4K to
64K). This also guarantees that the file extent items are spread over
multiples leaves, in order to exercise fiemap's correctness when reporting
shared extents due to shared subtrees.

Reported-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/276     | 85 ++++++++++++++++++++++++++-------------------
 tests/btrfs/276.out | 20 +++++------
 2 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/tests/btrfs/276 b/tests/btrfs/276
index 944b0c8f..2b5543ad 100755
--- a/tests/btrfs/276
+++ b/tests/btrfs/276
@@ -9,19 +9,19 @@
 # and when the file's subvolume was snapshoted.
 #
 . ./common/preamble
-_begin_fstest auto snapshot compress fiemap
+_begin_fstest auto snapshot fiemap
 
 . ./common/filter
+. ./common/attr
 
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "fiemap" "ranged"
+_require_attrs
+_require_odirect
 
 _scratch_mkfs >> $seqres.full 2>&1
-# We use compression because it's a very quick way to create a file with a very
-# large number of extents (compression limits the maximum extent size to 128K)
-# and while using very little disk space.
-_scratch_mount -o compress
+_scratch_mount
 
 fiemap_test_file()
 {
@@ -29,8 +29,9 @@ fiemap_test_file()
 	local len=$2
 
 	# Skip the first two lines of xfs_io's fiemap output (file path and
-	# header describing the output columns).
-	$XFS_IO_PROG -c "fiemap -v $offset $len" $SCRATCH_MNT/foo | tail -n +3
+	# header describing the output columns) as well as holes.
+	$XFS_IO_PROG -c "fiemap -v $offset $len" $SCRATCH_MNT/foo | \
+		grep -v 'hole' | tail -n +3
 }
 
 # Count the number of shared extents for the whole test file or just for a given
@@ -63,19 +64,38 @@ count_not_shared_extents()
 			  --source 'END { print cnt }'
 }
 
-# Create a 16G file as that results in 131072 extents, all with a size of 128K
-# (due to compression), and a fs tree with a height of 3 (root node at level 2).
-# We want to verify later that fiemap correctly reports the sharedness of each
-# extent, even when it needs to switch from one leaf to the next one and from a
-# node at level 1 to the next node at level 1.
-#
-$XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo | _filter_xfs_io
-
-# Sync to flush delalloc and commit the current transaction, so fiemap will see
-# all extents in the fs tree and extent trees and not look at delalloc.
-sync
-
-# All extents should be reported as non shared (131072 extents).
+# Create a file with 2000 extents, and a fs tree with a height of at least 3
+# (root node at level 2). We want to verify later that fiemap correctly reports
+# the sharedness of each extent, even when it needs to switch from one leaf to
+# the next one and from a node at level 1 to the next node at level 1.
+# To speedup creating a fs tree of height >= 3, add several large xattrs.
+ext_size=$(( 64 * 1024 ))
+file_size=$(( 2000 * 2 * $ext_size )) # about 250M
+nr_cpus=$("$here/src/feature" -o)
+workers=0
+for (( i = 0; i < $file_size; i += 2 * $ext_size )); do
+	$XFS_IO_PROG -f -d -c "pwrite -b $ext_size $i $ext_size" \
+		$SCRATCH_MNT/foo > /dev/null &
+	workers=$(( workers + 1 ))
+	if [ "$workers" -ge "$nr_cpus" ]; then
+		workers=0
+		wait
+	fi
+done
+
+workers=0
+xattr_value=$(printf '%0.sX' $(seq 1 3900))
+for (( i = 1; i <= 29000; i++ )); do
+	echo -n > $SCRATCH_MNT/filler_$i
+	$SETFATTR_PROG -n 'user.x1' -v $xattr_value $SCRATCH_MNT/filler_$i &
+	workers=$(( workers + 1 ))
+	if [ "$workers" -ge "$nr_cpus" ]; then
+		workers=0
+		wait
+	fi
+done
+
+# All extents should be reported as non shared (2000 extents).
 echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
 
 # Creating a snapshot.
@@ -84,26 +104,21 @@ $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scr
 # We have a snapshot, so now all extents should be reported as shared.
 echo "Number of shared extents in the whole file: $(count_shared_extents)"
 
-# Now COW two file ranges, of 1M each, in the snapshot's file.
-# So 16 extents should become non-shared after this.
+# Now COW two file ranges, of 64K each, in the snapshot's file.
+# So 2 extents should become non-shared after this. Each file extent item is in
+# different leaf of the snapshot tree.
 #
-$XFS_IO_PROG -c "pwrite -b 1M 8M 1M" \
-	     -c "pwrite -b 1M 12G 1M" \
+$XFS_IO_PROG -d -c "pwrite -b $ext_size 512K $ext_size" \
+	     -d -c "pwrite -b $ext_size 249M $ext_size" \
 	     $SCRATCH_MNT/snap/foo | _filter_xfs_io
 
-# Sync to flush delalloc and commit the current transaction, so fiemap will see
-# all extents in the fs tree and extent trees and not look at delalloc.
-sync
-
-# Now we should have 16 non-shared extents and 131056 (131072 - 16) shared
-# extents.
+# Now we should have 2 non-shared extents and 1998 shared extents.
 echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
 echo "Number of shared extents in the whole file: $(count_shared_extents)"
 
-# Check that the non-shared extents are indeed in the expected file ranges (each
-# with 8 extents).
-echo "Number of non-shared extents in range [8M, 9M): $(count_not_shared_extents 8M 1M)"
-echo "Number of non-shared extents in range [12G, 12G + 1M): $(count_not_shared_extents 12G 1M)"
+# Check that the non-shared extents are indeed in the expected file ranges.
+echo "Number of non-shared extents in range [512K, 512K + 64K): $(count_not_shared_extents 512K 64K)"
+echo "Number of non-shared extents in range [249M, 249M + 64K): $(count_not_shared_extents 249M 64K)"
 
 # Now delete the snapshot.
 $BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap | _filter_scratch
@@ -116,7 +131,7 @@ $BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap | _filter_scratch
 _scratch_remount commit=1
 sleep 1.1
 
-# Now all extents should be reported as not shared (131072 extents).
+# Now all extents should be reported as not shared (2000 extents).
 echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
 
 # success, all done
diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
index 3bf5a5e6..197d8edc 100644
--- a/tests/btrfs/276.out
+++ b/tests/btrfs/276.out
@@ -1,16 +1,14 @@
 QA output created by 276
-wrote 17179869184/17179869184 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Number of non-shared extents in the whole file: 131072
+Number of non-shared extents in the whole file: 2000
 Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
-Number of shared extents in the whole file: 131072
-wrote 1048576/1048576 bytes at offset 8388608
+Number of shared extents in the whole file: 2000
+wrote 65536/65536 bytes at offset 524288
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 1048576/1048576 bytes at offset 12884901888
+wrote 65536/65536 bytes at offset 261095424
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Number of non-shared extents in the whole file: 16
-Number of shared extents in the whole file: 131056
-Number of non-shared extents in range [8M, 9M): 8
-Number of non-shared extents in range [12G, 12G + 1M): 8
+Number of non-shared extents in the whole file: 2
+Number of shared extents in the whole file: 1998
+Number of non-shared extents in range [512K, 512K + 64K): 1
+Number of non-shared extents in range [249M, 249M + 64K): 1
 Delete subvolume (commit): 'SCRATCH_MNT/snap'
-Number of non-shared extents in the whole file: 131072
+Number of non-shared extents in the whole file: 2000
-- 
2.34.1

