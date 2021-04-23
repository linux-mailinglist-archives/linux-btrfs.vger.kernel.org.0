Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560C636910C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhDWL1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 07:27:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21581 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhDWL1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 07:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619177202; x=1650713202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z60KLyNq2AWMe9YzqvZt4u/Lx64f02p6j1PomXmYUGs=;
  b=SqgABVnGPxPSDT+YQa8llyIatWqMVuCMuzFCmftg21PR/bjKZ6TVDQWz
   8SW3kmKBoH0R6gOVLO/IaSrBZ3S70moCa8LWLyoGDo5KTq3i8iVVjJfS1
   6KLmAgVfsPqSQtEJFh2ScrMFk3n2uc8uxxT7WUNWO0O/OY1F/yNsr9Te0
   qLPvWk9pWxi3l8Lu8Sp5c14NM0sEvSJCo7LLKr9s9KVNycskwErNdTvAf
   /dNCttBeSCJrLiAy6cYMak0JhPgF/hcDY1il+KkPbIJ56qxu/X8hN7CiS
   Bwmhb3ZWknKCu37h8BerpFQstFyHuEsfzBvDswMeTtT1+7oRRporatJPZ
   g==;
IronPort-SDR: cIy/vm5R9dUW6NfHqWCUUZVPSwRZaBD0ehxlFibpuscET9WsVTpThxiypeK+W0uL2xsUYHAq37
 C4Ce3XMxlGjgIYpDwH+PYnWjPHAfEia53a35VhGqodFGHexnPAbFPLGlxofW97HLx5MZEYSHFZ
 GrCfNuZSUcZVgNku0USzzKCE1DZ0Y7O6g8GS8JEK+57SG/mS0kHak7s926ETSbj/9ZeF7e62oO
 /+3KcbL1Ubb3Xplzo/nIgXKGUg5QqMn4kdUQDJX8jSSxh/K40BdlDApQ8FwoSYPSmZK3qzYWiT
 Aag=
X-IronPort-AV: E=Sophos;i="5.82,245,1613404800"; 
   d="scan'208";a="165365026"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 19:26:42 +0800
IronPort-SDR: 23mLjuL/p6XRqKDS9qqu/5Wx/dLhQ8J6VYRHabKVAxe7ctyUQXLxKVeFOb1xOmVRIwN2UQlKfX
 xdpqicR2gk1E+eVVJpRKpR7ulsK+qujbMnjtGLMbUIXqZMCm95XJ1r85vmD9oknGW3oSuF6ech
 LaaNL2KLpu26R33VUbwX/MLQIDMTsPewBn6buTv0eos5r3iJC9UJguxYBgH0eW1xe+VNWtBex4
 d5Pomisuh2BdmX5KyG96qv9TC2bRkQ+2iSez/llHxIxvanE+4SZUWBTXWk6Ze1vUNOHBEQHfx5
 mEAgIeBgAp0AjJ7fx4S2wm9x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 04:07:16 -0700
IronPort-SDR: z6NFRIOzId/X6P4Q9cKU9tYVVZkcKpcw7sss4wAgIerFaiKKRqaiZMnxtIZt+TLd/coRBNU87p
 0pypJUXW7Yivt0qEPadP1VH4/TqyW482FaveyKT9Y+rJK/q5rfzt+BeB7iMDj6WU/a9pufECmL
 9H+gLxDnbpW9pNPvBJefjIdAv41STNPz44fleO1zStlZhxqTRvBLmPf1hNKUZ8Cr5AZ+uvvBKp
 LGHf5qpfph1nXJiiELNwAC+CWEHRFHdH3GkX89oxCVZNmxHebFstJ9BC9T7J1rdiIms+SLj6aS
 0Xg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Apr 2021 04:26:41 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/4] btrfs: require discard functionality from scratch device
Date:   Fri, 23 Apr 2021 20:26:32 +0900
Message-Id: <20210423112634.6067-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
References: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some test cases for btrfs require the scratch device to support discard.
Check if the scratch device does support discard before trying to execute
the test.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc       | 8 ++++++++
 tests/btrfs/116 | 1 +
 tests/btrfs/156 | 1 +
 3 files changed, 10 insertions(+)

diff --git a/common/rc b/common/rc
index 11ff7635700b..76a7265e23ba 100644
--- a/common/rc
+++ b/common/rc
@@ -3587,6 +3587,14 @@ _require_batched_discard()
 	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
 }
 
+_require_scratch_discard()
+{
+	local sdev="$(_short_dev $SCRATCH_DEV)"
+	local discard=$(cat /sys/block/$sdev/queue/discard_granularity)
+
+	[ $discard -gt 0 ] || _notrun "discard not supported"
+}
+
 _require_dumpe2fs()
 {
 	if [ -z "$DUMPE2FS_PROG" ]; then
diff --git a/tests/btrfs/116 b/tests/btrfs/116
index 3ed097eccf03..f4db439caef8 100755
--- a/tests/btrfs/116
+++ b/tests/btrfs/116
@@ -29,6 +29,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+_require_scratch_discard
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/156 b/tests/btrfs/156
index 89c80e7161e2..56206d99c801 100755
--- a/tests/btrfs/156
+++ b/tests/btrfs/156
@@ -42,6 +42,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _require_scratch
 _require_fstrim
+_require_scratch_discard
 
 # 1024fs size
 fs_size=$((1024 * 1024 * 1024))
-- 
2.30.0

