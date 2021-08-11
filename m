Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0601E3E9450
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhHKPNW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:13:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39981 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhHKPNT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694774; x=1660230774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UAJxyvk/jy+U6vgpw3DQptAkGFjcE3AVUBJ403T3DzA=;
  b=gOfVUaU7sDvlXKoQc74Go1d/53BoVio5+ClwQHFTiYMciQhUD9CvEfWC
   5ZAGVLCc8TGe6rJBulTtyimjxpfuB6lb+sTn6nEEbmExiBwBlIHT8zkEQ
   w4hqALv1ZEEtXqzGu1tT1P2e87dghPgiiOOk5Y+sbfYHrL46yoQt5xr2t
   TYnnXGuEtOzbFhBdy9xdjZU6dvaiX1kS4Bhm/cOb7duM3vSzVIaFbTYqf
   yxTks3VjIx5c4MoyozPWpNClPPNfGOiT6Q6hpZWPb9AXF/ZGyGL8tEDm+
   NfOgkD1AWdDzFiVzT+IWyMhHhw9qDPtqSoKpXPitBiQtb9c6p4iZ97X+l
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942551"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:12:54 +0800
IronPort-SDR: EvesHUStSv9OLA3+4p02blHZQkc5h3NMTwn5Ti9kCQnXHsv1qpcyA/JHg+qfKHx1kmOnu3G+Ca
 Ninx664ry+olBElxvj4qm+T/jM0umhpoHFZRkjeK70ah4qzoDZnSJCDtLY5QrDMIA4L/92I80C
 jDBA/Zil0yN+JcN2BZARG7NqWJegDDKSJj1NHOMWwpDEWsWZRLha92SBSeJdMB4oUvkPNs0o+e
 baFd5bn+JDIqVWM3i5liPjvahfSc4y9lXrtESdvNdNa1gyRtc3tCqDUxSdVgjsZN096PFOCtWt
 N4Oa0DvtiL41Vs6OAwxsjo+f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:25 -0700
IronPort-SDR: YZ54i88+8kiEu1mERhg1SMY/BEYy5jZ3Z/ESME6cIi9tBGjgsj5OxHVXzzoH/M9bkDI0VdQkxM
 /FgS/n7yF2trvaHKKJxaE0oxVrl8B/57fPfKkNK650s4OOWt7U9KtReUCP+l/sW4s75A3x1xV1
 6tjOO5q1ekfT4xYBvxwUm9zOEM45u+ImSYKiYmwef5LHg/62v+UoToVJcOTdimnu3+J7QqbwMu
 VFOK7PVkcKRCdGo3QkW4GAkwSMy9XIJr8iO8sffGEoOF1/cuX9CETFHKi/ai/vEfZvyOZnGxyL
 2Ps=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:12:55 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/8] fstests: add checks for testing zoned btrfs
Date:   Thu, 12 Aug 2021 00:12:24 +0900
Message-Id: <20210811151232.3713733-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series revisit my old series to test zoned btrfs [1].

[1] https://lore.kernel.org/fstests/PH0PR04MB7416870032582BC2A8FC5AD99B299@PH0PR04MB7416.namprd04.prod.outlook.com/T/

Several tests are failing on zoned btrfs, but actually they are invalid.
There are two reasons of the failures. One is creating too small
filesystem. Since zoned btrfs needs at lease 5 zones (= 1.25 GB if zone
size = 256MB) to create a filesystem, tests creating e.g., 1 GB filesystem
will fail.

The other reason is lacking of zone support of some dm targets and loop
device. So, they need to skip the test if the testing device is zoned.

Patches 1 to 4 handle the too small file system failure.

And, patches 5 to 8 add checks for tests requiring non-zoned devices.

Naohiro Aota (8):
  common/rc: introduce minimal fs size check
  common/rc: fix blocksize detection for btrfs
  btrfs/057: use _scratch_mkfs_sized to set filesystem size
  fstests: btrfs: add minimal file system size check
  common: add zoned block device checks
  shared/032: add check for zoned block device
  fstests: btrfs: add checks for zoned block device
  fstests: generic: add checks for zoned block device

 README            |  4 ++++
 common/btrfs      | 18 ++++++++++++++++++
 common/dmerror    |  3 +++
 common/dmhugedisk |  3 +++
 common/rc         | 24 +++++++++++++++++++++++-
 tests/btrfs/003   | 13 +++++++++----
 tests/btrfs/011   | 21 ++++++++++++---------
 tests/btrfs/012   |  2 ++
 tests/btrfs/023   |  2 ++
 tests/btrfs/049   |  2 ++
 tests/btrfs/057   |  2 +-
 tests/btrfs/116   |  2 ++
 tests/btrfs/124   |  4 ++++
 tests/btrfs/125   |  2 ++
 tests/btrfs/131   |  2 ++
 tests/btrfs/136   |  2 ++
 tests/btrfs/140   |  2 ++
 tests/btrfs/141   |  1 +
 tests/btrfs/142   |  1 +
 tests/btrfs/143   |  1 +
 tests/btrfs/148   |  2 ++
 tests/btrfs/150   |  1 +
 tests/btrfs/151   |  1 +
 tests/btrfs/156   |  1 +
 tests/btrfs/157   |  3 +++
 tests/btrfs/158   |  3 +++
 tests/btrfs/175   |  1 +
 tests/btrfs/194   |  2 +-
 tests/btrfs/195   |  8 ++++++++
 tests/btrfs/197   |  1 +
 tests/btrfs/198   |  1 +
 tests/btrfs/215   |  1 +
 tests/btrfs/236   | 33 ++++++++++++++++++++-------------
 tests/generic/108 |  1 +
 tests/generic/471 |  1 +
 tests/generic/570 |  1 +
 tests/shared/032  |  2 ++
 37 files changed, 145 insertions(+), 29 deletions(-)

-- 
2.32.0

