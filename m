Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B24709448
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjESJ5j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 05:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjESJ51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 05:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1300E7F;
        Fri, 19 May 2023 02:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB7D5651D1;
        Fri, 19 May 2023 09:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DAFC433D2;
        Fri, 19 May 2023 09:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684490229;
        bh=M5Er8cVtIQkLyiVUA7RHubAwotnvUH6OrWACfMRQhPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrwTATGJn3ufSEtMEbpWLf5hDrpjnwmdPUEvxLcbl1atH2A1f+gSakeTlSV2P4E7r
         39OXkD5SyYa0gr8FcG9J/Qu5dvO7nbp2e3rtIve+tjI9wGi47tyBI+sJuWZjNoVdko
         gaeXcxiNjgoP3YB52IzN/ynL8hxETjO96KBvDG5WkHQsRLunWgcMp5xEltGlV75GVb
         1CWqVUQpjVTDY3Gln/2VqTDVRXyBx6q50QbG4+gJQrOJQ2RzJhPfMQSyCmpAr+ku1d
         Xlmcwd1HQv+VK2nMGFfYjZcOCvSm9wI6v9kcKcy7dKyUMkxQONrMWjfM6S2ivtloG/
         xtvOqhS+wjpNg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs/213: avoid occasional failure due to already finished balance
Date:   Fri, 19 May 2023 10:57:01 +0100
Message-Id: <ff12321e5ddfdb763b9258f746e67fe3f6ea1321.1684489375.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com>
References: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

btrfs/213 writes data, in 1M extents, for 4 seconds into a file, then
triggers a balance and then after 2 seconds it tries to cancel the
balance operation. More often than not, this works because the balance
is still running after 2 seconds. However it also fails sporadically
because balance has finished in less than 2 seconds, which is plausible
since data and metadata are cached or other factors such as virtualized
environment. When that's the case, it fails like this:

  $ ./check btrfs/213
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc1-btrfs-next-131+ #1 SMP PREEMPT_DYNAMIC Thu May 11 11:26:19 WEST 2023
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/213 51s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad)
      --- tests/btrfs/213.out	2020-06-10 19:29:03.822519250 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad	2023-05-17 15:39:32.653727223 +0100
      @@ -1,2 +1,3 @@
       QA output created by 213
      +ERROR: balance cancel on '/home/fdmanana/btrfs-tests/scratch_1' failed: Not in progress
       Silence is golden
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/213.out /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad'  to see the entire diff)
  Ran: btrfs/213
  Failures: btrfs/213
  Failed 1 of 1 tests

To make it much less likely that balance has already finished before we
try to cancel it, unmount and mount again the filesystem before starting
balance, to clear cached metadata and data, and also double the time we
spend writing 1M data extents. Also make the test not run with an
informative message if we detect that balance finished before we could
cancel it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

v2: Make the test _notrun if we detect that balance finished before we
    could cancel it.

 tests/btrfs/213 | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/213 b/tests/btrfs/213
index e16e41c0..5666d9b9 100755
--- a/tests/btrfs/213
+++ b/tests/btrfs/213
@@ -31,7 +31,7 @@ _fixed_by_kernel_commit 1dae7e0e58b4 \
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 
-runtime=4
+runtime=8
 
 # Create enough IO so that we need around $runtime seconds to relocate it.
 #
@@ -42,11 +42,21 @@ sleep $runtime
 kill $write_pid
 wait $write_pid
 
+# Unmount and mount again the fs to clear any cached data and metadata, so that
+# it's less likely balance has already finished when we try to cancel it below.
+_scratch_cycle_mount
+
 # Now balance should take at least $runtime seconds, we can cancel it at
 # $runtime/2 to ensure a success cancel.
 _run_btrfs_balance_start -d --bg "$SCRATCH_MNT"
-sleep $(($runtime / 2))
-$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
+sleep $(($runtime / 4))
+# It's possible that balance has already completed. It's unlikely but often
+# it may happen due to virtualization, caching and other factors, so ignore
+# any error about no balance currently running.
+$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iq 'not in progress'
+if [ $? -eq 0 ]; then
+	_not_run "balance finished before we could cancel it"
+fi
 
 # Now check if we can finish relocating metadata, which should finish very
 # quickly.
-- 
2.34.1

