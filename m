Return-Path: <linux-btrfs+bounces-3664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D749388EC37
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154041C27793
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FB14EC5B;
	Wed, 27 Mar 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOrE8dsP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969D13E043;
	Wed, 27 Mar 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559525; cv=none; b=etQQ4rVydA5Ir3ObraQbthgD3Ht8Ywc0VtL4pTH61OHPUhY1aYfFuHygd/m7Ky48eXrHBB8Laq4fP0OmSloJEXjJy5hrZ8td8GwYUqe8jSirOPyI1SM2UgnZyO3hBB4gC0NcPfKlwlzx3E2OGfHTe4J7VFLPE117TNeygnGN59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559525; c=relaxed/simple;
	bh=rf8bzn44A2EaONt7W6/bPCIPHdoJKNHcHV0jFhxBPtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krVwWkZ3/A0VE2DQzjjvLYgHlGQ4QiKGQEqlZeGM2y+lPkWwovELkb/gMQQAuYgVKhAh9rnoYRi2GkK15Kuyt/JzlPtiWtLaYmX/0jU8eAgfQF6hpQr6449cVdEG7qF1v89GXzdRNG22jo1e19w7tcrsnna+VE5ia0wNyOuBW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOrE8dsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A633C433C7;
	Wed, 27 Mar 2024 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559525;
	bh=rf8bzn44A2EaONt7W6/bPCIPHdoJKNHcHV0jFhxBPtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOrE8dsPvjLVPW3fdB9P9pJXMNaL3kv6mRhlncKYHugDqFe0ATY6i7ex5btyQ/K1c
	 9aUcOr2zUpfEDdYxswcChUrcMQ0FSoSENDgtex7Pd7QsGLAUxgsURxGwJORrMaXiwU
	 vH5SJ+7DBb1U7SgFQF/8wgyD+oejLuLKXSc8mppw85kMG8iFRpSpZ6rN9N7sYuqlqr
	 BlsJJiDm9nwhEZaUG2uIwC7JTsnY7MhIygE6f3YttFKT4c3o4sHeuyGFfJyDmlEKk9
	 P6FxMSat+XMnsGA+nm+u2GSkok2NH2o3RYaYsal4wsOJXBYH4A8yWGAKKUuxKsmY7A
	 q/lLnjDFaAyMA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 09/10] btrfs: remove stop file early at _btrfs_stress_subvolume
Date: Wed, 27 Mar 2024 17:11:43 +0000
Message-ID: <5b91f615f28c14274d9ad96c69cd098c1a9a6f9b.1711558345.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711558345.git.fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of having every test case that uses _btrfs_stress_subvolume()
removing the stop file before calling that function, do the file
remove at _btrfs_stress_subvolume(). There's no point in doing it in
every single test case.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 1 +
 tests/btrfs/060 | 2 --
 tests/btrfs/065 | 2 --
 tests/btrfs/066 | 2 --
 tests/btrfs/067 | 2 --
 tests/btrfs/068 | 2 --
 6 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index e19a6ad1..29061c23 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -331,6 +331,7 @@ _btrfs_stress_subvolume()
 	local subvol_mnt=$4
 	local stop_file=$5
 
+	rm -f $stop_file
 	mkdir -p $subvol_mnt
 	while [ ! -e $stop_file ]; do
 		$BTRFS_UTIL_PROG subvolume create $btrfs_mnt/$subvol_name
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 87823aba..53cbd3a0 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -46,8 +46,6 @@ run_test()
 	balance_pid=$!
 	echo "$balance_pid" >>$seqres.full
 
-	# make sure the stop sign is not there
-	rm -f $stop_file
 	echo -n "Start subvolume worker: " >>$seqres.full
 	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
 	subvol_pid=$!
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index ddc28616..f9e43cdc 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -49,8 +49,6 @@ run_test()
 	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
-	# make sure the stop sign is not there
-	rm -f $stop_file
 	echo -n "Start subvolume worker: " >>$seqres.full
 	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
 	subvol_pid=$!
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index c7488602..b6f904ac 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -41,8 +41,6 @@ run_test()
 	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
-	# make sure the stop sign is not there
-	rm -f $stop_file
 	echo -n "Start subvolume worker: " >>$seqres.full
 	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
 	subvol_pid=$!
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index ebbec1be..7be09d52 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -42,8 +42,6 @@ run_test()
 	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
-	# make sure the stop sign is not there
-	rm -f $stop_file
 	echo -n "Start subvolume worker: " >>$seqres.full
 	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
 	subvol_pid=$!
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index 5f41fb74..19e37010 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -42,8 +42,6 @@ run_test()
 	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
-	# make sure the stop sign is not there
-	rm -f $stop_file
 	echo -n "Start subvolume worker: " >>$seqres.full
 	_btrfs_stress_subvolume $SCRATCH_DEV $SCRATCH_MNT subvol_$$ $subvol_mnt $stop_file >/dev/null 2>&1 &
 	subvol_pid=$!
-- 
2.43.0


