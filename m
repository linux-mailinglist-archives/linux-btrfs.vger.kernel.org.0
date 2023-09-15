Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4FA7A16B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 08:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjIOG7Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 02:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjIOG7W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 02:59:22 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ECC2D6D;
        Thu, 14 Sep 2023 23:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694761131; x=1726297131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aGwcnyqpRUzXtGffHAx7yD3EmIbDJv62Xe5VNnL25WQ=;
  b=bKhXwjnexfRMcptYeJQcpL0maWdIL6gyP9Sx34oraqbsXuBIUtDXDHat
   o0NjKAA/DBzs1tJfFs1emMeoU26lE9AYng8sQrDU0U6zEkeh98nGdB4p5
   ZzXAuQpr2nW+C8QhRMwiKICFY9fGB1cfuQb1z8UHtvJhw/CjvN946g3KD
   0LweVdQPfPg39zIMQOKok/xFMzbpiPC9x/Ek1SZVEw87FbOv5dSekOm5A
   UAbXckvCcwJFM6XbiVHG3FtTFaCtY4MKAfLi5Z1RdXdL/lX50A639dq/d
   BFuJg866fYc9vCfyx5GiiNifj/ocBZCC9lkPvQCj5bDP1QJzwYinpRSjk
   A==;
X-CSE-ConnectionGUID: 7JuOGogXSEmvSoi0R/aekQ==
X-CSE-MsgGUID: RCQ0C76SQGC7vnK+omDnDA==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="244368682"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 14:58:14 +0800
IronPort-SDR: GNYFFCjW8azvGCLY/weOuX2JNicw52Tykd9NwebmtIa0UaA9So421CYYwGMxyxUnMdoAou3RZQ
 iEgU1aL9xGwpVrCGzrrdE4gKNHlEcnDoRPZ8jr1BmxFWIJInmERKLYGmJkznuw+LfGIfielH06
 ZoSqmfPFrJ/o6l1fIsCNm0UhE2GqSTqHFF26pxFKz0ImwJNm/2k7xEnSorGvY3tfqOBuvFmpoj
 wqBIQs0NqlkmxoMdxC6Kc6QMQ1eH7CggVGXPe+7fEK3xaDWsLKmrOk5i+FAhYwe9U/n/9d4MTz
 QTg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 23:10:56 -0700
IronPort-SDR: d2YGXROPu2NpOPnZObf/O4waNZuUbs4tsLEYzg9j88ZV6SdEYb+1luTpDsVGQ68xfn54Pm4RM2
 L5n+oV4HcCKwyvXaAvrGflF/sWL/lYiLlib5Z3j1Wa2pa13US/VxrbxDIc70rQXOlEu4hVutFv
 lvS/RSJINcLbksvLpWyIcdM1RdN6y2TPE6Dn9eGPHbMWRyA7fXnLbERK1j11EGjRXqNdwkLRL5
 exd/RJ9x4hlVzU1rnYYuQqmDmCbXgPk9w51wH3VLEuQzxR1mL+ASUFZZ/9/B9Av/KgjCCnGEnN
 mWk=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 23:58:14 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs/072: use _fixed_by_kernel_commit to tell the fixing kernel commit
Date:   Fri, 15 Sep 2023 15:58:00 +0900
Message-ID: <0220e061fb52c6318d599d5dfd9aa10ef3fbaffe.1694760780.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694760780.git.naohiro.aota@wdc.com>
References: <cover.1694760780.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The fix commit is written in the comment without a commit hash. Use
_fixed_by_kernel_commit command to describe it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/076 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/076 b/tests/btrfs/076
index a5cc3eb96b2f..dbb67bd1c241 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -5,10 +5,8 @@
 # FS QA Test No. btrfs/076
 #
 # Regression test for btrfs incorrect inode ratio detection.
-# This was fixed in the following linux kernel patch:
-#
-#     Btrfs: fix incorrect compression ratio detection
 #
+
 . ./common/preamble
 _begin_fstest auto quick compress
 
@@ -27,6 +25,8 @@ _cleanup()
 _supported_fs btrfs
 _require_test
 _require_scratch
+_fixed_by_kernel_commit 4bcbb3325513 \
+	"Btrfs: fix incorrect compression ratio detection"
 
 # An extent size can be up to BTRFS_MAX_UNCOMPRESSED
 max_extent_size=$(( 128 << 10 ))
-- 
2.42.0

