Return-Path: <linux-btrfs+bounces-702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F784806CBE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86095B20E58
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706AA30644;
	Wed,  6 Dec 2023 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P10H5aq/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6DD9C;
	Wed,  6 Dec 2023 02:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701860182; x=1733396182;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=jp/Ui0yLzkKl+eO+byXYHoh44oL1oYqjGRrkdWsfOyU=;
  b=P10H5aq//+WiUNM4ivCFTcS2rw4dHRTLtrnr+nXGMLNWtawNxdtLIVqD
   MKjExBJy9oBZfsGRmwZREyndI9hEC115ww7Dv1BXWpGIg+QNB9IFzLJ2l
   FgOoUA9GaD8ukBaJ+vwiKWr4O0J08qQvfNhB/kZJMJKoY2O0CdPsr2DWi
   2ngjbxsfKuAyEk2A0mtGyjSCyD9WPmwsyVpXecpRQn2HQFhDIZBd4DeT5
   RyqzLe6DP2FI61lAjPO2c/EpDqd3MzPMznGey0keQHmOtNiRHhB9DGX7o
   1iJToINlaUXJvN1axuFWiRQewHCJAAoLjVS9E+U5AKk5CX9ikWMRg7qDh
   g==;
X-CSE-ConnectionGUID: 1j2ErnI8QN+4iQB/CpO4kA==
X-CSE-MsgGUID: 4ztQGMKzTK2X8wVWPzJlqw==
X-IronPort-AV: E=Sophos;i="6.04,255,1695657600"; 
   d="scan'208";a="4119707"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 18:56:21 +0800
IronPort-SDR: dHTk/IqPkg8wlxp1nJw5LPNeJ4VncL7kUQui/fxeT6RJAl9Y0Bq4KQ9rI4HtfmGqepGtjK68qt
 Jhy9pFJnt58w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 02:07:22 -0800
IronPort-SDR: 0Gf99RM642X+WlG0MsgXjRZLmObLJWe9mtQMoHIszR61O5ZE1sjoZlALpkmckacr3ovzcsgDnh
 eeqZddx7iVQw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Dec 2023 02:56:19 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/8] fstests: add tests for btrfs' raid-stripe-tree
 feature
Date: Wed, 06 Dec 2023 02:56:12 -0800
Message-Id: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExTcGUC/3XMSw7CIBSF4a0YxmIocENx5D6MAx4Xy8DWQIOap
 nuXdqJNdHhO8v0TyZgiZnLcTSRhiTkOfR1yvyOuM/0VafR1E864aDiT1I4pZJpM9FSBVqC0Clp
 5UsE9YYjPNXa+1N3FPA7ptbZLs7w/M6WhjFoOEm1jXQjt6eHdwQ03skQK/4awgbxCDqFliEZIs
 Fso/kNRIcMWlAEptOEfOM/zG45OL3cUAQAA
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701860179; l=2595;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=jp/Ui0yLzkKl+eO+byXYHoh44oL1oYqjGRrkdWsfOyU=;
 b=2KIWysUA+tGyXlPVYLU4I6MwlmlbqWX/XJGj5bpF5tNU6efdT0l1xXpoMG0WcOU0qSObHLJLb
 v1qHoT9WbBOB+Sihv1na59Ft7cm7w4czOJYTWWW96lJGRKtYG8YUmpL
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add tests for btrfs' raid-stripe-tree feature. All of these test work by
writing a specific pattern to a newly created filesystem and afterwards
using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
the placement and the layout of the metadata.

The md5sum of each file will be compared as well after a re-mount of the
filesystem.

---
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
Johannes Thumshirn (8):
      fstests: doc: add new raid-stripe-tree group
      common: add filter for btrfs raid-stripe dump
      common: add _require_btrfs_no_nodatacow helper
      btrfs: add fstest for stripe-tree metadata with 4k write
      btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
      btrfs: add fstest for writing to a file at an offset with RST
      btrfs: add fstests to write 128k to a RST filesystem
      btrfs: add fstest for overwriting a file partially with RST

 common/btrfs        |   7 ++++
 common/filter.btrfs |  14 +++++++
 doc/group-names.txt |   1 +
 tests/btrfs/304     |  55 +++++++++++++++++++++++++++
 tests/btrfs/304.out |  58 ++++++++++++++++++++++++++++
 tests/btrfs/305     |  60 +++++++++++++++++++++++++++++
 tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/306     |  58 ++++++++++++++++++++++++++++
 tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/307     |  55 +++++++++++++++++++++++++++
 tests/btrfs/307.out |  65 ++++++++++++++++++++++++++++++++
 tests/btrfs/308     |  59 +++++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 695 insertions(+)
---
base-commit: baca8a2b5cb6e798ce3a07e79a081031370c6cb8
change-id: 20231204-btrfs-raid-75975797f97d

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


