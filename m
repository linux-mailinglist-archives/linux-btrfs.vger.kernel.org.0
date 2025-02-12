Return-Path: <linux-btrfs+bounces-11410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E43A32CB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015423AB872
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9C25A2B9;
	Wed, 12 Feb 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRAtDysL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168D2586DD;
	Wed, 12 Feb 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379747; cv=none; b=DT2dctq0nmHCRupri+AaIKozgto2QSrPw+1qX+GYH8K4NooNXAG9ytlvtsmyOSb/xmiGs1fYeji4xhd2zz1gCM01J4JJ6ex9GuVk667y5d2wRJ+WTHGVFAwmGBlMWOFWBXatSxH6ZPFR8B70/eLswFVDFnemAkhaJYFvl0sAjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379747; c=relaxed/simple;
	bh=Gb//+2DMieZeX9z5NvgUybYc2HCQx3COjmFxat6FNck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz7uEv6FxZb9PbIVrLhUHjUn/lfutEjCLdQZg05fzCecXD0gD6PVbjZfv39l/W+vFaovrFj2XcUvHLsJLGzBj+thC3EHotNPPHKVvQotTHqSIXNa1XAq1mYiDi9y2i+aa3s6waoPABMbMe2jco8Q0SCe0HDxXRO5ZXAxjNPGJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRAtDysL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2109EC4CEDF;
	Wed, 12 Feb 2025 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379747;
	bh=Gb//+2DMieZeX9z5NvgUybYc2HCQx3COjmFxat6FNck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRAtDysLqW1lswv82uxVETtD0FrIyeGMUIr7LrD/J126+Jmaq+N7QHNQ3O9wtlPFT
	 csa1s3MN3H8UyI1NuOAD69aZqAscQ3LiIcFdD5VkuVuVfb0e1QKAzc54LJxzjD9d2h
	 wwDI7hQeRglpAZGKDc7uHU2ylkBYWjmlafrLttf1SZLjsNQAwOuPRktCjKG3VgB8wp
	 lObHJCd+5qfReBXloTrPp0O8wtd3+u7EIO6U3ckBhf+zYkl6pTzsEQhU5bi0xF6f5n
	 DulWSaIEid064kgYtTrWhIhQTc9znf7RUdRcvD/JojQ48im+an9dzefwg/QCLEzsLG
	 djM31cTI8EjZQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 8/8] btrfs: skip tests that exercise compression property when using nodatasum
Date: Wed, 12 Feb 2025 17:01:56 +0000
Message-ID: <ef820042ceee48a9f0aac3eaae34e3abf4094573.1739379186.git.fdmanana@suse.com>
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

A couple tests exercise the compression property and that fails when an
inode has the nodatasum flag set. So skip the tests when running under the
nodatasum mount option.

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


