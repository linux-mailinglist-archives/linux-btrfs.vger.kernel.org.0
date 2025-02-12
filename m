Return-Path: <linux-btrfs+bounces-11406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490EFA32CB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B472C169CA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70300257AE2;
	Wed, 12 Feb 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg1gdU75"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89254257AC8;
	Wed, 12 Feb 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379741; cv=none; b=lvdkzSGsoyTra/m4hAau2sPpBmJi9vHrND90zaEoLyw9+Xpes/ExoECl8MIjJOk/uexxudQ75mXjWnfqHKfAEvduU9ZtI1wC9XOnY5UoCNChVyKqb9g6hx4DWDSTGV8hFzyOAbCPFyguIALdAtbsU512JTelK2Xx9osdkftAh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379741; c=relaxed/simple;
	bh=DoNqZJ2DPe1zFDQ4bf7WJ0G8ryPUf21H7QmEJcl3+2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HB+KKhSv9rEiYi360CsfoplCWoMrjlkk32J8nrJvXMTQAhNKFsrpP3MyJLjc6vJ5d+/y8iVClaOVmYtmM3Zt0C4so7pVrube9ZtT1J6LfBjUZkTIcO+tRizoQGSNU7Sg+u1bGDh6WixkURPKhyqoj3jNiNTfweePEjFN8R6RG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg1gdU75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC00C4CEDF;
	Wed, 12 Feb 2025 17:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379741;
	bh=DoNqZJ2DPe1zFDQ4bf7WJ0G8ryPUf21H7QmEJcl3+2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pg1gdU75/qKhYfQ4muFCTDDmiIQp10trkIWqjZfnP1HCQDm5lc5pf2na4NxVVOexp
	 PonuhuybUoWGxvj23CWvuCVQLGS+zXf26XUFAsfH+T11+XsZkeHjVg1t64WU7+f1BY
	 6zty5pYrFXtAWnVtsk0zESK2y46yb0KklAYlAxMmcChryvvE3YUNcF90kNDfu7I9XB
	 oDy97oyd1bgflu3nu7LPId/3UyiXxYEkdgLR6MPhrF9szniLXHKT8fbizRbfAIr1lI
	 qE2tzgY14I8zVKiPNXS/pbJj9B1R0PH6xx2sm5+qP/4Q/9Y+LPxUPMCviwGat/MMT0
	 OCX/b1tAHfypw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/8] btrfs/333: skip the test when running with nodatacow or nodatasum
Date: Wed, 12 Feb 2025 17:01:52 +0000
Message-ID: <2b9009f68ee7581816810b70f9ceb2c94eb9d2b2.1739379184.git.fdmanana@suse.com>
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

Encoded writes are reject for inodes with the NODATASUM flag, so we must skip
the test if running with either the nodatasum or nodatacow (which implies
nodatasum) mount options.

So skip the test when under nodatacow and nodatasum mount options.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/333 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/333 b/tests/btrfs/333
index 14cecdbc..6214d7c5 100755
--- a/tests/btrfs/333
+++ b/tests/btrfs/333
@@ -14,6 +14,11 @@ _begin_fstest auto quick compress rw io_uring ioctl
 _require_command src/btrfs_encoded_read
 _require_command src/btrfs_encoded_write
 _require_btrfs_iouring_encoded_read
+# Encoded writes are reject for inodes with the NODATASUM flag, so we must skip
+# the test if running with either the nodatasum or nodatacow (which implies
+# nodatasum) mount options.
+_require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 
 do_encoded_read()
 {
-- 
2.45.2


