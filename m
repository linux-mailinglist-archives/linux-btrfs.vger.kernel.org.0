Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD5723F7C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbjFFKbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbjFFKau (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 06:30:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A0E55;
        Tue,  6 Jun 2023 03:30:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 912CD1FD69;
        Tue,  6 Jun 2023 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686047445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fGG+0XA3Pt5q1mk1qeiXYZxnk976/0urlm/19hljb5E=;
        b=km1eYGi61CAArOo+mEoba7kxjxb89qm+gjiY0dTU6Ano59k1OFfP2Sx88Gh0GinlwOg+oP
        A5XH227h5N+YJe7T8/cGxaRmbWZvJRXOHoevMMKx+UfN4e5OcbvRml6gFMd+vtpj5LFfwh
        kl9H7z55IxKsrzLkR2MuzR+/zk/91oQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD83813776;
        Tue,  6 Jun 2023 10:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cM1wJ9QKf2RTdQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 06 Jun 2023 10:30:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs/266: test case enhancement to cover more possible failures
Date:   Tue,  6 Jun 2023 18:30:27 +0800
Message-Id: <20230606103027.125617-1-wqu@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
Recently I'm debugging a random failure with btrfs/266 with larger page
sizes (64K page size, with either 64K sector size or 4K sector size).

During the tests, I found the test case itself can be further enhanced
to make better coverage and easier debugging.

[ENHANCEMENT]

- Ensure every 64K block only has one good mirror
  The initial layout is not pushing hard enough, some ranges have 2 good
  mirrors while some only has one.

- Simplify the golden output
  The current golden output contains 512 bytes output for the beginning
  of each mirror.

  The 512 bytes output itself is both duplicating and not comprehensive
  enough (see the next output).

  This patch would remove the duplication part by only output one single
  line for 16 bytes.

- Add extra output for all the 3 64K blocks
  Each 64K of the involved file now has only one good mirror, and they
  are all on different devices.
  Thus only checking the beginning of the first 64K block is not good
  enough.

  This patch would enhance this by output the first 16 bytes for all the
  3 64K blocks on each device.

- Add a final safenet to catch unexpected corruption
  If we have some weird corruption after the first 16 bytes of each
  64K blocks, we can still detect them using "btrfs check
  --check-data-csum", which acts as offline scrub.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/266     |  59 ++++++++++++++++++++----
 tests/btrfs/266.out | 109 ++++++++------------------------------------
 2 files changed, 68 insertions(+), 100 deletions(-)

diff --git a/tests/btrfs/266 b/tests/btrfs/266
index 42aff7c0..894c5c6e 100755
--- a/tests/btrfs/266
+++ b/tests/btrfs/266
@@ -25,7 +25,7 @@ _require_odirect
 _require_non_zoned_device "${SCRATCH_DEV}"
 
 _scratch_dev_pool_get 3
-# step 1, create a raid1 btrfs which contains one 128k file.
+# step 1, create a raid1 btrfs which contains one 192k file.
 echo "step 1......mkfs.btrfs"
 
 mkfs_opts="-d raid1c3 -b 1G"
@@ -33,7 +33,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
 _scratch_mount
 
-$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 192K 0 192K" \
 	"$SCRATCH_MNT/foobar" | \
 	_filter_xfs_io_offset
 
@@ -56,6 +56,13 @@ devpath3=$(_btrfs_get_device_path ${logical} 3)
 
 _scratch_unmount
 
+# We corrupt the mirrors so that every 64K block only has one
+# good mirror. (X = corruption)
+#
+#		0	64K	128K	192K
+# Mirror 1	|XXXXXXXXXXXXXXX|	|
+# Mirror 2	|	|XXXXXXXXXXXXXXX|
+# Mirror 3	|XXXXXXX|	|XXXXXXX|
 $XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
 	$devpath3 > /dev/null
 
@@ -65,7 +72,7 @@ $XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physical1 128K" \
 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 65536)) 128K" \
 	$devpath2 > /dev/null
 
-$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 * 65536))) 128K"  \
+$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 * 65536))) 64K"  \
 	$devpath3 > /dev/null
 
 _scratch_mount
@@ -73,19 +80,53 @@ _scratch_mount
 # step 3, 128k dio read (this read can repair bad copy)
 echo "step 3......repair the bad copy"
 
-_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
-_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
-_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
+_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 192K
+_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 192K
+_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 192K
 
 _scratch_unmount
 
 echo "step 4......check if the repair worked"
-$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
+echo "Dev 1:"
+echo "  Physical offset + 0:"
+$XFS_IO_PROG -c "pread -qv $physical1 16" $devpath1 |\
 	_filter_xfs_io_offset
-$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
+echo "  Physical offset + 64K:"
+$XFS_IO_PROG -c "pread -qv $((physical1 + 65536)) 16" $devpath1 |\
 	_filter_xfs_io_offset
-$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
+echo "  Physical offset + 128K:"
+$XFS_IO_PROG -c "pread -qv $((physical1 + 131072)) 16" $devpath1 |\
 	_filter_xfs_io_offset
+echo
+
+echo "Dev 2:"
+echo "  Physical offset + 0:"
+$XFS_IO_PROG -c "pread -qv $physical2 16" $devpath2 |\
+	_filter_xfs_io_offset
+echo "  Physical offset + 64K:"
+$XFS_IO_PROG -c "pread -qv $((physical2 + 65536)) 16" $devpath2 |\
+	_filter_xfs_io_offset
+echo "  Physical offset + 128K:"
+$XFS_IO_PROG -c "pread -qv $((physical2 + 131072)) 16" $devpath2 |\
+	_filter_xfs_io_offset
+echo
+
+echo "Dev 3:"
+echo "  Physical offset + 0:"
+$XFS_IO_PROG -c "pread -v $physical3 16" $devpath3 |\
+	_filter_xfs_io_offset
+echo "  Physical offset + 64K:"
+$XFS_IO_PROG -c "pread -v $((physical3 + 65536)) 16" $devpath3 |\
+	_filter_xfs_io_offset
+echo "  Physical offset + 128K:"
+$XFS_IO_PROG -c "pread -v $((physical3 + 131072)) 16" $devpath3 |\
+	_filter_xfs_io_offset
+
+# Final step to use btrfs check to verify the csum of all mirrors.
+$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+	echo "btrfs check found some data csum mismatch"
+fi
 
 _scratch_dev_pool_put
 # success, all done
diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
index fcf2f5b8..305e9c83 100644
--- a/tests/btrfs/266.out
+++ b/tests/btrfs/266.out
@@ -1,109 +1,36 @@
 QA output created by 266
 step 1......mkfs.btrfs
-wrote 262144/262144 bytes
+wrote 196608/196608 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 step 2......corrupt file extent
 step 3......repair the bad copy
 step 4......check if the repair worked
+Dev 1:
+  Physical offset + 0:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+  Physical offset + 64K:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+  Physical offset + 128K:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+
+Dev 2:
+  Physical offset + 0:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+  Physical offset + 64K:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+  Physical offset + 128K:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+
+Dev 3:
+  Physical offset + 0:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
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
+read 16/16 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+  Physical offset + 64K:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
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
+read 16/16 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+  Physical offset + 128K:
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
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
+read 16/16 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.39.0

