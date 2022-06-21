Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA9552B3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbiFUGoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346026AbiFUGoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:44:08 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6655A1B7B1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655793846; x=1687329846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Pv8MSGCq1umYzKQ+m2R3VG4oIT0Y7tt8Hrc1rom7To=;
  b=iM+bKjJXsCeYuA4hOSVrwzYUkIWY62MHkfA7MS4jMDVp47fl7NADGBKS
   KimPC6mRCaOMgJVZSv7M4zj1GqiVwrStzzFOy5gK+0+Uexm+87osyscKN
   iAECIaK7A5Pxm1OqdhA8VLHYSnzWMFesJObSqmcyeayviCzDwbbRSXQY0
   Xh6K4wKj/FwqOp/nMJQFmnc7rTvRbbQv0QWTIxNSrreSKgO1GoAv5lczC
   2Tps1hUliD5yuQTjSvZ2ToOFHBSXqLw5IjdsFYuBWtbj54aGUFH5YaZE5
   pWYObZfgY0QB9qGNXCmvpZcWesydWnx+3U2yDcm0GmxVTO4Av5s9GX8wH
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="208550417"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 14:44:06 +0800
IronPort-SDR: tK5iB3fr5EOpCa8CPPge9jZWYqTUETRReBw4zuxpwci9wDojOgLPftc5JTLWB7sLlh3Xyfn/pI
 8NFHPR6ALg3WC9vDTynWc/JuIS8HzwrGxSlwZ7F+sdsaJi/+o+CUWB8dqqmkY2zqtSGWMXgy3q
 bLG9U+jkq1WNWJfQJpudRUvjbiiA8fGbo8qlO+y31anfUC9diSBEYnQ0QJ6EUL6o7gQfs4hspL
 Thy/hoIg32fOtaWQHWAta8pxT6POXOf5OmbOZW9eDj+jmWJUaxccnDWb0UCof5hcHyfbbp2o0t
 iR0pzIjnN+nd+njhMrLeRY9D
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 23:02:14 -0700
IronPort-SDR: 7V+C7vRHSNo7Xwh8rfQqkcOB36xcpur5FF+IoK2utGT4n0SHRMCPa5CpIkzXnkOYtbb+rXfXdm
 QWYFaHLLVJYgQOtUtHO0Zr+p8qkZF6/ZV2yhcFbKJMnNAkg6NKLljXkADz3qoT2i6eD5FGOh9V
 gUPpeU2IYHujjV+m/lnXTMKQkHV9Ij6HliO9O7DcmxY6EVFf5LTeO2VyZw+KYg5Z/l+PkTihxz
 9uYuGBryIV+MEG4Y5oEArUAN9vyQN57gi+caTa3zm5/eBNfcjTvmrLb83aZ72jMHDUa/3WCuE0
 9A4=
WDCIronportException: Internal
Received: from dtjcyy2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jun 2022 23:44:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 4/4] btrfs: replace unnecessary goto with direct return at cow_file_range()
Date:   Tue, 21 Jun 2022 15:41:02 +0900
Message-Id: <a294ac30ec431016710e8dda1e778e18bfeff9c5.1655791781.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655791781.git.naohiro.aota@wdc.com>
References: <cover.1655791781.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The "goto out;"s in cow_file_range() just results in a simple "return
ret;" which are not really useful. Replace them with proper direct
"return"s. It also makes the success path vs failure path stands out.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 38d8e6d78e77..b9633b35a35f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1250,7 +1250,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * inline extent or a compressed extent.
 			 */
 			unlock_page(locked_page);
-			goto out;
+			return 0;
 		} else if (ret < 0) {
 			goto out_unlock;
 		}
@@ -1359,8 +1359,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_unlock;
 	}
-out:
-	return ret;
+	return 0;
 
 out_drop_extent_cache:
 	btrfs_drop_extent_cache(inode, start, start + ram_size - 1, 0);
@@ -1418,7 +1417,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     page_ops);
 		start += cur_alloc_size;
 		if (start >= end)
-			goto out;
+			return ret;
 	}
 
 	/*
@@ -1430,7 +1429,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	extent_clear_unlock_delalloc(inode, start, end, locked_page,
 				     clear_bits | EXTENT_CLEAR_DATA_RESV,
 				     page_ops);
-	goto out;
+	return ret;
 }
 
 /*
-- 
2.35.1

