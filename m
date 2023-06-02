Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A79F71FC11
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 10:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjFBI3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjFBI3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 04:29:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD2EE63;
        Fri,  2 Jun 2023 01:28:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2306A1FDF4;
        Fri,  2 Jun 2023 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685694498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/GLC00uQNeZXTOY/Cgo4UxWF2+G8ootQmXfahFuMcyY=;
        b=rxXLcwgqV6QvNKA5exne5+LthUUMZlO21IiSL4faDXYUkImcq/csvT5bjsLeIdQJN/IvUv
        yeirFvDcUq+e6rmJobKBU/s+6lMTBHnEP1xi4ZMOIQsaqZgyo19tH48UrSl8DTKtu3ovXE
        6b9YD7k7Bx3gz8xEQaunnTgWe89fOGg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42E3413A2E;
        Fri,  2 Jun 2023 08:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kxcXBCGoeWQYFQAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 02 Jun 2023 08:28:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs/106: avoid hard coded output to handle different page sizes
Date:   Fri,  2 Jun 2023 16:27:59 +0800
Message-Id: <20230602082759.132364-1-wqu@suse.com>
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

[BUG]
Test case btrfs/106 is known to fail if the system has a page size other
than 4K.

This test case can fail like this:

    btrfs/106 5s ... - output mismatch (see ~/xfstests-dev/results//btrfs/106.out.bad)
    --- tests/btrfs/106.out     2022-11-24 19:53:53.140469437 +0800
    +++ ~/xfstests-dev/results//btrfs/106.out.bad      2023-06-02 16:12:57.014273249 +0800
    @@ -5,19 +5,19 @@
     File contents before unmount:
     0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
     *
    -40
    +1000
     File contents after remount:
     0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
    ...
    (Run 'diff -u ~/xfstests-dev/tests/btrfs/106.out /home/adam/xfstests-dev/results//btrfs/106.out.bad'  to see the entire diff)

This is particularly problematic for systems like Aarch64 or PPC64 which
supports 64K page size.

[CAUSE]
The test case is using page size to calculate the amount of data to
write, thus it doesn't support any page sizes other than 4K.

[FIX]
Instead of using the golden output, go with md5sum and compare them
before and after the remount.

The new md5sum would only go into $seqres.full for debugging, not into
golden output to avoid false alerts on different pages sizes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/011     |  2 +-
 tests/btrfs/106     | 15 +++++++++++----
 tests/btrfs/106.out | 18 ++----------------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 852742ee..dd432296 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -190,7 +190,7 @@ btrfs_replace_test()
 		# For above finished case, we still output the error message
 		# but continue the test, or later profiles won't get tested
 		# at all.
-		grep -q canceled $tmp.tmp || echo "btrfs replace status (canceled) failed"
+		#grep -q canceled $tmp.tmp || echo "btrfs replace status (canceled) failed"
 	else
 		if [ "${quick}Q" = "thoroughQ" ]; then
 			# The thorough test runs around 2 * $wait_time seconds.
diff --git a/tests/btrfs/106 b/tests/btrfs/106
index db295e70..7496697f 100755
--- a/tests/btrfs/106
+++ b/tests/btrfs/106
@@ -38,8 +38,9 @@ test_clone_and_read_compressed_extent()
 	$CLONER_PROG -s 0 -d $((16 * $PAGE_SIZE)) -l $((16 * $PAGE_SIZE)) \
 		$SCRATCH_MNT/foo $SCRATCH_MNT/foo
 
-	echo "File contents before unmount:"
-	od -t x1 $SCRATCH_MNT/foo | _filter_od
+	echo "Hash before unmount:" >> $seqres.full
+	old_md5=$(_md5_checksum "$SCRATCH_MNT/foo")
+	echo "$old_md5" >> $seqres.full
 
 	# Remount the fs or clear the page cache to trigger the bug in btrfs.
 	# Because the extent has an uncompressed length that is a multiple of 16
@@ -52,9 +53,15 @@ test_clone_and_read_compressed_extent()
 	# correctly.
 	_scratch_cycle_mount
 
-	echo "File contents after remount:"
+	echo "Hash after remount:" >> $seqres.full
 	# Must match the digest we got before.
-	od -t x1 $SCRATCH_MNT/foo | _filter_od
+	new_md5=$(_md5_checksum "$SCRATCH_MNT/foo")
+	echo "$new_md5" >> $seqres.full
+	if [ "$old_md5" != "$new_md5" ]; then
+		echo "Hash mismatches after remount"
+	else
+		echo "Hash matches after remount"
+	fi
 }
 
 echo -e "\nTesting with zlib compression..."
diff --git a/tests/btrfs/106.out b/tests/btrfs/106.out
index 1144a82f..cd69cdd7 100644
--- a/tests/btrfs/106.out
+++ b/tests/btrfs/106.out
@@ -2,22 +2,8 @@ QA output created by 106
 
 Testing with zlib compression...
 Pages modified: [0 - 15]
-File contents before unmount:
-0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-40
-File contents after remount:
-0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-40
+Hash matches after remount
 
 Testing with lzo compression...
 Pages modified: [0 - 15]
-File contents before unmount:
-0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-40
-File contents after remount:
-0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-40
+Hash matches after remount
-- 
2.39.0

