Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24D47A1749
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjIOHZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjIOHZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 03:25:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541D1998;
        Fri, 15 Sep 2023 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694762723; x=1726298723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aGwcnyqpRUzXtGffHAx7yD3EmIbDJv62Xe5VNnL25WQ=;
  b=CcJMiSUBmkYhKURXi+dko1MrXg6esIA61jjPgbgN2xB6o6drbj6eNlL3
   YO5V185bAZ5GRkr3am9N17SJdODGxEtufd40Lok05HfcPHH/S8bfhmkzM
   9YIDjIUEWoy+2YOILK/yktkURC0bbr3KFEhbbvbMKNdjrVCs2jAeOU+yj
   cs7ZTiLUSwLeRcLALPsaZzo8cCBfjrHOdKLS+VWFsPaZ1LX/KuBTIcmcf
   T7xY1ArNSG0Z3tn0g1Jmwz1UqZ7rrYoaYPB2TB2oE/wPhVDFQJnzu2l9V
   rRy9hm5VhiY20QLGWyyYPOZNXToizHOZyXqkTL2m8mReuJPWU17nGlyae
   A==;
X-CSE-ConnectionGUID: cZf5YiJ/TUeMvZyw+xjAKw==
X-CSE-MsgGUID: 3l7kmOMLSzisMGbYsMbExA==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="242254965"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 15:25:17 +0800
IronPort-SDR: j0/KMgIjlN2ZSvULyuj3N/pRNprsxh6FvMu3Ge9eYYgFW6FPrjmmAi/wnaYUGhw3rLuJpQt1E+
 cLQsiPVV43QETvbxfDlSgIoNlOL4qfpwcdX5qigaoy9roWRjuTQ4VYT1xkufJpeZp7IPZs18r1
 Lq/kY4xlQps9Bcj3Pv76VMUmVKARV2EczkCEpMj1sfYRX9MRWW0/BNFewoKd9CVjCPnRByToDY
 1O7w5CpuUWwY3cqk7kDcFSZRlgbB4lb2sJJm0CgBWeo+FSfYEjSZ/uzoc3U9SF5/Djo1XiRkth
 ggA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 23:32:18 -0700
IronPort-SDR: ThZuI/M35Sf8GzVOjJqy5La8s2ueaO8G42fRQDmLWeIDyVPX6wHeWWOtYK+7goljKecmu3uNBQ
 xF/1xH8WG6pBbfBHp3+RJH8Q8b10XnOsiBBw0m+4FLRPwRh6vT7PDCiIsB9fsqPab3c11u54u0
 1Wq6Mh3SoBTjOCqZINLtiITUrOi1AjNoRa8Uj/Y2elfpWDTNRzl94RcW5yNUhSy8kYs7LewIVp
 EUbMEd8PLGR3A/NoAt7rI11g3nrHR0n4RopgA6OL377AGYDjMRxs4IRFxa1j8S0Z+xGcc62lgt
 Rok=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.78])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2023 00:25:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/2] btrfs/076: use _fixed_by_kernel_commit to tell the fixing kernel commit
Date:   Fri, 15 Sep 2023 16:25:11 +0900
Message-ID: <d975ad16c184649e89c57dedcb85064cb385ca47.1694762532.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694762532.git.naohiro.aota@wdc.com>
References: <cover.1694762532.git.naohiro.aota@wdc.com>
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

