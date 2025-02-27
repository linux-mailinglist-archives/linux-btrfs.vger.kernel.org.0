Return-Path: <linux-btrfs+bounces-11907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8001A47F1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 14:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41883B700C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B2823236A;
	Thu, 27 Feb 2025 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeKAbkFr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181722FDF1;
	Thu, 27 Feb 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662727; cv=none; b=HG7yWv4AeM6ox9L9Ru1fwgXZn0+fA0H2ZcfBpUurpVTZLSE70DIiXf3Zc9E4bcN40gFp00Sulix6GAP4A9Xh0EHvNZmECwYro8T78d8dVfxZU4YsoYZcktWw6UsIF52d+aigI627ctTP1eci0fu3BXyn3CJKRHbjrsSaFSDF4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662727; c=relaxed/simple;
	bh=KPWc296kRWMu7RrcMi8mkaj9TxqFRSw88sYWbpy79dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e55QlVP9O4rSDB2NKn1XG9KwXOLjQ9OnraeBLwpNBlS+BUikYMDo5Plu7TScVTstg/O6+vdmQOhkD6F7V928X3GoH4DLxIwowY7XIz5P0OHVcedyChnu9MhBjE1RyOnxnjsS1GsILPWOyXuHDXhPpNXaf/uFdisiU9CGtehfH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeKAbkFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D8AC4CEDD;
	Thu, 27 Feb 2025 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740662726;
	bh=KPWc296kRWMu7RrcMi8mkaj9TxqFRSw88sYWbpy79dM=;
	h=From:To:Cc:Subject:Date:From;
	b=jeKAbkFrKmH9eVX1jldHfI5icuxJz6zCgOlHzLaRK5H2EDlCVl3qd7VJScVsK3XxP
	 Vu6Sz/m6GPAS92uVcCUUG05n3DlGiNDnJDA1K/i9ZzpZEut73cjtzoUsX9zjk8CJG8
	 yH9ZaQIzugxoFnARD90RpBdHcMoqVS7+0DV3xyrG98JJYClf0KBWodgkkIXxIDheqd
	 fZRqsbqcF6EBCpSL7EuK/c6+qA6FIZDJI8aPcT4xpWhXivEeT5n7BGM/xbl8nCOJv6
	 xoK/m5LrwrEt0R/Z6kIU75yKirQGT5UQthI21h1pTlS21Sa+vu3r37lncVFxjbGVi7
	 6uXCUGxta7zww==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/254: fix test failure due to already unmounted scratch device
Date: Thu, 27 Feb 2025 13:25:18 +0000
Message-ID: <b470cdee538aab91177f8295fb8886ae79f680db.1740662683.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If there are no failures in the middle of test while the 3rd scratch
device is mounted (at $seq_mnt), the unmount call in the _cleanup
function will result in a test failure since the unmount already
happened, making the test fail:

  $ ./check btrfs/254
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/254 2s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad)
      --- tests/btrfs/254.out	2024-10-07 12:36:15.532225987 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad	2025-02-27 12:53:30.848728429 +0000
      @@ -3,3 +3,4 @@
       	Total devices <NUM> FS bytes used <SIZE>
       	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
       	*** Some devices missing
      +umount: /home/fdmanana/btrfs-tests/dev/254.mnt: not mounted.
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/254.out /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        770c79fb6550 btrfs: harden identification of a stale device

  Ran: btrfs/254
  Failures: btrfs/254
  Failed 1 of 1 tests

This is a recent regression because the _unmount function used to redirect
stdout and stderr to $seqres.full, but not anymore since the recent commit
identified in the Fixes tag below. So redirect stdout and stderr of the
call to _unmount in the _cleanup function to /dev/null.

Fixes: f43da58ef936 ("unmount: resume logging of stdout and stderr for filtering")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/254 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/254 b/tests/btrfs/254
index 33fdf059..e1b4fb01 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -21,7 +21,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	_unmount $seq_mnt
+	_unmount $seq_mnt > /dev/null 2>&1
 	rm -rf $seq_mnt > /dev/null 2>&1
 	cleanup_dmdev
 }
-- 
2.45.2


