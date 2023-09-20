Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4F7A7791
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjITJbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjITJbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 05:31:36 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC19E;
        Wed, 20 Sep 2023 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695202288; x=1726738288;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Hnjzezp2fhqydMZOcBzR8oKxJ5u8Yy9ISCL0cTZzX5o=;
  b=iB9NVYj/dpPkRweoO4q50cM40QWV0/MOsIEfEyyo1HfcWzyppNshXq0d
   TtiX/E7YGIvWw3D8SjX1vah61Oq8ZRkFlMYsICpF/yvIhHIXwnOjyLnp2
   zZkUEEoKv2X3sLFi+q16Zep5r54MtetgNTtZEPrviyNcWp9D8zYBYU+Gm
   +PHZ3IcOd17YK4JyLXZkgmQa9jDbdB2/t8E8km7ojUpsNz+AleHDqlZcO
   5Q9jJS9QSHlB4aCAC4fiINNW2mse/QNqVCn/fITOQHzCqxXZ3urmBA88t
   WsCs+HTohzknHHE4cQlYXPxUhyjbpxrEwZQijb06pxNao36ro9xLTXplk
   Q==;
X-CSE-ConnectionGUID: 4U+KZZ4JRZS7PZ8tU51X1A==
X-CSE-MsgGUID: 20i6vmMETIibjPe+K3RQEQ==
X-IronPort-AV: E=Sophos;i="6.02,161,1688400000"; 
   d="scan'208";a="356502796"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2023 17:31:28 +0800
IronPort-SDR: /ys7wBpBTDRF2Pd17lneblwKAEcv7qa/vcsTOco8HAo3rei22gfRXDIn8n1JWbyDhumAaUMSXZ
 vX5uQAwq2SCF8iEs1lo/ct/B4OONgFwhfLnzb5d0YSMe/ocAzQUcTni2tLMDvTVRoXJyAVRU6g
 zYM4xbIo7398bFLI7LkPkvPCjn0jFCv6IcVLhxxCD58OAlLR11/gl8CFZCu6XCRwO1AjSXHaup
 l2dNahZuU7Ccqkao2HtmuOwG9R2/YmqPwrxlSFVpJDpGlWsVqhCVsj3L2e2km0w23h6wRWCjo6
 U1E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:44:03 -0700
IronPort-SDR: tGZGxxAMW43F6N9Hwidex4Ifta9k1yNSskBTBc9ZcwZp9Ic+25m7MD5PEWD5SJzKZ2OBhAz0vb
 orp4HFY3kfSQkATk/LSZbgN4sH0+iRJ9tHJF4lLaHm5HkPF6T9Wq81neLJIvNT3WK65f4XDcWf
 gahTmJUaYxF0S8ldlb11gLF41oXe5R+eHiQwwnfWh6uIBjxDet+M3tXLgD4QIghW/Iu54p9i4y
 Vj84aigZyHdRxESgRx0SrJNC7lmEYjysDKWig20jKp81hTpIxx9Af2aNr2mV6jtSYU6dOmSAqp
 s3g=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Sep 2023 02:31:28 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 20 Sep 2023 02:31:17 -0700
Subject: [PATCH v2 1/2] btrfs: check for incompat bit in
 btrfs_insert_raid_extent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-rst-updates-v2-1-b4dc154a648f@wdc.com>
References: <20230920-rst-updates-v2-0-b4dc154a648f@wdc.com>
In-Reply-To: <20230920-rst-updates-v2-0-b4dc154a648f@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695202286; l=659;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Hnjzezp2fhqydMZOcBzR8oKxJ5u8Yy9ISCL0cTZzX5o=;
 b=eH7CUlHMFoPLYaKP0YJBGfjuWggoBkwtSXhNt7zD48qz+n4wEZFcOsxinUd8KOFieIk2c/VAN
 lu4Rujn7NYUAD7R5/N9xc1DAsbPYsZn0LK4rZY+4kykFcexz6/g9q9J
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 5e8afe662ed1..7b968eaf9e58 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -263,7 +263,7 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 	u64 map_type;
 	int ret;
 
-	if (!trans->fs_info->stripe_root)
+	if (!btrfs_fs_incompat(trans->fs_info, RAID_STRIPE_TREE))
 		return 0;
 
 	map_type = list_first_entry(&ordered_extent->bioc_list, typeof(*bioc),

-- 
2.41.0

