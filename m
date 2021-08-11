Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6413E938E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhHKOVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64262 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhHKOVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691660; x=1660227660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1yNoVcCd5aPyEBAtdlR6pEGuekOtr26ywy3I2FMQOE=;
  b=QJQpOg9G+hcz0wryrk8ncMaNWXBq5gnbFZAFol+m5wmFZTAiC1T6ylfv
   FDsh2/354xybOAFLdXCSoiW8JqM4MpAZCHGT1kf2NyCufiWeklyvvnqr0
   F6pNlQ+TQet2aTOIuTsWkcIbRtx4+7nkyZi/hDGqYcn5pdoE7aEhGWwW1
   EdWWfgxpDUS/bUD9prgC3OG5yM/z9Mxsi7RwqYqgigIQ/QZDwQzs1z06O
   2PzqyXcu7OYyxfaNfJK6OZR1SL9Xq1TsqRkYf8Fb1Z/OWfAUCr5GbebMt
   fcAGz3rgLBd6KWZZrp4QoFKyP6aMREK83z/N/AnUHyXCPCscQxEfM91i7
   A==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="288506679"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:59 +0800
IronPort-SDR: jMJ/9Z4kum0U6sYVKlKaztGujPWhvyDfuPLcDjIos01x6VNod5CWNT1t6uigM2ZxnQ7UWrpEDI
 vnZxyj7BqceC3n1mDTsLSYdxsZTHg53nGQ8v/6SfTPtBvHZu1pDtxZSUg1psk+Hirf2CGKNYIy
 ahga3S6svYaJ2m0OvQNQKX2sD8/QjGBxIxVzJ9xwf+bQrsfZ6qF14pxEan3kz6kzIE8H4K5bh3
 2NGAGjpjnw8bvx5eXTro7gb/4pT4mp46BRRsr99CeXeCKHene8nJzt2PkY/Tae8ByBx57sfSum
 gSfMxAhDGxGfJ3hkg0ur4QwX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:30 -0700
IronPort-SDR: 1HF39dvzAf/DGJsfUV84Jj285+O5yIqJOwznr9Q6/FXnkk3uveqTACNMGkGECeDzodzZs6xTDL
 L4xiHoF4EogowhVNqdM3+r7SKBdOxF0wne2as3X8T+qWwbDXTbLbtqL6/+pqN4eyAmqLI3LhL2
 qy9Jjdr7+DvHL1YRhPdhYqhknWDKFCW7cWptsUgNZNSClu1IZMQDx7kf+88U02gMo1TyP9EIB8
 Y3W4ADY1kn42am4tDS9ucVsJc8MvVUbY/ItJp05AuRo08sCsB/Po10m9YcG08+RukvQldTKQWf
 yHQ=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:59 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 13/17] btrfs: zoned: activate new block group
Date:   Wed, 11 Aug 2021 23:16:37 +0900
Message-Id: <3967ca687f61272b719260b2c114d3c2531195d2.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Activate new block group at btrfs_make_block_group(). We do not check the
return value. If failed, we can try again later at the actual extent
allocation phase.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 90c4279592a0..f4fa65438eed 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2447,6 +2447,12 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 		return ERR_PTR(ret);
 	}
 
+	/*
+	 * New block group is likely to be used soon. Try to activate it now.
+	 * Failure is OK for now.
+	 */
+	btrfs_zone_activate(cache);
+
 	ret = exclude_super_stripes(cache);
 	if (ret) {
 		/* We may have excluded something, so call this just in case */
-- 
2.32.0

