Return-Path: <linux-btrfs+bounces-6409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E882692F2EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 02:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206021C22013
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6EF645;
	Fri, 12 Jul 2024 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZpuUsdF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B59173;
	Fri, 12 Jul 2024 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742740; cv=none; b=AgQGP+Rye1y/P1AM2YSCARXzXBMda3EiRmSq3h9Ttc2LEkkh0TGEILmenWihyiZuQqCQ41Ua6UCkXGwGWcEV5E53ZoUqE0JqjzchAky72ZEhrt49srs92QotTXkl0Y74LktGG2vncu0ydx4XpW9zWU9+uhwFRi+qOyfBkrAuxgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742740; c=relaxed/simple;
	bh=pUkc0BD5j3U39nDRNfzzwCogGBUFuTFXpvRDxc1fajw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzPkBbxg4IpogbFiT99tUr0wPPtl8UpPMHP8+mDnnWoDetx7woQx+UsgC0qiffjEpX7NpiSR6nQm4aiz6tayhGIWtMPyQoJhdB26MaKGomK20J+HZqbhW/vG2i201ugKWLHFDg5fBgoghV/+J4k6gkQ4KzAPzmTZYbyGp1KrC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZpuUsdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F15C116B1;
	Fri, 12 Jul 2024 00:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720742740;
	bh=pUkc0BD5j3U39nDRNfzzwCogGBUFuTFXpvRDxc1fajw=;
	h=From:To:Cc:Subject:Date:From;
	b=mZpuUsdFjhvvlqIwC1NVgf9KSdt/migXcs3qSw+2gNk+rVsGXKENWjIj8cYdqqeh4
	 07jAPXGztJ3BEkenMPr/EFuLGu2ECUTKkNBgJ21ku4dQJ3uDN2ZBB+vwDaI+d/zr+4
	 0kFi1dmV8ssAbS0o/+c2+BKpXyMJ75MMXD6jbuVMyGXN6WrFWIXJ8mq+vD9YVC0f5L
	 ntbE2boYzjBDhdf4oayhx1zE+grGi4cVutkcCfuIqgMRTjEjwILznId/nuuHKb7AQY
	 1VJoCmvIQHlsfDBMGMx+Aq7KIhesnTk/jT7Msd0XKRxBO4ruu6SPfua+ZiQLJpXb48
	 CjaKZ0L8uT/qw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: fix _require_btrfs_send_version to detect btrfs-progs support
Date: Fri, 12 Jul 2024 01:05:31 +0100
Message-ID: <fbc8f96ec69397ce358e759b9a8df25f3e64c6ce.1720742612.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Commit 199d0a992536df3702a0c4843d2a449d54f399c2 ("common/btrfs: introduce
_require_btrfs_send_version") turned _require_btrfs_send_v2 into a generic
helper to detect support for any send stream version, however it's only
working for detecting kernel support, it misses detecting the support from
btrfs-progs - it always checks only that it supports v2 (the send command
supports the --compressed-data option).

Fix that by verifying that btrfs-progs supports the requested version.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index be5948db..953dc2a0 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -777,17 +777,30 @@ _require_btrfs_corrupt_block()
 _require_btrfs_send_version()
 {
 	local version=$1
+	local ret
 
-	# Check first if btrfs-progs supports the v2 stream.
-	_require_btrfs_command send --compressed-data
-
-	# Now check the kernel support. If send_stream_version does not exists,
+	# Check the kernel support. If send_stream_version does not exists,
 	# then it's a kernel that only supports v1.
 	[ -f /sys/fs/btrfs/features/send_stream_version ] || \
 		_notrun "kernel does not support send stream $version"
 
 	[ $(cat /sys/fs/btrfs/features/send_stream_version) -ge $version ] || \
 		_notrun "kernel does not support send stream $version"
+
+	# Now check that btrfs-progs supports the requested stream version.
+	_scratch_mkfs &> /dev/null || \
+		_fail "mkfs failed at _require_btrfs_send_version"
+	_scratch_mount
+	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+			 $SCRATCH_MNT/snap &> /dev/null
+	$BTRFS_UTIL_PROG send --proto $version -f /dev/null \
+			 $SCRATCH_MNT/snap 2> /dev/null
+	ret=$?
+	_scratch_unmount
+
+	if [ $ret -ne 0 ]; then
+		_notrun "btrfs-progs does not support send stream version $version"
+	fi
 }
 
 # Get the bytenr associated to a file extent item at a given file offset.
-- 
2.43.0


