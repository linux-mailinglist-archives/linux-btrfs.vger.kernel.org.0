Return-Path: <linux-btrfs+bounces-14298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5DAC7D1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DB34E5323
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081E28FA9C;
	Thu, 29 May 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvFKuExJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A24290BCD;
	Thu, 29 May 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518405; cv=none; b=AXj9grRfxKumE6ZSj7ET/KZNiovlRCWsLYy24nK47bscvRx2nf6e+8gVYefA38qEyxLku01vG36SHNnK/ReySsEhdpd/ka0uO/HfJhPrVF1xQ53FNEHgy9oESM2HXYaIs5XlWYFw8YYJqfHTcs6fZm5VDtcLPkvkae2CqPR4nao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518405; c=relaxed/simple;
	bh=bFsO9Grd7TM96dG8E8asP/7pn1Os9r6ScC0x2U8GEUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iITtCXUsJ+YbTIxzkLWn7WqgnzB6DEddMdDe71s0baiMpA4fd6KUt79s/x9zhTnxMroydISAh+OQulILrv7rK6zTBJuckT9KAKDyAAlXyoebYskZ2ehz3p00PUlVud88xkiv+TXk0f39HNffsdxh4m14E6aZntS7zpFrZ2ikXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvFKuExJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95784C4CEEB;
	Thu, 29 May 2025 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748518404;
	bh=bFsO9Grd7TM96dG8E8asP/7pn1Os9r6ScC0x2U8GEUY=;
	h=From:To:Cc:Subject:Date:From;
	b=EvFKuExJOoJ8VvptR9lBU3nM7Yo2ziu4aEMkOzOsC/3s9BPI1hZxglpBUZbvBIF1o
	 E2wTABzQu7uNAQ2h1MCpvv6DqMm2KY9bOuNlDNnX/vOgaB8IMMbWeniuMjThigHTb3
	 Mc9VewZfuxLJoorsrQm9m5qrI4E3yxODQUu76sbiV1Q8d3rD7WmLz5j/0+YV5DvAgV
	 oy5bEDq8dzccWrLfq5hpV4Gmj7j8f5bmZkHn6Td67YSyld5uGRoqPQDH3ZB2IDvQNM
	 cwvMoXa5JmIkZqvndlp1TXTABTPEt0/FsX8vMUzz8/NH0EKMfX69Sfdc3ZqIoyb8A9
	 F2Vwg8XES4VjQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/094: fix test ignoring failures
Date: Thu, 29 May 2025 12:33:13 +0100
Message-ID: <7425c940548e19ab996b8458717dd3c3c3c55630.1748518250.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test is ignoring failures completely:

1) If mounting the scratch device fails it redirects both stdout and
   stderr to /dev/null, so it gets unnoticed and the test runs against
   a different fs than expected (in my test environment $SCRATCH_MNT
   points to a directory in an ext4 fs for example but I want to test
   btrfs);

2) We are redirecting the stdout and stderr of fiemap-tester to the
   $seqres.full file, so if it fails it gets completely unnoticed and
   the test succeeds.

For the first issue fix this by not even using the scratch filesystem and
use instead the test filesystem, since the test creates a 2M file which
is small enough.

For the second issue simply don't redirect the stdout and stderr, so that
if the test program fails it causes a mismatch with the golden output,
making the test fail.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/094 | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/generic/094 b/tests/generic/094
index c82efced..6ae417c3 100755
--- a/tests/generic/094
+++ b/tests/generic/094
@@ -9,18 +9,22 @@
 . ./common/preamble
 _begin_fstest auto quick prealloc fiemap
 
+_cleanup()
+{
+	cd /
+	rm -fr $tmp.*
+	rm -f $fiemapfile
+}
+
 # Import common functions.
 . ./common/filter
 
-_require_scratch
+_require_test
 _require_odirect
 _require_xfs_io_command "fiemap"
 _require_xfs_io_command "falloc"
 
-_scratch_mkfs > /dev/null 2>&1
-_scratch_mount > /dev/null 2>&1
-
-fiemapfile=$SCRATCH_MNT/$seq.fiemap
+fiemapfile=$TEST_DIR/$seq.fiemap
 
 _require_test_program "fiemap-tester"
 
@@ -29,12 +33,10 @@ seed=`date +%s`
 echo "using seed $seed" >> $seqres.full
 
 echo "fiemap run with sync"
-$here/src/fiemap-tester -q -S -s $seed -r 200 $fiemapfile 2>&1 | \
-	tee -a $seqres.full
+$here/src/fiemap-tester -q -S -s $seed -r 200 $fiemapfile
 
 echo "fiemap run without sync"
-$here/src/fiemap-tester -q -s $seed -r 200 $fiemapfile 2>&1 | \
-	tee -a $seqres.full
+$here/src/fiemap-tester -q -s $seed -r 200 $fiemapfile
 
 status=0
 exit
-- 
2.47.2


