Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9953E64B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiFFP7f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbiFFP7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 11:59:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F46A53E12
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654531170; x=1686067170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wy0ORLrGca7+Ftoe19p8DFQ8vB7g8VwzcdofwpBOVk8=;
  b=YUb2EdLlnY3QaeW2sUcQkJgyyQcHYyv2qrJpv72gDGEPNb5+2o7RdROQ
   Fq5QdkhzA6Gek9aWbaX81EtBQTmRqGDwGJ7jCYEAR1yguLhbAOOSF/OQo
   KU+hSsyQfQhnJVUvAB9yNq/5e6JqeJ0PWgAHT5fwuCmDS/Wx1rT5aOe68
   nFbrylAlzxtYp99hLpjvlvFvKb6eXoSJ6Hsc7Ca9Y3pQmnjcEEww4K2a1
   +d4U5Y1by/qoIfVs985Y4iSf9FjSRFbZQ+gySjNPMv/NoQeIYOaLcULdb
   xr9CMR7cu3qtgCHxGM/+upb9YfR4SMxyzhbdaH4+Z/xOkKV1Tn6tHvC37
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647273600"; 
   d="scan'208";a="207245102"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2022 23:59:30 +0800
IronPort-SDR: iY7lpP2kS1iUJfMYb2YYYJQTYy0ciei2PL/XltaGFPoaDdooAqf9LMRxxtC1/S6bj4z4z3dKM2
 qDkBR+l6C9pMM6IKQXMy9H4V4NSHESIDBnnOSfayJrg3CXc9GWZI2ab3gP6sL8yxaUJWZ5M67B
 mCwHme/JJt58TyfO6SznfyPDGtkpH7PX2sAdgrA9Ars8cgnAefPeMO/W7gHjOAQyGdjFZML1Nn
 7HPYRMyarWqvxn23tAedpMmoKOEfWpPf8NypxcV6IuTKSD46XclGsCd2XI9v0IcoReBM0rQPRK
 4H34E/eIeoHIoGiVqmzb8IDG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 08:18:29 -0700
IronPort-SDR: 4KYJ+DnVIEdbLavCZX08+MwdxxNCBIe7w0TbQegk7Jy+2x7nK/U5TTzgSmQqo5DkdFVV4aEZ9j
 fnd6Tna9kuZzbsjPxCDUK7bP3ZZTiE6RZkPr+zvLHzTNxgL4fEGcPB8/F3tDTn9te10mwRnq4s
 gyFBzUBY137maHeY8MvRLtEUBNrNHhpz4GN8mORQylH3q6LQmEbjeYfXyMZ6BV+zRyxYqXSkHH
 zchU4OdPNvpA1egZBsGKBi6RPJ5v0sW7f77f6cI7kGHkaR4qZLtxhHP78eSWaE00Yi0GkahFRy
 WzM=
WDCIronportException: Internal
Received: from 5cg2012pz0.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.70])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jun 2022 08:59:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: fix critical section of relocation inode writeback
Date:   Tue,  7 Jun 2022 00:59:21 +0900
Message-Id: <ea2968f6fb505a90fdad8a9362f54e2121b55bc8.1654529962.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654529962.git.naohiro.aota@wdc.com>
References: <cover.1654529962.git.naohiro.aota@wdc.com>
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

