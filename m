Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60F1383CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 07:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfFGFjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 01:39:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18377 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFGFjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jun 2019 01:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559885955; x=1591421955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RKQgkpClO4Cg3+V+yzEKsa+T2NMknNbzGMNgFAmEXIE=;
  b=WwniPXrTUfnbEkko3UfprkMdQVdmelByvFrQOmPCbzNRtADu+qHf3JQO
   KihtQkyl4diw1GYB9SNUlJwcyLyQjTAb5mdfMtgjcE4dnNphVHC0wuV7s
   qQpw6pP57mqCUmNxSsfA3nOMN+QBFU1StgmbCCCA9bz5YQHCW3MGs2nGZ
   nDx85f6sRS6WjNIR7BiX5fPBTGjtgBmlOGtldcI7smfrfWAJA1v6aJx25
   nwrlQH6VPjLnWIHH1OoRTfRiBxAc1mU3m+6CQF9oI8YIbIjCJgQwXIj0g
   vE79sgaDeNyxf6fNkxiS+/sS2bVuL/flWAu2ZHfPLj+ssVJk/I66fLLq0
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,562,1557158400"; 
   d="scan'208";a="114955384"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 13:39:15 +0800
IronPort-SDR: 2DPrSdaTG6HY7D3lsF8cZIB5xvFqtKHh+KjKphu9d19H7lZOa0CUyJegPzh6rsEY6XPbEaw09Z
 krhLffcvJECrBVXn9f9mnNrUyay67w5jEECsPZaHsMpl1nvU6prZUNr5Dk7iCDPQvmQLuFUQ1u
 NoQGONSa5GwJpzLERwBg3osOCGFo42NAMfDm0gBBA4F1LcUBHqTXzaRgen7IRKnHjYhRzGEXxr
 PUrNFVvsb/QWLRlQQeWYmBMwsSQUdksmbU/freNF4HOor8r/CZsoalyGqFXa4rPJFsQK3wU3Gg
 ZI+EeXvn96XuRnRf8So7I8MT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Jun 2019 22:16:32 -0700
IronPort-SDR: BH+wDU7w4gSWs+uvXBZvNblU+itVxsiwNsAyGrPW0Qwd0SrDpRcmAu6quojgrk5k9OeQkO5pGz
 U+D4if64xnsEUgH8sZ9lBVk8pbEUgqb7Fd3FSPQu38NxovLFxSCPcd7OW9d3+ovL448pdRnhM4
 TH3fRkpBswYvBu/5nGJ4Lh4Ws3j3/96LAn19YJ5FHnsuMTfI2kKsopuuymlfZZYWXPwdkFNpZX
 IG1EztvqST8Rph8Ta7TgfT9JW4n1sCRC84Vn9TzwCZ1ShMggMrXb2yBpouGl3cyedPscPzrpP8
 anQ=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jun 2019 22:39:14 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     fdmanana@gmail.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] fstests: btrfs/163: make readahead run on the seed device
Date:   Fri,  7 Jun 2019 14:39:10 +0900
Message-Id: <20190607053910.2127-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long lived bug that btrfs wait for readahead to finish
indefinitely when readahead zone is inserted into seed devices.

Current write size to the file "foobar" is too small to run readahead
before the replacing on seed device. So, increase the write size to
reproduce the issue.

Following patch fixes it:

	"btrfs: start readahead also in seed devices"

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
changelog:
v2:
- Update the expected output as well.
---
 tests/btrfs/163     | 2 +-
 tests/btrfs/163.out | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 8c93e83b970a..24c725afb6b9 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -50,7 +50,7 @@ create_seed()
 {
 	_mkfs_dev $dev_seed
 	run_check _mount $dev_seed $SCRATCH_MNT
-	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar >\
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >\
 		/dev/null
 	echo -- gloden --
 	od -x $SCRATCH_MNT/foobar
diff --git a/tests/btrfs/163.out b/tests/btrfs/163.out
index 50f46da6df86..91f6f5b6f48a 100644
--- a/tests/btrfs/163.out
+++ b/tests/btrfs/163.out
@@ -2,8 +2,8 @@ QA output created by 163
 -- gloden --
 0000000 abab abab abab abab abab abab abab abab
 *
-1000000
+20000000
 -- sprout --
 0000000 abab abab abab abab abab abab abab abab
 *
-1000000
+20000000
-- 
2.21.0

