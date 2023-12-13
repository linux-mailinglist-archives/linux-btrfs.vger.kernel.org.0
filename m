Return-Path: <linux-btrfs+bounces-923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337D8114F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB50E1F21774
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8F2EAFD;
	Wed, 13 Dec 2023 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pLCya56+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D5E116;
	Wed, 13 Dec 2023 06:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478587; x=1734014587;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=5WVCAfr07jYxoLzMbloFz6OFtEdpfQOpVfwUdN+zweg=;
  b=pLCya56+UPuEkAnUVvHZOXWE3ezD6c58fR0bMYiDc+pyC9T/2BvS3VO1
   bO8gzrgUgN+/MlBb8NsIePK8bDFzC05eC8I5BPLJbvSgSIqBQNDTNwI/R
   iGG13xhft94UOm6pd0D8v3yfc1ccsVUd9ofBIisJOfISYv6fWn6tRNAgP
   uR5ipTEPME3FPrFl74Mjw+GbKLeEoWFIqzyrEN9E4W5asYSKgfyDp9Rf8
   cjO5O52q8E7wwrmXuD2yR48U+SfnGldcG0hVqAp3Bgd26ZKltONcYgmiX
   /Nnp/C1wXVIOsq2/ubrwEIiC8ugfX64dzRkeN5G6D2Y7uGrSwTE0PkBy3
   g==;
X-CSE-ConnectionGUID: 0xId4nYKTOKId+fyts6KlQ==
X-CSE-MsgGUID: LC3veFvQRpaTk6b07Sx0iw==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4802933"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:07 +0800
IronPort-SDR: lrVidY/xkYLJzC5qp1+3SWIUg0cc3aEqpkO9Gu/qUET2zhtR0/wfPU/60Gp3Oy1gV/QBnkZG5o
 kZsMJlA84fXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:19 -0800
IronPort-SDR: Ge8WnutGkNdHzjRMAwhP1jbkQrE6YzoDhsCg63xNdaeuwszKw7SdP6oyDiku68gZSA2+GeWbJ+
 vabbeGDbgzHg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:06 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 00/13] btrfs: clean up RAID I/O geometry calculation
Date: Wed, 13 Dec 2023 06:42:55 -0800
Message-Id: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/CeWUC/3WNTQ7CIBgFr9J8azFAi6aueg/TNPxaYgsNVNQ03
 F1s3LqcSd68DaIOVke4VBsEnWy03hWghwrkyN1NI6sKA8W0JhSfkViDicPMl0FMXt6RnDR3jwX
 VzcmwmhvTYgVlvQRt7GsvX/vCo42rD+/9KJGv/TUJ/dtMBGEkqGpZo1rOmOieSh6ln6HPOX8AB
 Pzz57wAAAA=
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=1872;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=5WVCAfr07jYxoLzMbloFz6OFtEdpfQOpVfwUdN+zweg=;
 b=ZhqRgLFD/ytsiyaEc1+zC594UEA1OkCcyXTwj45pnlyI4Yao3FgkY+6Z7C3NwapkEJckugvJf
 6gRy42yB5pWDdqHqFbOf2giSg+nGVmobkEx+mNmcSWKDyfy1ptEtSei
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

The calculation of the RAID I/O geometry in btrfs_map_block has been a maze of
if-else statements for a very long time and the advent of the
raid-stripe-tree made the situation even worse.

This patchset refactors btrfs_map_block() to untagle the maze and make I/O
geometry setting easier to follow, but does not introduce any functional
changes.

I've also run it through Josef's CI and there have been test failures, but
none of them introduced by these patches.

---
Changes in v2:
- add btrfs_map_op into struct btrfs_io_geometry
- split RAID56 read and write into two different helpers
- drop redundand 'for' in helper function names
- kept dev_replace_is_ongoing variable name
- Link to v1: https://lore.kernel.org/r/20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com

---
Johannes Thumshirn (13):
      btrfs: factor out helper for single device IO check
      btrfs: re-introduce struct btrfs_io_geometry
      btrfs: factor out block-mapping for RAID0
      btrfs: factor out RAID1 block mapping
      btrfs: factor out block mapping for DUP profiles
      btrfs: factor out block mapping for RAID10
      btrfs: reduce scope of data_stripes in btrfs_map_block
      btrfs: factor out block mapping for RAID5/6
      btrfs: factor out block mapping for single profiles
      btrfs: btrfs: untagle if else maze in btrfs_map_block
      btrfs: open code set_io_stripe for RAID56
      btrfs: pass struct btrfs_io_geometry to set_io_stripe
      btrfs: pass btrfs_io_geometry into btrfs_max_io_len

 fs/btrfs/volumes.c | 410 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 259 insertions(+), 151 deletions(-)
---
base-commit: 14d1d39586246ca9d4ce97049c98be849e3bbcd9
change-id: 20231207-btrfs_map_block-cleanup-346f53aff90d

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


