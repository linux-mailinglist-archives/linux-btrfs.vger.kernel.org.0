Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9714E8E37
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 08:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiC1GbP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 02:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiC1GbN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 02:31:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90211164
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Mar 2022 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648448973; x=1679984973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHrBn1YNCmuwXW6ORMDqdmjUIEQ2fsNF0+FgRscZpvE=;
  b=inaU4iMrPGgPClDPQ+Xo2Lu3xyqxJP4rztadSiUebD28u6FFNr+miIiz
   TAAcE6mOryjBLKZU/zwWnuykR7l1nkbnTxPTJXv6P/6KZ8beXi4FL/XIi
   AODfU5vfkagkZx6n7jB2nMQCJi8iEkwMU9xmuWTdOyzfdbufEgQrMQiib
   t0TvykBQfvKZcgLViCbCAN44uWsyKJlmk5soSlEA9dwOFrqFTWrwcQvrs
   OdYxQJfLx9M988jvI8WgeNWpL+5nfqJa9BtQ/ecBiQWugEEazA8aoXf1q
   an9d1C4mzfQWmftbz805gTdpapUogo7orK819uCN0vVATuqd3GjNYHBZP
   g==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="300566282"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 14:29:33 +0800
IronPort-SDR: pS9o2929oeo0o7uErnuWxyrrEX0KdOXmhWttCrY8rH9lZ1F4+4ZqBsCw53KT+kpJjwOmBWkxtl
 oxQizSqbQ5v6HRG0JZlUtNwW02gNUNWvkN0V89MD4sXJ4BP7G0X8mv5+lTSGw2/FxIHTayAYxi
 bAOZ6abf9DBquaWY0K6H1Iu0i+wqZoTqo+BIoPuEofoR0/Yw2rI5uI4ri9cRSylbvtdvLpYdd5
 ZVVuF63d37MhM48uTEJWecXop4T3ZrS8BkGsyzVO/iNJBEEd0iLVvTqcPfXz7YHmeqEpTvyotw
 5r9P0kTnd8sgMNAdh/nAtAUY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 23:00:26 -0700
IronPort-SDR: 3sl3qsOvfbPYooCMGdZP+wzt3rhl1lJXVT6IKw01rdQmMlUnoRT3aRiMyGEoQoTLwf2+Y1b082
 FWYIwJYJTSB0qYdwaI5nfDJ99ijxKzCiqXCl4rKcVhfQi6kv7IGtZZC+GueE2QyaNxf2P+CEms
 CEIl8giBtAnaazNUfPeq7nOMhu0tAnX4rBJiaXOcmrjgxzb3k2iFutL1MXe5cH1hFLKfBL/ePh
 Nd66iF2/lhMONTVW76a6hRm2y8tWlB+6eqiIt5fQH550lBOWNSEr23FB46lY+GbWn11ZwzG5a3
 yHo=
WDCIronportException: Internal
Received: from phd006511.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.242])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Mar 2022 23:29:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 3/3] btrfs: assert that relocation is protected with sb_start_write()
Date:   Mon, 28 Mar 2022 15:29:22 +0900
Message-Id: <3c5403c65f3aacbba5f4e441b336233f2112f141.1648448228.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648448228.git.naohiro.aota@wdc.com>
References: <cover.1648448228.git.naohiro.aota@wdc.com>
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

btrfs_relocate_chunk() initiates new ordered extents. They can cause a
hang when a process is trying to thaw the filesystem.

We should have called sb_start_write(), so the filesystem is not being
frozen. Add an ASSERT to check it is protected.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fdc2c4b411f0..705799b2b207 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3977,6 +3977,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	if (!bg)
 		return -ENOENT;
 
+	/* Assert we called sb_start_write(), not to race with FS freezing */
+	if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
+		ASSERT(sb_write_started(fs_info->sb));
+
 	if (btrfs_pinned_by_swapfile(fs_info, bg)) {
 		btrfs_put_block_group(bg);
 		return -ETXTBSY;
-- 
2.35.1

