Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05D622AD8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 12:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiKILoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 06:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKILoF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 06:44:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286CA1A04E;
        Wed,  9 Nov 2022 03:43:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF060B81DF5;
        Wed,  9 Nov 2022 11:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1D2C433C1;
        Wed,  9 Nov 2022 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667994226;
        bh=j1Aieg493NQTqXY3czipEQEPMuHZTJs8oAvLJMoCCmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7hmokEXp0AW0laL0H2Az8JrPTeMIjJ2zdN1lXWbBt+uKvfRz9agPWXC5Oi9qwf1v
         MZD3d0JRigCdT0K1uh/q+vLBmoNtKXRTkXGvjuzNeaDhqE23yarIrqo3pR7CLP4AH3
         Ct/kaV3Jxpsu0QSqthyZs/dUIOhJknAlMsENCgicur5sNwEVGfef++YH4AGmAbQLK6
         zySRDe1WB5SL6gIk9m6FwhZX+DHh2rVb797DXcggGdzVXyAS7QOTeshnhN1WOSr/hT
         UpwIab0ij8hiRF5hbOIS1NmsQUc9wXxNOBId04qDAY9abRJu2tj/mIR2Z+y1J1crGp
         6XhWMZ2cofrXw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/3] btrfs: fix failure of tests that use defrag on btrfs-progs v6.0+
Date:   Wed,  9 Nov 2022 11:43:36 +0000
Message-Id: <d2723c3a1b0205c68f5e62ed5156672d93b2e270.1667993961.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667993961.git.fdmanana@suse.com>
References: <cover.1667993961.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Starting with btrfs-progs v6.0, the defrag command now prints to stdout
the full path of the files it processes. This makes test cases btrfs/021
and btrfs/256 fail because they don't expect any output from the defrag
command.

The change happened with the following commit in btrfs-progs:

  dd724f21803d ("btrfs-progs: add logic to handle LOG_DEFAULT messages")

So update the tests to ignore the stdout of the defrag command.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/021 | 4 +++-
 tests/btrfs/256 | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/021 b/tests/btrfs/021
index 5943da2f..1b55834a 100755
--- a/tests/btrfs/021
+++ b/tests/btrfs/021
@@ -22,8 +22,10 @@ run_test()
 
 	sleep 0.5
 
+	# In new versions of btrfs-progs (6.0+), the defrag command outputs to
+	# stdout the path of the files it operates on. So ignore that.
 	find $SCRATCH_MNT -type f -print0 | xargs -0 \
-	$BTRFS_UTIL_PROG filesystem defrag -f
+		$BTRFS_UTIL_PROG filesystem defrag -f > /dev/null
 
 	sync
 	wait
diff --git a/tests/btrfs/256 b/tests/btrfs/256
index 1360c2c2..acbbc6fa 100755
--- a/tests/btrfs/256
+++ b/tests/btrfs/256
@@ -50,7 +50,9 @@ $FSSUM_PROG -A -f -w "$checksums_file" "$SCRATCH_MNT"
 # Now defrag each file.
 for sz in ${file_sizes[@]}; do
 	echo "Defragging file with $sz bytes..." >> $seqres.full
-	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz"
+	# In new versions of btrfs-progs (6.0+), the defrag command outputs to
+	# stdout the path of the files it operates on. So ignore that.
+	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz" > /dev/null
 done
 
 # Verify the checksums after the defrag operations.
-- 
2.35.1

