Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB4358380
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhDHMkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 08:40:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:55242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhDHMkN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Apr 2021 08:40:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F222AD22;
        Thu,  8 Apr 2021 12:40:01 +0000 (UTC)
Date:   Thu, 8 Apr 2021 07:40:25 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH] btrfs: Correct try_lock_extent() usage in
 read_extent_buffer_subpage()
Message-ID: <20210408124025.ljsgund6jfc5c55y@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

try_lock_extent() returns 1 on success or 0 for failure and not an error
code. If try_lock_extent() fails, read_extent_buffer_subpage() returns
zero indicating subpage extent read success.

Return EAGAIN/EWOULDBLOCK if try_lock_extent() fails in locking the
extent.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7ad2169e7487..3536feedd6c5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5914,10 +5914,8 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
 
 	if (wait == WAIT_NONE) {
-		ret = try_lock_extent(io_tree, eb->start,
-				      eb->start + eb->len - 1);
-		if (ret <= 0)
-			return ret;
+		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1))
+			return -EAGAIN;
 	} else {
 		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1);
 		if (ret < 0)
-- 
2.30.2
