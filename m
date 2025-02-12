Return-Path: <linux-btrfs+bounces-11407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB2A32CB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B923E18866CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83F257AD3;
	Wed, 12 Feb 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyuaP8A6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE612580CF;
	Wed, 12 Feb 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379743; cv=none; b=UJOAnBcGfLUm0yZZ+IThd4KuGNnxkdSimPacE0jI37NT1nD2Vdn7xrUA+5EzqtyuAFAfSCqb9OiFcVPLQtFQMeKiXHeSSzoXkCw97ShhWpxY7FviqJRZehK2VWqASIqxge/eCKSJ/M81ordpqni35kQIh6yjwI6Duz6kT7eFOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379743; c=relaxed/simple;
	bh=zL2i+NOW7siMRPylPeLh9PgpkpTe5QBsef1RNuJDQdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqgXWACG6VQt/kCUhEypUZpTUgnntgYhtsb7jbEHtOZISQKSIrsbC8v0iN7RiPtchNbqYYASTesnhTk/3oVKpjTnRRJgG2tE0/AFPITGaZf0M+IT1PoB0Iq9t3VsWr033o+r5ixYA58j5OAt3twHu7jVZ7chghCGidMhXA3II7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyuaP8A6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD39C4CEEA;
	Wed, 12 Feb 2025 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379742;
	bh=zL2i+NOW7siMRPylPeLh9PgpkpTe5QBsef1RNuJDQdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyuaP8A6eIpkQ1lIPaOhwz5oF0unJfgY+axtBnhzpKAk31s1STEYt6Lofms4M7Guz
	 HUrXkJVpZr7QbK663TY1h/VZrF4G6VdalO/DEJuDiGC2hE6uPNQxEtECbBKUJsUOp5
	 a+zkQBRGhrUnQRFhXfL/W7l2FszVJmIdyXJRmlSqS2LZ/KgrlKhoAYvOjGiNj5kTxv
	 sBa7+KM6TufxbiUvOMaSjvfJBxy5iCJ6e1EHK++PK/1zrkyaEtAPflMn6gpxzJhHOe
	 SrmL8P5Jwr0M6c+n9HRbA0cWZbkc368l7TCUBhxEBT96w0Ad0J9uptH5olUZ+8EQDJ
	 M5kwd2GKywSMg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 5/8] btrfs/205: avoid test failure when running with nodatasum mount option
Date: Wed, 12 Feb 2025 17:01:53 +0000
Message-ID: <d30273c05a30b3d177277a05e82c52a998779907.1739379185.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739379182.git.fdmanana@suse.com>
References: <cover.1739379182.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently the test fails when we pass "-o nodatasum" in MOUNT_OPTIONS and
the reason is because we enable compression, with "chattr +c", on a file
and then try to clone from it to a file with nodatasum inherited from the
mount options, which results in the clone ioctl to fail with -EINVAL since
it's not possible to clone from datasum to nodatasum and vice-versa.

Fix this by removing the "chattr +c", as it's not needed and we already
exercise the compression scenario by explicitly cycle mounting the scratch
device with "-o compress". This also allows us to exercise cloning the
"foo1" file without compression. I originally added the "chattr +c" call
but this was probably an oversight while debugging something.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/205 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/btrfs/205 b/tests/btrfs/205
index 13a1df8b..71522492 100755
--- a/tests/btrfs/205
+++ b/tests/btrfs/205
@@ -21,7 +21,6 @@ _begin_fstest auto quick clone compress prealloc
 
 _require_scratch_reflink
 _require_xfs_io_command "falloc" "-k"
-_require_command "$CHATTR_PROG" chattr
 _require_btrfs_fs_feature "no_holes"
 _require_btrfs_mkfs_feature "no-holes"
 
@@ -33,7 +32,6 @@ run_tests()
     # extent. It has a file size of 128K.
     echo "Creating file foo1"
     touch $SCRATCH_MNT/foo1
-    $CHATTR_PROG +c $SCRATCH_MNT/foo1 > /dev/null 2>&1
     $XFS_IO_PROG -c "pwrite -S 0xab 0 4K" \
 		 -c "fsync" \
 		 -c "pwrite -S 0xab 4K 124K" \
-- 
2.45.2


