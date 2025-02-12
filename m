Return-Path: <linux-btrfs+bounces-11435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB645A33378
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7800E163B7D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1A263C67;
	Wed, 12 Feb 2025 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo1Qsf5M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F325D548;
	Wed, 12 Feb 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403326; cv=none; b=R/omQTuL9PT3dYEW856op3S8DgNnl2FAdWock9/Qz1kAcxjkeCLUHgaNbd37Anplgd6jY3HOt/wrX06Cb7NO7Wtourv/rN39Dj6EF5/ojzNtPrmT450p1kue87ry3cV9vkVc66f7nwBZXGFGO8P5iwtAJU10XuEEdyby/X8JgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403326; c=relaxed/simple;
	bh=g2U64/jen+A/FU39yqHRTgfvxFrRvv9Tg0mJK9PBfV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJrIEL9qbjEkGhwXc8kxRlIpQc5+Td+TxLERv/1qqpVSBYwZ0KheQIAezhHxwbbCVOnbng2YR1bFpMKpcHs7UkhXTiHoMfmhalXD+f5aQh8IZl20fiy1slFdVmbHEpvWcq/t3veM/Yayt0eJ6JbzBCHL58/X4psmbcjOqr0aybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo1Qsf5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E613FC4CEE5;
	Wed, 12 Feb 2025 23:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403326;
	bh=g2U64/jen+A/FU39yqHRTgfvxFrRvv9Tg0mJK9PBfV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wo1Qsf5MkTqAT689eA2yGZ+BP7tD647XWNF3g9VpZwIGexMp2p9RPcIkHZMcNzgh0
	 9GQLOEZ5M3npeqb6SLn/08GQZw+befQX3tXRY9u6XP2lGQVz4UZLbQcNlnsrLzG3tS
	 kqYR3xkdWctsvkBCBgj1aY5dyVCxsc1PZAm98qYAGtnUxBnnKWzyXA8zZfd2pMdcem
	 t7ZrolEIBhZ61yKVRSB7ZpySTXEKRqfYoWvhHhuEH/FrZf8ybAdebjzPf7xeB9GxJq
	 kStmZhiscVGu8wUsrnPpxr/6Tuf8gY8PRTZEdglwX6b0tctp47+RN3Ad8pqbpG9bK0
	 MCYHDcNkfydSA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 8/8] btrfs: skip tests that exercise compression property when using nodatasum
Date: Wed, 12 Feb 2025 23:35:06 +0000
Message-ID: <bba353ff8e99673a70f79ede58951f77d004bb22.1739403114.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739403114.git.fdmanana@suse.com>
References: <cover.1739403114.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple tests exercise the compression property and that fails when an
inode has the nodatasum flag set. So skip the tests when running under the
nodatasum mount option.

Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/048 | 3 +++
 tests/btrfs/059 | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/btrfs/048 b/tests/btrfs/048
index a38c3951..3676debe 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -28,6 +28,9 @@ _require_scratch
 _require_btrfs_command "property"
 _require_btrfs_command inspect-internal dump-super
 _require_btrfs_no_nodatacow
+# We exercise setting compression through properties, and that fails on inodes
+# with nodatasum, so skip when mounting with nodatasum.
+_require_btrfs_no_nodatasum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index 227ebb14..3da6a5a9 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -26,6 +26,9 @@ _require_test
 _require_scratch
 _require_btrfs_command "property"
 _require_btrfs_no_nodatacow
+# We exercise setting compression through properties, and that fails on inodes
+# with nodatasum, so skip when mounting with nodatasum.
+_require_btrfs_no_nodatasum
 
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
-- 
2.45.2


