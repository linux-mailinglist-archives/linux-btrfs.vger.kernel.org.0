Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF678351104
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 10:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhDAIlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 04:41:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61168 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDAIlT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 04:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617266479; x=1648802479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GqhbWB4d/kDcPe9vW/4f2RJ3iqpHL/p7YDT71wgb7M8=;
  b=i9SURz0syGZlCV4miRB2w7I01BL0Dnmeyir+JKgd0xu/tC+Q3BUp9Cxn
   eZG/TYxmjO91jelMI32QQtFsryqZNdiCIAD89J4OjxNVJb/VxZBx8orDf
   wPU3/zlqsKIeesyBg179ssdXrVB7PhcBYfeB/L5fwMpeKWnx6cOx699f6
   U0KPi4QHSCxG5jqfqrVm6CbrJgTleFsShOY7r+fp3Fhq42ngIxka71BQm
   2DCJqOm3FxG1lSYgbRZK/jyglngypLubi27RotYZ6jTgnfVpsup9LwyhZ
   UXdrXHB9hZQcAaUaOjYdReICPtIv3JKecfbQjtvFdKNGiVAhenInLFw9w
   A==;
IronPort-SDR: ILZsgMM0zHE44lGS3/F990o+W12d7VxK25HSQWYrORvyvKy6Tlz6GMcv15b8UtrMXtaotw8Iew
 2sPEEZ1gZHxkjFq0AB/LRy2QFFDsws/0R8bEWtgu/U8eZMQhUqvIWXxQi+1WaqJ4dRxDkQfUxe
 IPAojCa8MIo/nFL2NrVuXI96og0Rn7TiKY8CzF6lKcdOBfJafyonw6rY6CCi413zz443j1VOby
 5KESZ6jTSSo8O0nNvLh+i+7AFsJL0Qj9cBCyVxBBzpr4wIoEjNKBG2RdkQ3JJ7J2fYsFbHzf0Z
 HNQ=
X-IronPort-AV: E=Sophos;i="5.81,296,1610380800"; 
   d="scan'208";a="164565871"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 16:41:15 +0800
IronPort-SDR: r+erz59zPpqrtZtw8sAEJCTaZPvuxKU1trMdp+DxHfPrH/49VvZiHkuYOAsOuXz7OCjlwn7t2h
 A3PiWbdVkY84mWmrlDtzGcIk7otYaH0FH5uTa6Sq/7aNXqruS6F/yFqsBTTu5vQu2feej7B0eN
 6hWUa9r+4M0b4OAjFduzYMt3N1G2idgaF1fGsAElulmH1bxo2H7mzsrZXgLorLHe6kDn9pwMnm
 d6CTFFNkAApSJb8BsbaH/qeCrODKD8tgNSluZ8dx7n/N6LR8wAX7cbpqJuhgLunLxQQCGtBJtF
 vZgstntjBecQJmoRlGTvAVrS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 01:21:17 -0700
IronPort-SDR: cYn4VA3kyUeBKTtzeDeg/Gej72eGZ9tJ4PlS8WKUpZI7pNy4mhBk/+fRUl0gStCbG5Fw2p2erk
 V2xYpm+sAtPoeBuAT56hJ+E//KocZmsl/20Dyz4OUj097uGnO0uHHE/Buy9lPh23Yt1OTqbKFA
 ae6YU5zP39V+laNCWg3FWjpHqW+LEj+1Hzk0qn3V0bdTKOIy5twwuYnwdK3iQzhjLaxjs+YCiF
 9l7VKoEvbp2rZyhIb+Q+gCMEVCxrMagdz8FO/I6TYEfvXaqA77oNPes5ZCQZq07i6VMKcm8Tl6
 rNU=
WDCIronportException: Internal
Received: from ph5fb5j12.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Apr 2021 01:41:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs-progs: mark BUG() as unreachable
Date:   Thu,  1 Apr 2021 17:41:00 +0900
Message-Id: <5c7b703beca572514a28677df0caaafab28bfff8.1617265419.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Marking BUG() unreachable helps us silence unnecessary warnings e.g.
"warning: control reaches end of non-void function [-Wreturn-type]" like
the code below.

   int foo()
   {
   ...
   	if (XXX)
   		return 0;
	else if (YYY)
		return 1;
   	else
   		BUG();
   }

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kerncompat.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kerncompat.h b/kerncompat.h
index 01fd93a7b540..7060326fe4f4 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -333,7 +333,11 @@ static inline void assert_trace(const char *assertion, const char *filename,
 #endif
 
 #define BUG_ON(c) bugon_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
-#define BUG() BUG_ON(1)
+#define BUG()				\
+do {					\
+	BUG_ON(1);			\
+	__builtin_unreachable();	\
+} while (0)
 #define WARN_ON(c) warning_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
 
 #define container_of(ptr, type, member) ({                      \
-- 
2.31.1

