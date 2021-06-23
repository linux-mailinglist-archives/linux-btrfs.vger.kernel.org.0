Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0873B138D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFWF6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:58:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFWF6D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:58:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 85C8021941
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ui2DQo0KEVf2eqmaCessSaLN3Vcauoxi2arC/0NsiE=;
        b=p9lxUqKX30zum8irx1kFgNMMLGvKD/StzJKN8pPt7QDv6n+FeAIv+FtgBsiyw3kgIlhYgL
        kVziPqgtxDVvlEqsFYolzooPIluWPyyGIKNBNiscpRfaJDiNpFJKd0dTw3df5V2bPzHBIs
        2yDWSRZAVlDEPEoKcWlmtf8lkpmIxDk=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 8B1A7A3BAB
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 7/8] btrfs: make extent_write_locked_range() to be subpage compatible
Date:   Wed, 23 Jun 2021 13:55:28 +0800
Message-Id: <20210623055529.166678-8-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function extent_write_locked_range() gets called when an async range
falls back to regular COW.

In that case, we need to finish the ordered extents for the range.

But the function is still using hardcoded PAGE_SIZE to calculate the
range.

If it get called with a range like this:

  0   16K  32K   48K 64K
  |   |////|/////|  |

Then the range passed to btrfs_writepage_endio_finish_ordered() will be
start == 16K, end == 80K, and the page range will no longer cover it,
triggering an ASSERT().

Fix it by properly calculate the range end by considering both the page
end and range end.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e244c10074c8..c5491720a346 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5070,16 +5070,19 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 
 	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (start <= end) {
+		u64 cur_end = min(round_down(start, PAGE_SIZE) + PAGE_SIZE - 1,
+				  end);
+
 		page = find_get_page(mapping, start >> PAGE_SHIFT);
 		if (clear_page_dirty_for_io(page))
 			ret = __extent_writepage(page, &wbc_writepages, &epd);
 		else {
 			btrfs_writepage_endio_finish_ordered(BTRFS_I(inode),
-					page, start, start + PAGE_SIZE - 1, 1);
+					page, start, cur_end, 1);
 			unlock_page(page);
 		}
 		put_page(page);
-		start += PAGE_SIZE;
+		start = cur_end + 1;
 	}
 
 	ASSERT(ret <= 0);
-- 
2.32.0

