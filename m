Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82B536ACA
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 06:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355769AbiE1E4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 May 2022 00:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiE1E4F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 May 2022 00:56:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F1D11CB4B;
        Fri, 27 May 2022 21:56:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CD7B68AFE; Sat, 28 May 2022 06:56:01 +0200 (CEST)
Date:   Sat, 28 May 2022 06:56:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs: add a helpers for read repair testing
Message-ID: <20220528045601.GB13168@lst.de>
References: <20220527081915.2024853-1-hch@lst.de> <20220527081915.2024853-2-hch@lst.de> <20220527145445.fyrp3anncqdxb7sl@zlang-mailbox> <20220527150306.GA1534@lst.de> <20220528033414.qdzmvjpfen6ob6ix@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528033414.qdzmvjpfen6ob6ix@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 28, 2022 at 11:34:14AM +0800, Zorro Lang wrote:
> I can help to do this change when I merge this patchset, if you don't have
> more changes need to do. Actually I'm trying to wait this patchset for this
> weekend fstests release, due to it's almost done. I need to do a regression
> test today before pushing these patches on Sunday (if no exception:)

Ok. Here is the updated version of this first patch:

---
From 3de26208af33e9aa83deac77a9d34dec3ccb67c9 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 May 2022 09:06:38 +0200
Subject: btrfs: add a helpers for read repair testing

Add a few helpers to consolidate code for btrfs read repair testing:

 - _btrfs_get_first_logical() gets the btrfs logical address for the
   first extent in a file
 - _btrfs_get_device_path and _btrfs_get_physical use the
   btrfs-map-logical tool to find the device path and physical address
   for btrfs logical address for a specific mirror
 - _btrfs_direct_read_on_mirror and _btrfs_buffered_read_on_mirror
   read the data from a specific mirror

These will be used to consolidate the read repair tests and avoid
duplication for new tests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 common/config |  1 +
 2 files changed, 76 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index ac597ca4..c7058918 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -505,3 +505,78 @@ _btrfs_metadump()
 	$BTRFS_IMAGE_PROG "$device" "$dumpfile"
 	[ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPRESSOR -f "$dumpfile" &> /dev/null
 }
+
+# Return the btrfs logical address for the first block in a file
+_btrfs_get_first_logical()
+{
+	local file=$1
+	_require_command "$FILEFRAG_PROG" filefrag
+
+	${FILEFRAG_PROG} -v $file >> $seqres.full
+	${FILEFRAG_PROG} -v $file | _filter_filefrag | cut -d '#' -f 1
+}
+
+# Find the device path for a btrfs logical offset
+_btrfs_get_device_path()
+{
+	local logical=$1
+	local stripe=$2
+
+	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
+
+	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
+		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
+}
+
+
+# Find the device physical sector for a btrfs logical offset
+_btrfs_get_physical()
+{
+	local logical=$1
+	local stripe=$2
+
+	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
+
+	$BTRFS_MAP_LOGICAL_PROG -b -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
+	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
+		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
+}
+
+# Read from a specific stripe to test read recovery that corrupted a specific
+# stripe.  Btrfs uses the PID to select the mirror, so keep reading until the
+# xfs_io process that performed the read was executed with a PID that ends up
+# on the intended mirror.
+_btrfs_direct_read_on_mirror()
+{
+	local mirror=$1
+	local nr_mirrors=$2
+	local file=$3
+	local offset=$4
+	local size=$5
+
+	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
+		exec $XFS_IO_PROG -d \
+			-c "pread -b $size $offset $size" $file) ]]; do
+		:
+	done
+}
+
+# Read from a specific stripe to test read recovery that corrupted a specific
+# stripe.  Btrfs uses the PID to select the mirror, so keep reading until the
+# xfs_io process that performed the read was executed with a PID that ends up
+# on the intended mirror.
+_btrfs_buffered_read_on_mirror()
+{
+	local mirror=$1
+	local nr_mirrors=$2
+	local file=$3
+	local offset=$4
+	local size=$5
+
+	echo 3 > /proc/sys/vm/drop_caches
+	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
+		exec $XFS_IO_PROG \
+			-c "pread -b $size $offset $size" $file) ]]; do
+		:
+	done
+}
diff --git a/common/config b/common/config
index c6428f90..df20afc1 100644
--- a/common/config
+++ b/common/config
@@ -228,6 +228,7 @@ export E2IMAGE_PROG="$(type -P e2image)"
 export BLKZONE_PROG="$(type -P blkzone)"
 export GZIP_PROG="$(type -P gzip)"
 export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
+export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
-- 
2.30.2

