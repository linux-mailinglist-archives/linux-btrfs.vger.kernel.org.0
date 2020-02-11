Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA6159293
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 16:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgBKPKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 10:10:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35881 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgBKPKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 10:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581433833; x=1612969833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/XeVTTpHIzCXQJSJS9W1+Ng69r6dxMzAyfe0uCJwIY=;
  b=ZSwyUodowlAYNHzPaEIiOfZOJWj+geAnBfYOqQzNYTFgUpOaytCSG8Cy
   erzEKhip766jKkynrunqAIrda1kPqhzMnr0MTab+YIXwYC4SRL1cc8koc
   hDPjasj9mpp1dBmwCFIrMN6nEgIRUuj4F5eYg2DnT7QQsRCYsO10q0q3S
   Hn0X3aO26vRNwB8Ry+TyVQ8Yx5/3cfWqFFO//Hpu0CSGkmhGd0bTaZX7Q
   s+nGmXm6EgUUehKQJ19dodDOdak2erEd3ED0LfsQJgMquOLoHa551W05x
   U7oGihwhXHX1/DHmOiR4d32TiNvq+tk537LeIWss1O9OWhxC3pAOmbG0N
   Q==;
IronPort-SDR: 1/olxHnmsHQ012ILmitqg/RtHAYPrxHYZqZ8uWCDr14oFksVoRjoOrGyhD8NuvS6qz997LD0e8
 sng7DY6PdJwSOqjiTXzntICUJtykFHA7v61TNbe8dTNexS95p8+gRDPp/XceNpRyy08E6T66Q/
 NNtEvsGQZwIMUrDLG/ZNatt4IG8s8Q7J8+t08bFTqAQ35Eg3YdWCLyEYbCPNbC5Hb/sO3GEZJD
 d5YW9Cthkr8Y9Oi0xtbMZAItZZTFEZg784fqYTPcaT/ci6vWNMV0gEvKaPgXS76Qb39IAPQnVp
 B/c=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="130128675"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 23:10:32 +0800
IronPort-SDR: o6eAep86Y38TQa3ri1eB+ulkarw2uWjVU6E7mYcQgOUb8lpQ/V1y5lmWSGm2jqf0w554yGdwcV
 CRqzjeNgKwStcPvaN5wAnqrIDnRt9R5NlRuzowm5DdfSXqdHm1lBa48GCr99/mFvnukEUOP+HY
 YOYU5pHs8z/Rquwu2vlBh6BG0a5HmKg2LQoEbiVjc7J/ojiK133qZe0ikJjl4+P3BUks/hlnpx
 2CmxVRYC/+mj4qiKq8c4DJ75tv2Nbp9w4dXwbFPpLhULesIwDJeaDm2bEI2yW5Mwo0rbN96/xz
 Ipde3cFAkNgZvkSVExUMtz+8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 07:03:22 -0800
IronPort-SDR: Sfrk5LRdxva7v1nbzGAIiUFsONxlbnbL+DgWyg6BfrzV2+L80RRrn/GkBWBpW9fOhOqRMoa54Q
 Ocp+ZQ3PS+nMwixY0yr6nQPNrlr0Tg4hskOPBWSlYWBXx9DF6KC5odLNRNIH9fFC/gdM/NhoYa
 YzHmdZisaoJVkWsTEnk3X9hz421eZKQczmAN2DYw0kVgFN3ntNeh3iBLX/dXv3KsvBQpbqiK4o
 qUuacolzKTmjYVM+cHzsEFrRwnmDv0H0S9vst6ZY6a04lTOwCV7bEty8/E+LCEYDkUc6EcEfQI
 NfQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 07:10:32 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/5] btrfs: simplify error handling in __btrfs_write_out_cache()
Date:   Wed, 12 Feb 2020 00:10:22 +0900
Message-Id: <20200211151023.16060-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
References: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The error cleanup gotos in __btrfs_write_out_cache() needlessly jump back
making the code less readable then needed.

Flatten out the labels so no back-jump is necessary and the read flow is
uninterrupted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7d6d6aa7b7d6..705589daeffa 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1366,18 +1366,6 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 
 	return 0;
 
-out:
-	io_ctl->inode = NULL;
-	io_ctl_free(io_ctl);
-	if (ret) {
-		invalidate_inode_pages2(inode->i_mapping);
-		BTRFS_I(inode)->generation = 0;
-	}
-	btrfs_update_inode(trans, root, inode);
-	if (must_iput)
-		iput(inode);
-	return ret;
-
 out_nospc_locked:
 	cleanup_bitmap_list(&bitmap_list);
 	spin_unlock(&ctl->tree_lock);
@@ -1390,7 +1378,17 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
 		up_write(&block_group->data_rwsem);
 
-	goto out;
+out:
+	io_ctl->inode = NULL;
+	io_ctl_free(io_ctl);
+	if (ret) {
+		invalidate_inode_pages2(inode->i_mapping);
+		BTRFS_I(inode)->generation = 0;
+	}
+	btrfs_update_inode(trans, root, inode);
+	if (must_iput)
+		iput(inode);
+	return ret;
 }
 
 int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
-- 
2.16.4

