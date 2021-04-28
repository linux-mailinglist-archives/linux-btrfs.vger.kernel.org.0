Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FE36D431
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 10:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhD1IrE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 04:47:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48814 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhD1IrE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 04:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619599580; x=1651135580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JybtB+du94uMbGiT9jVrseN456JK463aeuF9MvLWLec=;
  b=YQjNCvBNakvPFWONyvTAb2cCUWoQiGLPp3MWBrsg2VvaVdF7YcdMbQYD
   RzVzEB8OR1qsZxBxM0fNxtWHqZLy5Qo/HEpkD01Mkbo36F/NRVBMRyusu
   GBtdmEGEpQCb4GL5EAjpvsPX6xw7/YwSwgzzwIRBLB4dUxMx1SRydEiur
   5D4KTWlcaVyfGog+BA9/nzZt6SWqGYImEG1Q5BZ+glaVpD7Xxuixq4JD5
   NuWh7TWVvmr9sjGa1o5RcTYrgy729Z4ACLHrheaOmaruIEoBrAeczIiG4
   2ik44W9XZ4dVGN1lZpLz1Gk+7xqPFp9bdEJ6w3EUjPcHybQomL/4T26Vf
   w==;
IronPort-SDR: NS3BuZqzU2z05lQwrVuYAPZ1yFVZw4UdfoAtWjJd364ZqubYIGiJL1fjkRP1YWR9GWQqIl0kZD
 WQ2nyntAjEM7xv8TPAf5YVNK8k8fBBH9HGA/WlD7iazqTEpLnxxTmfEmuE6hj9DepkULy1+XWE
 OEBk+VIHLGI/YTuj08bYmHNtDp05Ic6/PmNCVbGCpTWCAmv9hFHRyHO3cMrg54qYbPPLZXwc9m
 ZnVFzRwTHrqkiv/IFlIzrgHOGHjKij0g8fRUI2W3f8CEG91EyZht5uANjTNAqOri6FeJv9IFej
 UuA=
X-IronPort-AV: E=Sophos;i="5.82,257,1613404800"; 
   d="scan'208";a="167061148"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2021 16:46:20 +0800
IronPort-SDR: LfyG/wx+psWaZY9eBrLYKbAWtKSpx88RDYHiNXFqNin5cf9VMOMYr+eSPKn1fsVTX2kfFx1bO3
 FGqUPeqgx8Mhr4kotnAQcC5GIzfolOdtdKdnhwitrAejZBg++dxbLO+Tpe7eP+QyKdZdEdfYd2
 6TLuTopgPU+qM9+4t9gdLneWO1f6K8hZ/yB+8bSE8q1LcZ0Mwr3N5SxLLzYpAYzEgGmaapMAar
 ipEQ3wfyJtwHZ/1ccRNaecUhyPqhRmgHnbZ8uyYcqeCS5yXWZLt/UqXCpAHcYMLhQHVH6HOCDy
 swqxXcfqkm8NB7EiQef+gk+w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:26:39 -0700
IronPort-SDR: SyuTT1RDum3BEdhscWoFk7QIZH8foOGaZ+0qZSlmM6ZOFNzSH1I0X9ln/4YLn9LYSzn7Es1PpP
 /CFiWvAUonK36ccNjDg+sk1sPngVVPHsPjNdu23pHAiPUnr87OuR1tE9s199AqN5H/egQnye1o
 GFXlRaAT29b4sZ2AwPYTNF/wt5MfjLYEHx70VEnrSqirVGRqptU5zqFKx2Hms0w6rZue7anoeR
 tSrydtC9hvt0QJ+7RqCExoAp39BzgCjc0F3MlMpimph0uvXBR+Jg0wTn14oVbpuq5LGoLYRo1s
 8Gk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Apr 2021 01:46:20 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] common/rc: introduce zone check commands
Date:   Wed, 28 Apr 2021 17:46:07 +0900
Message-Id: <20210428084608.21213-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
References: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

Introduce some zone related helper functions: _zone_type(),
_require_zoned_device(), and _require_non_zoned_device(). They all take a
device path as an argument.

_zone_type() return the zone type of the device according to the value
returned from "/sys/block/<disk>/queue/zoned". See
Documentation/ABI/testing/sysfs-block for a detail.

_require_zoned_device() checks if the device is zoned. If not, it skips the
current test. _require_non_zoned_device() does the opposite.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/rc | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/common/rc b/common/rc
index 2cf550ec6800..acc750e6586f 100644
--- a/common/rc
+++ b/common/rc
@@ -1931,6 +1931,50 @@ _require_dm_target()
 	fi
 }
 
+_zone_type()
+{
+	local target=$1
+	if [ -z $target ]; then
+		echo "Usage: _zone_type <device>"
+		exit 1
+	fi
+	local sdev=`_short_dev $target`
+
+	if [ -e /sys/block/${sdev}/queue/zoned ]; then
+		cat /sys/block/${sdev}/queue/zoned
+	else
+		echo none
+	fi
+}
+
+_require_zoned_device()
+{
+	local target=$1
+	if [ -z $target ]; then
+		echo "Usage: _require_zoned_device <device>"
+		exit 1
+	fi
+
+	local type=`_zone_type ${target}`
+	if [ "${type}" = "none" ]; then
+		_notrun "this test require zoned block device"
+	fi
+}
+
+_require_non_zoned_device()
+{
+	local target=$1
+	if [ -z $target ]; then
+		echo "Usage: _require_non_zoned_device <device>"
+		exit 1
+	fi
+
+	local type=`_zone_type ${target}`
+	if [ "${type}" != "none" ]; then
+		_notrun "this test require non-zoned block device"
+	fi
+}
+
 # this test requires the ext4 kernel support crc feature on scratch device
 #
 _require_scratch_ext4_crc()
-- 
2.31.1

