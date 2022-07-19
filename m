Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E21579308
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 08:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiGSGPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiGSGPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 02:15:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3441C11F;
        Mon, 18 Jul 2022 23:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JNfIOmb3pZUjyCwdfZUagOuJbfz98B4d+ZnwP0UG7uY=; b=3goxqST7R90v7QrpJTuy6B80M7
        FExUoHLMOujZ44C67nnetuX3jUaPZzKD+GJRUfaY7ac3rLT0PuXMTRktrsWdANe0y9Qhwvn1Nr2hn
        t3lhij/0hztyG+Vh+p+mLEUTKIeqBA8yqjB9DUfq+bQ33/fudQPuY+Fz18LIbPW+eXiL5Oe2AcNOr
        5dvt3i19ADeKArVHylIdeUPrhHR40HWJNiugZZ9pHio8wvX/qLYLm/kukow0BwTPwrJvft50pZZQH
        2rkQHInjGICICxAntPWZG0HqdXTH4K5dJRISCttACSQv4L0d7foH1lJf93U2n7Hy3R+QdBQhq6D8L
        u8mag85w==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDgVU-005dPF-LJ; Tue, 19 Jul 2022 06:14:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix btrfs/271
Date:   Tue, 19 Jul 2022 08:14:54 +0200
Message-Id: <20220719061454.829559-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commited old version test the broken behavior of the current
upstream code that writes the uncompressed data into a previously
bad mirror.  Fix the test to check that the compressed data gets
re-replicated and add it to the compress group while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/270     | 11 +++++++----
 tests/btrfs/270.out | 34 ----------------------------------
 2 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/tests/btrfs/270 b/tests/btrfs/270
index 4229a02c..5b73fb15 100755
--- a/tests/btrfs/270
+++ b/tests/btrfs/270
@@ -7,7 +7,7 @@
 # Regression test for btrfs buffered read repair of compressed data.
 #
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair compress
 
 . ./common/filter
 
@@ -60,7 +60,9 @@ _scratch_unmount
 echo "step 2......corrupt file extent"
 echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
 	>> $seqres.full
-$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
+dd if=$devpath of=$TEST_DIR/$seq.dump.good skip=$physical bs=1 count=4096 \
+	2>/dev/null
+$XFS_IO_PROG -c "pwrite -S 0xbb -b 4K $physical 4K" $devpath > /dev/null
 
 _scratch_mount
 
@@ -70,8 +72,9 @@ _btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
 _scratch_unmount
 
 echo "step 4......check if the repair worked"
-$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
-	_filter_xfs_io_offset
+dd if=$devpath of=$TEST_DIR/$seq.dump skip=$physical bs=1 count=4096 \
+	2>/dev/null
+cmp -bl $TEST_DIR/$seq.dump.good $TEST_DIR/$seq.dump
 
 _scratch_dev_pool_put
 # success, all done
diff --git a/tests/btrfs/270.out b/tests/btrfs/270.out
index 53a80692..6d744c02 100644
--- a/tests/btrfs/270.out
+++ b/tests/btrfs/270.out
@@ -5,37 +5,3 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 step 2......corrupt file extent
 step 3......repair the bad copy
 step 4......check if the repair worked
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-read 512/512 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.30.2

