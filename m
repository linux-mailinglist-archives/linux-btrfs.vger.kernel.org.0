Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628285BCE0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiISOHB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiISOG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B931DF4
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C969B81BF7
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413B6C433B5
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596414;
        bh=/TY8SqEgMQnTmuEB1ZREYUpUPI7o9H1l4BTmP1teOv4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s74tCLm/PCWC7zllFNAY7RK3NRuJ5sWZB97q2AFBvOZTlOIIRGfQNb9kiQKZmpVGK
         OVyvOCvf5yf10/A++cJ4DlblAIqq9Okj+21J4BhXfgwrTmDx2StlmahBYDE8+20Z1H
         kI4/GF/Z+pinnxfCiejfDAL6MEwize1T+JnWe4x46/61P2KqwIA07WPNYHW4mKHFLa
         M6AYtEptrDr5/01UMzmlmq07lzbZdQVcQ1YJHV1a+4ZEEl/E7NHXP7/4sM5aygd8SU
         Qe6Un02LXxNvk/AelY5OqqlNehEgX6D79hm1hzsvUtboP1FGUvFXaIK57aOIQjiXBj
         LJPgogJU+6QaA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/13] btrfs: avoid pointless extent map tree search when flushing delalloc
Date:   Mon, 19 Sep 2022 15:06:39 +0100
Message-Id: <9d2ede948c70a5b9b64631cddbcd1ae8db8d56ae.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When flushing delalloc, in COW mode at cow_file_range(), before entering
the loop that allocates extents and creates ordered extents, we do a call
to btrfs_drop_extent_map_range() for the whole range. This is pointless
because in the loop we call create_io_em(), which will also call
btrfs_drop_extent_map_range() before inserting the new extent map.

So remove that call at cow_file_range() not only because it is not needed,
but also because it will make the btrfs_drop_extent_map_range() calls made
from create_io_em() waste time searching the extent map tree, and that
tree can be large for files with many extents. It also makes us waste time
at btrfs_drop_extent_map_range() allocating and freeing the split extent
maps for nothing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 024183c7480f..32fe3712ea9d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1254,7 +1254,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	}
 
 	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);
-	btrfs_drop_extent_map_range(inode, start, start + num_bytes - 1, false);
 
 	/*
 	 * Relocation relies on the relocated extents to have exactly the same
-- 
2.35.1

