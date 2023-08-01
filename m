Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABD276A990
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 08:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjHAGzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 02:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHAGzu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 02:55:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626BC1;
        Mon, 31 Jul 2023 23:55:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EBCF81F38D;
        Tue,  1 Aug 2023 06:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690872947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pzkeJHiorKeHlXYhJpTQ5Nged1sFoN7bgyGZNMfzEPc=;
        b=qa9DuieZVZo492Sy+xDV6c0MSGRo6Dom2mnbgCtB2B/lMik4HbMiho2p3WVH7eeVV1zWV5
        Qb5R/P9mxG7hUP3zZYvqQl4Eo3CWqDwYibVxQ+dVmpnwgJwfUQ+0HlbVpzST4XwwH6Y3/F
        hO4K3uPveNEDWPvugI6zyzk6xbY6TZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95D0513919;
        Tue,  1 Aug 2023 06:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FwrcFnKsyGQ1cQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 01 Aug 2023 06:55:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs/276: allow a slight increase in the number of extents
Date:   Tue,  1 Aug 2023 14:55:29 +0800
Message-ID: <20230801065529.50122-1-wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Sometimes test case btrfs/276 would fail with extra number of extents:

    - output mismatch (see /opt/xfstests/results//btrfs/276.out.bad)
    --- tests/btrfs/276.out	2023-07-19 07:24:07.000000000 +0000
    +++ /opt/xfstests/results//btrfs/276.out.bad	2023-07-28 04:15:06.223985372 +0000
    @@ -1,16 +1,16 @@
     QA output created by 276
     wrote 17179869184/17179869184 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -Number of non-shared extents in the whole file: 131072
    +Number of non-shared extents in the whole file: 131082
     Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
    -Number of shared extents in the whole file: 131072
    ...
    (Run 'diff -u /opt/xfstests/tests/btrfs/276.out /opt/xfstests/results//btrfs/276.out.bad'  to see the entire diff)

[CAUSE]
The test case uses golden output to record the number of total extents
of a 16G file.

This is not reliable as we can have writeback happen halfway, resulting
smaller extents thus slightly more extents.

With a VM with 4G memory, I have a chance around 1/10 hitting this
false alert.

[FIX]
Instead of using golden output, we allow a slight (5%) float in the
number of extents, and move the 131072 (and 131072 - 16) from golden
output, so even if we have a slightly more extents, we can still pass
the test.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/276     | 41 ++++++++++++++++++++++++++++++++++++-----
 tests/btrfs/276.out |  4 ----
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/tests/btrfs/276 b/tests/btrfs/276
index 944b0c8f..a63b28bb 100755
--- a/tests/btrfs/276
+++ b/tests/btrfs/276
@@ -65,10 +65,17 @@ count_not_shared_extents()
 
 # Create a 16G file as that results in 131072 extents, all with a size of 128K
 # (due to compression), and a fs tree with a height of 3 (root node at level 2).
+#
+# But due to writeback can happen halfway, we may have slightly more extents
+# than 128K, so we allow 5% increase in the number of extents.
+#
 # We want to verify later that fiemap correctly reports the sharedness of each
 # extent, even when it needs to switch from one leaf to the next one and from a
 # node at level 1 to the next node at level 1.
 #
+nr_extents_lower=$((128 * 1024))
+nr_extents_upper=$((128 * 1024 + 128 * 1024 / 20))
+
 $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Sync to flush delalloc and commit the current transaction, so fiemap will see
@@ -76,13 +83,22 @@ $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo | _filter_xfs_io
 sync
 
 # All extents should be reported as non shared (131072 extents).
-echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
+found1=$(count_not_shared_extents)
+echo "Number of non-shared extents in the whole file: ${found1}" >> $seqres.full
+
+if [ $found1 -lt $nr_extents_lower -o $found1 -gt $nr_extents_upper ]; then
+	echo "unexpected initial number of extents, has $found1 expect [$nr_extents_lower, $nr_extents_upper]"
+fi
 
 # Creating a snapshot.
 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
 
 # We have a snapshot, so now all extents should be reported as shared.
-echo "Number of shared extents in the whole file: $(count_shared_extents)"
+found2=$(count_shared_extents)
+echo "Number of shared extents in the whole file: ${found2}" >> $seqres.full
+if [ $found2 -ne $found1 ]; then
+	echo "unexpected shared extents, has $found2 expect $found1"
+fi
 
 # Now COW two file ranges, of 1M each, in the snapshot's file.
 # So 16 extents should become non-shared after this.
@@ -97,8 +113,18 @@ sync
 
 # Now we should have 16 non-shared extents and 131056 (131072 - 16) shared
 # extents.
-echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
-echo "Number of shared extents in the whole file: $(count_shared_extents)"
+found3=$(count_not_shared_extents)
+found4=$(count_shared_extents)
+echo "Number of non-shared extents in the whole file: ${found3}"
+echo "Number of shared extents in the whole file: ${found4}" >> $seqres.full
+
+if [ $found3 != 16 ]; then
+	echo "Unexpected number of non-shared extents, has $found3 expect 16"
+fi
+
+if [ $found4 != $(( $found1 - $found3 )) ]; then
+	echo "Unexpected number of shared extents, has $found4 expect $(( $found1 - $found3 ))"
+fi
 
 # Check that the non-shared extents are indeed in the expected file ranges (each
 # with 8 extents).
@@ -117,7 +143,12 @@ _scratch_remount commit=1
 sleep 1.1
 
 # Now all extents should be reported as not shared (131072 extents).
-echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
+found5=$(count_not_shared_extents)
+echo "Number of non-shared extents in the whole file: ${found5}" >> $seqres.full
+
+if [ $found5 != $found1 ]; then
+	echo "Unexpected final number of non-shared extents, has $found5 expect $found1"
+fi
 
 # success, all done
 status=0
diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
index 3bf5a5e6..e318c2e9 100644
--- a/tests/btrfs/276.out
+++ b/tests/btrfs/276.out
@@ -1,16 +1,12 @@
 QA output created by 276
 wrote 17179869184/17179869184 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Number of non-shared extents in the whole file: 131072
 Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
-Number of shared extents in the whole file: 131072
 wrote 1048576/1048576 bytes at offset 8388608
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1048576/1048576 bytes at offset 12884901888
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Number of non-shared extents in the whole file: 16
-Number of shared extents in the whole file: 131056
 Number of non-shared extents in range [8M, 9M): 8
 Number of non-shared extents in range [12G, 12G + 1M): 8
 Delete subvolume (commit): 'SCRATCH_MNT/snap'
-Number of non-shared extents in the whole file: 131072
-- 
2.41.0

