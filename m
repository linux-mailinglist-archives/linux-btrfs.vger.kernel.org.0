Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F42938EB62
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhEXPCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 11:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234576AbhEXPAH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 11:00:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EB18613F4;
        Mon, 24 May 2021 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621867794;
        bh=V6Ht5Q1d7BA+Esqjk6ydJwBvQnSAYZKpF8/BlSXnVyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1CAEkRcLB4r+uyz+BA6/M/vhhv8q265tmoowCtwXUEpNttfXmThkEt4Tocktj6Ay
         FNrWOXhVjvtsvrVrlRAG5tAprhsgsOa1EOD+VDIRwGEChRrZlyJYHbcqlgFQlXNFQs
         tVSRLkoRNIRcNYlKkaejR8OlWXtQX4odoofpWVpphIBX56tI9XbqpUv8TTv4P5iz9E
         QlXDHXKqkvyOMFJd5WA31uh4C5uxCusJqm//3C6fkzQ3xmjd6qhmHZCDIJmX99UPet
         cW0gA2BZoVzb1Zf3u94c0uLOTGd+XvO5G9JETXumqYrnCCOAK2UdoY8B9NDgq7VInq
         jfuIn4c2jdLdA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 41/52] btrfs: return whole extents in fiemap
Date:   Mon, 24 May 2021 10:48:51 -0400
Message-Id: <20210524144903.2498518-41-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144903.2498518-1-sashal@kernel.org>
References: <20210524144903.2498518-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

[ Upstream commit 15c7745c9a0078edad1f7df5a6bb7b80bc8cca23 ]

  `xfs_io -c 'fiemap <off> <len>' <file>`

can give surprising results on btrfs that differ from xfs.

btrfs prints out extents trimmed to fit the user input. If the user's
fiemap request has an offset, then rather than returning each whole
extent which intersects that range, we also trim the start extent to not
have start < off.

Documentation in filesystems/fiemap.txt and the xfs_io man page suggests
that returning the whole extent is expected.

Some cases which all yield the same fiemap in xfs, but not btrfs:
  dd if=/dev/zero of=$f bs=4k count=1
  sudo xfs_io -c 'fiemap 0 1024' $f
    0: [0..7]: 26624..26631
  sudo xfs_io -c 'fiemap 2048 1024' $f
    0: [4..7]: 26628..26631
  sudo xfs_io -c 'fiemap 2048 4096' $f
    0: [4..7]: 26628..26631
  sudo xfs_io -c 'fiemap 3584 512' $f
    0: [7..7]: 26631..26631
  sudo xfs_io -c 'fiemap 4091 5' $f
    0: [7..6]: 26631..26630

I believe this is a consequence of the logic for merging contiguous
extents represented by separate extent items. That logic needs to track
the last offset as it loops through the extent items, which happens to
pick up the start offset on the first iteration, and trim off the
beginning of the full extent. To fix it, start `off` at 0 rather than
`start` so that we keep the iteration/merging intact without cutting off
the start of the extent.

after the fix, all the above commands give:

  0: [0..7]: 26624..26631

The merging logic is exercised by fstest generic/483, and I have written
a new fstest for checking we don't have backwards or zero-length fiemaps
for cases like those above.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 95205bde240f..eca3abc1a7cd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4648,7 +4648,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len)
 {
 	int ret = 0;
-	u64 off = start;
+	u64 off;
 	u64 max = start + len;
 	u32 flags = 0;
 	u32 found_type;
@@ -4684,6 +4684,11 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out_free_ulist;
 	}
 
+	/*
+	 * We can't initialize that to 'start' as this could miss extents due
+	 * to extent item merging
+	 */
+	off = 0;
 	start = round_down(start, btrfs_inode_sectorsize(inode));
 	len = round_up(max, btrfs_inode_sectorsize(inode)) - start;
 
-- 
2.30.2

