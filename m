Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1F3B93C3
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhGAPP0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 11:15:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56624 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhGAPP0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 11:15:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 97F951FF9B;
        Thu,  1 Jul 2021 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625152374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=meIxA9H73wVE9Am2H50CFd7t+2s2Qs7a9feIY7flJlM=;
        b=GPO+1uKA9DdQsTS9VCeI9ySnkQ8x+oYmrfyGfCZTRubsewGQy3uJxam17GVAMt86TFW6Vy
        nP3lsnVxnAZQfU2oLsP8TSplrqXCEquKThzg4FpW+c8lHCfsIG3ppyBcphjaSZGtHfx9zQ
        jeoXz0/sulNhMnMInTyqWbyTk3Xvg/g=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 912ABA3B87;
        Thu,  1 Jul 2021 15:12:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B805DA6FD; Thu,  1 Jul 2021 17:10:23 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: zoned: fix types for u64 division in btrfs_reclaim_bgs_work
Date:   Thu,  1 Jul 2021 17:10:20 +0200
Message-Id: <20210701151020.31244-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The types in calculation of the used percentage in the reclaiming
messages are both u64, though bg->length is either 1GiB (non-zoned) or
the zone size in the zoned mode. The upper limit on zone size is 8GiB so
this could theoretically overflow in the future, right now the values
fit.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 38b127b9edfc..d4c8dc550889 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1540,7 +1540,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			goto next;
 
 		btrfs_info(fs_info, "reclaiming chunk %llu with %llu%% used",
-				bg->start, div_u64(bg->used * 100, bg->length));
+				bg->start, div64_u64(bg->used * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
 		if (ret)
-- 
2.31.1

