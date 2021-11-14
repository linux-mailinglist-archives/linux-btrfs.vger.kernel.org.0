Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1614544F7F3
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 13:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhKNMyT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 07:54:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35012 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKNMyQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 07:54:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB9D82177B;
        Sun, 14 Nov 2021 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636894279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m+hRe6illxHtoFOLvPSQJVrcOT9Os9gQlE36l4ZcsxE=;
        b=HnigsK2zIuJWPPF6F03jyVnrbf8KxBFbMV/6nqQN31XjLKvzHUIh3HaGUmrDP4Yy/Nu4Ys
        3vQxLHZqWRs3WUAUxLe8o2p68ymw7YIQUUf7SGyLVDNjI+3dx+A0XDd6/p/gpzs8wxqZ8y
        DKSG6tE2VWHppZ/nsegOsrVokCovIYI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C93AC13AAE;
        Sun, 14 Nov 2021 12:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Ug/JEYGkWHUSQAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 14 Nov 2021 12:51:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4] fstests: btrfs: make nospace_cache related test cases to work with latest v2 cache
Date:   Sun, 14 Nov 2021 20:51:01 +0800
Message-Id: <20211114125101.19751-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
v2 cache by default.

However nospace_cache mount option will not work with v2 cache, as it
would make v2 cache out of sync with on-disk used space.

So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
to reject the mount.

There are quite some test cases relying on nospace_cache to prevent v1
cache to take up data space.

For those test cases, we no longer need the "nospace_cache" mount option
if the filesystem is already using v2 cache.
Since v2 cache is using metadata space, it will no longer take up data
space, thus no extra mount options for those test cases.

By this, we can keep those existing tests to run without problem for
both v1 and v2 cache.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add _scratch_no_v1_cache_opt() function
v3:
- Add _require_btrfs_command for _scratch_no_v1_cache_opt()
v4:
- Remove _require_btrfs_command since it won't work in a sub-shell
  And since "btrfs inspect dump-tree" should be included in all non-EOF
  distros, there isn't much need for such requirement.

- Rename the helper function to _btrfs_no_v1_cache_opt()
---
 common/btrfs    | 9 +++++++++
 tests/btrfs/102 | 2 +-
 tests/btrfs/140 | 5 ++---
 tests/btrfs/141 | 5 ++---
 tests/btrfs/142 | 5 ++---
 tests/btrfs/143 | 5 ++---
 tests/btrfs/151 | 4 ++--
 tests/btrfs/157 | 7 +++----
 tests/btrfs/158 | 7 +++----
 tests/btrfs/170 | 2 +-
 tests/btrfs/199 | 4 ++--
 tests/btrfs/215 | 2 +-
 12 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 2eab4b29..3021815c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -461,3 +461,12 @@ _require_btrfs_sysfs_fsid()
 	test -f /sys/fs/btrfs/$fsid/devinfo/1/fsid ||\
 		_notrun "Need btrfs sysfs fsid support"
 }
+
+_btrfs_no_v1_cache_opt()
+{
+	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV |\
+	   grep -q "FREE_SPACE_TREE"; then
+		return
+	fi
+	echo -n "-onospace_cache"
+}
diff --git a/tests/btrfs/102 b/tests/btrfs/102
index e5a1b068..2a384f3c 100755
--- a/tests/btrfs/102
+++ b/tests/btrfs/102
@@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
 # Mount our filesystem without space caches enabled so that we do not get any
 # space used from the initial data block group that mkfs creates (space caches
 # used space from data block groups).
-_scratch_mount "-o nospace_cache"
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 # Need an fs with at least 2Gb to make sure mkfs.btrfs does not create an fs
 # using mixed block groups (used both for data and metadata). We really need
diff --git a/tests/btrfs/140 b/tests/btrfs/140
index 5a5f828c..66efc126 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -60,9 +60,8 @@ echo "step 1......mkfs.btrfs" >>$seqres.full
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
-# -o nospace_cache makes sure data is written to the start position of the data
-# chunk
-_scratch_mount -o nospace_cache
+# make sure data is written to the start position of the data chunk
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index cf0979e9..ca164fdc 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -59,9 +59,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
-# -o nospace_cache makes sure data is written to the start position of the data
-# chunk
-_scratch_mount -o nospace_cache
+# make sure data is written to the start position of the data chunk
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index 1318be0f..c88cace9 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -37,9 +37,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
-# -o nospace_cache makes sure data is written to the start position of the data
-# chunk
-_scratch_mount -o nospace_cache,nodatasum
+# make sure data is written to the start position of the data chunk
+_scratch_mount -o nodatasum $(_btrfs_no_v1_cache_opt)
 
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 6736dcad..8f086ee8 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -44,9 +44,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
-# -o nospace_cache makes sure data is written to the start position of the data
-# chunk
-_scratch_mount -o nospace_cache,nodatasum
+# make sure data is written to the start position of the data chunk
+_scratch_mount -o nodatasum $(_btrfs_no_v1_cache_opt)
 
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
diff --git a/tests/btrfs/151 b/tests/btrfs/151
index 099e85cc..54cd0827 100755
--- a/tests/btrfs/151
+++ b/tests/btrfs/151
@@ -31,8 +31,8 @@ _scratch_dev_pool_get 3
 # create raid1 for data
 _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
 
-# we need an empty data chunk, so nospace_cache is required.
-_scratch_mount -onospace_cache
+# we need an empty data chunk, so $(_btrfs_no_v1_cache_opt) is required.
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 # if data chunk is empty, 'btrfs device remove' can change raid1 to
 # single.
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 0cfe3ce5..ae56f3e1 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -64,9 +64,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid6 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
-# -o nospace_cache makes sure data is written to the start position of the data
-# chunk
-_scratch_mount -o nospace_cache
+# make sure data is written to the start position of the data chunk
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
@@ -94,7 +93,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
 
 # step 3: read foobar to repair the bitrot
 echo "step 3......repair the bitrot" >> $seqres.full
-_scratch_mount -o nospace_cache
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 # read the 2nd stripe, i.e. [64K, 128K), to trigger repair
 od -x -j 64K $SCRATCH_MNT/foobar
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index ad374eba..aa85835a 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -56,9 +56,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid6 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
-# -o nospace_cache makes sure data is written to the start position of the data
-# chunk
-_scratch_mount -o nospace_cache
+# make sure data is written to the start position of the data chunk
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
@@ -85,7 +84,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
 
 # step 3: scrub filesystem to repair the bitrot
 echo "step 3......repair the bitrot" >> $seqres.full
-_scratch_mount -o nospace_cache
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
 
diff --git a/tests/btrfs/170 b/tests/btrfs/170
index 15382eb3..8700be07 100755
--- a/tests/btrfs/170
+++ b/tests/btrfs/170
@@ -29,7 +29,7 @@ _scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
 
 # Mount without space cache so that we can precisely fill all data space and
 # unallocated space later (space cache v1 uses data block groups).
-_scratch_mount "-o nospace_cache"
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 # Create our test file and allocate 1826.25Mb of space for it.
 # This will exhaust the existing data block group and all unallocated space on
diff --git a/tests/btrfs/199 b/tests/btrfs/199
index 6aca62f4..2024447c 100755
--- a/tests/btrfs/199
+++ b/tests/btrfs/199
@@ -67,7 +67,7 @@ loop_dev=$(_create_loop_device "$loop_file")
 loop_mnt=$tmp/loop_mnt
 
 mkdir -p $loop_mnt
-# - nospace_cache
+# - $(_btrfs_no_v1_cache_opt)
 #   Since v1 cache using DATA space, it can break data extent bytenr
 #   continuousness.
 # - nodatasum
@@ -75,7 +75,7 @@ mkdir -p $loop_mnt
 #   Disabling datasum could reduce the margin caused by metadata to minimal
 # - discard
 #   What we're testing
-_mount -o nospace_cache,nodatasum,discard $loop_dev $loop_mnt
+_mount $(_btrfs_no_v1_cache_opt) -o nodatasum,discard $loop_dev $loop_mnt
 
 # Craft the following extent layout:
 #         |  BG1 |      BG2        |       BG3            |
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index fa622568..9ee1a8b3 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -30,7 +30,7 @@ _require_non_zoned_device $SCRATCH_DEV
 _scratch_mkfs > /dev/null
 # disable freespace inode to ensure file is the first thing in the data
 # blobk group
-_scratch_mount -o nospace_cache
+_scratch_mount $(_btrfs_no_v1_cache_opt)
 
 pagesize=$(get_page_size)
 blocksize=$(_get_block_size $SCRATCH_MNT)
-- 
2.33.0

