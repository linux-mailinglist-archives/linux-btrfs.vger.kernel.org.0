Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6186FB4BB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjEHQIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHQIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5A5243
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mk/eYF4kiK8qAMs5oBu1V5rGk5eSTdx1+ACao+nM2FQ=; b=qXWOxAkp3hh7ynVcVhAurMWqoc
        yIeJkZpE4YLerYuwXJjGv5r65FdsQ7COagcKKsH/D1IilABTl36Gytjd8hi0PhAOJaOFcgFAXLdF9
        Bpu4/+0wAj5RaeQclPwvnp2HlhLaInWwY4TMJnzXlJ1KBccV1ngKQ18KNtSz1R32HJRFUkj8JdY8g
        ehPvWiiOhblxqOT84JQiInRh5vgCU4G6LdNWwtAmelrpSqrfMdifUNQPGzui0jsoV6xpHoOPiqwTY
        Rd8tsDEqeZueEdUILUyk9nb4QJh18gAyfckBLxEfZZHFMLN8Y7g7Xhc40b86NU7ZMsU13DEua8MPx
        vgK2KQeg==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Po-000vz3-1O;
        Mon, 08 May 2023 16:08:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        syzbot+d8941552e21eac774778@syzkaller.appspotmail.com,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 01/21] btrfs: don't BUG_ON on allocation failure in btrfs_csum_one_bio
Date:   Mon,  8 May 2023 09:08:23 -0700
Message-Id: <20230508160843.133013-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Since f8a53bb58ec7 ("btrfs: handle checksum generation in the storage
layer") the failures of btrfs_csum_one_bio() are handled via
bio_end_io().

This means, we can return BLK_STS_RESOURCE from btrfs_csum_one_bio() in
case the allocation of the ordered sums fails.

This also fixes a syzkaller report, where injecting a failure into the
kvzalloc() call results in a BUG_ON().

Reported-by: syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/file-item.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index bda1a41091601f..e74b9804bcdec8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -792,7 +792,9 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
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

