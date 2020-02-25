Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A6716B848
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgBYD5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34231 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgBYD5M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603031; x=1614139031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJTSQ1c89aup4pa+F8rEF7dY+Ra69cRKtlf1ymhuCeY=;
  b=rzTkLNXwGGLxgh7jpPlrJ1TSMMo2MERs2D7W0e7Nzh9ogW6XsZC+dore
   uPyK8pmf3KP4fiMz5tDG9PI0bKdZdzY0MnSB1wfWYhY8XONq1Dm6Vd9Bv
   WCYNJM7gxq4/q0IK3IHCM6zANe6MPcxn6JDlxDxjGZ2H4PrbhdzbkQXLu
   w0ycZEktpMnhwsynwuC6dLxSEqY4Amrs55tKukcS5AEWsvbQE+hohp3wq
   tZixFw93Q+g946F/OSVD3UaG7FRzmtbUhJ/EoGj7ijpCuHrj9LqeNODR/
   TwJae5i4s0v4gtCwdfl38Aqp+NzxnmDv7OYUg/eKF9sfHcYwLkrlPEseS
   A==;
IronPort-SDR: oF6oLSuwua4QWYkFvae92F/qzNnvhoPNN/NkoXlrHueydwNum0MYEIj8Fs7ymTVJSLYnoHyP8t
 buHbr6KeP3Herv9hUgI2fpPzssQMYMGNYe+ydZknbiZ3dmBOTMS3O12l5o+42jRk0tbBD0RCNi
 JnLY+NCzqLtsHCr9f5lbVUgZ2vQEkzjl0U33l96FLI0zvwVcXt4tqQcYlEfQ5CaDhrxcjpmHTs
 uvtCc5ytcICXoqFLU6iBywWqPlcWjmC+Ku+fMohhYbIgvtjeINS3UUblMncApuccNU8ZlRYA44
 boE=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168285"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:05 +0800
IronPort-SDR: 0WZ41MwDPiEr3ku5ikxTew868HjOrRp26nhw8MD3v0yNFjHwrwlD28WkAtYJAClQZd+m+8Wse6
 hIeS3hUPZizPH7NQ1heof7U5GzSzjsBOhm9MTbgsOuSPf8Quzpt1iwgGRWBVLomS1H83bWmjYj
 fXSFaw04IVRCDqPfMApckf2uta0g8z82JK1i37bX7L47h9C5p5KViQjkM55p7KgZwXthNrAPLy
 LidTs1PRAewB7w1qPmuN/RMNH3xvLBIDwP6nE/rB9ef+pt4g/y0S5Ff1JPKa5+D14/UKBRN1ps
 zTZ9g24gGsSn/bE0yr1WZ6oH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:33 -0800
IronPort-SDR: i2WMMgh6Anx/RwUa5qKxxAZs6RB17B+SylMx3thr6av9hxTn6mM30uZRyCZwni/pHm8h+grUdh
 PMtxshYb9UoJ1GF9PHGKEuYCieIqHHnV9ffuVp/hGVLtR1oQl9yHQs3xw36aUzpDCbkr4tV7dV
 r/1zcrFlJrMpH/155tFhNqiOrxaZLghuzrEFcZiIaW2nHuOFXwPx9ayeZAz6UReonXh3pgaQ+u
 kt5y0bVOEuUE1DeLcGo03f40kOiWtvFPYbN8S8VAix4KB6WUj/YczvHrt5RA45NFfstoQ8+URq
 FN4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:05 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 08/21] btrfs: factor out decide_stripe_size()
Date:   Tue, 25 Feb 2020 12:56:13 +0900
Message-Id: <20200225035626.1049501-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out decide_stripe_size() from __btrfs_alloc_chunk(). This function
calculates the actual stripe size to allocate. decide_stripe_size() handles
the common case to round down the 'ndevs' to 'devs_increment' and check the
upper and lower limitation of 'ndevs'. decide_stripe_size_regular() decides
the size of a stripe and the size of a chunk. The policy is to maximize the
number of stripes.

This commit has no functional changes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 138 ++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cd3a46a803d8..fe194bc0bce3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4974,6 +4974,84 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	return 0;
 }
 
+static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
+				      struct btrfs_device_info *devices_info)
+{
+	int data_stripes;	/* number of stripes that count for
+				   block group size */
+
+	/*
+	 * The primary goal is to maximize the number of stripes, so use as
+	 * many devices as possible, even if the stripes are not maximum sized.
+	 *
+	 * The DUP profile stores more than one stripe per device, the
+	 * max_avail is the total size so we have to adjust.
+	 */
+	ctl->stripe_size = div_u64(devices_info[ctl->ndevs - 1].max_avail,
+				   ctl->dev_stripes);
+	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
+
+	/*
+	 * this will have to be fixed for RAID1 and RAID10 over
+	 * more drives
+	 */
+	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
+
+	/*
+	 * Use the number of data stripes to figure out how big this chunk
+	 * is really going to be in terms of logical address space,
+	 * and compare that answer with the max chunk size. If it's higher,
+	 * we try to reduce stripe_size.
+	 */
+	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
+		/*
+		 * Reduce stripe_size, round it up to a 16MB boundary again and
+		 * then use it, unless it ends up being even bigger than the
+		 * previous value we had already.
+		 */
+		ctl->stripe_size = min(round_up(div_u64(ctl->max_chunk_size,
+							data_stripes), SZ_16M),
+				       ctl->stripe_size);
+	}
+
+	/* align to BTRFS_STRIPE_LEN */
+	ctl->stripe_size = round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
+	ctl->chunk_size = ctl->stripe_size * data_stripes;
+
+	return 0;
+}
+
+static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
+			      struct alloc_chunk_ctl *ctl,
+			      struct btrfs_device_info *devices_info)
+{
+	struct btrfs_fs_info *info = fs_devices->fs_info;
+
+	/*
+	 * Round down to number of usable stripes, devs_increment can be any
+	 * number so we can't use round_down()
+	 */
+	ctl->ndevs -= ctl->ndevs % ctl->devs_increment;
+
+	if (ctl->ndevs < ctl->devs_min) {
+		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
+			btrfs_debug(info,
+	"%s: not enough devices with free space: have=%d minimum required=%d",
+				    __func__, ctl->ndevs, ctl->devs_min);
+		}
+		return -ENOSPC;
+	}
+
+	ctl->ndevs = min(ctl->ndevs, ctl->devs_max);
+
+	switch (fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		return decide_stripe_size_regular(ctl, devices_info);
+	default:
+		BUG();
+	}
+}
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -4984,8 +5062,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	struct extent_map *em;
 	struct btrfs_device_info *devices_info = NULL;
 	struct alloc_chunk_ctl ctl;
-	int data_stripes;	/* number of stripes that count for
-				   block group size */
 	int ret;
 	int i;
 	int j;
@@ -5020,61 +5096,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		goto error;
 
-	/*
-	 * Round down to number of usable stripes, devs_increment can be any
-	 * number so we can't use round_down()
-	 */
-	ctl.ndevs -= ctl.ndevs % ctl.devs_increment;
-
-	if (ctl.ndevs < ctl.devs_min) {
-		ret = -ENOSPC;
-		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
-			btrfs_debug(info,
-	"%s: not enough devices with free space: have=%d minimum required=%d",
-				    __func__, ctl.ndevs, ctl.devs_min);
-		}
+	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
+	if (ret < 0)
 		goto error;
-	}
-
-	ctl.ndevs = min(ctl.ndevs, ctl.devs_max);
-
-	/*
-	 * The primary goal is to maximize the number of stripes, so use as
-	 * many devices as possible, even if the stripes are not maximum sized.
-	 *
-	 * The DUP profile stores more than one stripe per device, the
-	 * max_avail is the total size so we have to adjust.
-	 */
-	ctl.stripe_size = div_u64(devices_info[ctl.ndevs - 1].max_avail,
-				   ctl.dev_stripes);
-	ctl.num_stripes = ctl.ndevs * ctl.dev_stripes;
-
-	/*
-	 * this will have to be fixed for RAID1 and RAID10 over
-	 * more drives
-	 */
-	data_stripes = (ctl.num_stripes - ctl.nparity) / ctl.ncopies;
-
-	/*
-	 * Use the number of data stripes to figure out how big this chunk
-	 * is really going to be in terms of logical address space,
-	 * and compare that answer with the max chunk size. If it's higher,
-	 * we try to reduce stripe_size.
-	 */
-	if (ctl.stripe_size * data_stripes > ctl.max_chunk_size) {
-		/*
-		 * Reduce stripe_size, round it up to a 16MB boundary again and
-		 * then use it, unless it ends up being even bigger than the
-		 * previous value we had already.
-		 */
-		ctl.stripe_size =
-			min(round_up(div_u64(ctl.max_chunk_size, data_stripes),
-				     SZ_16M),
-			    ctl.stripe_size);
-	}
-
-	/* align to BTRFS_STRIPE_LEN */
-	ctl.stripe_size = round_down(ctl.stripe_size, BTRFS_STRIPE_LEN);
 
 	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
 	if (!map) {
@@ -5098,8 +5122,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	map->type = type;
 	map->sub_stripes = ctl.sub_stripes;
 
-	ctl.chunk_size = ctl.stripe_size * data_stripes;
-
 	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
 
 	em = alloc_extent_map();
-- 
2.25.1

