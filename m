Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5E263A8BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 13:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiK1MvN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 07:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiK1MvM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 07:51:12 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6330064F9;
        Mon, 28 Nov 2022 04:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669639871; x=1701175871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nt80dKsPY1N6+jeHJ/cbVDo92m+nMSPtbDfxjdIM0kc=;
  b=ityPpWylco1pAKtbPDs2G5N7hgKD/YG983Jn6/fMjrk/pFLS7JISuWfv
   BjV0QCorQJEHBBB37Gh6hTQyq0uu6agNv7/8cerU+vO5VFdeIlHI+d76u
   yFoUefXyUofFWkaO8Rb5OaXUFSW2hXXn4VMq1J2p0kpAv8hVGdR5OoMEA
   TTaL9Yr/TA+SeQMoI48RUJqHZYoB8+sJ9v03kvVnjUn/eJuBLmSn89xSV
   QJSN9bb7O6xzp9NAMdOlMTKahvKNM0uDqIDWI5CBzMFlqwW8hsKjp/Dph
   Nd5i5XvPTHRbl4Dz0YkdeuB8u3toy5cpufWaJ8uRAS4u4Y+k7S+0dJp5/
   w==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665417600"; 
   d="scan'208";a="222499504"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2022 20:51:10 +0800
IronPort-SDR: Nb/2bkstSckHHv6NAqxTSIQ8opRVTJb9z1U0o28mlj4s19gVPRrz8z9A+V37cR7UOlSJ5YMtYQ
 gVGkob7bxjSSds2Xs9vIBuoM3vk69SOQsfhEEJZ5/HsAX9XM/+oRGPKFN3tEZuAXkY9gKWaaA4
 3aUyl/AWc3DaD/dnM7V7W4YjlkR5vRWMypHGbwkvbKYUG/b4OLtLp/9Asf/6AwMrmTkeugTANN
 fKuq+3XCEZsnXoDNfqnjBl44vdEDsZGj4CSFYDh1iu4EZoRKJjVdKp5YRIT9PbG+igvrS43JYk
 KfU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2022 04:09:52 -0800
IronPort-SDR: jrnmJoM7lMytfYEm/8E2eVPv9SQ6KzuICMLpALJrICzPSrKOmZnwyqVDbdEVwpoGIfBsYZH0OP
 TxLxPxRWT2zHDRCPlCeImUt2/IjAW8V4WX2f/VQqFSeC3U257Wnkw4TtKOeZAmw50i13n4f4HG
 hsQ7qyAoB2+oVGvEp6kq1sRGwoXwWLXZjJUJzJFwWJTMIK1ON11xg1eDgVsRQ/i5OuM2SXGFp6
 00J4r32lNEwi/ymtTJvsAxP+vTL3qe9sSPDLxDAjpgwkCLuxVNHSyFkbZxQJLcseaNE5IabVVg
 dwc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Nov 2022 04:51:09 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: skip btrfs/254 in case MIN_FSSIZE is more than 1G
Date:   Mon, 28 Nov 2022 04:51:05 -0800
Message-Id: <20221128125105.52458-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
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

The test-case btrfs/254 creates a 1G device-mapper setup, but this might
be too small for the filesystem to actually operate (i.e. in case of a
zoned block device which needs at least 5 zones).

Skip the test if MIN_FSSIZE is set to a value above 1G.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/254 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/254 b/tests/btrfs/254
index 5d6e33f40bb5..ae55ae8ca3a2 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -40,6 +40,7 @@ _require_dm_target linear
 _require_btrfs_forget_or_module_loadable
 _require_scratch_nocheck
 _require_command "$WIPEFS_PROG" wipefs
+_check_minimal_fs_size $((1024 * 1024 * 1024))
 
 _scratch_dev_pool_get 3
 
-- 
2.38.1

