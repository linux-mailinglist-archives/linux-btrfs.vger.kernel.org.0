Return-Path: <linux-btrfs+bounces-10198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFD99EB85E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 18:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B766628582F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1891B415C;
	Tue, 10 Dec 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAlvQhyy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6E1990BA;
	Tue, 10 Dec 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852033; cv=none; b=gntHJqvx3l8ZXIfLR+hTiOeTwJrpubFsbdhzrqAT/4Vb0oRwprYfXD9ZysyDgabikUw1z1VncD7MV4AifDV/LusISmh4hqCQyrtCDZKnukg/Y5L/IGSgE6hWNDsx5nta81uuMNnjJ544xqiHfAi1lTK0OhMKpTWZ5+kY3s4/VmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852033; c=relaxed/simple;
	bh=TVmCwMU+pQzR/m/g8++uvku/OgV9fFtDH4MnbpjqwZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoIvN0gOhtIt2PcIsbeJNT3yrkk/OhATHZhUQ2a1PmcdwbxK9+HZorvw7Q3zDJFaa5Y4KbB+VOfs5nNiSoodkf2vE4uY1Ybv/kyMpbg3jMPE/xOdMCkxmGwneRsWx8UzMehhsLmqnsALHDhwkxMwgm2M0EtLmcPGr+jurKN4fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAlvQhyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005ACC4CEDF;
	Tue, 10 Dec 2024 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733852033;
	bh=TVmCwMU+pQzR/m/g8++uvku/OgV9fFtDH4MnbpjqwZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=bAlvQhyyQ90m/DMuTuEpWusYDN8GZnGPR3ZXrgwW9/XLRc2NNqiNWirYM2sfPS87M
	 z/+6wJ8bMbG0xa59E+Qx7PMTyWlic7Lp/pT4XLcDgwSBQ0twD31drBwzSbbHergyMf
	 sJyD2eHOIRvXgUETzU4cP4Eyz7/EelEcawAgWQZJ06gp81qFt22KT1cc35h7Hlx6y2
	 K030CZfaYF9vxpXdRX+x3WjQxfsTj3dF0VZ53GuGYQxaOJvXaefvN98SxoeMXVrRm2
	 0zVjX53a4SamNZXIDSlfs1NP33B/xf1hNxdNQhHTtB9OPMapfdizXQxuSbMsYWRp1c
	 b5KZOZtcHWjPA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	dchinner@redhat.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/142, btrfs/143: fix dmdust device names
Date: Tue, 10 Dec 2024 17:33:47 +0000
Message-ID: <e890661f90bde3b8119bd9a533760b2c8e162cfd.1733852020.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After commit aaa132777476 ("fstests: per-test dmdust instances") the
dmdust device names are no longer a plain 'dust-test', they now have
a suffix matching '.N', where N is the test's sequence number.
The test cases btrf/142 and btrfs/143 are still using the old device
names, so they fail. Fix this my making them refer to 'dust-test.$seq'
instead of 'dust-test'.

Fixes: aaa132777476 ("fstests: per-test dmdust instances")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/142 | 4 ++--
 tests/btrfs/143 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/142 b/tests/btrfs/142
index cf7e8daa..0ab0f801 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -58,8 +58,8 @@ _mount_dust
 # step 3, 128k dio read (this read can repair bad copy)
 echo "step 3......repair the bad copy" >>$seqres.full
 
-$DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
-$DMSETUP_PROG message dust-test 0 enable
+$DMSETUP_PROG message dust-test.$seq 0 addbadblock $((physical / 512))
+$DMSETUP_PROG message dust-test.$seq 0 enable
 
 _btrfs_direct_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
 
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 5da9a578..490f27b5 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -65,8 +65,8 @@ _mount_dust
 # step 3, 128k buffered read (this read can repair bad copy)
 echo "step 3......repair the bad copy" >>$seqres.full
 
-$DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
-$DMSETUP_PROG message dust-test 0 enable
+$DMSETUP_PROG message dust-test.$seq 0 addbadblock $((physical / 512))
+$DMSETUP_PROG message dust-test.$seq 0 enable
 
 _btrfs_buffered_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
 
-- 
2.45.2


