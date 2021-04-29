Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F336EAA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 14:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhD2MkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 08:40:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45885 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbhD2MkR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 08:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619699970; x=1651235970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JybtB+du94uMbGiT9jVrseN456JK463aeuF9MvLWLec=;
  b=ZBl207Rk6fpXaZwZiT1gjDGho7B7zqlp09LGZViYG7rPu/BZjUXnHXIV
   sLg/7oIi+DQgQJUue02YnEkZBnla5jGNmdWFfQBd+gCu8LNB1wB0BROui
   2E2KUcILPbOJOoCawQT0CVmiWkE9F2ag0+J0nC04r4BwCApM/6CbQY7zw
   xJe/8QPu4bcMavLtIgGwm6IqRPeLlkrExFFO9ctzrcLkvX4+Ie98yBD0y
   5NReCr8IEl6ln7O+pitIu8TwHGH74JjMnPRVZnb+K4DKUl8LIr4dEegx3
   /wXct7eN81quwQuA0mSQU2y0XdOiBPZRS84I1DqPCCXvqt8+DJWggjUFf
   g==;
IronPort-SDR: rf8FpepkxSbwS59EsFQIJHVYgLmDUSCs93fG00rzQm2a0aIH9k+k2JY8HPMgtU+LEuOVQr33hB
 YU6t1jSQvaC/hxEEHe0/ZHLPGN/ayRV78f6FZn1duOC2l9C9FAi0gYezG2JUFObJu/fkcQHl6M
 2A0w/nyqhqHPaDYGUV2Uy2b4T6gYr8RdbS14thAz0WrGhFPz0EpcIUT4FOi91y3OwfJgwEUAEp
 8PKqp+aDLR+WBtRY+E14QRgzMCyBUKVTADBwAU90Ci3PQakReLW8yXcKTX7A7TUYRRSS+gtd0A
 FEw=
X-IronPort-AV: E=Sophos;i="5.82,259,1613404800"; 
   d="scan'208";a="171197736"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 20:39:30 +0800
IronPort-SDR: 132oXCQTAxZPB569DJLvvtmlAmd4RMsZHfIY16sL7Eo3Prc4GkRaq58tI6fGk8YnE+sCznrb+K
 FanfGiRugRJhvypzSz3998BwQ1Xr3RzYQV2hdR+d1Q/aH7l7FXelDFSW8hEu7Duc/R7gOrgYqb
 idTv/qMpIw8vNUPl/brpKp5POgNDSoCk3ttE77mBdxKX6TWLiRMtbwmGr488Z96kFIPLOXAgEV
 auNXfMmaJl29maJ/522E19WE6716C2+Uw/4ubjICpf1AbZuNpXe2Bc7z7a546i1EMolJc0SBo9
 CJOQUwFsACE2VbUgPZkRMj7C
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:19:49 -0700
IronPort-SDR: eoyr2jAbPJxGYM4rIw+xi6UDytGs5/9aF5XFWXyClxcveuiBwiydqcG0cC85GnxyhIrpvOhJ4+
 uyrUkPBHk0u2UV/1Xp/vq5MkhneK9v6pgDRXKyx0de0qCw6Rf1PBZaZ94bVwpJ39X+6/5k4v3e
 Zaq7DqJDhLJtQtVw5Nke9CuWU+LSDdv952xI6ftZ1oDKC+ylbHALBqyAW04sIAw8yB8DZ1utGe
 DB8NrbYwgSzOqOq/YX5uVQLdOH8c4fhiwyOTzLhOdLdOR554TNIyo8zBOqZne5dYwjWk5hAcQZ
 0qI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2021 05:39:31 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 1/2] common/rc: introduce zone check commands
Date:   Thu, 29 Apr 2021 21:39:26 +0900
Message-Id: <20210429123927.11778-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429123927.11778-1-johannes.thumshirn@wdc.com>
References: <20210429123927.11778-1-johannes.thumshirn@wdc.com>
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

