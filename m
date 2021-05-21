Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5217F38BDAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 06:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhEUFAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 01:00:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33627 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhEUFAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 01:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573117; x=1653109117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XaiGk7DPa4yauZ2+CAQdUSL1Nno7tKoh6bHxWLJe3PU=;
  b=T1LqI2VUHg05zUL/brPmZU93K3SJvIAXJ7paJM9C0SbQ26lWltjofPo9
   9ozNxKKOtrhs58ABMQO++4fxbV8+ROfC/V3f3JFSY/O2GpQd+xfBAnF8u
   88EIWxLsnuFWLAd37D2cOlQKQK40/dOnPau6WM/8ksojkB7tw/IWckt4M
   hl2by6RYfP4nnbQgZUxpTICdoOT4ur+6KGWCf1iY/d4ZkDNZWL8ZyRuN5
   ZhFFUezmBlICETCCmAU2BTWTos5PVRlq7m0YsjxiBgB/ZwHsrX3nBMnwT
   hAgIaLTZw+LCInYBk3DlYKE6nAg6Lr7A8LE2eBiQH/rj+NBd7tSKpPaaW
   g==;
IronPort-SDR: wC4wzxhOHZ+YJ827pblKCFltqUzuiIgBCmEIV2bqD1+qgl+eKWmjYb84oPNLU9VEn/s/yVd2T/
 sJ8jWU6JHsL6+wy8/Ohtsq0kJ8DvaI0KnZxPNLrNCni7jfeUUoM8pdbmZERAQaKeIrDVrJkc5m
 ygc5MkozOOpfDlvsrSleJBpnskeSrGb/5wTul29i7XkFGuA21qNPqfb+3s/4rmgheOA5ctPUmJ
 CDoMhhqYjiMn7sKkxkCkX22rC6kSf3ws3jm3Ft/uVcZ9cfHI6aQFwUVeJ/OmKu2RT2TpVEUpsJ
 nqk=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168955591"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 12:58:37 +0800
IronPort-SDR: y+jo2P2O3RcCV3AEo3TM2Q/zzySRS2xv78PI2BVKW17yzLZ4PqZHfQ/G/iTzjKWGdasb60PpZc
 fngicsw3KF8ao71Wro8FkR03hbyWcDxvxiPRHA5BCee+aGsXZUEbxaFADtIYtYWJ8zgN/dmg1H
 1OXit8LG92ngiEG4LMLXait4FvWUClwGLd3dNKrTkr3zr3NMDaNmZ2nCloF1YI0GSkLkmrGwCh
 TLiOg1O5WMnZPmGAKw6nNNJXdLqH2qzaAl0FVPSBmwE14HplB8IBSzIaDN4gW0u3MTh8f3T0wv
 mMdp99TnkQk73NRA3w+P/X3z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 21:37:01 -0700
IronPort-SDR: P+cYQJS9arhUjNOyoTa6zx3nRlrq3ED20ofHlt34PHEPlMLjOojA1yjcBJk7Jm6K3+Y+fB0Ce8
 swAQsUmNJRcHkgJS/KJhWSF13sUIc2GEPaOgj5Fl1C+0IP0KfEbAlg/AYcVtNWsws/IhLKvjs0
 U23mjlRiL53JuPCZNMVdwsPyssxk05JJXudAltWzCp0mR4bUZdSzOj8QAL9CMcXu4SOL61sz20
 u3Nyjba7W6wLW724o88/on5RXv46Vw0tjSRKt2RyhUblVWS/+N7zZ8HmA9Vhu0aZ5X4Vw0EARx
 QuQ=
WDCIronportException: Internal
Received: from 9rp4l33.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.75])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 21:58:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/5] common: add zoned block device checks
Date:   Fri, 21 May 2021 13:58:24 +0900
Message-Id: <20210521045825.1720305-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521045825.1720305-1-naohiro.aota@wdc.com>
References: <20210521045825.1720305-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

dm-error and dm-snapshot does not have DM_TARGET_ZONED_HM nor
DM_TARGET_MIXED_ZONED_MODEL feature and does not implement
.report_zones(). So, it cannot pass the zone information from the down
layer (zoned device) to the upper layer.

Loop device also cannot pass the zone information.

This patch requires non-zoned block device for the tests using these
ones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/dmerror    | 3 +++
 common/dmhugedisk | 3 +++
 common/rc         | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/common/dmerror b/common/dmerror
index 7d12e0a1843c..84d2c338df11 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -15,6 +15,9 @@ _dmerror_setup()
 	DMLINEAR_TABLE="0 $blk_dev_size linear $dm_backing_dev 0"
 
 	DMERROR_TABLE="0 $blk_dev_size error $dm_backing_dev 0"
+
+	# dm-error cannot handle zone information
+	_require_non_zoned_device "${dm_backing_dev}"
 }
 
 _dmerror_init()
diff --git a/common/dmhugedisk b/common/dmhugedisk
index 502f0243772d..715f95efde29 100644
--- a/common/dmhugedisk
+++ b/common/dmhugedisk
@@ -16,6 +16,9 @@ _dmhugedisk_init()
 	local dm_backing_dev=$SCRATCH_DEV
 	local chunk_size="$2"
 
+	# We cannot ensure sequential writes on the backing device
+	_require_non_zoned_device $dm_backing_dev
+
 	if [ -z "$chunk_size" ]; then
 		chunk_size=512
 	fi
diff --git a/common/rc b/common/rc
index 9a8458d4a3b6..55cd8e8df8f6 100644
--- a/common/rc
+++ b/common/rc
@@ -1812,6 +1812,9 @@ _require_loop()
     else
 	_notrun "This test requires loopback device support"
     fi
+
+    # loop device does not handle zone information
+    _require_non_zoned_device ${TEST_DEV}
 }
 
 # this test requires kernel support for a secondary filesystem
-- 
2.31.1

