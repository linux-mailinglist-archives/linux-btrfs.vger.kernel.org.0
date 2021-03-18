Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E09C3404F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 12:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCRLse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 07:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhCRLsU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 07:48:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BBD664F2A;
        Thu, 18 Mar 2021 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616068100;
        bh=N0svwE4Jl9ptt0xc9mBYuuAvr9wXnyZvVxI9MNOw2mE=;
        h=From:To:Cc:Subject:Date:From;
        b=PFrTz0PXj3e22J1iojZoEjWtrSrynMqzMUIEnXuoT+AZqBekmAHvNN2TYtwsmdJta
         nKZKgS/FvHlYivNIKw3laRwXunCfw393NDq5IdNlMW08ojv3s7A4fOYn4r1KWIrzY0
         Wxg2LYx3JwRJTsHsReAGfMq6GmqzwnpT5fZiXtrqhkVplL9cgRCbxtV3h3sSlJX4fr
         5oAP6+50m8DKYXLpiZgZy+++DexPvcdqWRXlPb7HvWZOJJCO/OfgFm4qTzetxilD3F
         bfsErlmqgk705qwoXcm7JQ1EHTcSPLVYKgIyw0kSk9vYsfA0b71yPDodHm6QRfOTJ4
         plut5cvx8FjOw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/232: fix umount failure due to fsstress still running
Date:   Thu, 18 Mar 2021 11:48:15 +0000
Message-Id: <024df0e67e78e0a77fedef4f6451eab6b26326b6.1616068024.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We start a process that runs fsstress, then kill the process, wait for it
to die and then end the test, where we attempt to unmount the fs which
often fails because the fsstress subcommand started by the process is
still running and using the mount point. This results in a test failure:

  btrfs/232 1s ... umount: /home/fdmanana/btrfs-tests/scratch_1: target is busy.
  _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
  (see /home/fdmanana/git/hub/xfstests/results//btrfs/232.full for details)

Fix that by adding a trap to the writer() function.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/232 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/btrfs/232 b/tests/btrfs/232
index b0a04a61..b9841410 100755
--- a/tests/btrfs/232
+++ b/tests/btrfs/232
@@ -32,6 +32,10 @@ _cleanup()
 
 writer()
 {
+	# Wait for running fsstress subcommand before exitting so that
+	# mountpoint is not busy when we try to unmount it.
+	trap "wait; exit" SIGTERM
+
 	while true; do
 		args=`_scale_fsstress_args -p 20 -n 1000 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 		$FSSTRESS_PROG $args >/dev/null 2>&1
-- 
2.28.0

