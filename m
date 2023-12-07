Return-Path: <linux-btrfs+bounces-735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533B48083BE
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 10:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE442840EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206F32C62;
	Thu,  7 Dec 2023 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VNxPazfD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555B10B;
	Thu,  7 Dec 2023 01:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701939815; x=1733475815;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ZRb8sPKyykF7MHoj95qT4dSpQ8fUwUeKeauCK55CAmA=;
  b=VNxPazfDkrRB4JtRFRwCQZC97cBq7cQcenWtkBCM9vG6HWnqtCDPSep3
   g1fTXwd6P+A9xBhSaQZQ64xc1beXdjyrtO8suSVhi9juixbzqP3fQThYp
   EiIPlCSufaVOx3zRFHu8YmlJ0SdacdhlNy0yGfEDu7VTDk+60CIxFWWSs
   OG24m02T17zJkG7KErnl8J54j4f8TYEMOrEcn/+GIEZt6MLyuED1LfQoR
   qkVTfOrbL7rTvqgjXWL887EokKNl6a3xIGpWx0c843vCZM8rUxaG/YrZk
   +sejGCk8xgKHPeqjyjxzzvD+qVkQsGH/Q6JzFRtgxk/aAykH8fuJj6574
   g==;
X-CSE-ConnectionGUID: aLcaSwHnSMazg5y8veg2cw==
X-CSE-MsgGUID: UQ/p7pedRSW6cNmm0RK6Pw==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4272766"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 17:03:35 +0800
IronPort-SDR: WTO09y8qsmmWzgs5dj2dogBvg9A2BLf1WXdone1I+bz3ex+Z3NTeJfjYr9Rhif8RhkczdCMaEV
 rIR+epgrHaYQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 00:14:35 -0800
IronPort-SDR: gU68KmssTLuQ3NKjMcUqp3/Cj9hT/txd0kI1JWf/F+siYdgvk7fg3y2qjqIdP5JYg91zoldW4b
 Iyvj4nKbnooA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2023 01:03:31 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 0/9] fstests: add tests for btrfs' raid-stripe-tree
 feature
Date: Thu, 07 Dec 2023 01:03:27 -0800
Message-Id: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+KcWUC/3XMQQ7CIBCF4asY1mLowAh15T2MCyiDZWFroKmap
 neXutEmunwv+f6JZUqRMjtsJpZojDn2XRm43bCmtd2FePRlMxAgKxCKuyGFzJONnmusNepah1p
 7VsAtUYiPd+x0LruNeejT890eq+X9mRkrLrgDVOQq14Rgjnff7Jr+ypbICN8QVxAKBAxGEFmp0
 K2h/A9lgYIMaotK1hbWUH3D/QqqAlEbMMp7abX4wHmeX14IMO1NAQAA
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701939810; l=2819;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=ZRb8sPKyykF7MHoj95qT4dSpQ8fUwUeKeauCK55CAmA=;
 b=f7GnvMWIM6EGGD3O4bUo4MPCUD8xo1/FSP12/N3aIVT+p6pLE5FFIyPBU9qyXkA3hfG77XMFq
 3K7UqKSpEWnD1ej6++cTvtw7Qnz4+vQAaTrSZxRaVhltKtD3LahZA+6
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add tests for btrfs' raid-stripe-tree feature. All of these test work by
writing a specific pattern to a newly created filesystem and afterwards
using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
the placement and the layout of the metadata.

The md5sum of each file will be compared as well after a re-mount of the
filesystem.

---
Changes in v5:
- add _require_btrfs_free_space_tree helper and use in tests
- Link to v4: https://lore.kernel.org/r/20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com

Changes in v4:
- add _require_btrfs_no_compress to all tests
- add _require_btrfs_no_nodatacow helper and add to btrfs/308
- add _require_btrfs_feature "free_space_tree" to all tests
- Link to v3: https://lore.kernel.org/r/20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com

Changes in v3:
- added 'raid-stripe-tree' to mkfs options, as only zoned raid gets it
  automatically
- Rename test cases as btrfs/302 and btrfs/303 already exist upstream
- Link to v2: https://lore.kernel.org/r/20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com

Changes in v2:
- Re-ordered series so the newly introduced group is added before the
  tests
- Changes Filipe requested to the tests.
- Link to v1: https://lore.kernel.org/r/20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com

---
Johannes Thumshirn (9):
      fstests: doc: add new raid-stripe-tree group
      common: add filter for btrfs raid-stripe dump
      common: add _require_btrfs_no_nodatacow helper
      common: add _require_btrfs_free_space_tree
      btrfs: add fstest for stripe-tree metadata with 4k write
      btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
      btrfs: add fstest for writing to a file at an offset with RST
      btrfs: add fstests to write 128k to a RST filesystem
      btrfs: add fstest for overwriting a file partially with RST

 common/btrfs        |  17 +++++++++
 common/filter.btrfs |  14 +++++++
 doc/group-names.txt |   1 +
 tests/btrfs/304     |  56 +++++++++++++++++++++++++++
 tests/btrfs/304.out |  58 ++++++++++++++++++++++++++++
 tests/btrfs/305     |  61 ++++++++++++++++++++++++++++++
 tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/306     |  59 +++++++++++++++++++++++++++++
 tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/307     |  56 +++++++++++++++++++++++++++
 tests/btrfs/307.out |  65 ++++++++++++++++++++++++++++++++
 tests/btrfs/308     |  60 +++++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 710 insertions(+)
---
base-commit: baca8a2b5cb6e798ce3a07e79a081031370c6cb8
change-id: 20231204-btrfs-raid-75975797f97d

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


