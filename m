Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07091354E4C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhDFIIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:08:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34809 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbhDFIIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696494; x=1649232494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hibkeTggU1wNs/e18iHznF1h6j9dX3BeOYrY2/mH6AA=;
  b=XKHf9cwcpcUTnKZiLmH7PnXwPH2GLy54eeOHSIDIldRlQ9EtsOi02qhC
   5WMv4vQF9CQv0lAL5gy3Xd5/k82lmUT63Hae2A8k1QK6RW+UL21mZh8RY
   pPGQECfFmGx9EfK7my+smQw7YBeih7jRvyZpJxSmOWjXYiK9BDE9dDwJY
   L/WQQjBlDpSP5u9P2G8YlpNVFiEhtnUPPhMHJ5xDsHAqyN2yC9UlaLbVg
   INouawrJdWTrXlxpHwpIL/j4otEDFxfReeMyDBgObpHLXC60PZJX7kvaD
   CEFQG0EtBnQn/Z+wvBSen4VNt3562WA68CbocCfkM0J4i5zyij4Co575m
   w==;
IronPort-SDR: gUVC/TbdltSROjrD6B1vjb7qNAGCYxqfE7Tri2ic0HbejhCQ6CZ0lcKk/a2B9cuozTbnr3K0P4
 khVyu7Z0kUeo1b1lLcLyOIs5CrXH9+mRcS1TVVqpqx1PqnBVg8noXnGBHRJyY/qA49SdrBvYKZ
 ZsR7iS6n+8jlV3pNpajaK7ANIxoNniwB/Tn+7PcXOZsOfG3thGkR+G7uSjP9v4kV/xw5tL/yj/
 BSjDcGT48t9O5W+4FPxWjQSCKHRtWAjWh2S+thbQO7D3dIRx9Roeg0plG4iCq272uFxN3ZmUkq
 Ik8=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="163733759"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:08:04 +0800
IronPort-SDR: dGq+Mlj7TI+iYNo2DdDgMYSu9Lk1Yb8bJxn+ZuSYOo82BlRZbfQm5vXPdmD+I7V4CaNxbtz0IR
 9q0NiiX0fLd16sCQ1breNJW5uJL/OPwxd1/C0hbsmxo0dlnmhb3pu2xY+cgq6XvkY8wW4HMTIM
 Q6Wk2wCYNrx7jPmKazoi+N/8+UJS4wPTAb2I6xzBXxCLITDZjVbfrVc77aMwT9fPO3sW6BuVSq
 zToxUBFUgVAee01Bp6aqxy2PRBxdPkenqsJnqrcqrHe7DQQDxgTNnK2ZI27NaHzxZwQyRjSm6n
 dkOt0z2rSGGn99CkbUDSP2ex
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:29 -0700
IronPort-SDR: qB8qo+ikWYt+b94hO0Z750BxFoGZY9UpVE2HzTQ+5oh8IQ7odDV4hhvcJizMrLanna6ub7kuut
 umNXR3aQdKBkE5/pUkNfPH2+GiPgIceROJHWN3ZKY6+4PsnPiNVgAXPM53rTxGS99a1G8/BD14
 kIb3KYrUIgUqUFVncYbRdBPgRKX/U9TPipik19l7J5/9LP9OGB02vbUxywkRbtGwDiItIMROeU
 7kfV/Hxbp/oO0ckpaYAvUobDPXfCEmiUm+v6l1qrHYByTY7Rn567lVlzNYFQpLlP634jw7sJed
 66w=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:07:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/12] btrfs-progs: drop alloc_chunk_ctl::stripe_len
Date:   Tue,  6 Apr 2021 17:05:52 +0900
Message-Id: <82254413cb8815ee384550bd306ad0cc3c69fdc6.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit b9444efb6658 ("btrfs-progs: don't pretend RAID56 has a
different stripe length"), alloc_chunk_ctl::stripe_len is always fixed to
BTRFS_STRIPE_LEN. Let's replace alloc_chunk_ctl::stripe_len with
BTRFS_STRIPE_LEN, like in the kernel code.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index d01d825c67ce..280537f6549d 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -159,7 +159,6 @@ struct alloc_chunk_ctl {
 	u64 min_stripe_size;
 	u64 num_bytes;
 	u64 max_chunk_size;
-	int stripe_len;
 	int total_devs;
 	u64 dev_offset;
 };
@@ -1057,7 +1056,6 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 	ctl->calc_size = SZ_8M;
 	ctl->min_stripe_size = SZ_1M;
 	ctl->max_chunk_size = 4 * ctl->calc_size;
-	ctl->stripe_len = BTRFS_STRIPE_LEN;
 	ctl->total_devs = btrfs_super_num_devices(info->super_copy);
 	ctl->dev_offset = 0;
 
@@ -1098,13 +1096,13 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl)
 	if (chunk_size > ctl->max_chunk_size) {
 		ctl->calc_size = ctl->max_chunk_size;
 		ctl->calc_size /= ctl->num_stripes;
-		ctl->calc_size = round_down(ctl->calc_size, ctl->stripe_len);
+		ctl->calc_size = round_down(ctl->calc_size, BTRFS_STRIPE_LEN);
 	}
 	/* we don't want tiny stripes */
 	ctl->calc_size = max_t(u64, ctl->calc_size, ctl->min_stripe_size);
 
 	/* Align to the stripe length */
-	ctl->calc_size = round_down(ctl->calc_size, ctl->stripe_len);
+	ctl->calc_size = round_down(ctl->calc_size, BTRFS_STRIPE_LEN);
 
 	return 0;
 }
@@ -1206,17 +1204,17 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	/* key was set above */
 	btrfs_set_stack_chunk_length(chunk, ctl->num_bytes);
 	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
-	btrfs_set_stack_chunk_stripe_len(chunk, ctl->stripe_len);
+	btrfs_set_stack_chunk_stripe_len(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_type(chunk, ctl->type);
 	btrfs_set_stack_chunk_num_stripes(chunk, ctl->num_stripes);
-	btrfs_set_stack_chunk_io_align(chunk, ctl->stripe_len);
-	btrfs_set_stack_chunk_io_width(chunk, ctl->stripe_len);
+	btrfs_set_stack_chunk_io_align(chunk, BTRFS_STRIPE_LEN);
+	btrfs_set_stack_chunk_io_width(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_sector_size(chunk, info->sectorsize);
 	btrfs_set_stack_chunk_sub_stripes(chunk, ctl->sub_stripes);
 	map->sector_size = info->sectorsize;
-	map->stripe_len = ctl->stripe_len;
-	map->io_align = ctl->stripe_len;
-	map->io_width = ctl->stripe_len;
+	map->stripe_len = BTRFS_STRIPE_LEN;
+	map->io_align = BTRFS_STRIPE_LEN;
+	map->io_width = BTRFS_STRIPE_LEN;
 	map->type = ctl->type;
 	map->num_stripes = ctl->num_stripes;
 	map->sub_stripes = ctl->sub_stripes;
@@ -1369,7 +1367,6 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	ctl.min_stripe_size = num_bytes;
 	ctl.num_bytes = num_bytes;
 	ctl.max_chunk_size = num_bytes;
-	ctl.stripe_len = BTRFS_STRIPE_LEN;
 	ctl.total_devs = btrfs_super_num_devices(info->super_copy);
 	ctl.dev_offset = *start;
 
-- 
2.31.1

