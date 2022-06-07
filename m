Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF053F6E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiFGHIi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 03:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiFGHIg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 03:08:36 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADACE1EED3
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654585716; x=1686121716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wy0ORLrGca7+Ftoe19p8DFQ8vB7g8VwzcdofwpBOVk8=;
  b=WnSNoTDO/90jF3wx8BVb25kClmWt5LD7h2geQbBWhBhSeURA88FDXoh3
   oQstGAFSOvMW/+goaE+iVnX2p8ehPRa8EXacpDkWbn9M599b0OFXYJC+Y
   6toS6/T/vAqfRHZMshp8MdeJYJMGHIcNC6FUaWGh2dzGgQTT2dH7PWDLf
   Gt+73NThWo4oSRJ6SEUZZNNOEAEv2uOT+KSbFco/LUUOqI/Do7e7oyqZb
   ONbe8VzBkabmbYoxaOvDjbqbqREyNSOVW63Zxms20fyg+lA2Of/g4SCMd
   hPv7tJI08PNZFQcllCNcO6pF58huv7eMA3NqnjOfUU/fxAccUQGE+CPWA
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="203238283"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 15:08:35 +0800
IronPort-SDR: n4azXK/hNwLA0gfWI0RN1r7RpPJtKN0WFza3Job/c9pI7mn3mTp35QsWdHMF2SXsKjklGN9Kw/
 aZhyZAQjx2MjFUhDx+H3jEPwBxyu0ZCc6DvleYw6x6HjGzl16ATEc/w2EAMIklR/lF3F7Tukto
 vwkxiUCYBs37c0ZCG57RV0nx3yuC+5LNzzQBNoTN3PsFsa0bGJbyxwa8iyza3sHPs7OOpLCx0n
 a+q3Gri5iVwqv9Czs/3l0DT99diNHCKWeL3dooiq7ezo6Lh1ZWzyphei+k6YqbCVtWWCvpUV8L
 WFCGxnQsVXWP60GSa69AJQY6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 23:31:51 -0700
IronPort-SDR: Q8DBXtFRtAxMHy44Vf7jASWQDRifKuc3r73nCtkwZ2KPz1LpPMMseZ6Uqo+BXB3U5AayB5Df1k
 qnX22dECaFgekCOMo43hstNgaSkhQLHlzOIc/jhtQbYiyWFJa9fqlNYz+jCmS22Ows7lSRzq3J
 8IrpoA2wz3KSWeijmTmsanUV5zjGwthkGfVS1+5yrdLUWQNUHYskPNkIizGhWSiG7BBQQvlEVb
 iiB1tUKxHPzv9STWXWVixh8mky4lbHiQYAhYBWHlhWVRHAbLTQ/tXb1GDfnRGtzjLv0/HOl6I0
 oC8=
WDCIronportException: Internal
Received: from hr204m2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2022 00:08:34 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/2] btrfs: zoned: fix critical section of relocation inode writeback
Date:   Tue,  7 Jun 2022 16:08:30 +0900
Message-Id: <668df7d610ddae48ffd260ae08f433cc3b3d7ecd.1654585425.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654585425.git.naohiro.aota@wdc.com>
References: <cover.1654585425.git.naohiro.aota@wdc.com>
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

We use btrfs_zoned_data_reloc_{lock,unlock} to allow only one process to
write out to the relocation inode. That critical section must include all
the IO submission for the inode. However, flush_write_bio() in
extent_writepages() is out of the critical section, causing an IO
submission outside of the lock. This leads to an out of the order IO
submission and fail the relocation process.

Fix it by extending the critical section.

Fixes: 35156d852762 ("btrfs: zoned: only allow one process to add pages to a relocation inode")
CC: stable@vger.kernel.org # 5.16+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4847e0471dbf..7a125b319a9f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5227,13 +5227,14 @@ int extent_writepages(struct address_space *mapping,
 	 */
 	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
 	ret = extent_write_cache_pages(mapping, wbc, &epd);
-	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
 	ASSERT(ret <= 0);
 	if (ret < 0) {
+		btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
 		end_write_bio(&epd, ret);
 		return ret;
 	}
 	flush_write_bio(&epd);
+	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
 	return ret;
 }
 
-- 
2.35.1

