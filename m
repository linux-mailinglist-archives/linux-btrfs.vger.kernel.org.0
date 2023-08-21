Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE1678242F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjHUHM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 03:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjHUHMZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 03:12:25 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBFBAC;
        Mon, 21 Aug 2023 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692601943; x=1724137943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G9ZyhRGZh2z81PLUydMfxH4iIes0hBOJauITXx85a2s=;
  b=HQWuV2HXfJFxsa1u923iHQBEUKzlI1HtUDBgBenjTOmbqZ9blfOByzVQ
   s4gWllC0wXQ2lNQL1LzUqZMP44z2Vpz7tWIBnj9SFgT9Dli4VxaRJRqGs
   H0rb+x72vur9y8/dQyVHMZwwJj+EZlm3mblVBDuoMZuYKVkDoO2dFhnlg
   z5AyIdry89ZQ0QmBTXxfpjmELfhii0EyTZe7nErGl9cI40Y9RbgrrVsGA
   iAuIfstISJ3BUbAGBNDPRel3BciHn2FpEgUHolS1nY60gDqLOb0ET/PL6
   rChjZSihrAjwKgvPeRv7PCuclWdFXmAK4uliDwkNJFM0rTntzdCfptqqk
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="246252752"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 15:12:23 +0800
IronPort-SDR: m/ZrsgfYO8KREpHKijNvhfzn0hOAEjGF2EmTMz2YpBW69Au27FD7Zp6lPJNlSvRXaGWVNDfh2v
 d/7HlYNvxhRyUXxHmQqVeVa/BXlNnHPL/L60oMHIPMXnhjDzJn5c1EoVauYfVT/HK+QG/yq4jA
 2gXQojn1R1px7Fc3fRPR4/sFjWhOWx7gw5G/v4v6DSqCEDaRawP1RQ5qEkDXjxpL8fLKtIJLKk
 0dZQIv+Q2kZh+/M8uO1FDydAoyY7R5fY+yZl9qwxd/kxCbKm3+mT4tGZ25M18Opp605y45x3li
 jek=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2023 23:25:35 -0700
IronPort-SDR: /2vGDwe3woEL4SrdpueKTI2bBQ2aFkyLEr7gUhfpJjJtGz4q//PCJwkUOWDAMlIZXEp+krjrA/
 IWDuUXrSfAyHefVZKAFuIobRBX2hcRF0sunEaXxMp9K01mmZF3vKUuHGWuGTwZD3+5BJTSIHkM
 Jn2rRx5So+moZAON3pBqbtS+kBXVwFF7ksneNuPKo1Aw6FLccNb7qbn9vuiw3iAuFGkrI/Q6BR
 Hwg0Pb/b3JcdZL/rlbb3LN/NimxgnuX/T3/1mwN0qv8pkx/3RSB8ON7gsBMTYQz2bSCIJ7HDZ3
 D7k=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2023 00:12:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 3/3] btrfs/004: use shuf to shuffle the file lines
Date:   Mon, 21 Aug 2023 16:12:13 +0900
Message-ID: <2d118ed03559472a0bf878509a32a9dded03efb2.1692600259.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692600259.git.naohiro.aota@wdc.com>
References: <cover.1692600259.git.naohiro.aota@wdc.com>
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

