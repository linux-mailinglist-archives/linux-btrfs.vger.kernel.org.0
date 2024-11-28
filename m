Return-Path: <linux-btrfs+bounces-9947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 979879DB760
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4362BB23A13
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E519F11B;
	Thu, 28 Nov 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYnIa5Pu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD419CC33;
	Thu, 28 Nov 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796108; cv=none; b=iOw/Y/rdNMpH7jrvoRQvhEsm2eT5t0XyQ665SDFr4zNFEAw621WL/eEaiZnYF0Ix/HLoMeA1VQlRmQX5UWtyhVswfUzgG8VRjRELG9Msum4Qs/IVtiOmwQeaWRux3tUvEUYSo6FA0dCeyzYgHxAoO4n+QxXTWIGlVNa3LvgADhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796108; c=relaxed/simple;
	bh=g4p6uIJXXTJNH4uP75kSBu15B/aWUtmzmgp2OVoJLjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z30P7KUwjtW08sX6+Yhu8ek25moS11EnLVDKT8Qp4SOAyds7vDlh5oZLlxIgfC4zF27yXFlI3b/dPzrIbRcL9Pyqr8iS6J6U2l+5g3UtmSDjArC+5abvggGut559zTC2BdRd6Dk85klIGlZWELAxLv8oUD4LicfpDIeEDegPTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYnIa5Pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27F9C4CECE;
	Thu, 28 Nov 2024 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732796107;
	bh=g4p6uIJXXTJNH4uP75kSBu15B/aWUtmzmgp2OVoJLjE=;
	h=From:To:Cc:Subject:Date:From;
	b=sYnIa5PuFKLpnsX7uvqbMK0eR63+G03M/OZqGrWV8xlvLVmRnCTQv6E6JKlKmnEET
	 18XIrYsupRYezMBTIBwlJqLjaK6xbPIehYcr2TjG34eeB2YxX321YA9fU2HIfwLC1F
	 ygBhZueD6S3IiHt9yabrGsKYI3SmM4+CFLni/v4zoZnPZbQkXGtjdGDGjswRItntw/
	 EtUMosk/FTClLiXxzEbf0TAVMctohdNiMZQQJcn4zK7T7e1oFkGnItdm9DUK2iqDYd
	 eX0kow5E/GMLUmn/ClH+8ZTHhP2swpqmS47/9iQeb2cklTqwsl8lCWiR6Zx0VkjIOs
	 BEuilehdQrYwg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/028: kill lingering processes when test is interrupted
Date: Thu, 28 Nov 2024 12:14:56 +0000
Message-ID: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we interrupt the test after it spawned the fsstress and balance
processes (while it's sleeping for 30 seconds * $TIME_FACTOR), we don't
kill them and they stay around for a long time, making it impossible to
unmount the scratch filesystem (failing with -EBUSY).

Fix this by adding a _cleanup function that kills the processes and
waits for them to exit.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/028 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/btrfs/028 b/tests/btrfs/028
index f64fc831..4ef83423 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -13,6 +13,19 @@
 . ./common/preamble
 _begin_fstest auto qgroup balance
 
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	if [ ! -z "$balance_pid" ]; then
+		_btrfs_kill_stress_balance_pid $balance_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 . ./common/filter
 
 _require_scratch
-- 
2.45.2


