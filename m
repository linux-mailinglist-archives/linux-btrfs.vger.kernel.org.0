Return-Path: <linux-btrfs+bounces-10223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175D79ECAB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 11:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B93281739
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 10:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACB1FF1C3;
	Wed, 11 Dec 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZpkTyB6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E92239BCF;
	Wed, 11 Dec 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914549; cv=none; b=eZIzqgG9B/2SHhN7oBmhGTfbUFFfC1uj9mq8eumNbTLKWpKFVctmDPzFrddvlGkfeU9WPdFpUBzfn00jKX4n4UIWvKFAJAMWILVzVo5HbPp84gMCQ6KVG7ocUKS4QpiOSj0i2Tew7wuZnyRVTuOxVmKiJYYHmw3dNAnKLZtieDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914549; c=relaxed/simple;
	bh=0FweEDu2QS27ef/Aj7WO6oyLB9eY4NDcApayvfvOKsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBgqSLrQLeBjE37V35+uey1rEGcSIwsb+f5xoDj7L6bCVo8KEtoNT79HpR/otjG82KG6XhP0nVNZfdcZvW9NBTl8O8cXDzUmE7s5nzJfCy3D7U01GyZTdw61pzY3q+d9juHzM7dUiQ0ALEgoC0fmL+YzQwhPtITUQZSrmUW3lHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZpkTyB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B093EC4CED2;
	Wed, 11 Dec 2024 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733914548;
	bh=0FweEDu2QS27ef/Aj7WO6oyLB9eY4NDcApayvfvOKsc=;
	h=From:To:Cc:Subject:Date:From;
	b=GZpkTyB60kBkM7gTKQM/U+suvBworQ6uVbrIH9+8ee+qDbUFEnbEJ9hiSL8HIkA8L
	 gn4lZVQawPFJzoBJGHjvAaR5IQJ7CSjKb8+vrCWx7MaN58vh2SSu7iSo+ZgBdjWVpI
	 p/4TxgmJG9uiY7mO6arUzOGoPdn1NmW5wUZFHc6M6S44hw3Yf4N9vXq2iyX7ec00xX
	 EdsimJmeP4ME20yo9sB3JlFV8tS7kT/jRh1Rjfx99yzieZQDBqiglybM0WMnml/yyS
	 WsU484aauztD31gQTz4tJxUawDFju17GySZeKclwEzRbdOZ/yjo5G7dPRyplTsQPWk
	 L5vHn5pudh6xg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	dchinner@redhat.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/590: fix test failure when running against fs other than xfs
Date: Wed, 11 Dec 2024 10:55:25 +0000
Message-ID: <bcb3d3adeb36c732e807d876b82219c3c1350e2e.1733914512.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

With commit ce79de11337e ("fstests: clean up loop device instantiation")
we started to always call _destroy_loop_device at the very end of the
test, but we only create a loop device if we are running against xfs,
so the call to _destroy_loop_device results in an error since no loop
device was setup.

For example running this test against btrfs or ext4 results in this
failure:

   $ ./check generic/590
   FSTYP         -- btrfs
   PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
   MKFS_OPTIONS  -- /dev/sdc
   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

   generic/590 29s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/590.out.bad)
      --- tests/generic/590.out	2020-06-10 19:29:03.858520038 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//generic/590.out.bad	2024-12-11 10:48:43.946205346 +0000
       @@ -1,2 +1,5 @@
       QA output created by 590
      -Silence is golden
      +losetup: option requires an argument -- 'd'
      +Try 'losetup --help' for more information.
      +Cannot destroy loop device
      +(see /home/fdmanana/git/hub/xfstests/results//generic/590.full for details)
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/590.out /home/fdmanana/git/hub/xfstests/results//generic/590.out.bad'  to see the entire diff)
   Ran: generic/590
   Failures: generic/590
   Failed 1 of 1 tests

Fix this by removing the call to _destroy_loop_device at the end of the
test, as it's unnecessary because we call it in the _cleanup function if
we have setup a loop device.

Fixes: ce79de11337e ("fstests: clean up loop device instantiation")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/590 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/generic/590 b/tests/generic/590
index 04d86e78..1adeef4c 100755
--- a/tests/generic/590
+++ b/tests/generic/590
@@ -115,8 +115,6 @@ $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
 # We need to do this before the loop device gets torn down.
 _scratch_unmount
 _check_scratch_fs
-_destroy_loop_device $loop_dev
-unset loop_dev
 
 echo "Silence is golden"
 status=0
-- 
2.45.2


