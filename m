Return-Path: <linux-btrfs+bounces-19705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF79CBA4E2
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 06:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E1B130019D3
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 05:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24CB21C9F9;
	Sat, 13 Dec 2025 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L6cNBHjF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD37182D2
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 05:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765602200; cv=none; b=q/tqycnF8lEQTPg76Bb76mUEmTG6QPgTRDc8AIGNbkk8ZWvulfGjYLcpv2uaKM7F3dmlEonMezebu1IxxlvdMatXyHL7VL86Udl2L6BNg/8G170FGPUPRcMqn4Yd9J7L8FIQixIRAMSDkkvN1d2mToiiFqFxHwItm7ELxh6kcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765602200; c=relaxed/simple;
	bh=leCF247BPLN4OaBdwFUacqPie1oMgTJCp39QvT5zRL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFJ+GkIAIhmNLdKVymgGZx/feSF+7g0CBu6uwxCl89/O5sp2M636PYV2QfZpY5sHy5zWZA8ZHPnoBLKInst3x04IAvjMMOcVgZw4+uvUhvidHESsdEBKIoqVbENCR8P8miUpFSjOd0pMEhNKxEeRsViO7W3LMHpvXFvna+AZp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L6cNBHjF; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765602198; x=1797138198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=leCF247BPLN4OaBdwFUacqPie1oMgTJCp39QvT5zRL0=;
  b=L6cNBHjFSKeabkRuKegPi8oFRb/ZBzCuGAxYieappInr6xAPbseKS2hc
   e8bLLgExagJ2oTGX0Q34zAzpgsCKB/SThlNnzCRLD522B0Eb6L+l3Pgkn
   9ZWGS1JUTYI0pk2btLnvA+xhh7JD5I0M4fBTlKjIsANEct7QN1mXRrns0
   Oizd6ZHOF04QNtBqqt9ier47ZttCCFshN/3KcIWTXWQMy6y9xKnZz3F+Q
   pIiVuRtM04q1Vsrh4LdsugAQhpq/HlEUfRk60P7EwsIWXsUChTfZwRUDH
   58vnGwQuTp07PhGooJQ9QjxXdjh0v2otzRAus1WOiLduaaYWIEDfZNCHt
   w==;
X-CSE-ConnectionGUID: U+N+aXCkQS26iFeH4Qjhvg==
X-CSE-MsgGUID: mFUbZy0yRv613VopS1mTsw==
X-IronPort-AV: E=Sophos;i="6.21,145,1763395200"; 
   d="scan'208";a="136986288"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2025 13:03:16 +0800
IronPort-SDR: 693cf394_YdhraLbQ/0VujyUlSVXg/gs/0Gpw9R6yRHm+4sSRS+0EzCg
 LZPYNZTDAva5FWyX7ZOKVywuNxZtyvzBQ587umg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2025 21:03:17 -0800
WDCIronportException: Internal
Received: from 5cg21747lt.ad.shared (HELO neo.wdc.com) ([10.224.28.121])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2025 21:03:12 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/4] btrfs: zoned: zoned statistics fixes and updates
Date: Sat, 13 Dec 2025 06:03:01 +0100
Message-ID: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
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

The last patch also adds the reclaimable zones to the statistics
printout. 

Changes to v3:
- collect reviewed-by tags
- add data_race annotations
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
  btrfs: zoned: move zoned stats to mountstats
  btrfs: move space_info_flag_to_str() to space-info.h
  btrfs: zoned: print block-group type for zoned statistics
  btrfs: zoned: also print stats for reclaimable zones

 fs/btrfs/space-info.c | 18 +------------
 fs/btrfs/space-info.h | 16 ++++++++++++
 fs/btrfs/super.c      | 12 +++++++++
 fs/btrfs/sysfs.c      | 52 -------------------------------------
 fs/btrfs/zoned.c      | 60 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      |  8 ++++++
 6 files changed, 97 insertions(+), 69 deletions(-)

-- 
2.52.0


