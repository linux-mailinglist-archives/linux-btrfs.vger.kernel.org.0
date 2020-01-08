Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0D134532
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 15:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgAHOkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 09:40:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:39098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgAHOkq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 09:40:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 129D8AD43;
        Wed,  8 Jan 2020 14:40:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DB01DDA791; Wed,  8 Jan 2020 15:40:33 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] btrfs: safely advance counter when looking up bio csums
Date:   Wed,  8 Jan 2020 15:40:32 +0100
Message-Id: <20200108144032.16354-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dan's smatch tool reports

  fs/btrfs/file-item.c:295 btrfs_lookup_bio_sums()
  warn: should this be 'count == -1'

which points to the while (count--) loop. With count == 0 the check
itself could decrement it to -1. There's a WARN_ON a few lines below
that has never been seen in practice though.

It turns out that the value of page_bytes_left matches the count (by
sectorsize multiples). The loop never reaches the state where count
would go to -1, because page_bytes_left == 0 is found first and this
breaks out.

For clarity, use only plain check on count (and only for positive
value), decrement safely inside the loop. Any other discrepancy after
the whole bio list processing should be reported by the exising
WARN_ON_ONCE as well.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file-item.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index bb374042d297..c2f365662d55 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -283,7 +283,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		csum += count * csum_size;
 		nblocks -= count;
 next:
-		while (count--) {
+		while (count > 0) {
+			count--;
 			disk_bytenr += fs_info->sectorsize;
 			offset += fs_info->sectorsize;
 			page_bytes_left -= fs_info->sectorsize;
-- 
2.24.0

