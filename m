Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AD43E9453
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhHKPN0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:13:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39986 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhHKPNX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694778; x=1660230778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s2Pc7oDcG0X82jcRxNaM184LmvuXSQJy2M4KZfdmrSE=;
  b=j6aA2qEuYDdZo8DWQFtF6f8WpjBEThowZhZg3SKq67WPfyjHozhMpcx2
   v+NDRDJCGo7S8PogI75FMUT837UYn22ss4tVlJP/cnMvcDzqG6qcV+MSv
   HaMpDwE/ht0Kobin01dDNVA72LlVqlrEGrJXfFz0C4Ix2TbHJVrsGQ2nv
   oTqxJWdQwI/9POciNQId/57kAijgn9laxqjVhaNxqrUFCyX/yFPTzIdKu
   3e4CCZD52ATPh062i2H+IMuuzOGiShEKMh3Z0fDXc5UshQ0veCamGYmO3
   G4K26UyiZ5x22gwVyLiK+ljl7vwpxkMLzErXJM9wUEGND16sMWZjmWDr0
   w==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942563"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:12:57 +0800
IronPort-SDR: 3PQqdiedGGOItY2LxCoCW0/IMzFS+uzfkyHkJHWSh8Rcam830vLPZwrJZ+gszRUJIzw+XHbJSn
 gvEmE+E/PjW9cAXGIhawfIQkfW+IL93x6QRKRYZ3XgyXFHZBtjiJGlL9o5m6rri8C2g2igX83w
 JQ6GxKCtas9MmZbBvauBCPmoPDnZR2uTa9nQIAfCApSxa2BmL/b3TSST3voRuZejD6643qpk27
 aCPd6i+3MTjxLMa5O9MFr9mWFRz4pGtQZ4gniPiFXNZVwTtW36mL56apxiAbomSvBpF6Bq7Qb7
 x4atFpA+qeuEeilkdjY/+a41
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:29 -0700
IronPort-SDR: EfCpYHw1gBDEhWXyXPbFTvFV+jLh/RYWrF1YGaJX7Y5rwtixgYU/kJZPzKSXDf84XeFnCL6fZA
 DDI90NUdb8zvw2OrjKvC4Zmf5BVkQIGrdQ+rw/5b0a3ICHGUzmfFCD7M67EvfkqImOpCnyTS1D
 jso8lF+fcuFqtz6AjLjb9KPJ8znnFeyvgR3Rd7OJWr5fan4Umlr+1UrDYsBOviEcozyZyS2uqN
 +aXne11IAD5a/fg6FL+9ilaB9cCqzyIrkcj6Qemu9eOivm6SUQkGWEqhqmFwe+5RSsYPxZuCh8
 KkU=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:12:59 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 4/8] fstests: btrfs: add minimal file system size check
Date:   Thu, 12 Aug 2021 00:12:28 +0900
Message-Id: <20210811151232.3713733-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some btrfs tests call _scratch_pool_mkfs or _scratch_mkfs by themselves to
specify file system size limit. It slips through the check in
_scratch_mkfs_sized(). Let's add size check call for each of them.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/141 | 1 +
 tests/btrfs/142 | 1 +
 tests/btrfs/143 | 1 +
 tests/btrfs/150 | 1 +
 tests/btrfs/151 | 1 +
 tests/btrfs/156 | 1 +
 tests/btrfs/157 | 1 +
 tests/btrfs/158 | 1 +
 tests/btrfs/175 | 1 +
 9 files changed, 9 insertions(+)

diff --git a/tests/btrfs/141 b/tests/btrfs/141
index 6f9a177a4487..cf0979e9b42a 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -55,6 +55,7 @@ _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index 3caa37d167ab..1318be0fba18 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -33,6 +33,7 @@ _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index f062f77bd7ce..6736dcad1702 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -40,6 +40,7 @@ _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index 56938b0f4500..986c80697f15 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -43,6 +43,7 @@ disable_io_failure()
 	echo 0 > $SYSFS_BDEV/make-it-fail
 }
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
 
 # It doesn't matter which compression algorithm we use.
diff --git a/tests/btrfs/151 b/tests/btrfs/151
index 3150fef07e19..099e85cc7b2e 100755
--- a/tests/btrfs/151
+++ b/tests/btrfs/151
@@ -23,6 +23,7 @@ _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 3
 _require_btrfs_dev_del_by_devid
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 
 # We need exactly 3 disks to form a fixed stripe layout for this test.
 _scratch_dev_pool_get 3
diff --git a/tests/btrfs/156 b/tests/btrfs/156
index 364135ab3e65..11bf4638c7d1 100755
--- a/tests/btrfs/156
+++ b/tests/btrfs/156
@@ -37,6 +37,7 @@ nr_files=$(( $fs_size / $file_size / 2))
 # Force to use single data and meta profile.
 # Since the test relies on fstrim output, which will differ for different
 # profiles
+_check_minimal_fs_size $fs_size
 _scratch_mkfs -b $fs_size -m single -d single > /dev/null
 _scratch_mount
 
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index c08cebdc9c22..0cfe3ce56548 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -60,6 +60,7 @@ _scratch_dev_pool_get 4
 # step 1: create a raid6 btrfs and create a 128K file
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid6 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index 4a642f52c05e..ad374eba8c7e 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -52,6 +52,7 @@ _scratch_dev_pool_get 4
 # step 1: create a raid6 btrfs and create a 128K file
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid6 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/175 b/tests/btrfs/175
index 8a9c0721f5ed..bf0ede257f87 100755
--- a/tests/btrfs/175
+++ b/tests/btrfs/175
@@ -14,6 +14,7 @@ _begin_fstest auto quick swap volume
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_scratch_swapfile
+_check_minimal_fs_size $((1024 * 1024 * 1024))
 
 cycle_swapfile() {
 	local sz=${1:-$(($(get_page_size) * 10))}
-- 
2.32.0

