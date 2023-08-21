Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E87823C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjHUGhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 02:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHUGhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 02:37:13 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4A4A9;
        Sun, 20 Aug 2023 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692599832; x=1724135832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G9ZyhRGZh2z81PLUydMfxH4iIes0hBOJauITXx85a2s=;
  b=XQ6wl/MGQYIKCXuWyZCwgHf7eEHvj0+mc+tfD58PY/jKrh4vBoMcfPeG
   xw/O7tMv10dCPC0UHK/mt3VIeRtaHe6zOIvdVVfZyFV5mZj0S4v1xaYfJ
   41+rXFln2Md86YloWK2T1mlotFasz++7SSjigxE516FPc1A+N6OVWnkjE
   OC10twT4xNHfpOtQUYFljIUrbkZLrMZqocKf6TOY0zINbRHw+toWzRA14
   XH87ymLBd5RHWOnk3x1Uu4ObLFtzqoJ/uP8td0GAGqLTbOl0Qu+crlBsU
   pvoi8AxKYHYAPjddtS+7ZjhQT04RH5e0IxNyLloGu705ibGK8NvYrCMdL
   g==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="241991953"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 14:37:11 +0800
IronPort-SDR: 2APoeC2xbV7fi38+cOZ9HohAWFqPmRaI2nKNHtX09/QidExbpbVpO1q2tjbr+67phs8bnsSD7v
 v808R33Jv64oyhWeFfIh0e2IXSdxP4vuFKC3soUyNvCsOR93h0FaiEIcGuTT5xJE0W+r6HRTvf
 kEAWyGRotIbqimLwP8j/C0GVHE0zLCXad8e+Dyi3c925IlaHJTFNAltzoUq3QmcGQLjzl+MXGX
 Fjtt4Ndclxtb7NCbKe3Y7e3/YU82ic+94b6rypp2LiM58Oj7I3IjJZApocIrDSCdCdlGv4GqbJ
 8ek=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2023 22:44:43 -0700
IronPort-SDR: 8B9YpI4ticd2Yi8e1aIL8ZXiwuwLSk5nm46pmREJIkZCc4QzasQGAG8jAbw0eY311qMysLo3Hf
 ihZjKp5sjZmZ+hr6WcbmlDjeI/xHFXVDbA3zlFFKccWHuXZOOEu2Glmpfe3U4cDA0iYgTGHwdC
 IZ14Bk7z3PSHJTVpHsXKJi4AAPF8QQeRlbsQl63IU6+XPrs2muRlGfMWB4YvbS1p9gMtWzsIr8
 3Q4tW3OmFgjKZEpwFfQ5LrNoj3LU1X5TPMMBXKcLX39h8gLsJT65MiBhCCTvBYJf9jvLqEimBb
 okw=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Aug 2023 23:37:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/3] btrfs/004: use shuf to shuffle the file lines
Date:   Mon, 21 Aug 2023 15:37:04 +0900
Message-ID: <ec5d63686914faace908a3b4a3152d639b754f4a.1692599767.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692599767.git.naohiro.aota@wdc.com>
References: <cover.1692599767.git.naohiro.aota@wdc.com>
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

The "sort -R" is slower than "shuf" even with the full output because
"sort -R" actually sort them to group the identical keys.

  $ time bash -c "seq 1000000 | shuf >/dev/null"
  bash -c "seq 1000000 | shuf >/dev/null"  0.18s user 0.03s system 104% cpu 0.196 total

  $ time bash -c "seq 1000000 | sort -R >/dev/null"
  bash -c "seq 1000000 | sort -R >/dev/null"  19.61s user 0.03s system 99% cpu 19.739 total

Since the "find"'s outputs never be identical, we can just use "shuf" to
optimize the selection.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/004 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/004 b/tests/btrfs/004
index ea40dbf62880..78df6a3af6b1 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -201,7 +201,7 @@ workout()
 	cnt=0
 	errcnt=0
 	dir="$SCRATCH_MNT/$snap_name/"
-	for file in `find $dir -name f\* -size +0 | sort -R`; do
+	for file in `find $dir -name f\* -size +0 | shuf`; do
 		extents=`_check_file_extents $file`
 		ret=$?
 		if [ $ret -ne 0 ]; then
-- 
2.41.0

