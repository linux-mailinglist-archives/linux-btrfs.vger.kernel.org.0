Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58271366CE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 15:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbhDUNc1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 09:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240847AbhDUNc1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 09:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8672261440
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Apr 2021 13:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619011914;
        bh=dBt1jNZxloTevCqMfiAtrTtbmPpGjjMskLYGjf5duMg=;
        h=From:To:Subject:Date:From;
        b=gp3Ct8lcu4+Rdi6j8PP0XH+6VEid+9Hvpebd2FAo3ebIATfVJbWjMXDaorEfj2PtF
         ztlVccNanXfBhZyct5zRNSVPrh2QRvgC962S1zvlHSP4kpiegJf6HBkNxdANKNEbrf
         1++OtFE2AL/0aGCsGfu1z7ix/6IbdYNXDIHKqwk/cZuOEGu9frpuOwKL46UyhlEYc2
         uIplcYwwgVE9Fkhcy1D+IEx7Xx87xFUw4L+JPoiC3VCoGb8h2bV6Snx4ekyKnST+xE
         aMIokf4PICF64zXAImEydTGBjY+QSqwuW66wkl6VVY+P/QtnvGOzsxOP6rjdqwfnKn
         V2gCI31NV+fcg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix silent data loss after failure splitting ordered extent
Date:   Wed, 21 Apr 2021 14:31:50 +0100
Message-Id: <0aba70d8929db6eeb640c795f512957db7a0b34a.1619011437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

On a zoned filesystem, sometimes we need to split an ordered extent into 3
different ordered extents. The original ordered extent is shortened, at
the front and at the rear, and we create two other new ordered extents to
represent the trimmed parts of the original ordered extent.

After adjusting the original ordered extent, we create an ordered extent
to represent the pre-range, and that may fail with -ENOMEM for example.
After that we always try to create the ordered extent for the post-range,
and if that happens to succeed we end up returning success to the caller
as we overwrite the 'ret' variable which contained the previous error.

This means we end up with a file range for which there is no ordered
extent, which results in the range never getting a new file extent item
pointing to the new data location. And since the split operation did
not return an error, writeback does not fail and the inode's mapping is
not flagged with an error, resulting in a subsequent fsync not reporting
an error either.

It's possibly very unlikely to have the creation of the post-range ordered
extent succeed after the creation of the pre-range ordered extent failed,
but it's not impossible.

So fix this by making sure we only create the post-range ordered extent
if there was no error creating the ordered extent for the pre-range.

Fixes: d22002fd37bd97 ("btrfs: zoned: split ordered extent when bio is sent")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 07b0b4218791..6c413bb451a3 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -984,7 +984,7 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 
 	if (pre)
 		ret = clone_ordered_extent(ordered, 0, pre);
-	if (post)
+	if (ret == 0 && post)
 		ret = clone_ordered_extent(ordered, pre + ordered->disk_num_bytes,
 					   post);
 
-- 
2.28.0

