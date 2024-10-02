Return-Path: <linux-btrfs+bounces-8438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00698DF2B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F0B1F26054
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CD1D0BA9;
	Wed,  2 Oct 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWc+zKOu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2421D094D;
	Wed,  2 Oct 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882937; cv=none; b=Zv/20va1z80UUU+iUUcex1beQXNVKakd+9OkgI1wQkP/C3rFyfyJ7Crv+fmbjloi1L7U9VGvJarU8tOY94Wg4UdZClqgrFUAFv21Js59AnnvqXQ7ZP42XoO+Owbn1rHp/gHdMFdfCQjXYCCQx2veCBF+TFUKAfj2NftLZtV1WGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882937; c=relaxed/simple;
	bh=zTIjwtTmfB6OliRyKQ8qWIHih5ezekyScuq7o+nEdWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQcyjnxkcchOIO24lOIRl1uhIestaitCIY9qFnFF4Bs7sNHO2HPrmRGQ3zlB6EymxqNj/ZV06Du+/5XwPzLuQLMr77nx73dtNFj6HSCItIWdoPoqSYJ19B7ULJMGt0cd6G8K0JnzDdLWO7YTwSp9ZLp+8b+HSPtXaxHK2RAGCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWc+zKOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866EDC4CECE;
	Wed,  2 Oct 2024 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727882937;
	bh=zTIjwtTmfB6OliRyKQ8qWIHih5ezekyScuq7o+nEdWg=;
	h=From:To:Cc:Subject:Date:From;
	b=hWc+zKOuobZ41/2PLlUdMe0JLmtA2YM7yNZg9IfDqtg5BzqrzcGxMZ6sD22FGlYTb
	 t8bz3W7Z5WCqCR6emzSk5CJgXN7XIku9jFyyUNt/ZVPeWANRvneb0tavtISBJzMkUg
	 6ZZd5l8FjcfxVxrWMaz3lMFvxVcmEPbC5LMHBfV9pv604jstBA/UIR0XfNti4+S8mw
	 taLh4nxxkplwVOcxIX2HBuyzi9C/7tBu7l4BAu9uM/+F6K2bZwkFKUguluyCKF4Ida
	 uUIrC8lgmwcUFKRu0DMUvIx8FERXFe9lNjNjFlW8geSNrUL1o3CTUl3DJKy2uE1Pur
	 pbp8CqODCS6Ug==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: update some tests to be able to run with btrfs-progs v6.11
Date: Wed,  2 Oct 2024 16:28:49 +0100
Message-ID: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
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

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/filter.btrfs | 5 ++++-
 tests/btrfs/100.out | 2 --
 tests/btrfs/218.out | 1 -
 tests/btrfs/254.out | 1 -
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 5a944aeb..6c53dffe 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -30,11 +30,14 @@ _filter_btrfs_filesystem_show()
 		UUID=$2
 	fi
 
-	# the uniq collapses all device lines into 1
+	# Before btrfs-progs v6.11 we had some blank lines in the output, so
+	# delete them.
+	# The uniq collapses all device lines into 1.
 	_filter_uuid $UUID | _filter_scratch | _filter_scratch_pool | \
 	_filter_size | _filter_btrfs_version | _filter_devid | \
 	_filter_zero_size | \
 	sed -e "s/\(Total devices\) $NUMDEVS/\1 $NUM_SUBST/g" | \
+	sed -e "/^\s*$/d" | \
 	uniq > $tmp.btrfs_filesystem_show
 
 	# The first two lines are Label/UUID and total devices
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


