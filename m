Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBF275DC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIWQou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 12:44:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52919 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIWQou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 12:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600879903; x=1632415903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nQMFYxjSVE7OWyUC6ZDteVUUOlsxj60FRGF0+xZKyIE=;
  b=l925RfIEbR7kmp1LU00vwyJpPPO2RX111Tw6v/sqCM3AmhA3V8M1ScID
   Ox7887SHofQYJz72TgHitr0d20oifrZQR9FhABqFMwMV/qHJ2zGKZboxO
   9HFLuiChG3YMm4gjpCnhg3nS/MuEs0vwHdHkWFLiKxVFT07r80uNSuzCS
   kHHZKuRYyxi4VuhUKLQOZ2yjvE/Gelv3483LC5VFWj9TyXAck0SoEXwHg
   ZQjch1V84YPWgWgCeQbxZN0I3EvnJ0gAQzaVkih1Q7igMyQ2WneNsa0LA
   h87VmwUP7Dn444nHiMt8eRzmCWK0eDfs7e+xtyoPnFR03M/MxKTn7lyoX
   g==;
IronPort-SDR: LenG9Ph2Ay2ha6W8BAcPNs5Ad1R7ranYJvXPVoLv2v6euvzAbe4loHA50tbrYPzNHWJmMNrDcd
 QialmxWkNDGfbYa5Zg5OzmyTlIrPiX2bIuJivvRt8Z3R7UN9M/t7CnkUPreETzngxsh4n/6hei
 OU0BPgBe/fcGxr4TptXGFcNrSXuuk1GXcnOCFGDrqalrj9k8Q62AyK65MDkdzugceSCQ51rmLB
 QeCb9qsDizcZ34348nVapVIJsvNMQKOx3cm1vM9IZq03wnqhJz5n1BEm3KSWbYQJYGBIXHLfcL
 cdQ=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; 
   d="scan'208";a="251486607"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 00:51:18 +0800
IronPort-SDR: Og1qxPQ+HCZWT1Xb/v9FvJ8I0cv4SFiWGGxaujEPZKUXvzi5J+A9403dbtgEvH21NCN5hc4buW
 fo25gMEUoHXw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 09:31:35 -0700
IronPort-SDR: fuknXWwoQBcdPLZqspnYGbwGQv+Z/DKZ2JXf/qA87QXsIc71hnofJoiPKKOf16CCILpPhmN12d
 ETSxzAJ5py9A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2020 09:44:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/125: remove constantly failing test from auto group
Date:   Thu, 24 Sep 2020 01:44:26 +0900
Message-Id: <20200923164426.19534-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test-case btrfs/125 is often failing due to a design deficiency in
btrfs' RAID5 code.

The details for this can be seen here:
https://lore.kernel.org/linux-btrfs/CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com/

Remove the test from the auto group until we have a replacement for the
current RAID5/6 code.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index 72e74cc39d03..899a6d67f739 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -127,7 +127,7 @@
 122 auto quick snapshot qgroup
 123 auto quick qgroup balance
 124 auto replace volume balance
-125 auto replace volume balance
+125 replace volume balance
 126 auto quick qgroup limit
 127 auto quick send
 128 auto quick send
-- 
2.26.2

