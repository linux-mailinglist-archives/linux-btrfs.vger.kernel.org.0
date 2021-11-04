Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0AC444CBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 01:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhKDA6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Nov 2021 20:58:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57750 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhKDA6t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Nov 2021 20:58:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B6F321639;
        Thu,  4 Nov 2021 00:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635987371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5/X5/+kBq854gx+r5Fdj/nqyaaBASHeO0eyO2GZXwGY=;
        b=SbCk9gKrFBaFdpTYZtbJAcNlwIIXPdpoKIb16vr5dwev4ELqghYSdlxJUpffpj+K3Gyd62
        SBYYExJW+2p8e3CnTqUfXZURoRqtlzTQaPLsanx/ausfiHUBIDTuBjFa6jxza4/lXYAT4G
        /IBLz6TiLgf2lvtfN+n/Is5tvo7N6o4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E21E13B9F;
        Thu,  4 Nov 2021 00:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZYoTF6ovg2EUGAAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 04 Nov 2021 00:56:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs: make nospace_cache related test cases to work with latest v2 cache
Date:   Thu,  4 Nov 2021 08:55:53 +0800
Message-Id: <20211104005553.14485-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
v2 cache by default.

However nospace_cache mount option will not work with v2 cache, as it
will make v2 cache out of sync with on-disk used space.

So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
to reject the mount.

There are quite some test cases relying on nospace_cache to prevent v1
cache to take up data space.

For that case, we can append "clear_cache" mount option to it, so that
btrfs knows we do not only want to prevent cache from being created, but
also want to clear any existing v2 cache.

By this, we can keep those existing tests to do the same behavior for
both v1 and v2 cache.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/102 | 2 +-
 tests/btrfs/140 | 2 +-
 tests/btrfs/141 | 2 +-
 tests/btrfs/142 | 2 +-
 tests/btrfs/143 | 2 +-
 tests/btrfs/151 | 2 +-
 tests/btrfs/157 | 2 +-
 tests/btrfs/158 | 2 +-
 tests/btrfs/170 | 2 +-
 tests/btrfs/199 | 5 ++++-
 tests/btrfs/215 | 2 +-
 11 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tests/btrfs/102 b/tests/btrfs/102
index e5a1b068..39c3ba37 100755
--- a/tests/btrfs/102
+++ b/tests/btrfs/102
@@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
 # Mount our filesystem without space caches enabled so that we do not get any
 # space used from the initial data block group that mkfs creates (space caches
 # used space from data block groups).
-_scratch_mount "-o nospace_cache"
+_scratch_mount "-o nospace_cache,clear_cache"
 
 # Need an fs with at least 2Gb to make sure mkfs.btrfs does not create an fs
 # using mixed block groups (used both for data and metadata). We really need
diff --git a/tests/btrfs/140 b/tests/btrfs/140
index 5a5f828c..e7a36927 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -62,7 +62,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
 # -o nospace_cache makes sure data is written to the start position of the data
 # chunk
-_scratch_mount -o nospace_cache
+_scratch_mount -o nospace_cache,clear_cache
 
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index cf0979e9..bf559953 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -61,7 +61,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
 # -o nospace_cache makes sure data is written to the start position of the data
 # chunk
-_scratch_mount -o nospace_cache
+_scratch_mount -o nospace_cache,clear_cache
 
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index 1318be0f..b2cc34a3 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -39,7 +39,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
 # -o nospace_cache makes sure data is written to the start position of the data
 # chunk
-_scratch_mount -o nospace_cache,nodatasum
+_scratch_mount -o nospace_cache,nodatasum,clear_cache
 
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 6736dcad..2f673ae2 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -46,7 +46,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
 # -o nospace_cache makes sure data is written to the start position of the data
 # chunk
-_scratch_mount -o nospace_cache,nodatasum
+_scratch_mount -o nospace_cache,nodatasum,clear_cache
 
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
diff --git a/tests/btrfs/151 b/tests/btrfs/151
index 099e85cc..e8bdc33c 100755
--- a/tests/btrfs/151
+++ b/tests/btrfs/151
@@ -32,7 +32,7 @@ _scratch_dev_pool_get 3
 _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
 
 # we need an empty data chunk, so nospace_cache is required.
-_scratch_mount -onospace_cache
+_scratch_mount -onospace_cache,clear_cache
 
 # if data chunk is empty, 'btrfs device remove' can change raid1 to
 # single.
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 0cfe3ce5..cd69cc16 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -66,7 +66,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
 # -o nospace_cache makes sure data is written to the start position of the data
 # chunk
-_scratch_mount -o nospace_cache
+_scratch_mount -o nospace_cache,clear_cache
 
 # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index ad374eba..1bc73450 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -58,7 +58,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
 # -o nospace_cache makes sure data is written to the start position of the data
 # chunk
-_scratch_mount -o nospace_cache
+_scratch_mount -o nospace_cache,clear_cache
 
 # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
diff --git a/tests/btrfs/170 b/tests/btrfs/170
index 15382eb3..746170f4 100755
--- a/tests/btrfs/170
+++ b/tests/btrfs/170
@@ -29,7 +29,7 @@ _scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
 
 # Mount without space cache so that we can precisely fill all data space and
 # unallocated space later (space cache v1 uses data block groups).
-_scratch_mount "-o nospace_cache"
+_scratch_mount "-o nospace_cache,clear_cache"
 
 # Create our test file and allocate 1826.25Mb of space for it.
 # This will exhaust the existing data block group and all unallocated space on
diff --git a/tests/btrfs/199 b/tests/btrfs/199
index 6aca62f4..2369d52f 100755
--- a/tests/btrfs/199
+++ b/tests/btrfs/199
@@ -70,12 +70,15 @@ mkdir -p $loop_mnt
 # - nospace_cache
 #   Since v1 cache using DATA space, it can break data extent bytenr
 #   continuousness.
+# - clear_cache
+#   v2 cache can't work with nospace_cache, so we workaround it by clearing
+#   all the space cache.
 # - nodatasum
 #   As there will be 1.5G data write, generating 1.5M csum.
 #   Disabling datasum could reduce the margin caused by metadata to minimal
 # - discard
 #   What we're testing
-_mount -o nospace_cache,nodatasum,discard $loop_dev $loop_mnt
+_mount -o nospace_cache,clear_cache,nodatasum,discard $loop_dev $loop_mnt
 
 # Craft the following extent layout:
 #         |  BG1 |      BG2        |       BG3            |
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index fa622568..7f0986af 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -30,7 +30,7 @@ _require_non_zoned_device $SCRATCH_DEV
 _scratch_mkfs > /dev/null
 # disable freespace inode to ensure file is the first thing in the data
 # blobk group
-_scratch_mount -o nospace_cache
+_scratch_mount -o nospace_cache,clear_cache
 
 pagesize=$(get_page_size)
 blocksize=$(_get_block_size $SCRATCH_MNT)
-- 
2.33.0

