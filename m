Return-Path: <linux-btrfs+bounces-562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C48034C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 14:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25992B21042
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3322925577;
	Mon,  4 Dec 2023 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KfM1U5v/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E041731;
	Mon,  4 Dec 2023 05:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701696314; x=1733232314;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=jWZggdfAkKx3qGGgsFwW3RNkyiJ8YocNqsMgRphdzHQ=;
  b=KfM1U5v/YEMz75u0f/kvS+r5AVsVDvF/naps+82LnyNCllluBGZeTlA8
   gGAdNd31ZLv5/hga3xlYn9wM2HmgxEVazoYC0g1N98B4pLaHJsO0fixjT
   fJdQZhw4WcYS1sCZ62iXto4CQzAinITQXHbq5p1bNwsIC6sG8GqPHsCks
   wD68+1gFZMF11ApP99Qcpe3+q4Hz14fRAUz+oF+eRg9k4526U+X9YC4uK
   IgZzvXhtO5qnvisWLrE59Tna2h1/Kg0lWHKYbIFJ39DKj9wC8EcLDxxOW
   NQmWQJiHg8fmvLOvjDxW0kt9RlwWx1x7qgrMZGr2UG8Q9kcgpf4O3gvYs
   g==;
X-CSE-ConnectionGUID: PpkBczJ1RliJGqbkv/N/rw==
X-CSE-MsgGUID: 656Tvk9pSumUF8bs4s+H0Q==
X-IronPort-AV: E=Sophos;i="6.04,249,1695657600"; 
   d="scan'208";a="3929116"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 21:25:13 +0800
IronPort-SDR: yRxh2+03SM9cIWiPO1brIukWC1PvMhB7KAzUx81DbUbIzJDHxkp0bN7loq2AnDNwn4ks+YUoiG
 C62A2iDyos0g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2023 04:36:16 -0800
IronPort-SDR: F4+n3/Ta9pWhJdr0BEJUy3mkY4NFn602108OiwaLdb6XC+ayQVAKu9DpflRSwtJcp+1S9AERHv
 PVDYga26qriQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2023 05:25:12 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/7] fstests: add tests for btrfs' raid-stripe-tree feature
Date: Mon, 04 Dec 2023 05:25:03 -0800
Message-Id: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/TbWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIwMT3aSSorRi3aLEzBRdc1NLc1NzS/M0S/MUJaCGgqLUtMwKsGHRsbW
 1ACiTKG9cAAAA
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701696311; l=1735;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=jWZggdfAkKx3qGGgsFwW3RNkyiJ8YocNqsMgRphdzHQ=;
 b=EQS+Qvu47ZIuudW7FDRidJLysBFaVeGdmZJQ68r8GWnf3rFXsDPE+2mE6/oyEgXfwpGZQhcmv
 o1nXlwAoeX+BCoB/vdOzjUH1TS9f1T+a+fPzCBXSOgB/N/Nb3y6BGKd
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add tests for btrfs' raid-stripe-tree feature. All of these test work by
writing a specific pattern to a newly created filesystem and afterwards
using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
the placement and the layout of the metadata.

The md5sum of each file will be compared as welli after a re-mount of the
filesystem.

---
Johannes Thumshirn (7):
      btrfs: add fstest for stripe-tree metadata with 4k write
      btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
      btrfs: add fstest for writing to a file at an offset with RST
      btrfs: add fstests to write 128k to a RST filesystem
      btrfs: add fstest for overwriting a file partially with RST
      common: add filter for btrfs raid-stripe dump
      fstests: doc: add new raid-stripe-tree group

 common/filter.btrfs |  14 +++++++
 doc/group-names.txt |   1 +
 tests/btrfs/302     |  55 +++++++++++++++++++++++++++
 tests/btrfs/302.out |  58 ++++++++++++++++++++++++++++
 tests/btrfs/303     |  59 +++++++++++++++++++++++++++++
 tests/btrfs/303.out |  82 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304     |  57 ++++++++++++++++++++++++++++
 tests/btrfs/304.out |  75 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/305     |  55 +++++++++++++++++++++++++++
 tests/btrfs/305.out |  65 ++++++++++++++++++++++++++++++++
 tests/btrfs/306     |  57 ++++++++++++++++++++++++++++
 tests/btrfs/306.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 684 insertions(+)
---
base-commit: baca8a2b5cb6e798ce3a07e79a081031370c6cb8
change-id: 20231204-btrfs-raid-75975797f97d

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


