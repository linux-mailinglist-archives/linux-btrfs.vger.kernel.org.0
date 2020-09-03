Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4ED025C493
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgICPMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:12:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25800 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgICMTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 08:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599135547; x=1630671547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VfLOlmE/2aCMCl8VZCY6JBjqufmAUHpAoMuPvGfpSEk=;
  b=d/c5vM2CJJBbBp18cWiFI7Ka4uWpuNDkGQ0fC3tEKubpTAFPK0Fk52Ki
   y2zJ8FQl2xvJMXWAsk6AQ7xbpL1vXIjFri8mhGaSpgNQO+MMcU4Rv9toG
   9wNCTttKimllt2oisxy1/UCsaRHTmmC207rczlVhwo6MlVnnhcmQ0ZPoA
   ZD4RIQv88/d2kKe2PdtO4BDi914SyokNHDGxnaVVTqRzgVRMpvAh7PTcO
   Ueq5z7S9LDpFv/sYefvb3t8S3WxQ2oMN3D4ih5aJzVregJuspm4jmeqW+
   DUFmvXsM7V2WHySdSSXewWYKn8MJZYFvCAF+CHRHnbjBqmWWxl1/V3eTk
   A==;
IronPort-SDR: ubY60Qc8no5mSewcoBvn6a2/s2Ed6YN5EIkhKgzKwD4j2CmFblA8h/CFFq03qfaglGocpZ8jWY
 soyZ1AaUUO10JlDG57BCyNRO48ugR3Z64Oi+Y9Ga6EiDroYfsfydJGyZtw+xkKaysIn560gho4
 pc5f0T/MUaxVqgsqJoLOoPiJs9FAf8BqFeSi7/Rid0weNU9x5PEMjfCIDRnbVQB5MawwiIPro4
 u9/WggTp8gQe8zVwU6q2tsZEGpkSUiBrAd3qW/IIt0BQf5COA8pU7vCQCl8ebgXBLx4Fx3hTb7
 Qe0=
X-IronPort-AV: E=Sophos;i="5.76,386,1592841600"; 
   d="scan'208";a="150839210"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2020 20:18:22 +0800
IronPort-SDR: solpUvhkaisHpFYNuWmWfcrjRe3HKU6yNgZah538E0JjVgwPfRGIUjitUzg8ukKfhh3FW90tLV
 TfYvdlFyA0ww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:04:56 -0700
IronPort-SDR: I2381ld81JVgHFK1lo/RADNWh60NX6p/nVpdAl4vjz1jQzTJSkhChf/uEMRck13buKzDrohMBR
 cB6WmRSIIppA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 05:18:21 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs/011: skip if on too small devices
Date:   Thu,  3 Sep 2020 21:18:15 +0900
Message-Id: <20200903121815.7797-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/011 does require a spare device of at least 10GB, skip if we don't
have big enough devices, e.g. when testing on ramdisks.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/011 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index de424f876e6e..f96d11ce6ee6 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -51,6 +51,7 @@ _supported_fs btrfs
 _require_scratch_nocheck
 _require_scratch_dev_pool 5
 _require_scratch_dev_pool_equal_size
+_require_scratch_size $((10 * 1024 * 1024)) #kB
 _require_command "$WIPEFS_PROG" wipefs
 
 rm -f $seqres.full
-- 
2.26.2

