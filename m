Return-Path: <linux-btrfs+bounces-13633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477ECAA7501
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC9D98048D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A432417D4;
	Fri,  2 May 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh+zUPvB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AB3398B
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196377; cv=none; b=qzWBI2mq+scqvqjhM0AOnDHOjl0hhH1ayQ7IZywm9wOGbUyGeHcKgtp9HWs3oL50eHL+8eUkEBZhOj8JDgbXM4b+VTgnA9QbRKrIpjEf41Xnfxgj7NDbzWXIDgB4OxMAg2ajeoJHnhg0fVFFIEMas+I3aPqQmSe9ANFY1oSgGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196377; c=relaxed/simple;
	bh=hU/pZL2Pwi0p3lAbuLMadJEXKjIw0RrbjmeNEe0diKo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ItOlyGmER6MlrdMDGVeK8rDN173sMdkGJSyJ0zu9SnlYhj4fmsuSsvT+tjDak4N2xDDMvv8k0QJluk2idghkbFjTolSRYHktU6KtAJ2qmKrBhAe1bFLMWxfKZQBob+ndJgI9ARpin1zgXFEaOf3sbWnU5wogDpnmAuxnCfT8zEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh+zUPvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01845C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746196376;
	bh=hU/pZL2Pwi0p3lAbuLMadJEXKjIw0RrbjmeNEe0diKo=;
	h=From:To:Subject:Date:From;
	b=Dh+zUPvByOBWyaHQEn610j+1QErnOtyzTPCwE4SuCXQH+7s7PyzMA5Ui1NIKB4Aow
	 We9smOiQKYUP268ZQ08MbU5WbvATAeY9qmfsu1WWUA2fNrCuBK+NcpZWq9CB6FowxR
	 BQ2n+JX/qGPowrdfdbfFTRCzXXAH5q+sEMyCGhbCsW0iAWwzaBNESJ5ZIws7OlegzD
	 +aGmcXeXIV+SEaS/SnYTwPz+lH7EJ1l7DCh1sUtOyHCL7GF+aUB1uu7+xDYtPR1B5+
	 UIeoJ2C9DPsPBjwChhZVrkP0Lm5NXyp2ApFSy2bHyN4RQJxsz0q7FT449ZtkbQ5CwJ
	 yxw0DOR8eqOnA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check: fix false alert on missing csum for hole
Date: Fri,  2 May 2025 15:32:52 +0100
Message-Id: <4dbd03928f8384d926aff5754199c5078fc915cb.1746194979.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we log a hole, fsync a file, partially write to the front of the hole
and then fsync again the file, we end up with a file extent item in the
log tree that represents a hole and has a disk address of 0 and an offset
that is greater than zero (since we trimmed the front part of the range to
accomodate for a file extent item of the new write).

When this happens 'btrfs check' incorrectly reports that a csum is missing
like this:

  $ btrfs check /dev/sdc
  Opening filesystem to check...
  Checking filesystem on /dev/sdc
  UUID: 46a85f62-4b6e-4aab-bfdc-f08d1bae9e08
  [1/8] checking log
  ERROR: csum missing in log (root 5 inode 262 offset 5959680 address 0x5a000 length 1347584)
  ERROR: errors found in log
  [2/8] checking root items
  (...)

And in the log tree, the corresponding file extent item:

  $ btrfs inspect-internal dump-tree /dev/sdc
  (...)
        item 38 key (262 EXTENT_DATA 5959680) itemoff 1796 itemsize 53
                generation 11 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 368640 nr 1347584 ram 1716224
                extent compression 0 (none)
  (...)

This false alert happens because we sum the file extent item's offset to
its logical address before we attempt to skip holes at
check_range_csummed(), so we end up passing a non-zero logical address to
that function (0 + 368640), which will attempt to find a csum for that
invalid address and fail.

This type of error can be sporadically triggered by several test cases
from fstests such as btrfs/192 for example.

Fix this by skipping csum search if the file extent item's logical disk
address is 0 before summing the offset.

Fixes: 88dc309aca10 ("btrfs-progs: check: explicit holes in log tree don't get csummed")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 check/main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/check/main.c b/check/main.c
index 6290c6d4..bf250c41 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9694,10 +9694,6 @@ static int check_range_csummed(struct btrfs_root *root, u64 addr, u64 length)
 	u64 data_len;
 	int ret;
 
-	/* Explicit holes don't get csummed */
-	if (addr == 0)
-		return 0;
-
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0)
 		return ret;
@@ -9807,12 +9803,15 @@ static int check_log_root(struct btrfs_root *root, struct cache_tree *root_cache
 			if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG)
 				goto next;
 
+			addr = btrfs_file_extent_disk_bytenr(leaf, fi);
+			/* An explicit hole, skip as holes don't have csums. */
+			if (addr == 0)
+				goto next;
+
 			if (btrfs_file_extent_compression(leaf, fi)) {
-				addr = btrfs_file_extent_disk_bytenr(leaf, fi);
 				length = btrfs_file_extent_disk_num_bytes(leaf, fi);
 			} else {
-				addr = btrfs_file_extent_disk_bytenr(leaf, fi) +
-				       btrfs_file_extent_offset(leaf, fi);
+				addr += btrfs_file_extent_offset(leaf, fi);
 				length = btrfs_file_extent_num_bytes(leaf, fi);
 			}
 
-- 
2.47.2


