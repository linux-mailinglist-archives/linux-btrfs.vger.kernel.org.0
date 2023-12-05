Return-Path: <linux-btrfs+bounces-658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA56C805B49
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5C281EC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A8249EA;
	Tue,  5 Dec 2023 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ow8XQItO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9888122;
	Tue,  5 Dec 2023 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701798425; x=1733334425;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=6/NcvXN/1Wu2nDcYuJzvhVMPb5/TEw8Di8Y04Zq8HhE=;
  b=Ow8XQItOqOgRY9yvwaEs8h957CkN+f1YxnDLyi2ZKPsVj8sO9WMkBA78
   KDS9o61froGSZUWROBKxwWAZiRbOhIXrmqvEfjlpGRp98yrzdIHT2w0Pt
   uPh1AMT9MhPOqh3A7GiVfHgjIIlYsVLN04IKaHJFvHHnztgeK3J5btp6a
   O1RNz/ahKQuocqP8aH1i9T8oInL8qrAOTI3N+XQ/vhHQodw2pozUpupTk
   xOhDNFguRiJxdoT3uMoPypXPjQpEOulazhpMEtNLOxJ4GfB73zZgrvNub
   shSpLpMwCy6Kj12RnquyQEmaojRmFkVlYN+rEasAwMMHs414XlJMNvHxb
   g==;
X-CSE-ConnectionGUID: BY6L3EsfRwiSy3lnNjFgOQ==
X-CSE-MsgGUID: Yx8lLJlmSwqBsZqb9Fy/8g==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="3944945"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 01:47:04 +0800
IronPort-SDR: IK0EZ6gASfpxPeGzRMdkhMcN1usDlsy6itbuU1UT11UDogFgRs2EqrKHqLhtZLW0/63Zwt0gc8
 Xf1eR0Tponfw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 08:52:25 -0800
IronPort-SDR: 3FkHniuo09g1+ieRR/rzNDsR265JTlUdkOyih4UbE1vh5lDS2RIEIauKU+OJadjgVm2tfxrpXr
 inMXwLsVgCIA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 09:47:04 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/7] fstests: add tests for btrfs' raid-stripe-tree
 feature
Date: Tue, 05 Dec 2023 09:47:00 -0800
Message-Id: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRib2UC/23MQQ7CIBCF4auYWYuBaQmtK+9hXBQY7CxsDTSoa
 Xp3aTdq4vK95PtnSBSZEhx3M0TKnHgcyqj2O3B9N1xJsC8bUGKlUNbCTjEkETv2wujWaNOa0Bo
 PBdwjBX5usfOl7J7TNMbX1s5qff9mshJSWNQ1WWVdCM3p4d3BjTdYIxm/of6BWCDq0Eiirqq1/
 cBlWd4S/JOd2wAAAA==
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701798423; l=2226;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=6/NcvXN/1Wu2nDcYuJzvhVMPb5/TEw8Di8Y04Zq8HhE=;
 b=KO8rGSp2FqkVCfUo0QndojRk0JWMiLsLcqIDx9DKbPWXWy53fShym7Auiifh241g/PywJwZl6
 tPLcz65k7XgCl43mfDHdwFdZQ94z9q5M0bH5qdx46yMBBiZqQ15avDl
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add tests for btrfs' raid-stripe-tree feature. All of these test work by
writing a specific pattern to a newly created filesystem and afterwards
using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
the placement and the layout of the metadata.

The md5sum of each file will be compared as well after a re-mount of the
filesystem.

---
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
Johannes Thumshirn (7):
      fstests: doc: add new raid-stripe-tree group
      common: add filter for btrfs raid-stripe dump
      btrfs: add fstest for stripe-tree metadata with 4k write
      btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
      btrfs: add fstest for writing to a file at an offset with RST
      btrfs: add fstests to write 128k to a RST filesystem
      btrfs: add fstest for overwriting a file partially with RST

 common/filter.btrfs |  14 +++++++
 doc/group-names.txt |   1 +
 tests/btrfs/304     |  53 ++++++++++++++++++++++++++
 tests/btrfs/304.out |  58 ++++++++++++++++++++++++++++
 tests/btrfs/305     |  58 ++++++++++++++++++++++++++++
 tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/306     |  56 +++++++++++++++++++++++++++
 tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/307     |  53 ++++++++++++++++++++++++++
 tests/btrfs/307.out |  65 ++++++++++++++++++++++++++++++++
 tests/btrfs/308     |  56 +++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 677 insertions(+)
---
base-commit: 5649843ef186de89f58bc69b04a8dc86adf8f1ae
change-id: 20231204-btrfs-raid-75975797f97d

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


