Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9BA41768A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbhIXOIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 10:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhIXOIL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 10:08:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03EE4610C7;
        Fri, 24 Sep 2021 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632492397;
        bh=t/U+4ihTDB37ydJMfTiBQuY/KDa6PhKWA6bAsWj1bmk=;
        h=From:To:Cc:Subject:Date:From;
        b=hdOiZdAVTspJVqNQoZzdwYy+5bdS6S3HmZew//DSv9xvS89Ab2PZAaT4nyVbkOSOL
         OVdIL5AAZO4fnK6nBLppjCDSW47CTeEMs+2MC73ZgL5fcQhvKeOZx1nxAlfKwSd1+6
         /gnZgOgsZ4MhQboadbU+2/LFBxLpqnthEGIFTatxv1dwXc8i+0Gjc9gCWmsVsJh04Z
         JAbn4ABUqZsvQJgACDAveAfnIyj97gT4EJFPqCisrQg+NpESta/MR7Lllk54MX2TnV
         TULRGlYFBGPZ4ERPPqNDuKnYNwQy4GgexLqSc0Yv1vfbLH8dojCGEeeZ8sCfGTbPkl
         4+1rvQfw+sBGw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/179: fix test failure when there are no snapshots to delete
Date:   Fri, 24 Sep 2021 15:06:32 +0100
Message-Id: <b393419eff2e5fbb512be59d30ba8106afc63700.1632492293.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

It's very rare, but we can end up in a situation where there are no
snapshots to delete, in which case the $victim variable of the function
delete_workload() ends up being assigned with an empty string. When
that happens we end up running the command:

   btrfs subvolume delete "$SCRATCH_MNT/snapshots/"

Which fails since the argument is not a subvolume or a snapshot.
This causes the test to fail due to an unexpected error message from
the subvolume delete command:

  btrfs/179 129s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/179.out.bad)
      --- tests/btrfs/179.out	2020-10-16 23:13:46.546152332 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/179.out.bad	2021-09-24 11:15:01.404863801 +0100
      @@ -1,2 +1,3 @@
       QA output created by 179
      +ERROR: Not a Btrfs subvolume: Invalid argument
       Silence is golden
      ...

Fix that by making the delete_workload() loop skip the deletion attempt
when there are no snapshots.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/179 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 9a3b36ab..2f17c9f9 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -70,6 +70,10 @@ delete_workload()
 	while true; do
 		sleep $((sleep_time * 2))
 		victim=$(ls "$SCRATCH_MNT/snapshots" | sort -R | head -n1)
+		if [ -z "$victim" ]; then
+			# No snapshots available, sleep and retry later.
+			continue
+		fi
 		$BTRFS_UTIL_PROG subvolume delete \
 			"$SCRATCH_MNT/snapshots/$victim" > /dev/null
 	done
-- 
2.33.0

