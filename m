Return-Path: <linux-btrfs+bounces-10199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6A9EB867
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 18:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD732857F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304061BCA05;
	Tue, 10 Dec 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp8bGwcN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F611A9B31;
	Tue, 10 Dec 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852059; cv=none; b=t1I/Ai+YD2MdF0QUbmnPC3ie5mxCWwKJisrr7OjSGUMxjwMirfuBDt0BJ/zeFzsMsG2i4B4/wmj4gbE3pM6vNb2YmUW6Et0vQtHAmHtHYlNND/FYE3RbGHoe0KnMIHuOZt9FxzW/VJuoJAvXjAyMhn5xbputEw1QfTthYbfHEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852059; c=relaxed/simple;
	bh=r04UzEVfWy7aN0G+Fp/8wWozJfXQ3+HM/IgfmsNGMcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FY2k852dMI3FIj8fystthksfN7+oFtVLcZmg18dfoi1u4FTwfnlFHldO+NGlPmoVyS4IhGwiLSYn+1h8B1vSWb0o7ma5QRg/KiH0Qc8W6CoHaemyrqey2KlMSmYs+ZrUuauojAdQdZxk1zlYg61U7JBWsNUW1L65myHn6uZ8ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp8bGwcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA57C4CEDD;
	Tue, 10 Dec 2024 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733852059;
	bh=r04UzEVfWy7aN0G+Fp/8wWozJfXQ3+HM/IgfmsNGMcY=;
	h=From:To:Cc:Subject:Date:From;
	b=pp8bGwcNhISyf/6ZNX8qeydID/OIKINW7qkbMiOkYHEA1CCDGBdehCuYZfE2lNiQg
	 1Zc0j/sfO5zMtO/HVBHUkpSgCyVHNP8I+pup7nbDRUmqnlFXjo8rF5e0YBoORg2+QX
	 wsujIl8FZ3Nl+Ul9TAw1/Zn07+PW7j8stFnBUQLwj7kmyU3iWcZuXH8CfT/RMgKtL0
	 sRPUywA8sVjbI+jhDgKb8Kejoe01PIB/2DmOA4J2BKKbKKdygeVuCFE75S/KyFgf3H
	 2rG4nLN8fJ5jLZB8SBNzDESOoDH+bR4HFEHZamhzD/jKTKTyYZHqMEyhWDPfAu5dEK
	 oDge+/78IrFUg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	dchinner@redhat.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/146: fix failure due to missing test number argument for fsync-err
Date: Tue, 10 Dec 2024 17:34:14 +0000
Message-ID: <5200182586d153054cbfc2549dea4b862c65e9fc.1733852046.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After commit 88c0291d297c ("fstests: per-test dmerror instances") the
script src/dmerror now has an extra argument, corresponding to a test's
sequence number, but btrfs/146 isn't passing that argument so the test
fails like this:

  $ ./check btrfs/146
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/146 3s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad)
      --- tests/btrfs/146.out	2020-06-10 19:29:03.818519162 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad	2024-12-10 17:19:40.363498130 +0000
      @@ -1,3 +1,4 @@
       QA output created by 146
       Format and mount
      -Test passed!
      +Usage: /home/fdmanana/git/hub/xfstests/src/dmerror {load_error_table|load_working_table}
      +system: program exited: 1
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/146.out /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad'  to see the entire diff)
  Ran: btrfs/146
  Failures: btrfs/146
  Failed 1 of 1 tests

Fix this by passing the test's sequence number as an argument.

Fixes: 88c0291d297c ("fstests: per-test dmerror instances")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/146 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/146 b/tests/btrfs/146
index d6d2829a..c1243757 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -57,7 +57,7 @@ _require_fs_space $SCRATCH_MNT $write_kb
 testfile=$SCRATCH_MNT/fsync-err-test
 
 SCRATCH_DEV=$old_SCRATCH_DEV
-$here/src/fsync-err -b $(($write_kb * 1024)) -d $here/src/dmerror $testfile
+$here/src/fsync-err -b $(($write_kb * 1024)) -d "$here/src/dmerror $seq" $testfile
 
 # success, all done
 _dmerror_load_working_table
-- 
2.45.2


