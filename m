Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6A2664556
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 16:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbjAJPw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 10:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjAJPwU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 10:52:20 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89C1CFC1;
        Tue, 10 Jan 2023 07:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673365939; x=1704901939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4GwrJt1opbtDvgNpabk+tAE/i5fgxpaZKNOZlDQBr8=;
  b=I85lsL3KXhp7JAle5tz2Ri61GAG9JdDwRfFSevB5kpnhYOpL9X9Wr9Yw
   Rd2namIO5nv2FM8uZ6N+9fQWQ4HpaH3oZIkP/VYphw34ZarVjGVSXoQoS
   zOfxoj4ahUy82pU+u+Y0Qz1Ua/bk0FnOYEwARdA6ujaSD0ZaJEAVaTzeR
   s0l2SdAfdvJUVnzhavR+j+iyFq6ERHCmoHAHtilT0WGMhdkPLOfybuPPT
   spF8dlM2jjJHP9KLpVNNJun5ToSvnR7iPKq5GqDRzOz5EToNaCXdIT+Qj
   7/PiWcWUKDH4FSL8n7e0bVdtmpG+9XmGWEQ6nd/zF6s74eZ9YyqmdkA+N
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="220565218"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 23:52:19 +0800
IronPort-SDR: 5/d0b4a/lboDJq1r6j4lCVdqP5yoiTk5UENgK1Z0nLvQADlXGBMr5DCru0ni8aBcRG45YLieeo
 VprFbUh8sMxEfgUa1Hbsx2c81JPMTuGwUBD6OHCzhVC1w9Jk4blqZxvpx4bVUcTBC7SlxBMG16
 dY/I88sZLE8NQUtV1vk+EJJgF9RWttY+RKmMicOHfprLsDSagv3+GEi8U97z6rLBFW36wMNqNO
 72/Lp98NNm8mJkDKVWEhuTmQAtnwix7cIALTqu7ecsnQea3hwjqLDcajrV8BqllrulDns0I4jm
 uJQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 07:10:09 -0800
IronPort-SDR: E4O1/JCD8wIuorKOPhZGaS1eCDiduzNUDeFgG4YZmLEw00ccoD2ycT0+MTY/kdTFlmXr6odLAW
 FUj32vPXtglXiIIMV4EAB45tFOzgDCRc5TO7g+KwBdl/fCBo9AMyFwcH3IOK8BW+eZ6iw2eHQO
 rUlXo4ZggARGEfkroXsSXJ2+xBmTNr8F/OH34nVuLKly7UVLR/5dVHSQfQYbz1xjPZdlAlHTQa
 CBKf1+6V7y+MBrHf8fqfs4zX3tEPwpw/3DEzS+3Epfs6qsaikWsKUvlIANwoeHpj0uktBd/k1V
 3BQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Jan 2023 07:52:19 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs/012: check if ext4 is available
Date:   Tue, 10 Jan 2023 07:52:16 -0800
Message-Id: <20230110155216.1809562-1-johannes.thumshirn@wdc.com>
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

btrfs/012 is requiring ext4 support to test the conversion, but the test
case is only checking if mkfs.ext4 is available, not if the filesystem
driver is actually available on the test host.

Check if the driver is available as well, before trying to run the test.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/012 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 60461a342545..d9faf81ce1ad 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -31,6 +31,7 @@ _require_command "$E2FSCK_PROG" e2fsck
 # ext4 does not support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 _require_loop
+_require_extra_fs ext4
 
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
 
-- 
2.38.1

