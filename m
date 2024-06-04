Return-Path: <linux-btrfs+bounces-5442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F09B8FB1EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 14:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC321F2176C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0C145FE1;
	Tue,  4 Jun 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCUsGU+l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CA145A1D;
	Tue,  4 Jun 2024 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503297; cv=none; b=P84sEyJBrzaEvwmH7VkOcK9acULkFzT1qCQ8wfOme9GoPRYbsbKT/7wuOiuNsBzisjVsOwDzAz+PZbm3rLzZC0ASLZEzUanNijJOlpm0jrdbxzVH5evZAfSctQIEzy7dF30BX88QcC7r9H0X3dsbIb49EtAYYGrEASDfoil9kGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503297; c=relaxed/simple;
	bh=NDa3qKkgeT9yyEdKxOR8b3wfQH7rPaSUaZzzxfmibQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/HVHKyfH4Y/iRYXallfbw+5QckcqvMyXfUsc1OmG6Is4gkLwHZsaIbNwJKMufv9wNYsglscO4VemzsbOYEfzh1OaupD7tO8ROUacOagBW+rJ/JWv9LX0eAzzS7rjzUlUv8yy5y9/HDcFexPU32Ythu9DJa29U+J8LCPajLmw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCUsGU+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA6FC2BBFC;
	Tue,  4 Jun 2024 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717503296;
	bh=NDa3qKkgeT9yyEdKxOR8b3wfQH7rPaSUaZzzxfmibQM=;
	h=From:To:Cc:Subject:Date:From;
	b=JCUsGU+lk7fMeOrtEafN17y8bD/cI4SpkINs6kxiZmxybUiFJScslwxb1WWgp1Trq
	 ItcvtOTNRZ/eXQy5SAb9ds9nCaAwngS9nC0uyN7dRHLm8gPvYF1mEyMxhH9jbVHxqp
	 ilEdQE7xqllm8fQGwZtQ2Lfv2lsCQbzJ0ze7Dth/xHlPhvGkRJlflbMjRlEDY3q3FR
	 ITDUtjcbHRzMyvuiEb1qTF7x+2Gnhf5wPdMCuFofPv1jWKJiRp5AaDxUKWRSUBqBjp
	 8wOVmGmCROSDiET+f9gdg7oV7oviNMumbDe8pK3NxeUEtCuoa7M96xfve0WnI6J7gi
	 g4xuH9/naZUMA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: fix raid-stripe-tree tests with non-experimental btrfs-progs build
Date: Tue,  4 Jun 2024 13:14:48 +0100
Message-ID: <95d9d97299aa1149da63566d57ef4ee673127cec.1717503211.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When running the raid-stripe-tree tests with a btrfs-progs version that
was not configured with the experimental features, the tests fail because
they expect the dump tree commands to output the stored and calculated
checksums lines, which are enabled only for experimental builds.

Also, these lines exists only starting with btrfs-progs v5.17 (more
specifically since commit 1bb6fb896dfc ("btrfs-progs: btrfstune:
experimental, new option to switch csums")).

The tests fail like this on non-experimental btrfs-progs build:

   $ ./check btrfs/304
   FSTYP         -- btrfs
   PLATFORM      -- Linux/x86_64 debian0 6.9.0-btrfs-next-160+ #1 SMP PREEMPT_DYNAMIC Tue May 28 12:00:03 WEST 2024
   MKFS_OPTIONS  -- /dev/sdc
   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

   btrfs/304 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad)
       --- tests/btrfs/304.out	2024-01-25 11:15:33.420769484 +0000
       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad	2024-06-04 12:55:04.289903124 +0100
       @@ -8,8 +8,6 @@
        raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
        leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
        leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
       -checksum stored <CHECKSUM>
       -checksum calced <CHECKSUM>
        fs uuid <UUID>
        chunk uuid <UUID>
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/304.out /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad'  to see the entire diff)
   Ran: btrfs/304
   Failures: btrfs/304
   Failed 1 of 1 tests

So update _filter_stripe_tree() to remove the checksum lines, since we
don't care about them, and change the golden output of the tests to not
expect those lines. This way the tests work with both experimental and
non-experimental btrfs-progs builds, as well as btrfs-progs versions below
v5.17.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/filter.btrfs | 4 ++--
 tests/btrfs/304.out | 6 ------
 tests/btrfs/305.out | 6 ------
 tests/btrfs/306.out | 6 ------
 tests/btrfs/307.out | 6 ------
 tests/btrfs/308.out | 6 ------
 6 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 9ef96761..5a944aeb 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -132,8 +132,8 @@ _filter_stripe_tree()
 	_filter_trailing_whitespace | _filter_btrfs_version |\
 	sed -E -e "s/leaf [0-9]+ items [0-9]+ free space [0-9]+ generation [0-9]+ owner RAID_STRIPE_TREE/leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE/" \
 		-e "s/leaf [0-9]+ flags 0x1\(WRITTEN\) backref revision 1/leaf XXXXXXXXX flags 0x1\(WRITTEN\) backref revision 1/" \
-		-e "s/checksum stored [0-9a-f]+/checksum stored <CHECKSUM>/"  \
-		-e "s/checksum calced [0-9a-f]+/checksum calced <CHECKSUM>/"  \
+		-e "/checksum stored [0-9a-f]+/d" \
+		-e "/checksum calced [0-9a-f]+/d" \
 		-e "s/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/<UUID>/" \
 		-e "s/item ([0-9]+) key \([0-9]+ RAID_STRIPE ([0-9]+)\) itemoff [0-9]+ itemsize ([0-9]+)/item \1 key \(XXXXXX RAID_STRIPE \2\) itemoff XXXXX itemsize \3/" \
 		-e "s/stripe ([0-9]+) devid ([0-9]+) physical [0-9]+/stripe \1 devid \2 physical XXXXXXXXX/" \
diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
index 39f56f32..e5e383e7 100644
--- a/tests/btrfs/304.out
+++ b/tests/btrfs/304.out
@@ -8,8 +8,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
@@ -26,8 +24,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
@@ -45,8 +41,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
index 7090626c..90eeb634 100644
--- a/tests/btrfs/305.out
+++ b/tests/btrfs/305.out
@@ -10,8 +10,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
@@ -36,8 +34,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
@@ -61,8 +57,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
index 25065674..efe7f903 100644
--- a/tests/btrfs/306.out
+++ b/tests/btrfs/306.out
@@ -10,8 +10,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
@@ -33,8 +31,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
@@ -58,8 +54,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
index 2815d17d..13ce8fcb 100644
--- a/tests/btrfs/307.out
+++ b/tests/btrfs/307.out
@@ -8,8 +8,6 @@ d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
@@ -29,8 +27,6 @@ d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
@@ -48,8 +44,6 @@ d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
index 23b31dd3..21a623c1 100644
--- a/tests/btrfs/308.out
+++ b/tests/btrfs/308.out
@@ -12,8 +12,6 @@ d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
@@ -46,8 +44,6 @@ d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
@@ -77,8 +73,6 @@ d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
 raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
 leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
 leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
 	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
-- 
2.43.0


