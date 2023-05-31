Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA271836A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjEaNvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbjEaNuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 09:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC31BEA;
        Wed, 31 May 2023 06:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35D463703;
        Wed, 31 May 2023 13:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300B1C4339B;
        Wed, 31 May 2023 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540717;
        bh=zLuyDAoDlFV+nZmcBKc3zhRvwWdjtze/tneGOZjD9rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJak3yLZS2Bp/rbF/SCqavbITQB+Jz3hVL2wWPRoozU/3Qt4ewGKYnc2btlaga5s9
         hV7EhcqqJs3YkTWiEKKMgj8DeDUky4aS3ctFQBh2Mic7xpbnPn63wBXlDJfJZYwJCf
         9lFAUAAeMkfZLPAlYf0HsXCSs0pRj1fPgbU4AHAN68Al+jrmfN8eJdI8EALumVVo9o
         w2oQ9x2F8ZuzFJZSoj06jGneZy9vHhMp6Cp6s0kv8x6kvOenmO+9HVM1TPiftLvh8D
         5wxZBGLT0Dlu6pN0k+fVKl0xkUvSNQU4ZDk7OBn1MULj5nbxSID7WvfP73ajmulYhG
         n1JJp3SfV3neg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        syzbot+d8941552e21eac774778@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/17] btrfs: handle memory allocation failure in btrfs_csum_one_bio
Date:   Wed, 31 May 2023 09:44:54 -0400
Message-Id: <20230531134502.3384828-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134502.3384828-1-sashal@kernel.org>
References: <20230531134502.3384828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 806570c0bb7b4847828c22c4934fcf2dc8fc572f ]

Since f8a53bb58ec7 ("btrfs: handle checksum generation in the storage
layer") the failures of btrfs_csum_one_bio() are handled via
bio_end_io().

This means, we can return BLK_STS_RESOURCE from btrfs_csum_one_bio() in
case the allocation of the ordered sums fails.

This also fixes a syzkaller report, where injecting a failure into the
kvzalloc() call results in a BUG_ON().

Reported-by: syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file-item.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 61b82c69eed50..1a7183cdfe950 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -499,7 +499,9 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 				sums = kvzalloc(btrfs_ordered_sum_size(fs_info,
 						      bytes_left), GFP_KERNEL);
 				memalloc_nofs_restore(nofs_flag);
-				BUG_ON(!sums); /* -ENOMEM */
+				if (!sums)
+					return BLK_STS_RESOURCE;
+
 				sums->len = bytes_left;
 				ordered = btrfs_lookup_ordered_extent(inode,
 								offset);
-- 
2.39.2

