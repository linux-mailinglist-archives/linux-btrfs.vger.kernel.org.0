Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD7236AC2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhDZG3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41949 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhDZG3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418504; x=1650954504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXQWsLQNpFmsGr39U3jojTtB99oLuiG1HtmvFzyWGX4=;
  b=X84RCRexwxdlXzbxW/PHx1oHEqG8Otz2uMLUCzv4hsiUhqFke00NyAdD
   6ujNA2Cmc3htdpprudIUyqLxDZihs4GowQJ/KhEIFp/3YoF559htf8Fxh
   NeqHTq4pTLLLWn8tffOOYyUb7cBbHDB6tWf21K+dbjcDnv1IsLwtAREli
   nA3LhDlGQz2BgQudp2At12XOm9QYY4pCyRhRhozyKtqcBu13m4cPIgOKF
   Ye8ArSR6kZIOVLLXgZyjDmNOoLdSU0TtgFa674jHC2O538IQp/08u4OC2
   TryDRHD4MPO2hBuozBMAzFEU06JUA4PTHUmHtyZHsj4DQ6YDFhhgfJZpr
   w==;
IronPort-SDR: /kRcr2zHtmVn3NXfu6txLtOezg/DYY2Fg1wbtKBhSE/JZi7/kDj9XQUhwrWPOt72xMe09v4IwT
 HVCDQeJBxENbAcUEsOhR3SiwRGeEKkyWOBvu1YrEMPnc0w8u0Zz9hRaDOmrpazJX7O/dp9JHS4
 C0VKaCLnEapt5rJAZ5kFUSoEgC6VpbWcO6HLN1MKbq3y2Mbu1d6UlIpPifGL3TwX8sVMJG7RVj
 ewqAti7F1xKr1v2EbOhp6aQrctGb3+5VfTHT5ONOADSz0XBdcaUUYEsEuW6L9PrqrNI75XVVyI
 4ZY=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788127"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:23 +0800
IronPort-SDR: iXIFZPBlPdXX+wXwOoCD7Q/RRSGXbYb7BaNO9UlyBJU6iqGh87JkWTUYmEM0F2nQFoLR4Vf/D3
 z7dc8fjNwN2iSyrclmsjSSv1Zwdn0jNwdxbnfWXJ+BV23cUey54TzX75icjZSvBH8gzB4W1CJx
 DeUiOhRIjjwkcbHMmV2rNLYIRjISpQ9Qa4+C9r2IfY+C2OiGNLVEuKQhT8DAGm0/yr++g/q6fr
 YvUgUfiDDh+Zw/q2V+99Szm72BTezAhqmVrO/Hy0tdA8L+8kX/UsdCHcyqxSYlRfA5n1tRbyM4
 C+78XdcVAgq+V6bLfsBrGSnM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:47 -0700
IronPort-SDR: 2N7NHyTWLbXyc1a5UuRB4aGT38i6jyW9Usy2rYAUzXDlcEy9rECY/tTpaD17fJSJhPUyAsRFrl
 Mja3uZxK69CIizpoalx46Gugiwr/NCS9pP1nIrz1JxzFM4Mjv15uTrc4p08GLmrsXvvEPQoywM
 hZSnl9nSlZsHaw/o2oewue/LGjflTrRW/KrLFbL+HziQEbLSY1ZMeT6ZAI2gij/ima4L0aw2+u
 NM03ZAc25xYSwCxwDdjZr5GXuX2u7gM4Mu0RI1bYFonkPc1NHV4rVYSGD7CtJ/QgCA/fGp5fVQ
 vm0=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:23 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 13/26] btrfs-progs: zoned: implement sequential extent allocation
Date:   Mon, 26 Apr 2021 15:27:29 +0900
Message-Id: <7a8a75019747c596075def43b885f7721d6c2bbc.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Implement a sequential extent allocator for zoned filesystems. This
allocator only needs to check if there is enough space in the block group
after the allocation pointer to satisfy the extent allocation request.

Since the allocator is really simple, we implement it directly in
find_search_start().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/extent-tree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index ec5ea9a8e090..7453bf9f49b6 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -284,6 +284,14 @@ again:
 	if (cache->ro || !block_group_bits(cache, data))
 		goto new_group;
 
+	if (btrfs_is_zoned(root->fs_info)) {
+		if (cache->length - cache->alloc_offset < num)
+			goto new_group;
+		*start_ret = cache->start + cache->alloc_offset;
+		cache->alloc_offset += num;
+		return 0;
+	}
+
 	while(1) {
 		ret = find_first_extent_bit(&root->fs_info->free_space_cache,
 					    last, &start, &end, EXTENT_DIRTY);
-- 
2.31.1

