Return-Path: <linux-btrfs+bounces-629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34A805508
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 13:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D0D1F215D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4FB5D91A;
	Tue,  5 Dec 2023 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B71IV3gI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95208120;
	Tue,  5 Dec 2023 04:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701780312; x=1733316312;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=jEWOH8dvaZHL/ZoRHFtM8gnw6DxdNfuEkQhcOjJF4VU=;
  b=B71IV3gIWgDDNZL1LScu+UH4mU1WPAHdbRYdhXE0UyjKfxfyleCZPIHk
   oZzOs5BrFKTlgmNq96iPySLeoxdmHwS/cxf3eu9spIi3IkMyr/0r0d0ys
   juM6Qj2DxAXIWVAOqKkANq/lsgD/lXIlDg6Iet0SoK1Jb6xxWOsjlC/5y
   23jFyoyx6b871pE5+fYn/jW3naXmy7C+dkg8/tyjcQ8JnlDfbjrfvJ5ll
   /txlXb2M3R703NJ5b8ShhuZkdHDnrxqBCfn7OnFnATJkIg6hQqY77I3kp
   05lNt8kEogAbxkxvY4/OlWGCtFcPRA2hIMTmTsA9yKFVwpiAwJ+/LsE64
   A==;
X-CSE-ConnectionGUID: pmDkDJy8TX2G6U2UkqmSVw==
X-CSE-MsgGUID: GJUVPx1SSuqBD+uuXF+5gA==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4043880"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 20:45:11 +0800
IronPort-SDR: f3rzE6L8rbP7zKs7m5xNbwzuMQGKBdi7lGbAYW9SEZPbKcRg5ax9XhwzjX+COqaPY2W5nVbST5
 aPXcqUMoNXTQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 03:56:14 -0800
IronPort-SDR: jdrZk7JpovGoU7gRKtfspzwPB9WTQ+zijiEI5l8reszBnhOZhixOUp/61C3rqyNRAqY90fzY18
 mbsuGv0ijqKw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 04:45:11 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/7] fstests: add tests for btrfs' raid-stripe-tree
 feature
Date: Tue, 05 Dec 2023 04:45:06 -0800
Message-Id: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFIbb2UC/23MQQ7CIBCF4as0s3YMYAniynuYLgoMdha2BhrUN
 Nxd7Nrl/5L3bZApMWW4dBskKpx5mVuoQwd+Guc7IYfWoIQ6SSV6dGuKGdPIAY22RhtrojUB2uG
 ZKPJ7x25D64nzuqTPbhf5W/8yRaJAp3RPTjof4/n6Cv7olwcMtdYv8mySQ6IAAAA=
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701780310; l=1962;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=jEWOH8dvaZHL/ZoRHFtM8gnw6DxdNfuEkQhcOjJF4VU=;
 b=bxNU9qvl2908mJcM6AhUKaF+chWmD1qQeDA2xl/fdzJJLhd9YMXNy6gQ9jsEefSmPqiKBXiQB
 SyNpyzTEySLBOrCqEL81y8QOfrQkvP5QGQmiAhhRsFlmb+qrRrgSxCv
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add tests for btrfs' raid-stripe-tree feature. All of these test work by
writing a specific pattern to a newly created filesystem and afterwards
using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
the placement and the layout of the metadata.

The md5sum of each file will be compared as welli after a re-mount of the
filesystem.

---
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
 tests/btrfs/302     |  53 ++++++++++++++++++++++++++
 tests/btrfs/302.out |  58 ++++++++++++++++++++++++++++
 tests/btrfs/303     |  58 ++++++++++++++++++++++++++++
 tests/btrfs/303.out |  82 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304     |  56 +++++++++++++++++++++++++++
 tests/btrfs/304.out |  75 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/305     |  53 ++++++++++++++++++++++++++
 tests/btrfs/305.out |  65 ++++++++++++++++++++++++++++++++
 tests/btrfs/306     |  56 +++++++++++++++++++++++++++
 tests/btrfs/306.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 677 insertions(+)
---
base-commit: baca8a2b5cb6e798ce3a07e79a081031370c6cb8
change-id: 20231204-btrfs-raid-75975797f97d

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


