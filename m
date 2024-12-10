Return-Path: <linux-btrfs+bounces-10197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230369EB85A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1742857D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A21B3727;
	Tue, 10 Dec 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um85zwMP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761B23ED49;
	Tue, 10 Dec 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852009; cv=none; b=Q3okL1lK/JUjD36Q+qz+nFXcp3qBA7eRKpwFGhqaIXkuIEKg0s9sySl2gUEyJSndUhF5NxglJcxzhzCWwioOZgy0fcfAG0NaZFAw+f8I+G5yX/G8VTM3lzcNZ3FBBgO7y/M3HR1lOLJ+o8pb+PAIQ+UoNEMyGEYdQw6kMspI0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852009; c=relaxed/simple;
	bh=SDIvUrTXVxQQGSD901YK/rvR6Ihwumo45F+yct5MrD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0giZJRXy0nWvntoYN0FkYPxeax2rh2vxYuJVsAQiPxi8kJf4HpcT2sMStDPcU9hz0UKJyvfDbRmH8dsisMi67sGZ+fJYUnelH4ntajIDh+PDucYGaM/0LBtGANODmnE+7xeX+N1xaBJ70/EbKcJQzvHHYNMOAG8rc5y8OEcBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um85zwMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A94C4CED6;
	Tue, 10 Dec 2024 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733852008;
	bh=SDIvUrTXVxQQGSD901YK/rvR6Ihwumo45F+yct5MrD4=;
	h=From:To:Cc:Subject:Date:From;
	b=um85zwMPcYNAU+qZ80vFv1SubMcnXdR0LZvX1H3U2UFKe83ffSrJ3Gl86dftXbr/K
	 p5LJjug9MzvLAQLmnpJKiBzMoC/5/XG9kcYcww/cCSWjzOZ/C7XabgHiOqH0jwzJd9
	 HgBngLAN/MRCCJqF0mJUdQ4Uqp4RboXH86hhp3SSs7X1DICamveXQGKMLxRpXZQ4T+
	 6jvrLOGasAgNNFIMi6uD5l4tNZFgn+47iJHF8dDV0YA6V/ze/gfsh+cTM8f2BinJXZ
	 lG94QGBJunTK6QZDM4mcaC8ig/tXpBFrnRafEAG4AoCt4qkrz2TotQ5d8Eun6qonqd
	 7xKlVUOsyEccA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	dchinner@redhat.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/100, btrfs/101: fix device name in their golden output
Date: Tue, 10 Dec 2024 17:33:22 +0000
Message-ID: <84afb2bfe9615a98a1ae4de7dfd5fca98771937d.1733851994.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After commit 88c0291d297c ("fstests: per-test dmerror instances"), the dm
error device name changed so that it's no longer a plain 'error-test' but
instead it's that plus a prefix matching the test number, such as
'error-test.100' for example. The tests btrfs/100 and btrfs/101 are still
using the plain old name 'error-test' in their golden output, which makes
them fail. So update them to use 'error-test.100' and 'error-test.101'.

Fixes: 88c0291d297c ("fstests: per-test dmerror instances")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/100.out | 2 +-
 tests/btrfs/101.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/100.out b/tests/btrfs/100.out
index 1fe3c0de..e0e6cec2 100644
--- a/tests/btrfs/100.out
+++ b/tests/btrfs/100.out
@@ -2,7 +2,7 @@ QA output created by 100
 Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
+	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test.100
 Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
diff --git a/tests/btrfs/101.out b/tests/btrfs/101.out
index c2359c7c..fbb5faa1 100644
--- a/tests/btrfs/101.out
+++ b/tests/btrfs/101.out
@@ -2,7 +2,7 @@ QA output created by 101
 Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
+	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test.101
 Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-- 
2.45.2


