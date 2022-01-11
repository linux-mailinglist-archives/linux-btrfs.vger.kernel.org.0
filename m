Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3848A474
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 01:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbiAKAhH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 19:37:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48954 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbiAKAhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 19:37:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C543E2114D;
        Tue, 11 Jan 2022 00:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641861424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dfVTysoVBlWUrgc3+Q1J51+58FPeeGDGaVCAYivBHno=;
        b=o+iVH4V13A87h/H1v6a+CDoOmGqux2TOXMfW7dntDSGyj6WcziyTs9M+OXv8brzsdW2w7M
        WM/V1jf0wL6Y5OA7E5L+XggmbCgsfB+fEofU6NhcuMkOyVuGWKPiU+OzNAY38FeZKAq4IF
        aCafweX943DIf3EDZx/FpeMIMrF0v5g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7BD813A42;
        Tue, 11 Jan 2022 00:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nq0GJy/R3GGwagAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 11 Jan 2022 00:37:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/011: continue the test if we failed to cancel the replace
Date:   Tue, 11 Jan 2022 08:36:46 +0800
Message-Id: <20220111003646.8712-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs/011 test case has exposed quite some bugs in the past, but it also
has some tendency to cause false alert, as its way testing replace
cancel require the replace to be still running when we send the cancel
request.

But on a lot of cases, the replace can finish way faster than the wait
time, and cause false alert.

Commit fa85aa64 ("btrfs/011: Fill the fs to ensure we have enough data for
dev-replace") tries to address the problem by filling the fs, but there
is still no guarantee.

Although there is still some discussion on how to properly solve the
problem, there is one thing sure that we should continue the test
instead of abort, if the replace cancel failed.

A quick abort caused by finished replace will leave other profiles
untested, reducing the coverage.

This patch will still mark the test failed for a finished replace, but
at least ensure we have run the test for all the profiles.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/011 | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index b4673341..05ea96b9 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -171,13 +171,25 @@ btrfs_replace_test()
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
+		# If the replace is finished, we need to replace $source_dev
+		# back with $target_dev, or later fsck will fail and abort
+		# the test, reducing the coverage.
+		if grep -q finished $tmp.tmp ; then
+			$BTRFS_UTIL_PROG replace start -Bf $target_dev \
+				$source_dev $SCRATCH_MNT > /dev/null
+		fi
+
+		# For above finished case, we still output the error message
+		# but continue the test, or later profiles won't get tested
+		# at all.
+		grep -q canceled $tmp.tmp || echo "btrfs replace status (canceled) failed"
 	else
 		if [ "${quick}Q" = "thoroughQ" ]; then
 			# The thorough test runs around 2 * $wait_time seconds.
-- 
2.34.1

