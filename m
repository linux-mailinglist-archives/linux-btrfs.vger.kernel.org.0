Return-Path: <linux-btrfs+bounces-19747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8775CBEE6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 17:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 511FA30274EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D930FF20;
	Mon, 15 Dec 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VEIie0HG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7E2C2363
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815877; cv=none; b=mRXc1v7P8xdxWj2v1oQB/+FBN3fSyuzys7bwQwgDRZf9vwqxYbtYHangjWKeXpYQCRg06+Z0noKndS/VqXkuXLCRuhe3WL9/5dPfgnHw8JRREB2wB4qPbpA/J9vNKBJIvagrATBCMSsEabqjTbE0/OVqKqmQwP5cJ4aQSjQn4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815877; c=relaxed/simple;
	bh=g2pZWIJPNJCWULT6dOPa9fuJFnEx26v5f5F3h6eT4Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2XdfziWSxvZqonrBNuNbVFNIGnOASXeizgVmIkzAOVd4CstPoPc4PbqPV5fYHAqX6ZH/Uz5Ov4kYs1uXgtByWTIaMqdhpDl+2sLO4sJO1sprUR4/RnNOZw6AoYBdpeFUhvbe0d2fcRy4NB3Tf1JT3p8esfUP7CKU6KHpzdDS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VEIie0HG; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765815876; x=1797351876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g2pZWIJPNJCWULT6dOPa9fuJFnEx26v5f5F3h6eT4Yk=;
  b=VEIie0HGiye4CiM6CaMw1j+VHcHtvm8+gZBUa+A/9THAPjk4lj8UQ03d
   g4wTkehX+04NAj3XdafZU8BK1rBSgZiUCKGtG+41cmtQro0/KikIv5KWv
   JMCh8jhJ5ErkiKqpU3Uh3SnU2Y6XQYaJ40wEMsnzzeUozpr79A+GxNIrb
   mgdTLW+umIhw0P8zqIMEHTWiVw/MPH9WtDrkNAD5dB3OMzd1KE2tyHEQh
   bO7xQlJgft6o1n/hid+AtrNR7SRe9wVbt1bdIMR/ulif3tEw6poQgdL4f
   1Sxjy1I5s1Tv4+yISF3FaXa1tLWW62DwTjR5kPHIJlaE5K8VRIbVHeZiw
   Q==;
X-CSE-ConnectionGUID: hjXUEQFET+6OqqCUtACQnw==
X-CSE-MsgGUID: 7qyhjmO5TyCgVMXSvSO86w==
X-IronPort-AV: E=Sophos;i="6.21,151,1763395200"; 
   d="scan'208";a="137916722"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2025 00:24:29 +0800
IronPort-SDR: 6940363d_y5As0PwGb516KlE3zN4qyOo01scLuFj0Jlu3no0/dVuSCqi
 xXnKybmYsDLNGhaLhCt/4s5XQTeR+YWOjWydABA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 08:24:29 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.125])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Dec 2025 08:24:27 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/4] btrfs: zoned: zoned statistics fixes and updates
Date: Mon, 15 Dec 2025 17:24:17 +0100
Message-ID: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
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

Johannes Thumshirn (3):
  btrfs: zoned: move zoned stats to mountstats
  btrfs: move space_info_flag_to_str() to space-info.h
  btrfs: zoned: print block-group type for zoned statistics

 fs/btrfs/space-info.c | 18 +-------------
 fs/btrfs/space-info.h | 16 +++++++++++++
 fs/btrfs/super.c      | 12 ++++++++++
 fs/btrfs/sysfs.c      | 52 ----------------------------------------
 fs/btrfs/zoned.c      | 55 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      |  8 +++++++
 6 files changed, 92 insertions(+), 69 deletions(-)

-- 
2.52.0


