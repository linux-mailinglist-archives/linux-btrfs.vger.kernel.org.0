Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC216B84F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgBYD5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:18 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34237 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgBYD5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603037; x=1614139037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WszfEOyJxfwxKdrqWiMsACV0CNVMVid1fA7DXhfQYxA=;
  b=IBj5M84cN8G7p43p0GUs9tZOtImj/JO+InmicYASiMbHaYjF8MlBcFWT
   DfY+zQZ4rIoGyCb9wxWzjw9dKWRJOc8MDdtQ3V+lOq8tjlGdV+WySqIAP
   WlhYxh72//b63Sjrd3k5P7dhO3ombG7Bl5Js6+YyJHtzvLHZ9FLH0G0Ge
   Pl2cuCnCh2zzoD58E7lJemzC5beGoV5TN3adIqHJ9luHknAFbUg6/hKm0
   g615NaITx0Q2xsmCKkjqe5r69fWeU97VqjJ5Ic+LnZ92aXc4CodRMaVKm
   BU3A6ZcfDrFZL9Zr2wwzEi9todN8416IpMF/RKdiG6x2LpKir/BUwLtrQ
   Q==;
IronPort-SDR: N2rrXzvxgrEUZDfruhnOhjH940tC2YF85UbrjhNP6BPmEE5ex3kIPzuJBiarKuxCAhSeW7iD1F
 68OT5gX4Hu5QM1kFH/Qpgy8CCeGPucnPMSJVQKLPQCmnFhaMKW5sEyUXKx1ziBrCQkmDXZhiWV
 zPr90HvbluWbeI/WrWH5POqdrFPxNo22YUCxknH0XffkaL1Bi4+RhJchK8/59oh6WyLiJJ5lOG
 LdatseH8GiuFfKlQ/3CYoyewafKBbz5m4XkJ8RmwsGKTOlGafLSAJmrCZFflPGu1tZHle6uIrW
 hYA=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168302"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:15 +0800
IronPort-SDR: zj4TSWMaohhnupbpCZZNerFfrL4N9llyBeV3oEHWA+o1wKMNOWav7eZaBwtfK8K4+flA5HVtMT
 6i+e7U4gap8qBapbUhKtBnuxasKZ2gmWxZzY8x0HSP7qh1H55lU3WzjORlLl3CybDXO+f02tmv
 qBZH8rt9DP9FVLSAyCrHE6GhV0bheu99TS12d3SLeXeUaI0y05DwHLxrv+1OdOo2IUiHwUeACY
 LlEVTYjB0PexzUaoD4ht5W9JPKzWgbcSFe4+F3tDN4GTTiRbOpfl2eWegiN2GyFO+qtOrP0rB7
 jSfSdmrgF8v2UGbDhBMbPRHa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:43 -0800
IronPort-SDR: yVgXqp+UxezeIxfcWKvYcY2/oz3alplTut9ES/YjGAXTw8X2BU7FRAU7eosoYWAx0G0bRUyNS8
 I/McIKDoqgVirDKJneOIv2J+EeGmtt59iXq6ZyzmoR7JzwcAF/XYW2g6Ttqd+Au4L6+dhkq/wY
 fAcikBZPS7RvQlO1bnyQ5bV5NJsFjF0PFxJfuuhAPt6B76WcbPJGZZv8YjGIkDBYCVIIJSyCh2
 uU3dVhRiocPRn1xJfpSPumzZcyN4UWk50NTLcRKVEndoRINR8NhMBXLdkgFwM4iksuxmuNdcVu
 d4s=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 15/21] btrfs: drop unnecessary arguments from clustered allocation functions
Date:   Tue, 25 Feb 2020 12:56:20 +0900
Message-Id: <20200225035626.1049501-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that, find_free_extent_clustered() and find_free_extent_unclustered() can
access "last_ptr" from the "clustered" variable, we can drop it from the
arguments.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1ed12a033ba9..1c0c94a2a8e0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3513,11 +3513,11 @@ struct find_free_extent_ctl {
  * Return 0 means we have found a location and set ffe_ctl->found_offset.
  */
 static int find_free_extent_clustered(struct btrfs_block_group *bg,
-		struct btrfs_free_cluster *last_ptr,
-		struct find_free_extent_ctl *ffe_ctl,
-		struct btrfs_block_group **cluster_bg_ret)
+				      struct find_free_extent_ctl *ffe_ctl,
+				      struct btrfs_block_group **cluster_bg_ret)
 {
 	struct btrfs_block_group *cluster_bg;
+	struct btrfs_free_cluster *last_ptr = ffe_ctl->last_ptr;
 	u64 aligned_cluster;
 	u64 offset;
 	int ret;
@@ -3617,9 +3617,9 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
  * Return -EAGAIN to inform caller that we need to re-search this block group
  */
 static int find_free_extent_unclustered(struct btrfs_block_group *bg,
-		struct btrfs_free_cluster *last_ptr,
-		struct find_free_extent_ctl *ffe_ctl)
+					struct find_free_extent_ctl *ffe_ctl)
 {
+	struct btrfs_free_cluster *last_ptr = ffe_ctl->last_ptr;
 	u64 offset;
 
 	/*
@@ -3685,15 +3685,13 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	 * Ok we want to try and use the cluster allocator, so lets look there
 	 */
 	if (ffe_ctl->last_ptr && ffe_ctl->use_cluster) {
-		ret = find_free_extent_clustered(block_group, ffe_ctl->last_ptr,
-						 ffe_ctl, bg_ret);
+		ret = find_free_extent_clustered(block_group, ffe_ctl, bg_ret);
 		if (ret >= 0 || ret == -EAGAIN)
 			return ret;
 		/* ret == -ENOENT case falls through */
 	}
 
-	return find_free_extent_unclustered(block_group, ffe_ctl->last_ptr,
-					    ffe_ctl);
+	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
 static int do_allocation(struct btrfs_block_group *block_group,
-- 
2.25.1

