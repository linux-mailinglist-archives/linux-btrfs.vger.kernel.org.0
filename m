Return-Path: <linux-btrfs+bounces-14269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9F3AC6884
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 13:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A104A1A7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED859283C8E;
	Wed, 28 May 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPA6lSSV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35D84A3E;
	Wed, 28 May 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748432548; cv=none; b=fEOPs4pgyn1nwDhq+Wp8aOCm03Vavrs27Cc5L4+BZsonKhtoa+0Ed48eSj9bEpWm8LKejuwU5mPyEW2JAPd+74guOt9pDRTlLMs1X4M/RtZKbhqC332E2UnJdkeFFh9PeA+7LLvdF8KqvxVgwCtPRuQhMFXmeGi480RehCyFNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748432548; c=relaxed/simple;
	bh=itcKsvmYwrqflZ1s+3+cNkVKpxeVBDeBvRtfCi6xjqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbEn1O+TliGf1VSR9Y5C/2PbmFrml959jbSjnKx1Oxhvv4yXqsVXxby48yUFIygNdPb1QE2QJbfIkvzf8vwK0vK5CUccQ2GPeP1P6pJU6H91/62zTuCu7y8ecloeUdTzYlYfux9bFYZlEN9KEukCGj9sPlyEpOdZzxCRgQ89ZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPA6lSSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00DEC4CEE7;
	Wed, 28 May 2025 11:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748432547;
	bh=itcKsvmYwrqflZ1s+3+cNkVKpxeVBDeBvRtfCi6xjqo=;
	h=From:To:Cc:Subject:Date:From;
	b=sPA6lSSVI17ydxdN1RzJEdeylnVv1HWB9YvgX16obm8WNjMnThQwACiwzoUGEzdBl
	 44x+/ywwQtMu0p3/nMTrSEjQcSpswY1bQ6iZEqbr2UAYQhqMDeLr7Gh0WMcW5aMpN9
	 bHZAlRoKTueItpSXPXKatrRPkkgTv7b0WzDCFBbmWszWWH/dk8NM9ztu7aNYBRi6zQ
	 pdihJpOJmRsjQv9Kyu8blCI2q3dfKkYpc/Ad9Gx68U+xRT28acNKPnRrgSIqcRKoDm
	 Awe+LBmBfKYZQCh4m4/KYz5EU35XzUWvBANXFx0tyhGcp330CvOT7rayjMEIVPPqqV
	 PZRO+NCzc66Sw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/032: fix failure due to attempt to wait for non-child process
Date: Wed, 28 May 2025 12:42:20 +0100
Message-ID: <ad779afaef849e0febdce26cbcb5503beed87341.1748432418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Running generic/032 can sporadically fail like this:

  generic/032 11s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad)
      --- tests/generic/032.out   2023-03-02 21:47:53.884609618 +0000
      +++ /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad    2025-05-28 10:39:34.549499493 +0100
      @@ -1,5 +1,6 @@
       QA output created by 032
       100 iterations
      +/home/fdmanana/git/hub/xfstests/tests/generic/032: line 90: wait: pid 3708239 is not a child of this shell
       000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
       *
       100000
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/032.out /home/fdmanana/git/h

This is because we are attempting to wait for a process that is not a
child process of the test process and it's instead a child of a process
spawned by the test.

To make sure that after we kill the process running _syncloop() there
isn't any xfs_io process still running syncfs, add instead a trap to
to _syncloop() that waits for xfs_io to finish before the process running
that function exits.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/032 | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tests/generic/032 b/tests/generic/032
index 48d594fe..b04b84de 100755
--- a/tests/generic/032
+++ b/tests/generic/032
@@ -28,6 +28,10 @@ _cleanup()
 
 _syncloop()
 {
+	# Wait for any running xfs_io command running syncfs before we exit so
+	# that unmount will not fail due to the mount being pinned by xfs_io.
+	trap "wait; exit" SIGTERM
+
 	while [ true ]; do
 		_scratch_sync
 	done
@@ -81,15 +85,6 @@ echo $iters iterations
 kill $syncpid
 wait
 
-# The xfs_io instance started by _scratch_sync could be stuck in D state when
-# the subshell running _syncloop & is killed.  That xfs_io process pins the
-# mount so we must kill it and wait for it to die before cycling the mount.
-dead_syncfs_pid=$(_pgrep xfs_io)
-if [ -n "$dead_syncfs_pid" ]; then
-	_pkill xfs_io
-	wait $dead_syncfs_pid
-fi
-
 # clear page cache and dump the file
 _scratch_cycle_mount
 _hexdump $SCRATCH_MNT/file
-- 
2.47.2


