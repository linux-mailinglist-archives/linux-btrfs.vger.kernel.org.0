Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5A36910D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhDWL1U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 07:27:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21581 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhDWL1T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 07:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619177203; x=1650713203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HVL8OW7L0ggpKA0j/PbdNF5sAD6Isv4zfpQMacmVhVc=;
  b=LUF4XjzcKl33lUMpMry/oEGIRsATymVDoWaU5qk37qsoCLwBe59ebD+8
   hdIvrHpBW9bDgXqDfBjtGvrCxpbaSVGAI13xONpjD0GMO5jTG2AgsjGR3
   9Jx58iHCkvz/iiZrqvMXLBc6O0+FCgi/DKZmrvGV2XfMsNnnt3aQbdIZH
   I1xiJboGbT8ipz4LUjhgTI8OwHol9Yg0CdRrKQNHPCLDi7pMD1tkozLRE
   cpFsox96dnQMkoSSYpA8/noaAKpppWwyr6PhVyRriWppAby6QLeZ6HZVw
   /quk6ZE+b9wR7JUXZA721Nqx5ezTFzExMauph0VYVMalznokr1Jr8OejX
   A==;
IronPort-SDR: CD3b8p9kWfrvs9hLR9lEuhOk1QdV/QyEbOpyyTXBWT//2/muBtHPuXa5CnDvi0bYcP7kNKL7Wb
 gVOPlewbIg/mZWbwiJco9TJ7lGjmOsIZya7Vz3LZSQCAm0HDMhdM/+XbekDvyZ693lAT3NBCAy
 LKjNYQfrBlfL3maRB0v+zEZeBlQm0g3CUWl3UqySiBkTJQT8gSQQ8KHaVArNnTHk16e5Q+Vqbt
 i+zuY+4+26evRQmc9j9duGSJSOwVHHjXb0Wh0Hise47qeJgzbN4OALHX5YBRsbEwj8DXL9dHXq
 GhI=
X-IronPort-AV: E=Sophos;i="5.82,245,1613404800"; 
   d="scan'208";a="165365027"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 19:26:43 +0800
IronPort-SDR: D/Nq6ZfLfJKl6ps0WxugGtTZerFL6OWvTUKr+MHbuU0ZyVAz7fJd38o47EWdzmI4bCemQ0AbGa
 OcS5W3cRbTCuKOTD+s82mdoFU1y94vZtldFDXOfXhY19u+znt1ccSwtWS2kRDf118KZdsfxzN5
 tO3klh49BpASoJO0JtrLD6TpMzvHAevfxv28QEKgn1Tk6Pvh/ZYCU4SdzihV4k/ZrpCKGmfyHV
 xdwx+sXlUJrSclU3QgNqCxz+Srnp03OYSwxMx7VF6AOnooKpVZhSpk3dCl/X85W1fxSjGTbsIQ
 NbFGeagRnvnnYS+50if1/Ggo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 04:07:17 -0700
IronPort-SDR: XSmQreHo4nP5+/HtmjOipsUjEs3LRCa4OOo97BUIVwXGkTFb85fxEIG7LVONYmxUAyF0er6tZy
 DFekOSa/IA8vpHji39JjKnmrCysCcS4veIfsVXRi1VKiuTkON16Y3n0Q/pGH++3limhMscHIgV
 xioirSVpWPNp1FK9kQAenU4duDq/Zyc24hkllbLILprio29bvJ5VZM5GqqGjnNGnXlt8+sClgO
 6PscS8XqA39GGXGsKw9miNgPA5tMPnNCblfq8x1yHxb6hzBdX2aTlfvJVvEK4CqLjUx0BlIYyS
 xlk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Apr 2021 04:26:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] common/rc: introduce zone check commands
Date:   Fri, 23 Apr 2021 20:26:33 +0900
Message-Id: <20210423112634.6067-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
References: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
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
index 76a7265e23ba..18436e33dcf3 100644
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
2.30.0

