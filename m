Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542897CF4A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbjJSKG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 06:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbjJSKG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 06:06:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0F12A;
        Thu, 19 Oct 2023 03:06:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3CEC433C8;
        Thu, 19 Oct 2023 10:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697709984;
        bh=2RHW6eQDtzw4Pa0BgCifdvVOWoLALmZaQF83z6YwPfI=;
        h=From:To:Cc:Subject:Date:From;
        b=EYR6qWBprpUKwMl/NbUgsFFrfZ30Z2z4aSkED33FK0T+DOPokoJcRGgXIqXa3VA9f
         MPlCt6Gt9B4dFh2KR0ksZI+xYZSyCvU0niYPyerYf7bYuOIRp9VP9txdEVFDpAk0LX
         +y9sBW1+ehwnJDl3nSBwmzXjbOz+zx8qAvIn77xbExVIRa3DgugKEqKh+tO5mnEg6h
         bjXaIF/ZR5B8UVpQgZNcPyENyNoWAk1VvBAe912H3a4wQaZva+yZsHWy5KJ2W3rhCh
         bB0lKIeDiauev1NHm+OO5ukSIjKu8O99AGE0FQ4Fy4TjT4y8zyPDxGLhgSirTZX9wP
         YkJ5rQLvRW/yg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/298: fix failure when added device supports trim
Date:   Thu, 19 Oct 2023 11:06:14 +0100
Message-Id: <ee1d17b6f4956c0638cb7faa6f9c92b7bf3c25ac.1697709904.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A btrfs device add command issues a trim on the device if the device
supports trim, and then it outputs a message to stdout informing that it
performed a trim. If that happens it breaks the golden output and the
test fails like this:

   $ ./check btrfs/298
   FSTYP         -- btrfs
   PLATFORM      -- Linux/x86_64 debian0 6.6.0-rc3-btrfs-next-139+ #1 SMP PREEMPT_DYNAMIC Tue Oct  3 13:52:02 WEST 2023
   MKFS_OPTIONS  -- /dev/sdc
   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

   btrfs/298       - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/298.out.bad)
       --- tests/btrfs/298.out	2023-10-18 23:29:06.029292800 +0100
       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/298.out.bad	2023-10-19 10:54:29.693210881 +0100
       @@ -1,2 +1,3 @@
        QA output created by 298
       +Performing full device TRIM /dev/sdd (100.00GiB) ...
        Silence is golden
       ...
       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/298.out /home/fdmanana/git/hub/xfstests/results//btrfs/298.out.bad'  to see the entire diff)
   Ran: btrfs/298
   Failures: btrfs/298
   Failed 1 of 1 tests

Fix this by redirecting the device add's stdout to the $seqres.full file.
Any device add errors are sent to stderr, so we'll notice if errors happen
due to possible future regressions, as it will break the golden output.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/298 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/298 b/tests/btrfs/298
index d5536cf3..0cea81d0 100755
--- a/tests/btrfs/298
+++ b/tests/btrfs/298
@@ -25,7 +25,7 @@ _scratch_mkfs "-b 300M" >> $seqres.full 2>&1 || \
 	_fail "Fail to make SCRATCH_DEV with -b 300M"
 $BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
 _scratch_mount >> $seqres.full 2>&1
-$BTRFS_UTIL_PROG device add $SPARE_DEV $SCRATCH_MNT
+$BTRFS_UTIL_PROG device add $SPARE_DEV $SCRATCH_MNT >> $seqres.full
 _scratch_unmount
 $BTRFS_UTIL_PROG device scan --forget
 
-- 
2.40.1

