Return-Path: <linux-btrfs+bounces-8582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C46992A42
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C831F23006
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5E1D1319;
	Mon,  7 Oct 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8dCe47F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3649C101C4;
	Mon,  7 Oct 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300780; cv=none; b=cAIzRM3sTrAXYuBVMmT9h64xGlUtxP84BQdsDJhX5YnDyXOY19z9VsbXLviFfh/qo9E9jITOt+MUP1diHN6vlJ1cRewO2nJngRlH++p8+9sDpKxUdyjPxInKLOXLR8mbKg+u5tZL07R+/rlayfLL/c1NoODWpILvMDQJCMQ1GxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300780; c=relaxed/simple;
	bh=PyM0DwevYnXrw0K/beAskeSXszuAMsf8VnQQtq8F0bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vkfh8k23GXLX9ckCrE9cIvBoUN0p6686awo31r/5vpoEeWavm6fi+Akw/njcTPz0qqCrXA5WyLNktPFRBQN00eYPcuaR5C5+i/8HS4Bj1Ql+lxXyas2v8z1QejeWPDD/fEeYTVv0hrUa2BJ0JPuM0PlHnbjcnp724W5pSVyAcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8dCe47F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82392C4CEC6;
	Mon,  7 Oct 2024 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728300778;
	bh=PyM0DwevYnXrw0K/beAskeSXszuAMsf8VnQQtq8F0bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8dCe47F/b172Yr93sxwzs2xQdrqEgggh2nRpPHRsBrlhmFhnfpRm+Mf3rb+LiK7I
	 LGRfpAKIukvOlJfnLjA+dILtcaXeEuTC+tnN5lfVxFP/NjOvHK/BT+ppNywAwiZmOD
	 sL9JK1rZ9gFLwl4/sFLPf+byL9go20Eq0VC+NhR66sOWbw4kA0FeElS4Ns30rvdpO7
	 bRCZUyqM0yu5bM1o3YJc0+9o3LgMcOFDwK4KVDGaaCBz1bqyHPeF8xymnK/HpM7a4T
	 nMl5IA9huk0IapJ+NulTxvESiBdEw77cEDqviGHBouUMI4xjaOPHmFFCP0KUzBVz8M
	 QIXZL3duFvP5Q==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2] btrfs: update some tests to be able to run with btrfs-progs v6.11
Date: Mon,  7 Oct 2024 12:32:50 +0100
Message-ID: <e75725e3d3c50922892ca07cd2b0965340c228be.1728300476.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>
References: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In btrfs-progs v6.11 the output of the "filesystem show" command changed
so that it no longers prints blank lines. This happened with commit
4331bfb011bd ("btrfs-progs: fi show: remove stray newline in filesystem
show").

We have some tests that expect the blank lines in their golden output,
and therefore they fail with btrfs-progs v6.11.

So update the filter _filter_btrfs_filesystem_show to remove blank lines
and change the golden output of the tests to not expect the blank lines,
making the tests work with btrfs-progs v6.11 and older versions.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Add missing updates to btrfs/006 and btrfs/100.

 common/filter.btrfs | 5 ++++-
 tests/btrfs/006.out | 2 --
 tests/btrfs/100.out | 2 --
 tests/btrfs/101.out | 2 --
 tests/btrfs/218.out | 1 -
 tests/btrfs/254.out | 1 -
 6 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 5a944aeb..bc914642 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -30,7 +30,10 @@ _filter_btrfs_filesystem_show()
 		UUID=$2
 	fi
 
-	# the uniq collapses all device lines into 1
+	# Before btrfs-progs v6.11 we had some blank lines in the output, so
+	# delete them.
+	# The uniq collapses all device lines into 1.
+	sed -e "/^\s*$/d" | \
 	_filter_uuid $UUID | _filter_scratch | _filter_scratch_pool | \
 	_filter_size | _filter_btrfs_version | _filter_devid | \
 	_filter_zero_size | \
diff --git a/tests/btrfs/006.out b/tests/btrfs/006.out
index b7f29f96..97d44f13 100644
--- a/tests/btrfs/006.out
+++ b/tests/btrfs/006.out
@@ -7,12 +7,10 @@ TestLabel.006
 Label: 'TestLabel.006'  uuid: <UUID>
 	Total devices <EXACTNUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-
 == Show filesystem by UUID
 Label: 'TestLabel.006'  uuid: <EXACTUUID>
 	Total devices <EXACTNUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-
 == Sync filesystem
 == Show device stats by mountpoint
 <NUMDEVS> [SCRATCH_DEV].corruption_errs <NUM>
diff --git a/tests/btrfs/100.out b/tests/btrfs/100.out
index aa492919..1fe3c0de 100644
--- a/tests/btrfs/100.out
+++ b/tests/btrfs/100.out
@@ -3,9 +3,7 @@ Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
 	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
-
 Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-
 === device replace completed
diff --git a/tests/btrfs/101.out b/tests/btrfs/101.out
index e1b88c2d..c2359c7c 100644
--- a/tests/btrfs/101.out
+++ b/tests/btrfs/101.out
@@ -3,9 +3,7 @@ Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
 	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
-
 Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-
 === device delete completed
diff --git a/tests/btrfs/218.out b/tests/btrfs/218.out
index 7ccf13e9..be11074c 100644
--- a/tests/btrfs/218.out
+++ b/tests/btrfs/218.out
@@ -2,7 +2,6 @@ QA output created by 218
 Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-
 [SCRATCH_DEV].write_io_errs    0
 [SCRATCH_DEV].read_io_errs     0
 [SCRATCH_DEV].flush_io_errs    0
diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
index 20819cf5..86089ee3 100644
--- a/tests/btrfs/254.out
+++ b/tests/btrfs/254.out
@@ -3,4 +3,3 @@ Label: none  uuid: <UUID>
 	Total devices <NUM> FS bytes used <SIZE>
 	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
 	*** Some devices missing
-
-- 
2.43.0


