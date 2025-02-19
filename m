Return-Path: <linux-btrfs+bounces-11598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9801CA3C739
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 19:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9D07A7380
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A950214A9D;
	Wed, 19 Feb 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkwAkU1t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECA8468;
	Wed, 19 Feb 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989173; cv=none; b=blYsLwr7wbtLEfHCradRAlUjzNWKFy7uKm5+YDVEyDusSYoY+Hi7Z/bMx9vBCFqG+XlGQJngiCLQc2+6gJ8bF4JqsLonC54fT3BV0xhgPsB+OCWPusrw2tazZVr6Kk9gjsDhLvqO6X2gBIYAmohjc12fBfQX+ezLouuwZXCrhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989173; c=relaxed/simple;
	bh=joYUR36Uz5HVkFMN+b28bsbD+JBbgJXnANUJNwj9Opo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MytQp9N83UJpfqWTJwkRI3tpv0fwdwE4amVkNZwPl5AjOdhBJUBOGu5OyCHy6oBHo5ohtfvXePPY7HHwwgLzOw1baLwispF//ZbBmGmqSSvVP5SW5xf2VX1S2UE2+brvtc+VHgWTf4aUHXrr6GwyT5V4oJYrkq+DA9N8EnkPsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkwAkU1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607FCC4CEE0;
	Wed, 19 Feb 2025 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989173;
	bh=joYUR36Uz5HVkFMN+b28bsbD+JBbgJXnANUJNwj9Opo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkwAkU1tCi0lIM7h5S9jeYilQWbSs2EELHOOFipETXTsgLnK/63AfrHPuUshof7lz
	 XJMwbEkuvqRdXFidek/Go+zlVE+YSCGQ9VrvRyZGz4XvAbVVvTmIQxAWhMOtTF5PcW
	 9LSrT0QTKLmEOcopCfWGJRCaQ1s94gtr5nCRJbC88JskUhcnrOcc5nM1vvsqJcy0Ov
	 9GilqimQ3iitET7DwmuG/bvAmOePOoEeRqZRkbO8gfSt1WNfZK/GOnsXgOtGSEVamD
	 /KQ0fOFeu5FyjGzKju819tFlgyEqhD4yyLGt9M7g0BlamgQT1ZAUlqrumLtBCTdV4L
	 55dVRFl12RMBw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs/254: fix test failure in case scratch devices are larger than 50G
Date: Wed, 19 Feb 2025 18:19:15 +0000
Message-ID: <27997253fd18428b2eb24d3f5ddd19885f058259.1739989076.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739989076.git.fdmanana@suse.com>
References: <cover.1739989076.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If the devices in the scratch pool have a size larger than 50G, then the
test fails due to chunk allocation failure when attempting to create a
multidevice filesystem on $lvdev and $scratch_dev2. This happens because
the $lvdev device has a size of 1G and metadata chunks have a size of 1G
for filesystems with a size greater than 50G, so mkfs fails when it
attempts to allocate chunks since it needs to allocate a 1G metadata
chunk plus a system chunk and a data chunk.

  $ ./check btrfs/254
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc3-btrfs-next-187+ #1 SMP PREEMPT_DYNAMIC Tue Feb 18 10:53:23 WET 2025
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/254 2s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad)
      --- tests/btrfs/254.out	2024-10-07 12:36:15.532225987 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad	2025-02-19 18:07:06.479812229 +0000
      @@ -1,5 +1,13 @@
       QA output created by 254
      -Label: none  uuid: <UUID>
      -	Total devices <NUM> FS bytes used <SIZE>
      -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
      -	*** Some devices missing
      +ERROR: not enough free space to allocate chunk
      +btrfs-progs v6.13
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/254.out /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        770c79fb6550 btrfs: harden identification of a stale device

  Ran: btrfs/254
  Failures: btrfs/254
  Failed 1 of 1 tests

Fix this by creating a 2G $lvdev device instead of 1G.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/254 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/254 b/tests/btrfs/254
index 6523389b..ec303e24 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -44,8 +44,11 @@ _scratch_dev_pool_get 3
 
 setup_dmdev()
 {
-	# Some small size.
-	size=$((1024 * 1024 * 1024))
+	# On filesystems up to 50G the metadata chunk size if 256M, but on
+	# larger ones it's 1G, so use 2G to ensure the test doesn't fail with
+	# -ENOSPC when running mkfs against $lvdev and $scratch_dev2 in case
+	# the device at $scratch_dev2 has more capacity than 50G.
+	size=$((2 * 1024 * 1024 * 1024))
 	size_in_sector=$((size / 512))
 
 	table="0 $size_in_sector linear $SCRATCH_DEV 0"
-- 
2.45.2


