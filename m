Return-Path: <linux-btrfs+bounces-6416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B992F873
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984062822B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81214EC5E;
	Fri, 12 Jul 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfG06/AW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C3148300;
	Fri, 12 Jul 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778072; cv=none; b=FLB/XPboyMMM19R/MK7OOgjsnw3Dts2piEl281aV/ne9MfdDacYjOHHFh4pQcMaVbtLvsJ+2iHDEyA1bn8c8tDLbePIT1X1kd7tCMjipZE3AQDen3HYJGG6FyOK30YCrr8FvCDST4lb1iFwgqAuVEJa4IFLfJ8ylAzWl4qAFhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778072; c=relaxed/simple;
	bh=fFFj1SKT+oYaqKzsVAs56jEPlc/LDJTvDp5BA2PQrm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyP4ahGXINZ938A6HKrlmpKbqSpEcmaf4Cl6NZha/nMzRPMXpqBdpennhOtOq87vn2HNFsDjr+9qB0RuppcNomok2+AfJshq2aJTcgrsBpkkEso2H3Iv96wrcWJpG44SEVauO24Ezfnwl/SiD2bOqgegdE1CDdRc/Bu3lQ/qiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfG06/AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D061C32782;
	Fri, 12 Jul 2024 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720778071;
	bh=fFFj1SKT+oYaqKzsVAs56jEPlc/LDJTvDp5BA2PQrm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfG06/AWnGCB2H7aXrKJwF6yFSJkCTCtrf+FXPusf8ieJ/WvaB+J5cMGRLGsxrOGX
	 K9pfMa+a2unlXPe5GmRe4s7Q/Uc9wXn4Y19fEseJjSJvQiwQ7i7a6aTJP0yfAUevW5
	 zswSke2sNlRtYbZPv5Ch8tqptlmNPP1JUZd2KSxx3SDiaikSegPO5DMn8gxOrL0uEZ
	 AqucLvFOxpe16OouJmffq+w3pHwZnuaZBToJPMl35rU7Zie/6gA2fTKB5v0E6Nkhvf
	 wIHxXQA6X0ruoJps3Wn4H4Ij/QhQ66GQstYNzUur3YBrww2JS//3cbhMo3CNti2T9F
	 85VMcTJPXQu7g==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2] btrfs: fix _require_btrfs_send_version to detect btrfs-progs support
Date: Fri, 12 Jul 2024 10:54:24 +0100
Message-ID: <f1e109784681df64d6d9fc62aa2b1952ce0bccbe.1720777916.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fbc8f96ec69397ce358e759b9a8df25f3e64c6ce.1720742612.git.fdmanana@suse.com>
References: <fbc8f96ec69397ce358e759b9a8df25f3e64c6ce.1720742612.git.fdmanana@suse.com>
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Don't use -f /dev/null in the send command, just redirect stdout and
    stderr to /dev/null.
    Add Qu's review tag.

 common/btrfs | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index be5948db..c0be7c08 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -777,17 +777,29 @@ _require_btrfs_corrupt_block()
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
+	$BTRFS_UTIL_PROG send --proto $version $SCRATCH_MNT/snap &> /dev/null
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


