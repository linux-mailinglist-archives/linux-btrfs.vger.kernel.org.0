Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E444E489770
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbiAJLa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 06:30:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50808 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbiAJL3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:29:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9CFA2114E;
        Mon, 10 Jan 2022 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641814146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wQ6m015dUSXp+gbU2X0jmyWGQH7xvuU6GtTPy22zsaQ=;
        b=rCnifcmq+POPauLmrP4e7UrNbbE0NiKj1ZRmlDt4PVDcCss7JMIIpVcHGM/EC4MNJg1WnU
        IxgjhCy9t1BEeVyvJ2RweaYW9fr76pHGzCq1llGVxKcHDFePClBv9xP33iQWxCs3nUcp0Z
        vqYh3QAJqrlNZmD+uRSYJ1cg67mqDR4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF424139ED;
        Mon, 10 Jan 2022 11:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2jsZLYEY3GGIcgAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 10 Jan 2022 11:29:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/011: handle finished replace properly
Date:   Mon, 10 Jan 2022 19:28:48 +0800
Message-Id: <20220110112848.37491-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running btrfs/011 inside VM which has unsafe cache set for its
devices, and the host have enough memory to cache all the IO:

btrfs/011 98s ... [failed, exit status 1]- output mismatch
    --- tests/btrfs/011.out	2019-10-22 15:18:13.962298674 +0800
    +++ /xfstests-dev/results//btrfs/011.out.bad	2022-01-10 19:12:14.683333251 +0800
    @@ -1,3 +1,4 @@
     QA output created by 011
     *** test btrfs replace
    -*** done
    +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
    +(see /xfstests-dev/results//btrfs/011.full for details)
    ...
Ran: btrfs/011
Failures: btrfs/011
Failed 1 of 1 tests

[CAUSE]
Although commit fa85aa64 ("btrfs/011: Fill the fs to ensure we
have enough data for dev-replace") tries to address the problem by
filling the fs with extra content, there is still no guarantee that 2
seconds of IO still needs 2 seconds to finish.

Thus even we tried our best to make sure the replace will take 2
seconds, it can still finish faster than 2 seconds.

And just to mention how fast the test finishes, after the fix, the test
takes around 90~100 seconds to finish.
While on real-hardware it can take over 1000 seconds.

[FIX]
Instead of further enlarging the IO, here we just accept the fact that
replace can finish faster than our expectation, and continue the test.

One thing to notice is, since the replace finished, we need to replace
back the device, or later fsck will be executed on blank device, and
cause false alert.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/011 | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index b4673341..aae89696 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -171,13 +171,24 @@ btrfs_replace_test()
 		# background the replace operation (no '-B' option given)
 		_run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
 		sleep $wait_time
-		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
+		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT 2>&1 >> $seqres.full
 
 		# 'replace status' waits for the replace operation to finish
 		# before the status is printed
 		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
 		cat $tmp.tmp >> $seqres.full
-		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) failed"
+
+		# There is no guarantee we canceled the replace, it can finish
+		if grep -q 'finished' $tmp.tmp ; then
+			# The replace finished, we need to replace it back or
+			# later fsck will report error as $SCRATCH_DEV is now
+			# blank
+			$BTRFS_UTIL_PROG replace start -Bf $target_dev \
+				$source_dev $SCRATCH_MNT > /dev/null
+		else
+			grep -q 'canceled' $tmp.tmp || _fail \
+				"btrfs replace status (canceled ) failed"
+		fi
 	else
 		if [ "${quick}Q" = "thoroughQ" ]; then
 			# The thorough test runs around 2 * $wait_time seconds.
-- 
2.34.1

