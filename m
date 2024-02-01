Return-Path: <linux-btrfs+bounces-2037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A2845F62
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433CF299036
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E563128802;
	Thu,  1 Feb 2024 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkJUGEaU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA373127B52;
	Thu,  1 Feb 2024 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810649; cv=none; b=BrYZJlaV73fg5rjoQVrW2RDhVEZ8fe1McTGPxAGYcIWb/DDkpXDzsVnHU4NxmhO/wucFQeKKqQTvynAC3ZWpmO48aYFgMeNQg9xan5QRtaQ91SWgLPjAse2RFTMpg4jn567Xi0MEu9ClXGcaoh0EglNh+InV58UvDhSzIJaCp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810649; c=relaxed/simple;
	bh=pJey/BqAnBn9Q7A8kD7XQJQcSUF9vWU0CCQME/Wrf/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGswaXjvza0zwMDMbmP8l3KjTuJTAtJLGm3z3xe1JZGxr8YJ0y4XeHe0hSSjo152atuK40XYukwOOEe5SqU/GZTBPyBCJCCBM8nvbr4xKt4trEXvntk0ifvdU3nPa42Grv+3YWBXER0NtXiJLuTOmMjao9ubMerbZ3ofvbxeooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkJUGEaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE0C433C7;
	Thu,  1 Feb 2024 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810649;
	bh=pJey/BqAnBn9Q7A8kD7XQJQcSUF9vWU0CCQME/Wrf/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkJUGEaUQgc4APZot2PJ0JVP0BTiibY3/ljwylh6BQ8fZF46yIkf9Fo8px8g1nIY9
	 7E+BG5AO0Q5vwTrnE9YWYwnT6wd5P8K9zf3+OzTZnmXi5zqqMo6dOwCg7BcZYVvZjW
	 NcuOsweraKLO4/KhEUz4/NuxlmiJQ1UJPBoHOH308NQ9ATFASTkIbxMick0pF9SPhZ
	 3FPYzUm9yFHEu2pfoh3dIB0ApwMIOialfzmeFjXi9AMFFpiSKfj+h9bY6s5L+DRfNa
	 Udddg2be+pbQ67vxR4ODTkWwu6rBUlsPpm5VJU5N8YdCyLaWk0NtxnZ5qL76BuqCvG
	 XOjeA+rL8tBuw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/4] btrfs/299: skip test if we were mounted with nodatacow
Date: Thu,  1 Feb 2024 18:03:49 +0000
Message-Id: <92cf2f68139e3e8488c09372ef1fd46443b3299b.1706810184.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706810184.git.fdmanana@suse.com>
References: <cover.1706810184.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test requires the ability to create an inline extent in a file with
a prealloced extent, created with fallocate's FALLOC_FL_KEEP_SIZE mode,
which can only happen when COW is enabled. If the test is run with
MOUNT_OPTIONS="-o nodatacow", then COW never happens as all writes end
up using the preallocated extent. This results in the logical-resolve
command to return one file path when it should return none, since the
base logical address of the prealloc extent is still in use unless COW
happens.

So make the test not run if nodatacow is specified in MOUNT_OPTIONS.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/299 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/btrfs/299 b/tests/btrfs/299
index c4b1c7c5..d38bf2ac 100755
--- a/tests/btrfs/299
+++ b/tests/btrfs/299
@@ -23,6 +23,9 @@ _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
 _require_btrfs_command inspect-internal logical-resolve
+# Can't run with nodatacow because we need to be able to create an inline extent
+# in a range with a prealloc extent, which can only happen with COW enabled.
+_require_btrfs_no_nodatacow
 _fixed_by_kernel_commit 560840afc3e6 \
 	"btrfs: fix resolving backrefs for inline extent followed by prealloc"
 
-- 
2.40.1


