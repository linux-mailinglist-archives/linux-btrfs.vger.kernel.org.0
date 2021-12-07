Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FCF46BDB8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhLGOdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:33:00 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19470 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbhLGOcQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 09:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638887326; x=1670423326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GostnQnsy4OKQf0BXPwtK9WawOfLpYRmdOzpEYta01Q=;
  b=TTTsKJlioeu8pMVIBrcQOfoSad3CbYZo6gzbgl2izeyGoT8viaKR4K1p
   jSdCjbHcOCGbFs+Ro+veWIQndm1wvpjiTyi15Sylwumr2xYxTSFZ9sNqJ
   /liYXHmnfpJd9UC2Vs5rRzHVo4JYrMLTdUmOZRJdvbTP3spG9Iu8nM0kJ
   oUoxfsWSg7db3b4FGxWXC9HB/MjiPNoz6ynjHfI14fmlKKVWRKpnd+SIW
   la2rgwxKNSy1BRtZi6KJQTq7wgZPm9utLaDS1CG3bD8YA2iBT4DsuEmKP
   JRIoeSevjk8GhvVJyy3NYX0s5oXVS7N2vA0bTf79GciD7TjlOE0Fyvljx
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="299501480"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 22:28:46 +0800
IronPort-SDR: MG2x06jypUuRUSlLgMiBEcjVaotU065iEgYVQ8zViO5W+4RQsr5tW0W4HrCh5F58GlEabqcn8U
 8Op2t1veVdLyKO9Tyom7DFM1rw9os8ZqVIjqG6Pc8PZCzB3zmnwhCU1ZtBy9pIxUE1ynZZNmjV
 6P2XGOy+BhVf0zSz82LTvZyB/EHFbBJ+IZO8B508+jS+cxIaCVOXuy6uJu3+vO26bAlBZ00roI
 tmcOq5na3u7O1ptFo6WS4Rd8xe5gjIUoLfsMM2T3PndpBd5+uZ1Vq/mz6xJy3RWm2skgecDjsZ
 /E9jn8Sx+ZoNOxke/Mmtshxe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:01:51 -0800
IronPort-SDR: 5WnuQuqOkm5dXXBrI6J1xOngIOkVvk4X4M/noLc1bxCjppEuiWlJsS707XR8i7QkQ3CmnHUUnI
 /KAV4lIK5hfdtcv59CIYpBw+MqK6tdcZLVhs3CkV5GkKl6X1E8RnmrOrm67/yVUMmSkObrYFRW
 bo21V6uC6v3QiHVCiX8sly1+bsRwqtGoTmF36tv7P0zYgRxpNkx7ugnEKKkRakYOW7Ogs24A5H
 bn5mT+/QnR63Qdbe/ug3/rrXCSTz8aDNcBVZkIIu7Bf8fiBHGAXnvXgyZCCYP2KkSea6HMW3fG
 cDY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 06:28:46 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 4/4] btrfs: zoned: it's pointless to check for REQ_OP_ZONE_APPEND and btrfs_is_zoned
Date:   Tue,  7 Dec 2021 06:28:37 -0800
Message-Id: <6e0e8382cbc22b8fc9c3c9210d4fb1b910b31c5f.1638886948.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638886948.git.johannes.thumshirn@wdc.com>
References: <cover.1638886948.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

REQ_OP_ZONE_APPEND can only work on zoned devices, so it is redundant to
check if the filesystem is zoned when REQ_OP_ZONE_APPEND is set as the
bio's bio_op.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5a7350145cc3..4f70d6d2ce70 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3283,8 +3283,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	else
 		bio_ctrl->len_to_stripe_boundary = (u32)geom.len;
 
-	if (!btrfs_is_zoned(fs_info) ||
-	    bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
+	if (bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
 		bio_ctrl->len_to_oe_boundary = U32_MAX;
 		return 0;
 	}
@@ -3339,7 +3338,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 		bio_set_dev(bio, bdev);
 		wbc_init_bio(wbc, bio);
 	}
-	if (btrfs_is_zoned(fs_info) && bio_op(bio) == REQ_OP_ZONE_APPEND) {
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		struct btrfs_device *device;
 
 		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
-- 
2.31.1

