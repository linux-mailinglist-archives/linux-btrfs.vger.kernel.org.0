Return-Path: <linux-btrfs+bounces-912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A2811036
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 12:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745982822D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215624205;
	Wed, 13 Dec 2023 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Efw+pJyX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CE7199;
	Wed, 13 Dec 2023 03:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702467325; x=1734003325;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=CFMdVIjYEHRKAW9HT5fnwral3Zbl4aKvKfqrMdBv2r8=;
  b=Efw+pJyXf8D93c+CoWvkmcnasAFIAlswh2edhF/hgMdD5BHUp9EKH7Xw
   oz9VeepXSvElGwOIDrRxg9ta9K/ZuqhzbWHdhywms1S/ZLdYUfcpZXzR0
   qW1IMdWMOzzC/brysk6WhudsGXQh/PbmAqoM4Keat2Ywn8qJusafdjgIB
   otftDxiY7EBzhtM6ZGu+XQQNYkUYNeBmaqDviQGTyQtUKkWDWFJciZnuG
   ELC3Qh8a756km4k3JopDyl2b4EH0TMREEIjo3NGnvlNSD+W/JLywzX0Tq
   tJqWf/HvlsjJ0WXNye0YT8GTyQBLinayPhAF08WgOjTcoRnOzRGcNMqPW
   A==;
X-CSE-ConnectionGUID: T/Zw7jMRTOapnFMIdjT4RA==
X-CSE-MsgGUID: 1FkfndhUTJ24iGvGHuzbzQ==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4718825"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 19:35:24 +0800
IronPort-SDR: c6BJfNm0BmkZUiCWH4VUNjKlbPHb5Qe9SRELAMftePQrjLspBoAl6qLqxyuKU9xCRucVuB+Lyp
 +Wz0vjoAqLhQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 02:40:36 -0800
IronPort-SDR: jvUpEoHthA792O98JBaVOFAXaPdmoiOtOsspMFnTQ1IUUVcv6hGMRfftbHiqrobKwEDR4vxeA7
 iaa9ndtwlHtA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 03:35:24 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 0/9] fstests: add tests for btrfs' raid-stripe-tree
 feature
Date: Wed, 13 Dec 2023 03:35:21 -0800
Message-Id: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmWeWUC/3XNQW7DIBCF4atErEsEA+PBXfUeURZgoGHRuILIT
 RT57p1kUyOlyzfS989dtFRLauJ9dxc1LaWV+cxjeNuJ6eTPn0mWyFuAAqNBWRkuNTdZfYmScCS
 kkfJIUTD4rimX6zN2OPI+lXaZ6+3ZXvTj+jKzaKlkALQp6DDl7D5+4rSf5i/xiCywhdhBYAiYn
 UrJG4uhh+Z/aBiq5JA8WjN66KHdwqGDliGSA2djNJ5UD3ELqYPI0Frvtc+ZHw9/cF3XXwQqCBi
 GAQAA
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702467323; l=3025;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=CFMdVIjYEHRKAW9HT5fnwral3Zbl4aKvKfqrMdBv2r8=;
 b=iN2P+hsMiJAiuSlB+vq2DCQH+YkG/MSeNOHELyoUAV9b9Eu4eYiX/4ntnU8LksewJ8FgDJNdx
 jEVfDXY02AWCe3HsnTshsvQU9W8eV8ZPHlgwq6nEVMnXHJZyRhP+0MD
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add tests for btrfs' raid-stripe-tree feature. All of these test work by
writing a specific pattern to a newly created filesystem and afterwards
using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
the placement and the layout of the metadata.

The md5sum of each file will be compared as well after a re-mount of the
filesystem.

---
Changes in v6:
- require 4k pagesize for all tests as output depends on page size
- Add Filipe's Reviewed-by
- Link to v5: https://lore.kernel.org/r/20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com

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
 tests/btrfs/304     |  58 ++++++++++++++++++++++++++++
 tests/btrfs/304.out |  58 ++++++++++++++++++++++++++++
 tests/btrfs/305     |  63 +++++++++++++++++++++++++++++++
 tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/306     |  61 ++++++++++++++++++++++++++++++
 tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/307     |  58 ++++++++++++++++++++++++++++
 tests/btrfs/307.out |  65 ++++++++++++++++++++++++++++++++
 tests/btrfs/308     |  62 ++++++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 720 insertions(+)
---
base-commit: e8a1c16502fad2660d29de5835c4c84700b1f11a
change-id: 20231204-btrfs-raid-75975797f97d

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


