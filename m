Return-Path: <linux-btrfs+bounces-19836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC54CC7F7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 14:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2A2307C6FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0602E3446D2;
	Wed, 17 Dec 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q/H94fWv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F234252F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978905; cv=none; b=GkDA+NAGvsiXUVS8BdBHeEND5auaFWvpnQqzbDvfJJagI5hWGuIhw1wfijTAUW0Tb920H59EQHL6PJUxVEtN2kmvN5Kx5tryCNmEqB973mfNKeBD/XXdZOgkbGlvTmhNAIgLObaZ42rQbefeSV/tvHQwvsHG2VFgm6kDTKpzyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978905; c=relaxed/simple;
	bh=/6PXVx3WWxbpf9UWSMffXC8nqaf42ia1OkwWNwb+P+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2ZGXRmzDMUPrYyfVz5FUHDWs94K763YhgKUpou3zFevblt4Nh7tdXMxO2FRzTKtOY5OkapVOCbVjtbbOGbACGxkZ/jSPy0zb3Y/6lo5Rx1R0xTNe5eKmKSdoiZlKYG2deCDFTbBneWeN1MUge3ge8hOY4o0s8Ow8dU5y8uwGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q/H94fWv; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765978903; x=1797514903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/6PXVx3WWxbpf9UWSMffXC8nqaf42ia1OkwWNwb+P+4=;
  b=q/H94fWvjA04zwwPTS5kO9VUh2htkleNIBWY8qZbv/6pCkXGm3VAkUdD
   MpvsWfLXLdEyizvdapHVv6DJF+191QZ4WPK1k00uMtD+bfa+DXZy4q++r
   nD95G5ur3X2eJLDOprIB/rsvyx2k8i8739CvUGMUH4GB70iXSA3767jXA
   vyQoNPES9qpERJe/OFWO5I+cjRhEWMTPtFk479CALlxisFychDjhkb6WM
   1p79ESnPyBv0pBGp8/SGzWk/CWP3/4KIrPHiDAKrOkWMNNQWVD60UXgEP
   3sR/wNMBfEGgI+jJKkutjk2rVdsicETzFN/S9R5Co9SiFktB10iWc7JyL
   w==;
X-CSE-ConnectionGUID: J/rjviWoS1KBwRtKpnLsdw==
X-CSE-MsgGUID: huwjLjKhQke1yghqVQp/lQ==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="136693786"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2025 21:41:43 +0800
IronPort-SDR: 6942b317_fzbNSv+0dbGb2MjltMgRc7pan/u2vMtIJ4b8yEe6FVR+uHu
 N0dEhylwqZRo6naYm0PUOM1ARfXB1apRWOXI71w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 05:41:43 -0800
WDCIronportException: Internal
Received: from 5cg1443rm2.ad.shared (HELO neo.fritz.box) ([10.224.28.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Dec 2025 05:41:42 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 0/4] btrfs: zoned: zoned statistics fixes and updates
Date: Wed, 17 Dec 2025 14:41:35 +0100
Message-ID: <20251217134139.275174-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the zoned statistics prints, the first patch moves the statistics
from sysfs to procfs follwoing XFS' lead, as sysfs is constrained to a
single page and single value per file, which truncates the output.

Next move space_info_flag_to_str to space-info.h so we can reuse it
outside of space-info.c, this will then be used in the zoned statistics
in patch 3 that print the block-group type for each block-group.

Changes to v4:
- remove sysfs file in prep patch
- add a "zoned statistics" header
Link to v4:
https://lore.kernel.org/linux-btrfs/20251215162420.238275-1-johannes.thumshirn@wdc.com

Changes to v3:
- collect reviewed-by tags
- drop the reclaimable zones patch again, its inherently error prone
- access block-group files under bg->lock
Link to v3:
https://lore.kernel.org/linux-btrfs/20251212071000.135950-1-johannes.thumshirn@wdc.com/

Changes to v2:
- add patch to move zoned statistics to /proc/<pid>/mountstats
- move brtfs_space_info_flag_to_str() to space-info.h
- add patch to print reclaimable zones
Link to v2:
https://lore.kernel.org/linux-btrfs/20251211082926.36989-1-johannes.thumshirn@wdc.com/

Changes to v1:
- Move space_info_flag_to_str to block-group.h and rename to btrfs_bg_type_to_str
- Use btrfs_bg_type_to_str to decode block-group type

Johannes Thumshirn (4):
  btrfs: remove zoned statistics from sysfs
  btrfs: zoned: show statistics about zoned filesystems in mountstats
  btrfs: move space_info_flag_to_str() to space-info.h
  btrfs: zoned: print block-group type for zoned statistics

 fs/btrfs/space-info.c | 18 +-------------
 fs/btrfs/space-info.h | 16 +++++++++++++
 fs/btrfs/super.c      | 13 ++++++++++
 fs/btrfs/sysfs.c      | 52 ----------------------------------------
 fs/btrfs/zoned.c      | 55 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      |  8 +++++++
 6 files changed, 93 insertions(+), 69 deletions(-)

-- 
2.52.0


