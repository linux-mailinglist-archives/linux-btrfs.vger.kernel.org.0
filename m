Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8DB6198F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKDONY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Nov 2022 10:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiKDONE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Nov 2022 10:13:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C302FFFB
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667571169; x=1699107169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i/u7RCDvksiJ3TEAf54ihRJYwj2ixLOYz4ySA6KmTio=;
  b=TIDwnXGLBHJ0Qyg2vYPU48bK1fs7GJiBNULmyBMP2HSxybEDuC344WLB
   fUP92vNeG2PaNWKGAdvBwOJom8UqF6Wnt7YeUsuy3f5WjfKQM/EJx7qUg
   jYCcPHLoUWUWUwdeXo0fjqhCGaOOdOF8rjfST02TeqL4PPXhH8zjNRYuj
   ofG2FhSUoohloADLfovsu6jfjhSA4gE55td7F2aIufwfAblxtcyNSBkDr
   iFy56KQmnuwAvblA2mPT3/nsQWinZxU/xsc5e+gUsmOeHGNpa3Gr0SdF1
   DT6DuczDnToIXvGZ8sSgnRdCoOlP4BhMGxEJfpw3NF7Dcby9PJE251Xye
   w==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665417600"; 
   d="scan'208";a="327603639"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 22:12:44 +0800
IronPort-SDR: iEJ4KiLw+/HFRi0+m2MlKTDEn/o54jxLPZjXior/YNfmib0adiFASS+CvzGJkhO9DV0wbHE1/P
 tIf05IDmIsq+1QYaRIoJXNj7NSwNMJoeO2kY37im1YC6FN7PVZdymGMm3D4s/LSQFzH7fQYQjF
 HRO29UVN6+bSbntUzPQHc4ZR1lm/E0V0m052QXc8Ia3v9ufEyeTZ3Tt96lRAXI9ys0B0GGfevE
 SkHszrDYQi1W19g3kpSFjM/ay9h+mjFc3VayksEiQStlgNrfIgrfuilWT73rxJlMkjeHbGVLx4
 7ME=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2022 06:31:56 -0700
IronPort-SDR: OUv6NKdsifMgcySlROBnRdTz84XczD8Uau6eOfU2w1PLlh8SZ8kfjlxnepe9D4HAQugGSLH34G
 WMWrRmsex1TVUednDqELy6R3Sfpf0Doc9RdfGcFVpd2YnXH6as8Da71ZTfo20ke6X4EGisQ2VG
 VQ8G1lHrvG8rXjTtjgycszaBIEn3ldYkLyXHfxq+Mhp4Ii8hPY6t2sf61cS44fUDgjllv6FlsK
 /TwF4rr1jNljuPIxCDx8Y9Q4sfjdufZSGIyA4Qxb6ZZ6EMzTIyzXa8uR/NjV00ebe0n34MUsat
 BH4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2022 07:12:45 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 3/3] btrfs: zoned: fix locking imbalance on scrub
Date:   Fri,  4 Nov 2022 07:12:35 -0700
Message-Id: <befc22e36114742d3642215d57dff1d9f212f3e5.1667571005.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667571005.git.johannes.thumshirn@wdc.com>
References: <cover.1667571005.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're doing device replace on a zoned filesystem and discover in
scrub_enumerate_chunks() that we don't have to copy the block-group it is
unlocked before it gets skipped.

But as the block-group hasn't yet been locked before it leads to a locking
imbalance. To fix this simply remove the unlock.

This was uncovered by fstests' testcase btrfs/163.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2c7053d20c14..65f6f04afdbe 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3932,7 +3932,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
 			if (!test_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags)) {
-				spin_unlock(&cache->lock);
 				btrfs_put_block_group(cache);
 				goto skip;
 			}
-- 
2.37.3

