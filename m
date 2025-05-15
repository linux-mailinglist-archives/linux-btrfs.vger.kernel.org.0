Return-Path: <linux-btrfs+bounces-14035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB3AB853F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 13:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236B11BA234D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E4298C03;
	Thu, 15 May 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9ipQ+L+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90729898C;
	Thu, 15 May 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309822; cv=none; b=FWx1zULSgaftjglxfQjbc2oSebqqwY2qTY0MLtaJrzLJnXtiZFAgpjtUjqqCP0Bgp1iGeELIJ6Wfn1kc8pUxIogpj4HByroS7kRyLJ66doCpfvbzNX/pHaVlZMW0qg295Qy4n1mOROA+ZjYLfSGEo16ztanlJcOwnzvYbUbQZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309822; c=relaxed/simple;
	bh=/7fScfko9HeLhI+rotb8TA8MEfeFNNICxOedxDlEy+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQMM+mqrzi4wMhR5a50Z7EeU1cJBN49V/waw6UVqPNYBVIF8iQnd5NwtYHSXYEY6iDHo233JIdp+c/oUZwbwaONDnASvzHhJ4NBzR4VleS1dqAvZsuF6zGgVuN71icbOafp6l+mZos8QPhmO2pr2qkoNdx4rLurzammS3lEYgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9ipQ+L+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3C8C4CEE7;
	Thu, 15 May 2025 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309821;
	bh=/7fScfko9HeLhI+rotb8TA8MEfeFNNICxOedxDlEy+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9ipQ+L+Rn9pkD0yYFtS5TC6xjutNPZEZnKkswLkDGz33ruf+n6ndJvKkhcji4/s4
	 FBEF9DK7SrfCs5vhzC/u+hieNiENHblUheNeFGoT/eKTXG1Xu39dSl0w2t89GSLGt9
	 mDWgJE95BoCAgBEFvzv7SOAtzafS63nscpyYPMUuScb+Cg4trJr+UifHQf12R1Ejgl
	 R1nhNvPxxKftDG2aFnigZb6Zl/ZOKfN1wHFwi8YixWtGh5GE6PLJNygi25SYY0XCDm
	 L41GCBtEuOyFmEQcU295i2PzE6sVdAAd0qDP7ccmvtuwEWxAc6RCrhR3Zxb0OSw4QB
	 KV7Nucl5eiO9A==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] btrfs: add tests that exercise raid profiles to the raid group
Date: Thu, 15 May 2025 12:50:07 +0100
Message-ID: <12c1487e9ba62c6f6694b0b580c23a347af4d9c6.1747309685.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1747309685.git.fdmanana@suse.com>
References: <cover.1747309685.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Many tests (in fact most) that exercise one or more raid profiles are not
tagged in the raid group. Tag them with the raid group so that we can
easily run only raid test with "./check -g raid" when testing changes that
affect only raid code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/003 | 2 +-
 tests/btrfs/011 | 2 +-
 tests/btrfs/020 | 2 +-
 tests/btrfs/023 | 2 +-
 tests/btrfs/027 | 2 +-
 tests/btrfs/060 | 2 +-
 tests/btrfs/061 | 2 +-
 tests/btrfs/062 | 2 +-
 tests/btrfs/063 | 2 +-
 tests/btrfs/064 | 2 +-
 tests/btrfs/065 | 2 +-
 tests/btrfs/066 | 2 +-
 tests/btrfs/067 | 2 +-
 tests/btrfs/068 | 2 +-
 tests/btrfs/069 | 2 +-
 tests/btrfs/070 | 2 +-
 tests/btrfs/071 | 2 +-
 tests/btrfs/072 | 2 +-
 tests/btrfs/073 | 2 +-
 tests/btrfs/074 | 2 +-
 tests/btrfs/100 | 2 +-
 tests/btrfs/101 | 2 +-
 tests/btrfs/124 | 2 +-
 tests/btrfs/125 | 2 +-
 tests/btrfs/140 | 2 +-
 tests/btrfs/141 | 2 +-
 tests/btrfs/142 | 2 +-
 tests/btrfs/143 | 2 +-
 tests/btrfs/146 | 2 +-
 tests/btrfs/148 | 2 +-
 tests/btrfs/150 | 2 +-
 tests/btrfs/151 | 2 +-
 tests/btrfs/160 | 2 +-
 tests/btrfs/175 | 2 +-
 tests/btrfs/184 | 2 +-
 tests/btrfs/195 | 2 +-
 tests/btrfs/197 | 2 +-
 tests/btrfs/198 | 2 +-
 tests/btrfs/223 | 2 +-
 tests/btrfs/242 | 2 +-
 tests/btrfs/249 | 2 +-
 tests/btrfs/254 | 2 +-
 tests/btrfs/265 | 2 +-
 tests/btrfs/266 | 2 +-
 tests/btrfs/267 | 2 +-
 tests/btrfs/268 | 2 +-
 tests/btrfs/269 | 2 +-
 tests/btrfs/270 | 2 +-
 tests/btrfs/286 | 2 +-
 tests/btrfs/296 | 2 +-
 tests/btrfs/335 | 2 +-
 51 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/tests/btrfs/003 b/tests/btrfs/003
index ecefdd14..d9b3b854 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -7,7 +7,7 @@
 # btrfs vol tests
 #
 . ./common/preamble
-_begin_fstest auto replace volume balance
+_begin_fstest auto replace volume balance raid
 
 dev_removed=0
 removed_dev_htl=""
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index c46f2cc4..822ce82e 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -20,7 +20,7 @@
 # performed, a btrfsck run, and finally the filesystem is remounted.
 #
 . ./common/preamble
-_begin_fstest auto replace volume scrub
+_begin_fstest auto replace volume scrub raid
 
 noise_pid=0
 
diff --git a/tests/btrfs/020 b/tests/btrfs/020
index 7e5c6fd7..4e3e2cc4 100755
--- a/tests/btrfs/020
+++ b/tests/btrfs/020
@@ -10,7 +10,7 @@
 # bbb651e Btrfs: don't allow the replace procedure on read only filesystems
 #
 . ./common/preamble
-_begin_fstest auto quick replace volume
+_begin_fstest auto quick replace volume raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/023 b/tests/btrfs/023
index f03bcbb9..52fe0dfb 100755
--- a/tests/btrfs/023
+++ b/tests/btrfs/023
@@ -9,7 +9,7 @@
 # The test aims to create the raid and verify that its created
 #
 . ./common/preamble
-_begin_fstest auto
+_begin_fstest auto raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/027 b/tests/btrfs/027
index 28287771..3a35d8f3 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -7,7 +7,7 @@
 # Test replace of a missing device on various data and metadata profiles.
 #
 . ./common/preamble
-_begin_fstest auto replace volume scrub
+_begin_fstest auto replace volume scrub raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 21f15ec8..d5486122 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -8,7 +8,7 @@
 # with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance subvol scrub
+_begin_fstest auto balance subvol scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/061 b/tests/btrfs/061
index 5a2bd709..5b614420 100755
--- a/tests/btrfs/061
+++ b/tests/btrfs/061
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance scrub
+_begin_fstest auto balance scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index a25d6d11..9461d790 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance defrag compress scrub
+_begin_fstest auto balance defrag compress scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index 7d51ff55..719d14d3 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -8,7 +8,7 @@
 # simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance remount compress scrub
+_begin_fstest auto balance remount compress scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index 3b98f327..e0cae009 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -10,7 +10,7 @@
 # run simultaneously. One of them is expected to fail when the other is running.
 
 . ./common/preamble
-_begin_fstest auto balance replace volume scrub
+_begin_fstest auto balance replace volume scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index f0c9ffb0..0f069afa 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -8,7 +8,7 @@
 # operation simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol replace volume scrub
+_begin_fstest auto subvol replace volume scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index e3a083b9..53caabf2 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -8,7 +8,7 @@
 # operation simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol scrub
+_begin_fstest auto subvol scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 76899311..e080549f 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -8,7 +8,7 @@
 # operation simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol defrag compress scrub
+_begin_fstest auto subvol defrag compress scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index 3d221259..311ad23e 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -9,7 +9,7 @@
 # in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol remount compress scrub
+_begin_fstest auto subvol remount compress scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index 7954e80a..b99d567c 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace scrub volume
+_begin_fstest auto replace scrub volume raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index c1838003..177a24ea 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace defrag compress volume scrub
+_begin_fstest auto replace defrag compress volume scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index 5c2b725b..161c570c 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -8,7 +8,7 @@
 # algorithms simultaneously with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace remount compress volume scrub
+_begin_fstest auto replace remount compress volume scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/072 b/tests/btrfs/072
index 32750887..02f34e3f 100755
--- a/tests/btrfs/072
+++ b/tests/btrfs/072
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto scrub defrag compress
+_begin_fstest auto scrub defrag compress raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/073 b/tests/btrfs/073
index b77e14c9..6154089b 100755
--- a/tests/btrfs/073
+++ b/tests/btrfs/073
@@ -8,7 +8,7 @@
 # simultaneously with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto scrub remount compress
+_begin_fstest auto scrub remount compress raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index a752707d..6157bd15 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -8,7 +8,7 @@
 # simultaneously with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto defrag remount compress scrub
+_begin_fstest auto defrag remount compress scrub raid
 
 _cleanup()
 {
diff --git a/tests/btrfs/100 b/tests/btrfs/100
index a319c7bb..cbbc7da1 100755
--- a/tests/btrfs/100
+++ b/tests/btrfs/100
@@ -8,7 +8,7 @@
 #
 #
 . ./common/preamble
-_begin_fstest auto replace volume eio
+_begin_fstest auto replace volume eio raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/101 b/tests/btrfs/101
index cb14d6a0..5f679ce7 100755
--- a/tests/btrfs/101
+++ b/tests/btrfs/101
@@ -8,7 +8,7 @@
 #
 #
 . ./common/preamble
-_begin_fstest auto replace volume eio
+_begin_fstest auto replace volume eio raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index af079c28..f7cbefee 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -23,7 +23,7 @@
 # Verify if all three checkpoints match
 #
 . ./common/preamble
-_begin_fstest auto replace volume balance
+_begin_fstest auto replace volume balance raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index c8c0dd42..bd6d998d 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -22,7 +22,7 @@
 # Verify if all three checkpoints match
 #
 . ./common/preamble
-_begin_fstest replace volume balance auto quick
+_begin_fstest replace volume balance auto quick raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/140 b/tests/btrfs/140
index cb70f967..affb9322 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -12,7 +12,7 @@
 #	commit 2e949b0a5592 ("Btrfs: fix invalid dereference in btrfs_retry_endio")
 #
 . ./common/preamble
-_begin_fstest auto quick read_repair fiemap
+_begin_fstest auto quick read_repair fiemap raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index 4afd3304..a6a05236 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -13,7 +13,7 @@
 #	Commit 9d0d1c8b1c9d ("Btrfs: bring back repair during read")
 #
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index 0ab0f801..af3666db 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -13,7 +13,7 @@
 #	commit 97bf5a5589aa ("Btrfs: fix segmentation fault when doing dio read")
 #
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair raid
 
 . ./common/filter
 . ./common/dmdust
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 490f27b5..7e25af96 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -20,7 +20,7 @@
 #	commit 9d0d1c8b1c9d ("Btrfs: bring back repair during read")
 #
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair raid
 
 . ./common/filter
 . ./common/dmdust
diff --git a/tests/btrfs/146 b/tests/btrfs/146
index c1243757..1cafbc2f 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -10,7 +10,7 @@
 # Then fsync on all one last time and verify that all return 0.
 #
 . ./common/preamble
-_begin_fstest auto quick eio
+_begin_fstest auto quick eio raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/148 b/tests/btrfs/148
index 3f651e54..746d9e8d 100755
--- a/tests/btrfs/148
+++ b/tests/btrfs/148
@@ -7,7 +7,7 @@
 # Test that direct IO writes work on RAID5 and RAID6 filesystems.
 #
 . ./common/preamble
-_begin_fstest auto quick rw scrub
+_begin_fstest auto quick rw scrub raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index a37f252b..ad0b854f 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -11,7 +11,7 @@
 #	Btrfs: fix kernel oops while reading compressed data
 #
 . ./common/preamble
-_begin_fstest auto quick dangerous read_repair compress
+_begin_fstest auto quick dangerous read_repair compress raid
 
 . ./common/filter
 . ./common/fail_make_request
diff --git a/tests/btrfs/151 b/tests/btrfs/151
index f635aa25..32e06e87 100755
--- a/tests/btrfs/151
+++ b/tests/btrfs/151
@@ -11,7 +11,7 @@
 #	Btrfs: avoid losing data raid profile when deleting a device
 #
 . ./common/preamble
-_begin_fstest auto quick volume
+_begin_fstest auto quick volume raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/160 b/tests/btrfs/160
index c4a01d33..eb6e74a3 100755
--- a/tests/btrfs/160
+++ b/tests/btrfs/160
@@ -9,7 +9,7 @@
 # then call fsync on it. Is the error reported?
 #
 . ./common/preamble
-_begin_fstest auto quick eio
+_begin_fstest auto quick eio raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/175 b/tests/btrfs/175
index 2208d5f1..be400151 100755
--- a/tests/btrfs/175
+++ b/tests/btrfs/175
@@ -7,7 +7,7 @@
 # Test swap file activation on multiple devices.
 #
 . ./common/preamble
-_begin_fstest auto quick swap volume
+_begin_fstest auto quick swap volume raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/184 b/tests/btrfs/184
index 575807b0..1e284e8f 100755
--- a/tests/btrfs/184
+++ b/tests/btrfs/184
@@ -8,7 +8,7 @@
 # filesystem its superblock copies are correctly deleted
 #
 . ./common/preamble
-_begin_fstest auto quick volume
+_begin_fstest auto quick volume raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/195 b/tests/btrfs/195
index 4dffddc1..88164590 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -8,7 +8,7 @@
 # source profiles just rely on being able to read the data and metadata.
 #
 . ./common/preamble
-_begin_fstest auto volume balance scrub
+_begin_fstest auto volume balance scrub raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/197 b/tests/btrfs/197
index 9f1d879a..77eb9b79 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -10,7 +10,7 @@
 #   btrfs: remove identified alien btrfs device in open_fs_devices
 #
 . ./common/preamble
-_begin_fstest auto quick volume
+_begin_fstest auto quick volume raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index d17ab6da..69ac13c4 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -7,7 +7,7 @@
 # Test outdated and foreign non-btrfs devices in the device listing.
 #
 . ./common/preamble
-_begin_fstest auto quick volume
+_begin_fstest auto quick volume raid
 
 . ./common/filter
 . ./common/filter.btrfs
diff --git a/tests/btrfs/223 b/tests/btrfs/223
index f6c0daa6..dd154318 100755
--- a/tests/btrfs/223
+++ b/tests/btrfs/223
@@ -10,7 +10,7 @@
 # new device only in degraded mode, as this is the easiest way to verify it.
 #
 . ./common/preamble
-_begin_fstest auto quick replace trim
+_begin_fstest auto quick replace trim raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/242 b/tests/btrfs/242
index daa2d972..d0fa317f 100755
--- a/tests/btrfs/242
+++ b/tests/btrfs/242
@@ -9,7 +9,7 @@
 #     [patch] btrfs: check for missing device in btrfs_trim_fs
 
 . ./common/preamble
-_begin_fstest auto quick volume trim
+_begin_fstest auto quick volume trim raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/249 b/tests/btrfs/249
index 641a3c87..c2129d39 100755
--- a/tests/btrfs/249
+++ b/tests/btrfs/249
@@ -14,7 +14,7 @@
 #
 
 . ./common/preamble
-_begin_fstest auto quick seed volume
+_begin_fstest auto quick seed volume raid
 
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
diff --git a/tests/btrfs/254 b/tests/btrfs/254
index e1b4fb01..8e1333fb 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -8,7 +8,7 @@
 # Test if the kernel can free the stale device entries.
 #
 . ./common/preamble
-_begin_fstest auto quick volume
+_begin_fstest auto quick volume raid
 
 # Override the default cleanup function.
 node=$seq-test
diff --git a/tests/btrfs/265 b/tests/btrfs/265
index 823d4d96..edb4a870 100755
--- a/tests/btrfs/265
+++ b/tests/btrfs/265
@@ -9,7 +9,7 @@
 # mirrors for the same logical offset.
 #
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/266 b/tests/btrfs/266
index bffcec27..3490ecce 100755
--- a/tests/btrfs/266
+++ b/tests/btrfs/266
@@ -10,7 +10,7 @@
 #
 
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/267 b/tests/btrfs/267
index b4ea3106..66e08d18 100755
--- a/tests/btrfs/267
+++ b/tests/btrfs/267
@@ -10,7 +10,7 @@
 #
 
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/268 b/tests/btrfs/268
index 7681b1a5..0e44ea20 100755
--- a/tests/btrfs/268
+++ b/tests/btrfs/268
@@ -9,7 +9,7 @@
 #
 
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/269 b/tests/btrfs/269
index c048da44..21e8ac76 100755
--- a/tests/btrfs/269
+++ b/tests/btrfs/269
@@ -13,7 +13,7 @@
 #
 
 . ./common/preamble
-_begin_fstest auto quick read_repair
+_begin_fstest auto quick read_repair raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/270 b/tests/btrfs/270
index c8651fa1..acdf90f3 100755
--- a/tests/btrfs/270
+++ b/tests/btrfs/270
@@ -7,7 +7,7 @@
 # Regression test for btrfs buffered read repair of compressed data.
 #
 . ./common/preamble
-_begin_fstest auto quick read_repair compress
+_begin_fstest auto quick read_repair compress raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/286 b/tests/btrfs/286
index 7909fa50..05b6fb47 100755
--- a/tests/btrfs/286
+++ b/tests/btrfs/286
@@ -8,7 +8,7 @@
 # for NODATASUM data.
 #
 . ./common/preamble
-_begin_fstest auto replace
+_begin_fstest auto replace raid
 
 . ./common/filter
 
diff --git a/tests/btrfs/296 b/tests/btrfs/296
index f4f7cec6..0baf89c0 100755
--- a/tests/btrfs/296
+++ b/tests/btrfs/296
@@ -8,7 +8,7 @@
 # when a new feature is added.
 #
 . ./common/preamble
-_begin_fstest auto quick balance
+_begin_fstest auto quick balance raid
 
 _require_scratch_dev_pool 3
 _fixed_by_kernel_commit b7625f461da6 \
diff --git a/tests/btrfs/335 b/tests/btrfs/335
index 82085d4f..f3a705ee 100755
--- a/tests/btrfs/335
+++ b/tests/btrfs/335
@@ -9,7 +9,7 @@
 # position in the target zone.
 #
 . ./common/preamble
-_begin_fstest zone quick volume
+_begin_fstest zone quick volume raid
 
 . ./common/filter
 
-- 
2.47.2


