Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45424FB6D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiDKJFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiDKJFL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 05:05:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7453ED25
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649667777; x=1681203777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VKctoTzK60F2ezrc6EtPVYRYvhKwJdVqKKFz7dcLEls=;
  b=adW95vyUkxsK9jwI7uRx98zTSaqAK0CcM4ZWokWWx9vyclgzhS4bdeok
   ftjAPbwINriU6fRSl+SzYLzNYZ8zpMua5RajCX1F/8mMegO80ArIcbWrp
   7/SlFQSbHiLwWhAdFy7oHfFGMMCeebl7SzkASw2Tl9Y4A4lBW5C98aibV
   diY6j/TD/CLg3r/0X0J1DtxGA28VPtH/wHZ1yYDzOzUhIkCk6zAa/mU4/
   l1g+d2RG/pCaaQRf+OgGR2JeIjKLZO2nV/pn+pq/TAYr6gJctfcD+CBCU
   CLqHY7d50ly+xWqPsPMVHkRthpzfhoAsJqo56Oab3hYo7FvJWCLZMaA7a
   A==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643644800"; 
   d="scan'208";a="196481459"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2022 17:02:57 +0800
IronPort-SDR: xeHddGIXzU81Zvcp0TIEN0UPpr0sWFCKvx83/VqAD4RPvlexb/QewAaU54XyATrFWVsEu+1VEL
 m2MoHBMvcf5Qz2eS0d7+nn+UocYd+t+es3gODnC0lZEWP6xSqZIImVJcpgb7QzMzSjUCHq4D+E
 5CI1iM2aaitd7PmMM6PsGxqbMkqnVLt/KfmN8bkuYdk46kWlOMrCBMojsoMzKhuzs7cX6AX+je
 CwPEITWxIVjPijA9poO0zVuWlw9tMauwNsW9gOd30OgY+Te/cxInE6RhTIH3q49FEapl4d9S8H
 JcsdOE2cHswQNmblroR9iZEf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 01:33:26 -0700
IronPort-SDR: wHpQrqVPH9ho1LyTIzkqPCTTGL854SBng+rE1kw+omk+uTAe4gnrcr9ifa0o6YqltVmfUaHCmk
 ejCV/enEXRFt9r/tgqZxZ4UTKlXHLrbXVKmw+CaA5uUIadsyv3+inmb/fA0iU6ltWgGneVOesp
 Dq/zZRYqfig+2eQ48SO3fzxV5rdQsqHSi1y51TdeqKzKMvMzkcGSZuRd8f9UdSTWDMWSSGEFGy
 njoasvy0XGjLGLlP/vR8B4pXfScSaIhlBtHKjOl7MOYhltVKUWL2HnTkPN0Kx2Yd8iiq1cVKqZ
 CDY=
WDCIronportException: Internal
Received: from 5ty3fb3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.51])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2022 02:02:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH] btrfs: do not sleep unnecessary on successful batch page allocation
Date:   Mon, 11 Apr 2022 18:02:52 +0900
Message-Id: <1c7f75c138cba65d0af23ad4eda7c1bab1cc21fe.1649666810.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
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

After commit 727fd577af04 ("btrfs: wait between incomplete batch memory
allocations"), fstests btrfs/187 becomes incredibly slow. Before the commit
it takes 335 seconds to run the test on 8GB ZRAM device running on QEMU.
But, after that patch, it never finish after 4 hours.

This is because of unnecessary memalloc_retry_wait() call. If
alloc_pages_bulk_array() successfully allocated all the requested pages, it
is no use to call memalloc_retry_wait() to wait for retrying.

I confirmed the test run time back to 353 seconds with this patch applied.

Link: https://lore.kernel.org/linux-btrfs/20220411071124.zwtcarqngqqkdd6q@naota-xeon/
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1a5a7ded3175..2681a998ee1c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3150,6 +3150,9 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 
 		allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages, page_array);
 
+		if (allocated == nr_pages)
+			return 0;
+
 		/*
 		 * During this iteration, no page could be allocated, even
 		 * though alloc_pages_bulk_array() falls back to alloc_page()
-- 
2.35.1

