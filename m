Return-Path: <linux-btrfs+bounces-5761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69190B70E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 18:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF532856AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858E1662FC;
	Mon, 17 Jun 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIcWe5Bp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBF1369A8;
	Mon, 17 Jun 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643141; cv=none; b=Cignf2IRMLYn5oxVT7YRgA+TV4irRNo4PkkmR7tL0WGJsPWpV63B/wf50UK8+fN1mGTfxkIbZbfF+I8wTKX5zw8q+6uq8S9Btce1zgQR0yCWKFIvgLWfdH9/zDywXRsxfJgmhfnN/B6sMPpnNHKymkJ/z46MVtd3pcyPjoHMY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643141; c=relaxed/simple;
	bh=JElrMA/RGAnyYmZy9NcpLBTJthgBG4jOKijrblNqkBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OB9WRlPPlImG56m+33jHZl/iEOU17sgySn+1DrDjEUIJVMRArI1uRlRJVMY+rJtiRS9b4wrrxr8o8MITiOhsHpUpw8TiMwpEdJ6QA2hnC2RT9dUNCKImtPfhI5IG5dCup4BTCsVH7Y44Dbmz29Txdt6SwXbHHXQQmokIAqmmKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIcWe5Bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6296C2BD10;
	Mon, 17 Jun 2024 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718643140;
	bh=JElrMA/RGAnyYmZy9NcpLBTJthgBG4jOKijrblNqkBU=;
	h=From:To:Cc:Subject:Date:From;
	b=nIcWe5Bp0wK8+UngmvOlcJaFjXBHLJCDLaft/KA56EOIN9iJjOwFCm06/tku1SZJ7
	 YshzzZhCL1zlJGIZ3k4qUBS4+mBbhngWfeACFzsjy0pWfxhXaBhQ7am/0FfFaB152/
	 G3xdz+kOH1Ut3XSRlBlRxUHNQNSVuReAqc15jyoZT+Q7ewvZjweck3IXxkVSgUikZg
	 u7ym065y6TJh7Gf1fnxexfTUwDrTx6xbnSRiGJmyDPrMRXXw6nl9RrNCD2OMf9JxQF
	 ErPyQMikcNuT6cs/Ct7FLPsltNXH+323RN1iukgQ7xA021NUcw3hCJm55qrv9gt3Nd
	 EPlZ/DVxWxV/Q==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/74[3,8]: add git commit ID for the fixes
Date: Mon, 17 Jun 2024 17:52:14 +0100
Message-ID: <85c32250ac781bf925d1f26b0c6933dace05b3d1.1718643112.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The corresponding fixes landed in kernels 6.10-rc1 and 6.10-rc3, so update
the tests to point the commit IDs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/743 | 2 +-
 tests/generic/748 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/743 b/tests/generic/743
index ad37d32f..769ce706 100755
--- a/tests/generic/743
+++ b/tests/generic/743
@@ -23,7 +23,7 @@ _cleanup()
 # Import common functions.
 . ./common/dmerror
 
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit 631426ba1d45 \
 	"mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly"
 
 # real QA test starts here
diff --git a/tests/generic/748 b/tests/generic/748
index 71b74166..428d4a33 100755
--- a/tests/generic/748
+++ b/tests/generic/748
@@ -17,7 +17,7 @@ _require_scratch
 _require_attrs
 _require_odirect
 _require_xfs_io_command falloc -k
-[ "$FSTYP" = btrfs ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
+[ "$FSTYP" = btrfs ] && _fixed_by_kernel_commit 9d274c19a71b \
 	"btrfs: fix crash on racing fsync and size-extending write into prealloc"
 
 # -i slows down xfs_io startup and makes the race much less reliable.
-- 
2.43.0


