Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B93616B850
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgBYD5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:19 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34233 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgBYD5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603037; x=1614139037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nc1KMUIXBP1u4BIelQu8vLGgpaHwULi+6lmDWLNOIb4=;
  b=ICxVAsT9b/9k3Iw8cI83gPx08mQh8mrCoQkOOKFsZafDW4LOOFUSBo4H
   z3YMRTjl54y0AUsseUaI964ylPyWYNsMdGztWZ0Vi3YXw16I9S3Jn75vV
   48hT8IH3ixyZ/QbUAiHt4WaeNcoqJvwJvoA6xahgL2eoIsttYxFhQoOXs
   D3fxGWPyXIgj2ZTBxgDwpZaEAmEFkgrmsnONAd8U8bhwQPmqXv5C5SXVX
   R9VJdz6icrnD1QxXyRFQbEzyOAduM5QHAGg8epruz8pCrC1QSiOWnmbYD
   ltUODUHuB1C1uKdjtUm4zOS1hNQ1JiOgmD2wJhs1Zs+GhIyXXFfPr3nqg
   A==;
IronPort-SDR: 6Na8bBhhne928wWw6Ugvo3YEvxNfjAsZJmhA44WRGhGW/+vb66jtrG6zxsZLaTZYtcXCjQvH6E
 /9Vle+ARvKCG986aDKmRZwCRCl8KPBAi9ubDh4bz6uV/1CP8KmhEuUJwxCgML16jL3BMJKz2G3
 MUYZbq7qRVdzanCSYXSgsXuFR0a5b4OT8Egx13utwpj6ie1KkswaRtOjFjNgcfdkmKMsYbeaS+
 YXzCaswXZ+yZg9cRXCMJAEolH2nMSA1BTsiVOp55IiNuJ2jqDXRGlL5BrZmWhpFIe0JXFPMvO6
 JuQ=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168303"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:16 +0800
IronPort-SDR: 0RyhmNCsIq8cmYE3rmu4Z5WKucfgKZNR9vMhraclS3POrp6bPWYpzQWj6gBjVDv5zn207PSpQq
 YHIkELwt3nqdCgJu195dZnAV+jJ+dyUiYgK8vSQ/EqihxUOEziyW0BDxvyqVrpjpzCF0xrpRZo
 jtRdi8L8Z/n9hKBTkWQNQJUl6zIKv3qGcycr3QS5i8EZrLguvvRDlLPw0tewe8qcvYPmmwaYck
 q9WX+1Ru6bSzzD2LzCnTgF/20UgmAD1y0wt27eI+xGLY9GUn7glP/mDgIKTzXcGcZ4TgfeigAK
 Y1b1xNbNBR2zT1NG5Zeq6RbB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:44 -0800
IronPort-SDR: xneidgKyQHH2ArnQKzLTHZz67/h3YjpiXZ0u9HwdjPBdJuBiHzq7hAlwUjiqaMrCDh+TXDPea/
 z1zDRJTUAkOfbs9Y3d+4BbjL3gGGcR1WsXgpy1je53uI2K4l+wgX2JYBYt7W6n70exnywOTL14
 N6qM0R225Pk862XwUW0183/NHNi5sIHEN5qwI/c37HgFsMsRJMTbgBFfdsyuLtuUQBqWxzabic
 mSrrnTRzwpF9FBGx71v4d8eowMbRqbAo+5j3wK4ga1FwFEGiQ17GNA1OSaR7DEXsJ1l7xjHBYr
 jfo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:15 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 16/21] btrfs: factor out release_block_group()
Date:   Tue, 25 Feb 2020 12:56:21 +0900
Message-Id: <20200225035626.1049501-17-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out release_block_group() from find_free_extent(). This function is
called when it gives up an allocation from a block group. Each allocation
policy should reset their information for an allocation in the next block
group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1c0c94a2a8e0..76e05ed33f1f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3706,6 +3706,24 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	}
 }
 
+static void release_block_group(struct btrfs_block_group *block_group,
+				struct find_free_extent_ctl *ffe_ctl,
+				int delalloc)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		ffe_ctl->retry_clustered = false;
+		ffe_ctl->retry_unclustered = false;
+		break;
+	default:
+		BUG();
+	}
+
+	BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
+		ffe_ctl->index);
+	btrfs_release_block_group(block_group, delalloc);
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -4083,11 +4101,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		btrfs_release_block_group(block_group, delalloc);
 		break;
 loop:
-		ffe_ctl.retry_clustered = false;
-		ffe_ctl.retry_unclustered = false;
-		BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
-		       ffe_ctl.index);
-		btrfs_release_block_group(block_group, delalloc);
+		release_block_group(block_group, &ffe_ctl, delalloc);
 		cond_resched();
 	}
 	up_read(&space_info->groups_sem);
-- 
2.25.1

