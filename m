Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD08A16B851
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgBYD5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:20 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34237 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgBYD5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603037; x=1614139037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ixCL4dVUEY7dMteTQlDqJxOzfdZTV36CemBrGbDvYzY=;
  b=LcGo3nos9qqMsT+3DWJsaAA7jg1LXmMZLRSk6TiYkhUeBU8vqhsb0g/n
   KLQJit84xnyutqG83hnRWkl39Umwaah1xbGJdGUHP84ogeX5M+HQ4q0Xr
   4HnH6jzEJaoIMJSkvrVpgyqpdwVDOdrCTNw9/krufnbE5AtpgxAP4qkHp
   n1LkAn7R7vityupXgxiyjiSnlqGfBBiUoDg8gM+vASUzuBLofTQ6yopLo
   RU8OBl54pmiHIFnA+wlvSgbQQ3nK8jbwYs5X/julunoXaxTQERQu9FJg2
   2OM0WWoDTLLXT0gcqjCBZdD3opLLy6tAxfTrH1HZoAca9ilrOf+hDG09w
   g==;
IronPort-SDR: U7E8+EUAlIW+ptikd3CJKanCVwu1tlYLZqSbdGXC1i+2/eXYaLm+xKMHvyhoSwsBqtsF0hOjHT
 +EEKszLETyW8o//6wqpPMoNcGeWRjiHTicg+KKq+r2iOcVou8EfPB7ta4BzlI+pXvNo4IuCcJQ
 mF8RfnrHX1mz+G6rwreIBUqBsmuXsrXxO8Aif8yrsZKhPtPB87HU7CPF4mHnLosrn1j6j3TIe1
 vweYt0BEnSAhEmFK2hugXzARtrI+CzQGEw8sFodaotXd6Ihe1eYxHV+8ENqwdOkzQzafAidP+6
 8Yc=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168307"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:17 +0800
IronPort-SDR: GPH9oS0Z13REenc5DpVzGbcA5qq98IKxIvX+HZDFVFVLiZDUGKl38DTJsaPsrJd63X3HvtDZIx
 01AnUhTbR00hjfDrni3ornJzvJ6F1C0g/mQTUfEOg76JsnvZtRqYgHpoKFv4M829GVfcWxHaoL
 n/0QIS+gxiM/PCjGpzgnN5dN6lqTMHzVMG9vXJu3Ivt/nFwcLaJwuB32EeG+G4K/qn6jHuVMRO
 dRY1YkUPJ2Lr/aaqU026lymzw1VLU8hCXjvKhb4aKTYG4Bo2BdCBiZGI28JgGEEuykfeavzOS7
 1BzLg4PXzkrkYOWMtYhVrHSQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:45 -0800
IronPort-SDR: +/2DpfSQtlqU+vHP87YDcs/k4DRc3fJuVrsdxZj5qNvtuQPD3wnpjzjtZxQIw2ZgJTNhFD/fNf
 jgp+OucnEjKNE+dAOtktzwOmkA4VRWTvGSlyl+4vUpCQ+kKrklVpglYFY+5hhaqVfzGt8iLBQ0
 68LtUMR+9TOUaGsN/QFBt/hHyDC9nN2B8B6v+x2n9+7vN7+eDjQxDDyCttdcXBqVCn8O72pEK7
 9C+hQ84SoL9TgcviEePdHGvlgH7xiRdL22cR3PdreP7sioeZJZKk7O/WhHmYKalqhf+XXkVvFC
 Qr0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:17 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 17/21] btrfs: factor out found_extent()
Date:   Tue, 25 Feb 2020 12:56:22 +0900
Message-Id: <20200225035626.1049501-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out found_extent() from find_free_extent_update_loop(). This
function is called when a proper extent is found and before returning from
find_free_extent().  Hook functions like found_extent_clustered() should
save information for a next allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 76e05ed33f1f..46d0338659d7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3724,6 +3724,30 @@ static void release_block_group(struct btrfs_block_group *block_group,
 	btrfs_release_block_group(block_group, delalloc);
 }
 
+static void found_extent_clustered(struct find_free_extent_ctl *ffe_ctl,
+				   struct btrfs_key *ins)
+{
+	struct btrfs_free_cluster *last_ptr = ffe_ctl->last_ptr;
+
+	if (!ffe_ctl->use_cluster && last_ptr) {
+		spin_lock(&last_ptr->lock);
+		last_ptr->window_start = ins->objectid;
+		spin_unlock(&last_ptr->lock);
+	}
+}
+
+static void found_extent(struct find_free_extent_ctl *ffe_ctl,
+			 struct btrfs_key *ins)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		found_extent_clustered(ffe_ctl, ins);
+		break;
+	default:
+		BUG();
+	}
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3750,11 +3774,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		return 1;
 
 	if (ins->objectid) {
-		if (!use_cluster && last_ptr) {
-			spin_lock(&last_ptr->lock);
-			last_ptr->window_start = ins->objectid;
-			spin_unlock(&last_ptr->lock);
-		}
+		found_extent(ffe_ctl, ins);
 		return 0;
 	}
 
-- 
2.25.1

