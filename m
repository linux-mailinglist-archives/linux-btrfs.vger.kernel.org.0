Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4795BCE00
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiISOGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiISOGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA931DFF
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEB20B81BF7
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA07C433B5
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596407;
        bh=ST9E6UU1/gd/dog8lRvaqiVvmvCakfC9ugcjfM6v9hk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Bz+fFUWLifmr4k1qurhraYgx6GRzQjo/7g2zZTMJTCBrLBuKNoF13ErPZsYJEgmpY
         ahk19YSRkqoe5q6Of/uHoeGTinFeDZ+myX8zVvxP+5evtGbV854z7wfc2syppB3Vmm
         uZL+wJ2JRLJv5RSzUnVabEYUy5rq+j74tCyHEoia6yEd20QgGGlfvcsWR2+6jtXOX2
         YvDF4S4xxNi9uWMNvp2OrBty6HEXuBis/RAw5CgD/gr7heo5SoafIpUrBweyPjzP2A
         0ebllGBXpDmC4/jh5gxC2b+hf2bczebKE2C0teXloBl5hImRUSNPZN2OeAP5gRIlF5
         bvnS5mc95m+Wg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/13] btrfs: use cond_resched_rwlock_write() during inode eviction
Date:   Mon, 19 Sep 2022 15:06:31 +0100
Message-Id: <03ba3bd984b2ec069ca5b7b7071e91e6df2c933c.1663594828.git.fdmanana@suse.com>
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

At evict_inode_truncate_pages(), instead of manually checking if
rescheduling is needed, then unlock the extent map tree, reschedule and
then write lock again the tree, use the helper cond_resched_rwlock_write()
which does all that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4cb5a00c7533..32755e2977af 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5295,11 +5295,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
 		remove_extent_mapping(map_tree, em);
 		free_extent_map(em);
-		if (need_resched()) {
-			write_unlock(&map_tree->lock);
-			cond_resched();
-			write_lock(&map_tree->lock);
-		}
+		cond_resched_rwlock_write(&map_tree->lock);
 	}
 	write_unlock(&map_tree->lock);
 
-- 
2.35.1

