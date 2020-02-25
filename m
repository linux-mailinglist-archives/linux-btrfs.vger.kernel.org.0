Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6816B84C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgBYD5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:15 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgBYD5N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603033; x=1614139033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0X2I6mNARdubB8ebF8WxvZdHBmncnPsrup3zWZuyh4=;
  b=W3H4n7U78yXPq523d6gBZpmBLCX2y0ILl3KtGCi2mHzE/Lg3onQfTDP4
   IYgvczhGuCVQ3+zloOt/dBfdnbB0TeAurfSNVV50wdC5ZcxtzjQnu+Wu1
   thjuQsXb9YubKbPR6PhAoCoah9pvMuLTPsJNHojImFxtnN+oX4emsLuqH
   tPiVfp2XeXuXk0nMbbS/AtghgoCnqaXDK+FTBMcqeyb1wfsGW6Nj/3qK8
   6YTGObzGxgvCMaj7zJkETQ2qhunvifT7++lzdTdki9cc0HyTrhq6YRc4x
   2aqxsGEl2oFh4YXU4ulwyXhc7fOqvJWJIhiE7N/e/3AyPDz4+bwXycCDn
   Q==;
IronPort-SDR: ZrCfKVRyXUdzYvoiNgx6piMZqKkPfl4Ho/7HcEGW3k13swJDwgqAAasksmZjUkL/ulPQu6oZuv
 pubSoiKJxtCCOJkoURcrRdN30n9NrlOG2TKSqgnfr7HEIJ52UFYtQJqURYWJPRuUfILzfUw9w8
 8dSx+J1IGCCCQuGzB5Vrw/kYWTDyaIgRB0n2ybypbeBO5WQVD7s6hXF2RUEI2FXq+WfZntwfi/
 cfB8dTT3fQTE1Ay6mUE6uj//GXQCRhWQvAoOBQJ6737s+e2eZDLdDrhh+MdF3c/KaZY5cVZqp9
 ehw=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168291"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:09 +0800
IronPort-SDR: YZFbmZAHJH6t/iNN2FEbsh0QPIZ+ZzuFPFmhqIkYZPINbEPV0VfKif8GmiwFvCfuDyy58I9oMm
 9/zygxMdLIB+EoFtOjAg1HAw/QLBD7479DeQvf7NbeDkVCvS/frLayywwal44skIiaRBrb+XAn
 nQnGV0tnvB4Nph9dyYfOwYPi0gsSSwY0BOfChq7HQutKF78aYStsRD64NhkNESjrvS1MdrqVrf
 6nmJyi3TTpe91hA652LEiraG1A14zBqL1ScRv1j0kguoc1nEBJXQLrgJig52Yae63Pl9xhDCIF
 ihBKxO6m4KQMCto7k8tWkt1Y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:37 -0800
IronPort-SDR: 8rfZb1n1ntXVSwar8jZBKReg3qkv7kMDukPl6N1N3rHp0/0LRkr/VAZmLHsQI3WeSiM6fpskI9
 g46RQKFE/jf19J5S1pfCi17Qe4cCO85XELquAVSztG0o+pU1LNygf8OWys3Sy4EGCOjMwymJHQ
 slpN2hlp+NzQeVRyzyqVG7TTcGhxvQd4mN2Y91vak5SFAiVI0lPP+R+LfHmnJ20Y7ZTe78/AYL
 OYgXEP/TX2duYOwywnSPf/D/LtgZEYo+gimzHffn1iOSL/IfXHz3tZDQ15/Suzy2xiPS3TlzCL
 hXo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:09 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 11/21] btrfs: introduce extent allocation policy
Date:   Tue, 25 Feb 2020 12:56:16 +0900
Message-Id: <20200225035626.1049501-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit introduces extent allocation policy for btrfs. This policy
controls how btrfs allocate an extents from block groups.

There is no functional change introduced with this commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ed646a13956d..edc72e768119 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3438,6 +3438,10 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 	btrfs_put_block_group(cache);
 }
 
+enum btrfs_extent_allocation_policy {
+	BTRFS_EXTENT_ALLOC_CLUSTERED,
+};
+
 /*
  * Structure used internally for find_free_extent() function.  Wraps needed
  * parameters.
@@ -3489,6 +3493,9 @@ struct find_free_extent_ctl {
 
 	/* Found result */
 	u64 found_offset;
+
+	/* Allocation policy */
+	enum btrfs_extent_allocation_policy policy;
 };
 
 
@@ -3826,6 +3833,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.have_caching_bg = false;
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
+	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
-- 
2.25.1

