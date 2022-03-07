Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941804CFC93
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbiCGLWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 06:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiCGLWP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 06:22:15 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224610F5
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 02:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646650046; x=1678186046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vk0GZhtGBRJSzfj162tVREae07WencQ07QTx1GTOx3Y=;
  b=kjXPOCm1f7poK+ZYf/YUlheI6o8+/Qr+8PMWdGT/oZQ610n94q9GygfN
   n3xIkLyJeUJW+PUv814t0bRYcvIYC6EBKmsVraWs0pFHED+tnUXSbTF1C
   CLoRAzCtlSI+x/ohVwlH+bZN3Ngbm4VFF3imgamfnObqCXhITALRehGVy
   u+nZ4esKcKMGCAM3u44f8pL7r04J9J+w0ohDxkhB0iPECYGzw9P6jyWxR
   tidfHzypbhzUo3LuJJdTC/Dh+yEPY4iBuDgOpBZ7PWm+2hw1Qso5W5ygt
   ATbTwmqTlUgUcWyQpQg+G8rS9ODLT3r3ZCR/Bzi26e2sLO4uipbZ9qiqB
   A==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="195615433"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 18:47:24 +0800
IronPort-SDR: 9cw2G+0CUrwtO7/06YQz1X7gqSKbFdJen+Ltxg8Gm8cSCxaZjKE3OxQjxHpm8OENKgSO61uDgZ
 Hepx4+SVcV2fsO/k32gAvoucHDFt1PfoFW/j2aOA36UdaO2Pb1HTOULWb70HNMPi+F3mOLPHRV
 i8WtfLszUU7r5ccY79xANXzb7hdKgE5IdLUnGkiGHXlKD2LZ90spPH0SY6xlwRBN59H3iesQZ+
 +uhR0SxkrtBJB8Q3fSO4ZZsZ7L0JPhFAAu2fFsrjN9m1Z+rSMakfr2NsRRfSS+WvxYaLsvfkoz
 VGp4h6KYbrG2WQ82iDM6j2yw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:19:42 -0800
IronPort-SDR: OmsSNRa5+ijisqkdex1DPuv4wc2Z0ES0Hx9a00cd1k7MK+dUBFi0S1uT997HZbHPl7nRMoz3GR
 gW65L69yDgYZGW42G1s0RyoYQkmTpTDPHMlRuhW8MC0MX+9ZBSaj9/sxpJ+OfH6oYY4JvCFeMR
 tSsHT1L1LjMIHZ15W01mVxHNxSp9rfXKJ6WNr2lUCjMhSwo+fSdmhMASHP3lzrCbnDtFnN6cXb
 lTQDhKfygOU9GYH0DblNmtYMi76M8fuYP2Q8i8qlokixjFG4F4Hkt/O3eLdPfTMZs9HlBO69vB
 Vhs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Mar 2022 02:47:23 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: zoned: remove left over ASSERT()
Date:   Mon,  7 Mar 2022 02:47:18 -0800
Message-Id: <afb9a5ffbb49458cd5b6fa0c9e1b9297f0050a6b.1646649873.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646649873.git.johannes.thumshirn@wdc.com>
References: <cover.1646649873.git.johannes.thumshirn@wdc.com>
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

With commit dcf5652291f6 ("btrfs: zoned: allow DUP on meta-data block
groups") we started allowing DUP on meta-data block-groups, so the
ASSERT()s in btrfs_can_activate_zone() and btrfs_zoned_get_device() are
no longer valid and in fact even harmful.

Fixes: dcf5652291f6 ("btrfs: zoned: allow DUP on meta-data block groups")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index cf6341d45689..49446bb5a5d1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1801,7 +1801,6 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 
 	map = em->map_lookup;
 	/* We only support single profile for now */
-	ASSERT(map->num_stripes == 1);
 	device = map->stripes[0].dev;
 
 	free_extent_map(em);
@@ -1982,9 +1981,6 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	if (!btrfs_is_zoned(fs_devices->fs_info))
 		return true;
 
-	/* Non-single profiles are not supported yet */
-	ASSERT((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0);
-
 	/* Check if there is a device with active zones left */
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
-- 
2.35.1

