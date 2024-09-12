Return-Path: <linux-btrfs+bounces-7972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB93B976962
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 14:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55483285D4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0411A2627;
	Thu, 12 Sep 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="li7EdmOh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241F1A4E85;
	Thu, 12 Sep 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145107; cv=none; b=oe8xLAuN/D2Ti5215Nn7LafpFIIVUj0EqsYAO2UBwUYSDCLUuzUIMr5ecrRlpV5GWlDT8gGTnw10F75HpNc9laoc4d4+tY62xCve1qZnzmkADayf470YD71FBGtRJ8WRQjIDfylUUblG5hfdHiGJFa4Fc4Q5kQEdrRqtxDaCqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145107; c=relaxed/simple;
	bh=eytcVU4Igne2L7WRNk2/ov3GQ3XP5+lebIE+x7DCPEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgbJbyP5z/Yg2ZBU0FqG0TLaAw5KK7UaBxCODv9+tCqJFgtmO9g/sw2h9bElTK7TnjQ3Quxu66WvLSmrhW8FGByxs3nxUCj+wBeUptlJzTCoFOWzelp+7/WOI5NKsOagwS97OO8mA6xcY5Vq2OKNuLEDlUsardAOgvtAliGLegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=li7EdmOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C505FC4CEC3;
	Thu, 12 Sep 2024 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726145106;
	bh=eytcVU4Igne2L7WRNk2/ov3GQ3XP5+lebIE+x7DCPEw=;
	h=From:To:Cc:Subject:Date:From;
	b=li7EdmOhsb6S5w/HVm5Dn8W71QEpZ5QMw4jaMVvlTYlWx+8u6pMTKbA4wXueSdH4A
	 q1lud08jFWcStCWPudLUEndbjanV531/+q+jcAo6iLp5KZsOklr0JBG9JW3FttyZcl
	 52LWw/BJCkVEqe+QX1J1ke1RmwS2iOa0kNDIzNG4DSoLvXkxo88vbQ0z6LwSmw+ZUN
	 ZZWKoBwd6/JMhBS/TSrzq7z/LV7gvDh9gNYx6DNz+1VSq0exXW4aELOvveKhY520dd
	 e2RX9jDHQuIkha961Q254ll2mLTRU0XtW2esyPJVOuthn5r0rZfywOUJEftt0Mi6bz
	 JFjBta4abMSEw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/321: make the test work when compression is enabled
Date: Thu, 12 Sep 2024 13:45:00 +0100
Message-ID: <21f8d987309ca0699c6bb95666278d02da03ff32.1726145029.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When running btrfs/321 with compression enabled it fails like this:

  $ MOUNT_OPTIONS="-o compress" ./check btrfs/321
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc7-btrfs-next-174+ #1 SMP PREEMPT_DYNAMIC Tue Sep 10 17:11:38 WEST 2024
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/321 2s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/321.out.bad)
      --- tests/btrfs/321.out	2024-09-12 12:12:11.259272125 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/321.out.bad	2024-09-12 13:18:40.231120012 +0100
      @@ -1,2 +1,5 @@
       QA output created by 321
      -Silence is golden
      +mount: /home/fdmanana/btrfs-tests/scratch_1: can't read superblock on /dev/sdc.
      +       dmesg(1) may have more information after failed mount system call.
      +mount -o compress -o ro /dev/sdc /home/fdmanana/btrfs-tests/scratch_1 failed
      +(see /home/fdmanana/git/hub/xfstests/results//btrfs/321.full for details)
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/321.out /home/fdmanana/git/hub/xfstests/results//btrfs/321.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        10d9d8c3512f btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()

  Ran: btrfs/321
  Failures: btrfs/321
  Failed 1 of 1 tests

This is because with compression enabled we get a csum tree that has only
one leaf, and that leaf is the root of the csum tree. That means that
after the test corrupts the leaf, the next mount will fail since an error
loading the root is critical and makes the mount operation fail.

Fix this by creating a file with 128M of data instead of 32M, as this
guarantees that even if compression is enabled, and even with the maximum
allowed leaf size (64K), we still get a csum tree with multiple leaves,
making the test work.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/321 | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/321 b/tests/btrfs/321
index 93935530..c13ccc1e 100755
--- a/tests/btrfs/321
+++ b/tests/btrfs/321
@@ -33,9 +33,11 @@ _scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >> $seqres.full 2>&1
 # This test requires data checksum to trigger the bug.
 _scratch_mount -o datasum,datacow
 
-# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 32M data
-# will need 32K data checksum at minimal, which is at least 8 leaves.
-_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
+# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 128M of data
+# will need 128K data checksum at minimal, which is at least 34 leaves when
+# running without compression and a leaf size of 64K. With compression enabled
+# and a 64K leaf size, it will be 2 leaves.
+_pwrite_byte 0xef 0 128m "$SCRATCH_MNT/foobar" > /dev/null
 _scratch_unmount
 
 
-- 
2.43.0


