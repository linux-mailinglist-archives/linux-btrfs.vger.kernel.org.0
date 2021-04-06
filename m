Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1B354E4B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhDFIIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:08:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhDFIIT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696494; x=1649232494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nb8AwbYRcUj5xB4CdIS38Xo2SZa9m6oBGFvUiOmDn0M=;
  b=J9zcDVMHtryPugVgLuOzPP/5wByukSiafnoGqr0zEgVEwJuLyjwBtKUs
   d6h2DN2pLyRcAM4j8ezRCkWvM00CFc5vQUW9nIlsMESfafB6ngI/EFChb
   ea2UCBGDJ0XoTeof1btiPTevz0ZVpDwwQu52uZyq3ZK+iWztm+ZW6oAjQ
   oRMntgQ0gverjJ6z3W/TAT3DwbzS44GuAHJDBCRxWMI72y0SXsfwEmiYz
   sgaZrS5IIjMtOqQSf7E6v1GtPnLbmJqtzpr8v3OKMT6odJ4ccCDQZImZr
   IG3/NM1Db6eGStQMMuUvF+2HQazKTQMQB9dyqH9ttkpIEfnCmRYMAS6dg
   Q==;
IronPort-SDR: nAk0aAsFWnC5WC2feyWKv34jD0LQKTsKTs90jCc7cgWwDXueqXdPiEPHIrOOVzVQ5T4UD7UvEH
 UeSQJJZ7bex6DKg4racEq3CDIvJG5WSNKAuWz9snhwQtFYcqtgG0/HsTUm4Q3XNT/q6bgYqEdO
 4zXIHTePiTG1s4/2ItQBsGpNHAdoj92Ulq3WSP7upRWQyusyv0VPnp4xBsFyH4N7Fp7m/LSYx1
 Bs5VqSRZqEr1tw2Nms593VYQg8l7ykAK6mOMYxq6AhYaL2ZcLM58WjHwS3bjL+qPbh7ID1IseG
 oL8=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290719"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:08:00 +0800
IronPort-SDR: dCVr+uotIa01pC6Nvy+RNMA0xpHiz2QL3aZr/0zuEfMyREcYc1OLCXlNv3CBUzGwd45xv71dEa
 fdaSDa5uhHqg2dAx/c9BdSBet2vHzLSAguf5Y1Jiea/9VKJeQ7HWdeEcsyMcV8fd367l52XqM6
 GJ4va5Xc6GDUBsObvZxcQrd2fwxlvkO6Jaez/N+NtUlAX2U68hexb9h50Gs8oQ+UZ0uhXBKQDI
 YNL374YdwD1OFLRKh3qySYbqU8HYyOZeZI53OTeizw3l0ZnyG+2EUJvMhZ+4PX6KgiaLBj9Ui4
 X1hBOImtqVZ/4+a+TNCwial7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:28 -0700
IronPort-SDR: Y2KPYjHiuxfwI8SBODGsCIUaW0N8jgGRX6m+Y7Ci7Z8jf2Z/hqV8fv63iQeVZrANTXAkru+UY4
 f5tFKbUkZ0y98L1xe+Y8N3G4kZmU0bYwPN+vlMcen8yDonIUd/hdl0/n23Cd65MSU7mWHDX5qb
 cBkmmXiFiHlaAspcQvv4xMr+bqmtkuv65DjEa7Pk4n7xzkn0FhRfc6k99OG4zQBfSyIHixz/zb
 Zqs9HM9p9SxR34ksClOnBT7uEkDGadvEE4J+QZh2eoZ3dtmM1gI6gvd0hyStEjXe1Ho+Vjh/YJ
 9Kk=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:07:03 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 09/12] btrfs-progs: use round_down for allocation calcs
Date:   Tue,  6 Apr 2021 17:05:51 +0900
Message-Id: <22e1c5423bd180cebca859285942bdb77e679013.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several calculations in the chunk allocation process use this pattern.

    x /= y;
    x *= y;

Replace this pattern with round_down().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index ed3015bf3e0c..d01d825c67ce 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1098,15 +1098,13 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl)
 	if (chunk_size > ctl->max_chunk_size) {
 		ctl->calc_size = ctl->max_chunk_size;
 		ctl->calc_size /= ctl->num_stripes;
-		ctl->calc_size /= ctl->stripe_len;
-		ctl->calc_size *= ctl->stripe_len;
+		ctl->calc_size = round_down(ctl->calc_size, ctl->stripe_len);
 	}
 	/* we don't want tiny stripes */
 	ctl->calc_size = max_t(u64, ctl->calc_size, ctl->min_stripe_size);
 
 	/* Align to the stripe length */
-	ctl->calc_size /= ctl->stripe_len;
-	ctl->calc_size *= ctl->stripe_len;
+	ctl->calc_size = round_down(ctl->calc_size, ctl->stripe_len);
 
 	return 0;
 }
@@ -1315,8 +1313,10 @@ again:
 		if (index >= ctl.min_stripes) {
 			ctl.num_stripes = index;
 			if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
-				ctl.num_stripes /= ctl.sub_stripes;
-				ctl.num_stripes *= ctl.sub_stripes;
+				/* We know this should be 2, but just in case */
+				ASSERT(is_power_of_2(ctl.sub_stripes));
+				ctl.num_stripes = round_down(ctl.num_stripes,
+							     ctl.sub_stripes);
 			}
 			looped = 1;
 			goto again;
-- 
2.31.1

