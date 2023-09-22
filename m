Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE537AA5E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 02:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjIVAC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 20:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIVAC5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 20:02:57 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F38F9;
        Thu, 21 Sep 2023 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695340972; x=1726876972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NMFq9kyJzF7hvV5bjMVbyruk3pyhx7OcNAU4CjkeeXU=;
  b=KOiGfALmpaAWA0cTklF1y2LjgETG3tTRcngLLzAwG9KB9euV8h5b0gUv
   aDQWTwB14JpNQat8bLnFOIBQfT8K4gAp0p/fIZn/RGpX8VudSiuKUIMv/
   hSiSWUqJzAeXyaGKjJkYL8siptPiAbxokA2kNcUb8imN6Zi6/uj+AXlNp
   XxA8Bi3Xfo2twgdVi3Iu1w/4TRhkFD6lKkqEwIrP0yxW1JIPUliiZ3iKL
   hl+OEXBcfMVTRksY4KNNrtE/VPtIjUFflddB69NspLHfynNAtvrhkv9SJ
   ErWs3ssXpGqJaGwIoo7q1oJr+lBillDw9wm18aG/ompSpVCMR23OlwPnP
   Q==;
X-CSE-ConnectionGUID: nSG1mCcaRYqgfArO1Mg37g==
X-CSE-MsgGUID: uxN6eu1CTXikOXNrez4aSQ==
X-IronPort-AV: E=Sophos;i="6.03,166,1694707200"; 
   d="scan'208";a="356675179"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 08:02:51 +0800
IronPort-SDR: ed7JsOHkFIp6hilKf17oPXd40XbetPNOHCG2gPyAhDxv1kB8bMrPptNLiouK3PtJXRhGagSLic
 oj+ZKeV2RHDvd+KmadJ2A6T/02z5Bf3GulF41GD/g5OXM9Ud9jCcCSVA+EZzt8lFelWCMtliNR
 hx9RDGlg6D4wCVQ0hIaPK5QAnHNrMe/+JZ/mC0NOFB2K0E8klQfP+t2iq+C/5TlPQA4X9S8ZCp
 lsNRpDlN6glaWElbLM4EwcmuvIfhTV9FliBPQPfaClzrM6hR4P7kM32sujk5r+a+pDZSHrmvZG
 flo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2023 16:09:44 -0700
IronPort-SDR: OoAqtSCXi+Y2cFzb/1LqipWPCjvWsuLx5SMY+boEzUoe+DZnW6pHuhhDuMCY0jtuJQLu0raPLu
 16ITxJa7+v+2JzjKZHTvUceMUPNkcuy0tLfYvBe/k6NRwcRPWK7sdkakPOHYBwi45CvIGTxr1D
 VuAbLgYXwFoyTWeq5024BQQhS57NSBdM63x1bY7Dn7AOASQiTbq15EBxovHFBXcbmVkwXN6WGO
 CpZ2lSruY919erUSwJBVIQEtX7FyYgOjHDOoWttMSMCDLnd0rr40vRHkOE8K/0/qe2WaU8DQIt
 ikI=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Sep 2023 17:02:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/259: fix output's wrong word
Date:   Fri, 22 Sep 2023 09:02:49 +0900
Message-ID: <20230922000249.2345701-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It prints "File extent layout before defrag" for the both outputs, but the
latter one should be "after defrag".

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/259 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/259 b/tests/btrfs/259
index cbbea9f527f5..358a455068a1 100755
--- a/tests/btrfs/259
+++ b/tests/btrfs/259
@@ -40,7 +40,7 @@ sync
 
 new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
 
-echo "=== File extent layout before defrag ===" >> $seqres.full
+echo "=== File extent layout after defrag ===" >> $seqres.full
 $XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
 $XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" > $tmp.after
 
-- 
2.42.0

