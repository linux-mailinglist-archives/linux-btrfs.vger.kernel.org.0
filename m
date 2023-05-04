Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EE6F6A9A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjEDL70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjEDL7Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:59:24 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988175580
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683201563; x=1714737563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lXfp0KhL9qPgJWW3XoQnt0Ti1q3/2Gs+ZDaIe8Y3y3Q=;
  b=HBKTwxGSsRkGuOx6lQLtm/dK8Q3LlAIiT+yyV3l58T6Q9O64NWs9EwA/
   ZcTkj+bJvf2yULfXR7jheirUBHydMEGj1xueggwYxzDxi8nH3E1CLjzBH
   xhM1q+w7nDXefAXjEb8eInUha/mABeBIs9p7Hiy9uHpg7vzgjjMWV/Mxl
   2tHzsbP2nptFTacRcZuS8L6ZrNGi7swtYVAccMMaLiO4TIz0ukXXYkUrb
   dKldlNbiBSXlGZlVW2ncgX3cdkZjUmAwjSyJy8IJ2ef9Lj7K1hR6A9Ds+
   8V3vC0G9pi4sNllp7nRE6lyNUb7seRY4EUE2EpzVgusDKi4lFdj7K3dTM
   g==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677513600"; 
   d="scan'208";a="234847931"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2023 19:59:21 +0800
IronPort-SDR: X8SaUc9MT5CsoP457WMavwHyBzLOuKfrUJv67oSFbP0BvTvP2SzxiV7Jvau6Z6QHol3NFiQM2t
 iv6n9jLLJcA2FhR2maNpAqAcpi1u4deE/awRGGVX42NL0vlnGc3FpGy7Vy8bdTwR3TJxvVJxx4
 jYf279RoA6h9dFQA+4fTJU8AxvxJj34VBKtpvVAQkwNmuHoioVRfMpZXNRVHhnu34Mw5USI0/P
 tt7PxcLTWz5TolHHne0ZBnXa6FTSjIqqKJ4pFJiSNmAjBTBo1JdqFW/W9X+jis803LU/uflXOu
 kHE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2023 04:14:46 -0700
IronPort-SDR: /zgKlMquKvSFjHvLbZJBigH2moSQYfHi5DrlXNuciH6SWwmrwcjOlx86LjiamFMeu6YlloEvVY
 JtzUxqV5RGQRWKG89YwI74oS9EHy1INM1TXfGKmGten/h8gu1Dysf7KcklTbpUd6YdotQf6l8f
 a0SsVBbHanNYGtYmS4WpVy5Y5bna5hIJKOuyd1AfFWSCn7zPtez/uw2TCKF4ZL+3gFWu1RA/kM
 1iFCgxzGL5HVWXqk5O5K8sdzU3eA5ZHCTHQpGrZKZb4qThisEgIQSkVLTRyggGGEixR/fs4Ieh
 NSI=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 May 2023 04:59:19 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: don't BUG_ON on allocation failure in btrfs_csum_one_bio
Date:   Thu,  4 May 2023 13:58:13 +0200
Message-Id: <20230504115813.15424-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since f8a53bb58ec7 ("btrfs: handle checksum generation in the storage
layer") the failures of btrfs_csum_one_bio() are handled via
bio_end_io().

This means, we can return BLK_STS_RESOURCE from btrfs_csum_one_bio() in
case the allocation of the ordered sums fails.

This also fixes a syzkaller report, where injecting a failure into the
kvzalloc() call results in a BUG_ON().

Reported-by: syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/file-item.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index bda1a4109160..e74b9804bcde 100644
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
2.40.1

