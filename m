Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC4354E4A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhDFIII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:08:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38648 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbhDFIIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696502; x=1649232502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DdwkRL44P768f4/8TmEFH5I2JgoZ7i57NgCUXx1ASDA=;
  b=o5XylYybF1zERl3VOvmGFuq2MlRx5eaWvv0xdGe0D11MPZcb2+w+qjCE
   DwLpa6tJQZpDz1hio566Tlu0ony+jcZZSZICsk2QcfwrkPhdp+W2dpF+Z
   wABnXQ4AbzXVYHt9rs5cIfLOSJbis9wu4daP5r7Gf3RHRc8qCt4+jkrwG
   sLFvZiwNh2Kp7c5LgZE+U9nH8vn8JLPcRRCtB4vcbI4UIShwZHLT7wXfp
   ++zCBG9bVGrXUpnlyi75rWavJ7dIO1HiyPpeIhOiXK6jJPWIvhjujgJLG
   ZMcoJTlSumYcHWf5WnlIAgwOecZTs1QALNQx4LXqpidjxY3XKNd8YghcY
   Q==;
IronPort-SDR: uDWOYIDFcARZTL01Dy6zl0SK8/ytUYJRVjdSfhKBsf8Mj2OiEGpkhaXsXuRHiVUQWwPRNVDUu7
 tfJJqoHgrIf7Iksw0xHkD2CY+sQmKp2vXD7bPiMnC3sDKCdMd19UkuXIGp614CS5wfFiYByrIp
 1PZmPtl3XzQ46qk5SntlNyO0YUk4fKBjCfIwBzFy2elr7XPa5HAo5Z44r4gNJN85tEQCOajvq1
 mhP1CeKasIWwTkc+oHOWuI2uHt0Z8sD7s86C0NzBFIsdTzPOCv6p80Q3magBYkzR1g8gdS4urY
 tBU=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290709"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:08:06 +0800
IronPort-SDR: rbt1xmvK0K16OyxFhHrGBv3oy/lTQx+9KxaY/nJeg1t9UZBeJVGwIYxvbWean+cR5ovAsyPXHP
 TtXm54ev/uCZHCAJVqh9UMrNH0d9at6cos3T68D18LD+QV2QHUj6aItnOUaKr8Y/HyiIcbTKn9
 xFQQC+BKcJ2iF+OjFGdNZB9dz0+q4COOjrr19pvTPsvRLgqWAW19zWlIrsx07VPiJgWGOaqWLW
 /IYxaHTAjKJFA10qwK+BbWMom/STjRZoMfli+6wn4uOf2I20NahTEo+4kMPW4ZyGCxwZmOkOpb
 dvRt6FAtDZ7LenDALl/FSDDP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:27 -0700
IronPort-SDR: VsafkTtppQ5WyNhXwtx6e83H+Wae4qr/85WqctVeBKtVciswyHzxngMmCP0UxI94sxK+dblDUv
 JEJaErROmvAGDQTxdaZ9Dgc58kxrMhI5GXEB9xwz0udbuhr1jsgN/I0gKhFk3rjhl0Ts6Sn772
 UeeCqJDMNQCqfurm3vj6AN3pP2ULce8WVVfDNlErn6w8Xi8WujiBQ+uR1ef5qL7Q5yQkZwY1/M
 xO6cdLRNwFgae5+4nK+oXdcU+nqUZktRCeaZI6ffd+NaYpIG0CsjN3ZhMn8wfIaEgrnJ7Na1lA
 gEY=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:07:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 08/12] btrfs-progs: fix to use half the available space for DUP profile
Date:   Tue,  6 Apr 2021 17:05:50 +0900
Message-Id: <810b410d06941a1abefbf8dc2a9bac8512b4b773.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the DUP profile, we can use only half of the space available in a device
extent. Fix the calculation of calc_size for it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 2a094eab4971..ed3015bf3e0c 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1323,7 +1323,10 @@ again:
 		}
 		if (!looped && max_avail > 0) {
 			looped = 1;
-			ctl.calc_size = max_avail;
+			if (ctl.type & BTRFS_BLOCK_GROUP_DUP)
+				ctl.calc_size = max_avail / 2;
+			else
+				ctl.calc_size = max_avail;
 			goto again;
 		}
 		return -ENOSPC;
-- 
2.31.1

