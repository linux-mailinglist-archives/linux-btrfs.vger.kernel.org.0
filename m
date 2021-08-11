Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3EA3E945B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhHKPQw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:16:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39986 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhHKPN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694782; x=1660230782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xfsbypqwh3KcoJ3yzQaSC5LUs06zuIK25HVL2c6JM/4=;
  b=gbsR5MvJYFiOet9nX8e+kZaUzb25O/5hXq2SfkDTqud3pYvCF9Vgo9FU
   1H3F/HhJ6vWzA9DK3PCoXXM1aaxpe+AkTjW+YOPeMRdOURQSxe2l/lzZt
   03MfcFgeXZWTHEVMtwyKTDK/qp3eFTIm0IpVw0x8Rs8wSbUc8jq08LFsA
   4nz6FiyKAZPGmQiED48DrLJKR2n6CpkAmQV7Ass5nJcsf/tqJaJ+dEysI
   Tu0eCPUwyfxoAxegCxpYG9Y3JkUZR7dAR2ZvjnwoViDWgmiuiy/XtIkX4
   6t1KJGVUEP3fSf2OGVc9bkpYQFuGCCav+oSM49mb7QRN/sxz0HB8pRAg1
   w==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942582"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:13:02 +0800
IronPort-SDR: mNXp1PrTCPBAnCsjKxWRRAScBHUSJmlec1JJ3MqCOhdOfqM1Jl55KUcbOL7jgN4ehQNOjFR8aF
 MCdX+ujWVX2CYdl3kiEwFKfkzY2Ioogsw5dV8eqzcdbPyvixTHFlm7VnWssYTzN7Upb9hIiQVA
 +xMBOE4t3MC62nrfmC4RU7SzQpbmLCBg7UcQaY5XdnHyPCMvkEWxrWvw9tSHmUrxc0tbEPp4rA
 MOYuw/35Yvv9cCzUkm8rImrbBgLrmS3RpOEQVbT1k5maht1nUFFvtJgHIkKoU7LufTxPYuR5eZ
 9fuC01pBz0AgsAuoviyLWw2d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:33 -0700
IronPort-SDR: BXYApj0OI66a2mhE9JtjYNcl8QoODjCXJvE4frH7A5blwo/loP0fZao5TXmYez/6ytQo8JAf49
 v85mEz3s2dDDoW1/riavDd/xmUkiK5bnfgAb5dvAOjBmQhOd/3rb+Ws4v39NwpQilev2FT+vhv
 e1KPumAVt4/bBBtnbvCPkz/WGsM6iFX7oCzjKZgQE6cSztRvX+HUGYZIab7vvxcVFRt9HMkEva
 m2WgMSP723PoMlFDkE4n0Rg8Xu/L2Y9xuMwpUB442MYQNHCUVZwgLJL7/BrLLOdCCOe1s1P0gr
 ExA=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:13:03 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 8/8] fstests: generic: add checks for zoned block device
Date:   Thu, 12 Aug 2021 00:12:32 +0900
Message-Id: <20210811151232.3713733-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Modify generic tests to require non-zoned block device

generic/108 is disabled on zoned block device because the LVM device not
always aligned to the zone boundary.

generic/471 is disabled because we cannot enable NoCoW on zoned btrfs.

generic/570 is disabled because swap file which require nocow is not usable
on zoned btrfs.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/generic/108 | 1 +
 tests/generic/471 | 1 +
 tests/generic/570 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/generic/108 b/tests/generic/108
index 7dd426c19030..b51bce9f9bce 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -35,6 +35,7 @@ _require_scratch_nocheck
 _require_block_device $SCRATCH_DEV
 _require_scsi_debug
 _require_command "$LVM_PROG" lvm
+_require_non_zoned_device $SCRATCH_DEV
 
 lvname=lv_$seq
 vgname=vg_$seq
diff --git a/tests/generic/471 b/tests/generic/471
index dab06f3a315c..66b7d6946a9f 100755
--- a/tests/generic/471
+++ b/tests/generic/471
@@ -37,6 +37,7 @@ mkdir $testdir
 # all filesystems, use a NOCOW file on btrfs.
 if [ $FSTYP == "btrfs" ]; then
 	_require_chattr C
+	_require_non_zoned_device $TEST_DEV
 	touch $testdir/f1
 	$CHATTR_PROG +C $testdir/f1
 fi
diff --git a/tests/generic/570 b/tests/generic/570
index 7d03acfe3c44..71928f0ac980 100755
--- a/tests/generic/570
+++ b/tests/generic/570
@@ -25,6 +25,7 @@ _supported_fs generic
 _require_test_program swapon
 _require_scratch_nocheck
 _require_block_device $SCRATCH_DEV
+_require_non_zoned_device "$SCRATCH_DEV"
 test -e /dev/snapshot && _notrun "userspace hibernation to swap is enabled"
 
 $MKSWAP_PROG "$SCRATCH_DEV" >> $seqres.full
-- 
2.32.0

