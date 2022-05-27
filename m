Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B256E535B4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348671AbiE0ITW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347019AbiE0ITV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:19:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD4ED8FC;
        Fri, 27 May 2022 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tGyY2wVDyAuJxuihe3FeTBKyvFue7JDkkgMl8TI3lyI=; b=vY7D0E9grRJHIsO6vwOm6jirry
        wdKtMsCxlg3KYn15a1D55qUANkqf0Lkb8TTvTx2BcrDw+cpxrs2Hq6gfresjXvX4QtDQJF2b+Ev5k
        FWF4ojuC26RCKd7bE5b9SqtrD736fqaStWEXfMaUEdzJAT+wkmj4UWIm2jGd4pg2j0DeQGEWRz2/X
        3gctgFTJr9JtyCHD2SOvwRFIw+EJ5gEuGXtooXzFliJnO6imtN1OUjc2bXaNF9U+Hv1/SB/m4U3a1
        CAehOSksSAMe0090mQWGkgjGW+zPSkzRg56WpRVY3/vnbCJDUfKypG3g5yZ/OTsvyNEPyY0yblfxf
        ZGJoJmLg==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVBo-00GzuN-0m; Fri, 27 May 2022 08:19:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 01/10] btrfs: add a helpers for read repair testing
Date:   Fri, 27 May 2022 10:19:06 +0200
Message-Id: <20220527081915.2024853-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527081915.2024853-1-hch@lst.de>
References: <20220527081915.2024853-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
index ac597ca4..b69feeee 100644
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
+	${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
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

