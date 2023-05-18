Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DF707EE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjERLJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 May 2023 07:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjERLJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 May 2023 07:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5561D1FEE;
        Thu, 18 May 2023 04:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25FBF64A96;
        Thu, 18 May 2023 11:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC43C4339B;
        Thu, 18 May 2023 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684408115;
        bh=0HSDO+TJgQ6yrG6sznJDeE/s5xbyaTbBdPU3M17P7Mg=;
        h=From:To:Cc:Subject:Date:From;
        b=XghzFkXITGDKUTjmaPvjRbK0ry2n5I+idHoUSxdiFLHhMyJU07FgAp/H3It5QaJF6
         eovHFpsqm3V5q+lPbbszkmL4OOT/Bo588bCecjL5XGUKDZOaztRXSgh+EBTnVcoaH9
         KYRtEUJ5SjBQUqQlInrBM3t5W6Ez/NRz1gl+iY4qKWxiZKY3LhaR3mj1lurS9QKYif
         c064p9/OMOCj8LPnr0qQHqD/oAQpnnADno/u1xXKqS/vOceAmX7RMRyZnaV0Yg7Ia8
         2vT8Im7ir5YUjXM9yzmSsj1mw5tE4DwnVHYjVWcbXTGpaybako3hDJKfvfhKPnDmfE
         uv8snlFqK/uuQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/213: avoid occasional failure due to already finished balance
Date:   Thu, 18 May 2023 12:08:30 +0100
Message-Id: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
spend writing 1M data extents. Also ignore when the balance failed because
it was already finished when we tried to cancel it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/213 | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/213 b/tests/btrfs/213
index 8a10355c..cca0b3cc 100755
--- a/tests/btrfs/213
+++ b/tests/btrfs/213
@@ -28,7 +28,7 @@ _require_xfs_io_command pwrite -D
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 
-runtime=4
+runtime=8
 
 # Create enough IO so that we need around $runtime seconds to relocate it.
 #
@@ -39,11 +39,18 @@ sleep $runtime
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
+$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iv 'not in progress'
 
 # Now check if we can finish relocating metadata, which should finish very
 # quickly.
-- 
2.34.1

