Return-Path: <linux-btrfs+bounces-566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B696E803917
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A5E280F5D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7E2D041;
	Mon,  4 Dec 2023 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciflRWVb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77892D025;
	Mon,  4 Dec 2023 15:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8F5C433C8;
	Mon,  4 Dec 2023 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704731;
	bh=n7YuIoa82GkbK/BqnqWdSdY0Ifz9AubKaRkeIrBO/dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ciflRWVb6fSGVed41L1Nd017aKgZCiAPnu1sSHkYYGXiP6q7hehMA+Bbj/uHPDrd7
	 6ODOa3xNKySyczS4F5HBEW1YbxyVGB17k77j/GNwBZbCoaaqA7ddrjP1/yd1eGJ6Vu
	 8zLjERkjKL3ih7VehBt0ISar0gcR7dsqmczGd3DAbwTdjwlRzKMrwVbAp6cxNGZfrk
	 s+TlSTeDy/e+SBaeXWHieXJBVZFcuOvxrSEt0dwmdKY+xuuHcB0CLS3nPrqnba0OfD
	 r3hg5KVV7ssRQmU8HXOWHjAIBcIxFJ05g8VqKoeWubNQydLueI0uA+btFvJpIxoW1+
	 z93jf4J9Hd5Ag==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] btrfs: add some tests to the 'compress' group
Date: Mon,  4 Dec 2023 15:45:10 +0000
Message-Id: <d3a5bded35e8502cdb609bfb0d950c7160461904.1701704559.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1701704557.git.fdmanana@suse.com>
References: <cover.1701704557.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are several btrfs test that exercise compression in one way or
another but are not listed as part of the 'compress' group, so add them
to that group.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/004 | 2 +-
 tests/btrfs/005 | 2 +-
 tests/btrfs/048 | 2 +-
 tests/btrfs/052 | 2 +-
 tests/btrfs/056 | 2 +-
 tests/btrfs/059 | 2 +-
 tests/btrfs/094 | 2 +-
 tests/btrfs/112 | 2 +-
 tests/btrfs/150 | 2 +-
 tests/btrfs/167 | 2 +-
 tests/btrfs/173 | 2 +-
 tests/btrfs/174 | 2 +-
 tests/btrfs/259 | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 78df6a3a..381ad072 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -10,7 +10,7 @@
 # We check to end up back at the original file with the correct offset.
 #
 . ./common/preamble
-_begin_fstest auto rw metadata fiemap logical_resolve
+_begin_fstest auto rw metadata fiemap logical_resolve compress
 
 noise_pid=0
 
diff --git a/tests/btrfs/005 b/tests/btrfs/005
index 878a8c7c..84634770 100755
--- a/tests/btrfs/005
+++ b/tests/btrfs/005
@@ -7,7 +7,7 @@
 # Btrfs Online defragmentation tests
 #
 . ./common/preamble
-_begin_fstest auto defrag
+_begin_fstest auto defrag compress
 cnt=119
 filesize=48000
 
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 93d4a171..7816a997 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -11,7 +11,7 @@
 #  btrfs: fix zstd compression parameter
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick compress
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/052 b/tests/btrfs/052
index 4408de21..0d60d413 100755
--- a/tests/btrfs/052
+++ b/tests/btrfs/052
@@ -9,7 +9,7 @@
 # file.
 #
 . ./common/preamble
-_begin_fstest auto quick clone
+_begin_fstest auto quick clone compress
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/056 b/tests/btrfs/056
index e5ac516d..e1263983 100755
--- a/tests/btrfs/056
+++ b/tests/btrfs/056
@@ -15,7 +15,7 @@
 #    Btrfs: make fsync work after cloning into a file
 #
 . ./common/preamble
-_begin_fstest auto quick clone log
+_begin_fstest auto quick clone log compress
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index d2ced0ae..76a1e76e 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -11,7 +11,7 @@
 #     Btrfs: add missing compression property remove in btrfs_ioctl_setflags
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick compress
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/094 b/tests/btrfs/094
index e94cf17b..75804465 100755
--- a/tests/btrfs/094
+++ b/tests/btrfs/094
@@ -18,7 +18,7 @@
 #   Btrfs: incremental send, fix clone operations for compressed extents
 #
 . ./common/preamble
-_begin_fstest auto quick send
+_begin_fstest auto quick send compress
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/112 b/tests/btrfs/112
index c3f7fe5c..fd7aaad4 100755
--- a/tests/btrfs/112
+++ b/tests/btrfs/112
@@ -8,7 +8,7 @@
 # corruption or data loss.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc compress
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index a7d7d9cc..c21e0a66 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -11,7 +11,7 @@
 #	Btrfs: fix kernel oops while reading compressed data
 #
 . ./common/preamble
-_begin_fstest auto quick dangerous read_repair
+_begin_fstest auto quick dangerous read_repair compress
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/167 b/tests/btrfs/167
index fb271cfa..2cfcf100 100755
--- a/tests/btrfs/167
+++ b/tests/btrfs/167
@@ -11,7 +11,7 @@
 # ac0b4145d662 ("btrfs: scrub: Don't use inode pages for device replace")
 #
 . ./common/preamble
-_begin_fstest auto quick replace volume
+_begin_fstest auto quick replace volume compress
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/173 b/tests/btrfs/173
index 4972a5a7..6e78a826 100755
--- a/tests/btrfs/173
+++ b/tests/btrfs/173
@@ -8,7 +8,7 @@
 # CoW file nor compressed file.
 #
 . ./common/preamble
-_begin_fstest auto quick swap
+_begin_fstest auto quick swap compress
 
 . ./common/filter
 
diff --git a/tests/btrfs/174 b/tests/btrfs/174
index 0acd65f0..16305c18 100755
--- a/tests/btrfs/174
+++ b/tests/btrfs/174
@@ -8,7 +8,7 @@
 # specific to Btrfs.
 #
 . ./common/preamble
-_begin_fstest auto quick swap
+_begin_fstest auto quick swap compress
 
 . ./common/filter
 
diff --git a/tests/btrfs/259 b/tests/btrfs/259
index 358a4550..7f053ac9 100755
--- a/tests/btrfs/259
+++ b/tests/btrfs/259
@@ -8,7 +8,7 @@
 # at their max capacity.
 #
 . ./common/preamble
-_begin_fstest auto quick defrag fiemap
+_begin_fstest auto quick defrag fiemap compress
 
 # Import common functions.
 . ./common/filter
-- 
2.40.1


