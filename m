Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4A7182C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbjEaNpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbjEaNoU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 09:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E319BA;
        Wed, 31 May 2023 06:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1131C637AA;
        Wed, 31 May 2023 13:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70662C4339C;
        Wed, 31 May 2023 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540550;
        bh=Qvxj74D67uU3ptFtjNBZ01IkRpGiV41YlE4yyitA/3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KsYcA6qM05nAe3ML/wXCb7rsUfwICydVCUMKG1O4A5CxUrdPIyP80v+n7GoxkhpjB
         410mS3c6jktF8d2LaKCJE3Q+52VlxPCvpBxWw3UPZOeJBgdZ9pOQwlTglKAFukpn6j
         Yo5QmFAn3XVcWWK+La1c2YWvDYT+jeFlGDKj2DcvgAf86V6RM7ohOl2rjwRvYiWdty
         aKz4jPLRkq90dTn+9Yn6bfnlfWP5LYxlobGbb632AxSug5BRfXri9CdqMlhPw/CulJ
         UXyiCmpvwtgKOzcVSmqlNnIqslPde2/6r88T7+xQvUlxyf0VgJ6KhffTCNcimgnQ6c
         H0ri1lp95hn/g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        syzbot+d8941552e21eac774778@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/33] btrfs: handle memory allocation failure in btrfs_csum_one_bio
Date:   Wed, 31 May 2023 09:41:43 -0400
Message-Id: <20230531134159.3383703-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
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
index 4fab7da632594..b14d2da9b26d3 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -717,7 +717,9 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
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

