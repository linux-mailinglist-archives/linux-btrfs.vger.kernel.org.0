Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5BE36EAA6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhD2MkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 08:40:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45885 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhD2MkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 08:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619699969; x=1651235969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vojb/psOOhQn7UsrOtkRy7i2KwuZNP5uRFzT8+36NcI=;
  b=DMTBcIpAZp4oUP8k8OKWaUfuEs/tXiK1wEa5ub3TSweW2MypWu/wl9UR
   UZVLbhGxGrcW2jNzikec4CCqyvIEkJxAkScHQz8GJGS0ouQRJYUuFA48/
   iVNptLskpUq2987vLf/w1NoZFef6L5MkqG0RXkrJ+k4sS2M8Xf1h8n/Bj
   l40va4E82jy84ZiaOeGTpDmbeu9urp1xhVTOsXNcfEWmYUhn1Do9OHzEQ
   RnmcwL3aRYEddKwTY+HvP4Sym/wSgkbCCs8NsZ2Y54eucEU1k+aFkAL5x
   0kXqV6/mmSqu/3UObmXUJjan7d0Lnc/24tjn9koWO4RdVuCbtU6aj8QMW
   A==;
IronPort-SDR: nbKTl0drn5zLaI5dPjBLW6MK5EyxOKJ+Qa1eVn4yhPz8t2aBpCfeb654A3AZTcJIdjL6WwuoRn
 WHPfvsr6yFwoGQqxaejFldpfe1mDNuO3Tcplq5Sl0uI4Qy2bZVkxJ2T0D2t3rVQBVMxmBH7LqK
 n0rr3pZz0HJpFZhbM8bIpKaMUeRvnUcMD7XQuHp7S5BmWp76vequZAupxmc2+22+698XAhFql/
 oSaEWVNxZeO/a8IsGOYYzNScv6j/2BAWTijSClLV4h+XaNSRW5mtdRHU+s9LTi/+DkAjcC1q2m
 XP8=
X-IronPort-AV: E=Sophos;i="5.82,259,1613404800"; 
   d="scan'208";a="171197735"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 20:39:29 +0800
IronPort-SDR: vKY+sxmhy0dTc5w7e9t0w+/9RD6lRhDFDv+SAh5lsXtdsBsJvkM0LPEFRw8nf18KqEFgwtAIum
 OWWvpDAMjutJDNVVuq/ybghBhRQ2kxA6HuTY3bHk9bsuXLmYpCxujzNkoSbIZ98iT70AyP4ltG
 +euZ3Cpt5Bd64zcIswANB4Mo+Dm+TSaDqM1Gr0S/Bs19jSr2BDsiiEL4fDRhoqSw5Nz/fF6bWS
 cy8Yb9Vn4x0sDLjIqYV5HcDu8WeUu4LyNR1avN4bCC/TNq1yyDipl0NQCv5QS5T4tOEh1GICGc
 0kDfkpTghV5Jk6yj8G72ijGj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:19:48 -0700
IronPort-SDR: pOOPXzpepgoRaO0jEjFi7TkhhuD/1z5Gy17CapWnwmpmVevAWC30r9fkF7W8Da4PlJ4mv08XMX
 N27hws8kAwNVNtpXhVLgbY/tL6NJUne1zCBNWKndmZzcyCf9ZPUdvnU/dZNTbSJd+V+wtDDX+W
 I09PQff67idieVAt8PJlVDIbeKNsJ8j7FRJRZ8rhcdo5961pi7KCPlT0vpGRxtR2Q+rv4Luk57
 XCgHcNq074xqTB9eggUMZgaMrP1oaL/BCy5hsy7znbeoTNBIDqVV2Kc795EkVMfXiiDWLETf3V
 Olg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2021 05:39:30 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/2] fstests: first few support patches for zoned btrfs
Date:   Thu, 29 Apr 2021 21:39:25 +0900
Message-Id: <20210429123927.11778-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series adds preparations for xfstests for testing on zoned block
devices and a first test for btrfs' zoned block device support.

General zoned block device support for btrfs was merged with v5.12 and the
zone auto reclaim feature is staged to be merged with v5.13.

Changes since v2:
- reduce commit itme to 1s
- reduce sleeps
- don't use _fail for last print
- don't use direct io

Changes since v1:
- rebased onto master
- drop unnecessary patch
- comment sleep and commit= mount option use

Johannes Thumshirn (1):
  btrfs: add test for zone auto reclaim

Naohiro Aota (1):
  common/rc: introduce zone check commands

 common/config       |   1 +
 common/rc           |  44 +++++++++++++++++++
 tests/btrfs/236     | 103 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |   2 +
 tests/btrfs/group   |   1 +
 5 files changed, 151 insertions(+)
 create mode 100755 tests/btrfs/236
 create mode 100644 tests/btrfs/236.out

-- 
2.31.1

