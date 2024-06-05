Return-Path: <linux-btrfs+bounces-5466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2228FCA64
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 13:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD802821DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE1192B9B;
	Wed,  5 Jun 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzsGWl8x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE1192B7C;
	Wed,  5 Jun 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586787; cv=none; b=UlLFwZ3615kAG5kfKSoEWMTGQW9boEngwOQGJSSUBzJ1cEORbW3wURj3ERyRdS/qMkSh46C6VinpQ1S2niFBz3y25hkqTdxfW2fCNUFAVQGHX1OlAtNZ9RNOQ9m5VpGBruvxkHf+KOT5/0B5fHkAvgLHp/JszATL1rw6SysoQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586787; c=relaxed/simple;
	bh=4YJYWvtPVHJOX484OMtRysOXcmMfHyNUjQOxToqjlKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1A0eLfgF6e9KEcQiDdl1nLOnRQarXgEX0b10iytoEZgEE71fuTWkJuCf3BjLeH9wilhPdArw3IivsmIxOl9g1eIoUSBM+PD39DjkZlasIiCUUI0xh5YnJ9FkgWBtVVHhs6oSrpDbEJy4Kq/rRaZqxnASa7FsUc8ypP0rID88m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzsGWl8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BBEC3277B;
	Wed,  5 Jun 2024 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717586787;
	bh=4YJYWvtPVHJOX484OMtRysOXcmMfHyNUjQOxToqjlKE=;
	h=From:To:Cc:Subject:Date:From;
	b=KzsGWl8xaUk2UxjI1a5zqDdyHSAjmex4h31zXb0PJrNeOa1uX3/Vw073pfZj/MJdT
	 PENglnxKVjcthwk5lUgfxUg+mAYtGwHVZ/D9yVms4/lDUi0YgIwBdnbppA4rjEefBX
	 BdPFNeL7rAv6c+34dDrdMgsapLK2FwKM4drURL2uqhDPow5ko986cqGBmKTBfkrU7Z
	 h+tFQOy30BWIqMcThDVf00NC+EQ/UdUBMSPpTwcLsHqSmEpg/VjAYHf6hj7OuyLyj9
	 mQDkCClsk+XtqZe8OhTLppgnhOtMbetinNN6p9Nx0gMRPGYTp+yyWkr5a5NecuJuGi
	 UIua94p0MF1bw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/280: run defrag after creating file to get expected extent layout
Date: Wed,  5 Jun 2024 12:26:20 +0100
Message-ID: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test writes a 128M file and expects to end up with 1024 extents, each
with a size of 128K, which is the maximum size for compressed extents.
Generally this is what happens, but often it's possibly for writeback to
kick in while creating the file (due to memory pressure, or something
calling sync in parallel, etc) which may result in creating more and
smaller extents, which makes the test fail since its golden output
expects exactly 1024 extents with a size of 128K each.

So to work around run defrag after creating the file, which will ensure
we get only 128K extents in the file.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/280 | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/280 b/tests/btrfs/280
index d4f613ce..0f7f8a37 100755
--- a/tests/btrfs/280
+++ b/tests/btrfs/280
@@ -13,7 +13,7 @@
 # the backref walking code, used by fiemap to determine if an extent is shared.
 #
 . ./common/preamble
-_begin_fstest auto quick compress snapshot fiemap
+_begin_fstest auto quick compress snapshot fiemap defrag
 
 . ./common/filter
 . ./common/punch # for _filter_fiemap_flags
@@ -36,6 +36,14 @@ _scratch_mount -o compress
 # extent tree (if the root was a leaf, we would have only data references).
 $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
 
+# While writing the file it's possible, but rare, that writeback kicked in due
+# to memory pressure or a concurrent sync call for example, so we may end up
+# with extents smaller than 128K (the maximum size for compressed extents) and
+# therefore make the test expectations fail because we get more extents than
+# what the golden output expects. So run defrag to make sure we get exactly
+# the expected number of 128K extents (1024 extents).
+$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foo" >> $seqres.full
+
 # Create a RW snapshot of the default subvolume.
 _btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
 
-- 
2.43.0


