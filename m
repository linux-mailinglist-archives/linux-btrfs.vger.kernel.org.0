Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36F445B773
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhKXJeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:09 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746259; x=1669282259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ba1cYXeJ5eNvMFKRNhE4V7FpScaXD3HUwsG3d9Zvg8k=;
  b=fTRs4uYLzRpjLXHuDHXAFnxEv2tr0gYo2PU51ukEmflznCFnzQRcbwHW
   onXoFLMOoEDYVyS0pJDTG9bstvSeNcHfT4IRw5scikfegMNGkhLqvKDdu
   s66d8zYayjaGbbPzC4l/zw7db2AMrf2SC92dV8ZGr9hDTWISmX2nQqM31
   6fVvsuH1yhnPRvtnG1b6UsmgSxis+2L5Nmmo7SENw72I8netZogvx2iy+
   TdNRHLkM97mOBJpZVUwvOCQoVQiY92ARqungjg3XklRYQR7KNQWRn4qAi
   kQAWgOOPNFiZ3CvtCx6FB7/v/w1p5hpYewrzJotkRLWsEcj5JuSVdPexL
   w==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499361"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:30:59 +0800
IronPort-SDR: QL3hBgZZHceiRjNx8+kem9EOaaoVcclLVMdyARtzFEOBh3sI8YUgskwSKE+1HyatshVr5yzgx3
 TiyQSO/gq9Gv++H4NwYn/B2A0aZml11dXLauC+YG6zFxRHLpzNnCDWcJcyLHUv6reXQ027n2/W
 +kUAsADXX0wa1G73hP8fCuax4CeQFZzSGMVQVEIdXZmh4ryCu+IJ3k8sgpDEOqlBfx3bCc0KaC
 CqRafjt692GOXZ3ZVsd+p58ns8XOohai4JZ64MbwRxJCzPk5C19tjbkFMS0egE+NCsjv8jFi5q
 psvSVk7OqQM44aqKcVhOoWHE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:52 -0800
IronPort-SDR: NfN0awGI2Sir1TwT++cXkeL7vTZldSOxR8ZK3qI9SQz3IeOImFTpBgcWBsdgXQARo1dxCat+EQ
 D4piMedvI76HEDbJ/ghSBbKs6cxC8dpqEagRQfKzvdp4Kh4l+12vvlyVneKsBaCUPNQtw9WYhM
 5s2m5dguBEPGuYrFmCJjhA5w1oa/6MW9W45AQRyK1zelUoDUPgOfqHMWcyqnO6ZzVNl5/mhUpu
 ZDh0AdxpY6cRdAQ2/KYws2BdDfpIZnKKewSlzavI1lran1/PRdSsdQxXumk98zbYXnnDoa3pKV
 KSc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:30:59 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 04/21] btrfs: zoned: it's pointless to check for REQ_OP_ZONE_APPEND and btrfs_is_zoned
Date:   Wed, 24 Nov 2021 01:30:30 -0800
Message-Id: <2a77d18e249ace733422771b05d48a883c4e5b07.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

REQ_OP_ZONE_APPEND can only work on zoned devices, so it is redundant to
check if the filesystem is zoned when REQ_OP_ZONE_APPEND is set as the
bio's bio_op.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 96c2e40887772..d5eb31306c448 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3282,8 +3282,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	else
 		bio_ctrl->len_to_stripe_boundary = (u32)geom.len;
 
-	if (!btrfs_is_zoned(fs_info) ||
-	    bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
+	if (bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
 		bio_ctrl->len_to_oe_boundary = U32_MAX;
 		return 0;
 	}
@@ -3338,7 +3337,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 		bio_set_dev(bio, bdev);
 		wbc_init_bio(wbc, bio);
 	}
-	if (btrfs_is_zoned(fs_info) && bio_op(bio) == REQ_OP_ZONE_APPEND) {
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		struct btrfs_device *device;
 
 		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
-- 
2.31.1

