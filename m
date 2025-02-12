Return-Path: <linux-btrfs+bounces-11432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC754A33375
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40213188B567
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31626157D;
	Wed, 12 Feb 2025 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDpHWj4+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A8260A46;
	Wed, 12 Feb 2025 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403322; cv=none; b=O8HrD22r2kLqvFqcXtcBBN5J/FkbRbBuUaK2A5T3uE+kdbJ8ncRsYCwSETsFSNkGOtYKeVqW73nWBuQx9GFNU+0NdjzB+5er2MhxlUoQNQoXWEt/jvqhDEtV711fJzPMRJy9wtksC88jhUBHdbGYnhYS6Rj/BZGqDtdxQEARsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403322; c=relaxed/simple;
	bh=KeK7/K+QbR1bp4NC/jH89KpxaVH/+F9qplZtR13OptA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKJAyXSRgQmQl6WTPoLksyperD4qGKgY8g7zRt1yomLlAonCEXWKPuR5W7QF8IzJHFNuwuLS3FkKC1gGfuGKGeAPeAW3FAZOcvzGRNWET2WTjkTle+FSLFUi9Y0W3GA72N7QbqBqFoFHgsOD33nFu0Fj2t7ujChCiox/L7OlOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDpHWj4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6DAC4CEE4;
	Wed, 12 Feb 2025 23:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403321;
	bh=KeK7/K+QbR1bp4NC/jH89KpxaVH/+F9qplZtR13OptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDpHWj4+/+2GAhIJ//eIpeu3UvnWWvJeL5IwjcF1GTdeGYHfHTVFZo1udk3jfPUen
	 YghUiJKpjRlX7KVCan9rc4dIsKYS91+aaF0w9K06kugXDaYr2enym20Jwv4ym3rnAx
	 SyMmzzKA86qalwEJ7WnJ1OqdDpaG2vbt98/I+sVZ6W8DzLuskNHPEQbdb4ooos9YWO
	 6/UMZXUwwBx2hISnoFdgfHJAze4kW4NlmRNYlcIs01yxoOqVrcK2k78eVW5JIQGiOK
	 tjwygvUu3jRnuuqshOX+s7o1pSdJsuSthNgX+iE+jC9+Ezlz7/mXzFpzC63dQvlo4e
	 UghYEhw0KPxSg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 5/8] btrfs/205: skip test when running with nodatasum mount option
Date: Wed, 12 Feb 2025 23:35:03 +0000
Message-ID: <dc61c4474930cb42142081be5c18245551efcde8.1739403114.git.fdmanana@suse.com>
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

Currently the test fails when we pass "-o nodatasum" in MOUNT_OPTIONS and
the reason is because we enable compression, with "chattr +c", on a file
and then try to clone from it to a file with nodatasum inherited from the
mount options, which results in the clone ioctl to fail with -EINVAL since
it's not possible to clone from datasum to nodatasum and vice-versa.

So skip the test if nodatasum is a mount option.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/205 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/205 b/tests/btrfs/205
index 13a1df8b..a557ab14 100755
--- a/tests/btrfs/205
+++ b/tests/btrfs/205
@@ -24,6 +24,11 @@ _require_xfs_io_command "falloc" "-k"
 _require_command "$CHATTR_PROG" chattr
 _require_btrfs_fs_feature "no_holes"
 _require_btrfs_mkfs_feature "no-holes"
+# We want to create a compressed inline extent representing 4K of data for file
+# foo1 and then clone it into a file without compression, and since compression
+# implies datasum, cloning fails if the destination file has nodatasum. So skip
+# the test if nodatasum is present in MOUNT_OPTIONS.
+_require_btrfs_no_nodatasum
 
 run_tests()
 {
-- 
2.45.2


