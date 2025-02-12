Return-Path: <linux-btrfs+bounces-11404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC0A32CB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D94167834
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C6257420;
	Wed, 12 Feb 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgbAHsLw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F08212B31;
	Wed, 12 Feb 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379738; cv=none; b=L8O3Tko1LXPamyc8g0UNMe7FC5qIxBQ3ASJkrWlp7DSCS3VeX96QTDq2swPGEUgM5y0Pj9C8obKR3RhfVFrKku7WRUPqhYp0hy0ENPw36tKZOGc9+fe16oXDajKmgaRi3AEn/p1kvMBh1yHnSp50iPEq4BlkK/QxnhKMAEnAWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379738; c=relaxed/simple;
	bh=wQdIuWLdrKAF+/zcUz4/kR4beRBYI0ynkYZlPoZDmXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJL2wjIDuy5J7JkPaBBCHFpJ0MJKAjPS73xAqvg7STpo/jvc6AJScQNY8DhBWTKl5BLOwcwxhs89WuTtTr8IouSFTgD3uig+Rr/IEnPZjXhny28+jxxQxf2T1Zfkf9J4YCrXHBaQlFpOAxEKsHyDwqnrteCWYmVkIzWxhTFiDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgbAHsLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BC1C4AF0C;
	Wed, 12 Feb 2025 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379738;
	bh=wQdIuWLdrKAF+/zcUz4/kR4beRBYI0ynkYZlPoZDmXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgbAHsLw+9lK7Kx4av2++3cKoNlVHs9rPDUuOZNjgPILKfhPwLyTJaTHuqh2t37R3
	 481ccU75K0vkwtUMNtxWCTklY/tET+4s1a/RZKqPv2QDxdg1NIBFRVztBS95yARkqO
	 vz9H1HUMuiSgpJy4RZsJOko4hTQ9mNauGPnFgxdsV/sHgq1Cyh59dwvLpBu2aBY4Xa
	 ogCgz94WxR+GRWsLuiE0IWICUAzioWlM9bJrL6ImBn6oUp07+5CvcldXOkEY/I8XzZ
	 7cY5i3vZc2MEdnMajpmQZg4iNo/+M7cypEtjRbtPXUnj3O1QhPpAmIBGYl1/b5Nt0F
	 e+B/pAaBNSQyg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/8] btrfs/290: skip test if we are running with nodatacow mount option
Date: Wed, 12 Feb 2025 17:01:50 +0000
Message-ID: <a7694ebdfbe8fb9961f5fa43b6d1a153ffdec32a.1739379184.git.fdmanana@suse.com>
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

We exercise corrupting an inline extent and inline extents can't be created
with nodatacow, we get instead a regular file extent item and if we attempt
to corrupt its disk_bytenr field with btrfs-corrupt-block we fail tree-checker
validation at mount time resulting in failure to mount and the following in
dmesg:

[514127.759739] BTRFS critical (device sdc): corrupt leaf: root=5 \
        block=30408704 slot=8 ino=257 file_offset=0, invalid disk_bytenr for \
        file extent, have 7416089308958521981, should be aligned to 4096
[514127.762715] BTRFS error (device sdc): read time tree block corruption \
        detected on logical 30408704 mirror 1

So add a _require_btrfs_no_nodatacow call to the test.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/290 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/btrfs/290 b/tests/btrfs/290
index 1a5e267b..04563dfe 100755
--- a/tests/btrfs/290
+++ b/tests/btrfs/290
@@ -30,6 +30,18 @@ _require_xfs_io_command "pread"
 _require_xfs_io_command "pwrite"
 _require_btrfs_corrupt_block "value"
 _require_btrfs_corrupt_block "offset"
+# We exercise corrupting an inline extent and inline extents can't be created
+# with nodatacow, we get instead a regular file extent item and if we attempt
+# to corrupt its disk_bytenr field with btrfs-corrupt-block we fail tree-checker
+# validation at mount time resulting in failure to mount and the following in
+# dmesg:
+#
+# [514127.759739] BTRFS critical (device sdc): corrupt leaf: root=5 \
+#         block=30408704 slot=8 ino=257 file_offset=0, invalid disk_bytenr for \
+#         file extent, have 7416089308958521981, should be aligned to 4096
+# [514127.762715] BTRFS error (device sdc): read time tree block corruption \
+#         detected on logical 30408704 mirror 1
+_require_btrfs_no_nodatacow
 _disable_fsverity_signatures
 
 get_ino() {
-- 
2.45.2


