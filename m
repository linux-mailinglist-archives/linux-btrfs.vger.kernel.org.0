Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472577AA24A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 23:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjIUVPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjIUVPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD039A75EF;
        Thu, 21 Sep 2023 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695319276; x=1726855276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J5/Mm01U/8HkGqBt2NFeAHTMA49ugVf9griRdMZM9bc=;
  b=OjT/9BopjpGX/QNuLb4abuT0d4KM+xdm3f9ieaUJIXwk5KptG7rXgUQG
   KwlBNj0GlFa6JcuiiEvsmHFwbGR0J0FzOYt5UcykpuEOHdevfYLUal3Ia
   mDXm8EhjOZwkN2yVVIqt1E3kdeG4GLFAiBCuJIVpXaTXBU3PKy3NNbXeL
   nkOhm888l2TyelQ/t64vuO8dQCiqn118auUf2+7gOYIHI2sVioq8EPETH
   BaoSRjP78diBsuCqfeXEejBkOnS5TnDCqf8t1IA45XfgPmuja0xwRxgOX
   KBJTP0vhgvxbahFgF9tsZotInxw3LFidC+FBzoKVExV8knC9Zf1lRI1fX
   g==;
X-CSE-ConnectionGUID: KC3GDAmJQb+sCHBT0IJTIw==
X-CSE-MsgGUID: W6TQwcbCS2eFrOn2iQW9kA==
X-IronPort-AV: E=Sophos;i="6.03,164,1694707200"; 
   d="scan'208";a="349818423"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2023 15:44:24 +0800
IronPort-SDR: 9njPc3Ld3pehKnMA4GMgoGnwp3W5DkuYVIBxLNWbvFlyEqb3czJyp8wO5axNlL1HnV+RNSX0Lb
 478Of/WrC79BO7CSOwluqDe+jekcXxdnNkK/ulLRsKsJ+N9tbyD5v62jxkQLJVd5iekEtWu6JO
 8X0WHUbXznlDB712d/N0JxdLVb+d3IrGPQVp0TJf4hJAmWquBcObeM36QcLhBSJUClmicYzgD/
 Skiu/ElIhp5dx2Q7wC8jXBSbVDrI016k0QszEgHciskFDrrB182mGdRellVNxprwfDVK9weTTf
 baA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 23:51:18 -0700
IronPort-SDR: rF0sQVydsUig2QapScE+ESHXYYV/2xwQ0BDCzBhdhS8rzjf1gV4VqizBjMOauCwYwDtQqTrVbQ
 nMoh5LNSbWwwt0BqgTRYuwAWwU7slTTG8g7ZJBtsNin/T/8jC0+JHgzyyOH8tpV1F7cTA3CSis
 PUAZqIHETGziMISImKxj/viu8V4+cjl7spkF/w1eS1bYvPhp2oHild3j/ac3Iv0WgO97BgawI7
 40HhuE5ewLfvsS/M+a2xTwHCJsTwKlnHRTpHYVsNXYkqAXs8SyW5kst7Iup3tnFggNLad/aR8W
 qvE=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.94])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2023 00:44:24 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 2/2] btrfs/076: use _fixed_by_kernel_commit to tell the fixing kernel commit
Date:   Thu, 21 Sep 2023 16:44:08 +0900
Message-ID: <74525f6b1fd645ac276b701e5032f3f913ed8ce0.1695282094.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695282094.git.naohiro.aota@wdc.com>
References: <cover.1695282094.git.naohiro.aota@wdc.com>
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

The fix commit is written in the comment without a commit hash. Use
_fixed_by_kernel_commit command to describe it.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/076 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/076 b/tests/btrfs/076
index 43dbff538278..894a1ac7fa5d 100755
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
 max_extent_size=$(( 128 * 1024 ))
-- 
2.42.0

