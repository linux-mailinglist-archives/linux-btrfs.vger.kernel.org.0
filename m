Return-Path: <linux-btrfs+bounces-20617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F35D2F24E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 10:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53DE03007E72
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE0D35CBBB;
	Fri, 16 Jan 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c8Ue8gHr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC90239594
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557478; cv=none; b=G54YTv3x/dYC+4Ti4CEMNiBzfkPg3ckI3dPNLSEpZ7SD4nIzzDrl/9D5ucyQXO7rHLcz4pcacZ8ko7OzM/BYfE3r3NnXTrIkdIUihHUQhupb/btHHcKZWxZ6yP52lImmrp3ACuU2EFrTsLL9bz095hbKxry/DssPX9Obkp1jsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557478; c=relaxed/simple;
	bh=fWcu4GF5zYNa++Yul1CM2Xm6oKpXmPIqJsohy4XTfKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDp9EkUwWuB77QPgPwATxlyrIIl0ijQ8Y27XQQXDpAIGgiUMu13NCDEir87Kb0eLZeilU1I0xKPIzZXFur8R0S3r8lvxY7pHkoGR37TE72NVKaoZKUCAvoAOoTjWNDiIKa1SrxEAm34HDEE1gIT/KZJbouEKiVvTXfJOUxmm47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c8Ue8gHr; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768557477; x=1800093477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fWcu4GF5zYNa++Yul1CM2Xm6oKpXmPIqJsohy4XTfKU=;
  b=c8Ue8gHrksgZl4NEB9Jaez36ofMEKwLsZtKCXvsn6kRs+yxLo5D6vVx3
   ReI3i70hU7vC/oktFm/bsotj9chwqLvTbsT0DcVb6A9oZDO62QYvAkzcp
   j5znx7mCVMfDczizJohpPJ+k3yFXLmaku8oR6jQGiFHFe+YbmfSydhMlv
   P5v2LaI1z5Z9nkBfSLNU/wt/Ip4HYzuZGScTnLUY20mEp03GO2X4TOfT4
   O9VxCGCokXBckAoVBVHeVKzR0yKsue4fbuwd6pOTStZAOSSExNKxFfiHk
   PeA5AM/jiKsI/XrCIbZm/WR1Grzi3pqEpmUD6S+tu1ffa3IXIVoj1U5Bx
   A==;
X-CSE-ConnectionGUID: 8EnGzVH3TpG96rSWmBp0pw==
X-CSE-MsgGUID: DpHrQu5PTHWXgZ6NZDRrcA==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="138913516"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2026 17:57:51 +0800
IronPort-SDR: 696a0b9f_nY916PFSyXTJtfYz2agH0HZJx5YIbDcuJ9JVfxkjOkIQHB/
 a7AB3ykMkIb/xoPj9K9cr0bC83Q7M6eeDGorHRA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 01:57:52 -0800
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO neo.fritz.box) ([10.224.28.27])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jan 2026 01:57:48 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 0/1] btrfs: don't allocate data off of conventional zones
Date: Fri, 16 Jan 2026 10:57:36 +0100
Message-ID: <20260116095739.44201-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a zoned filesystem allocate data block-groups only off of the
sequential zones of a device.

Doing so will free up the conventional zones for the system and metadata
block-groups, eventually removing the need for using the zoned allocator
and all it's required infrastructure, that needs to be emulated, for
conventional zones.

TODO: If the device does not have any sequential zones left, but
conventional, allocate the data block-group from the conventional zone,
or just ENOSPC?

Note: This patchset also is only mildly tested. Several fsx runs for
stressing and file I/O for functional testing, no full fstests run yet.

Johannes Thumshirn (3):
  btrfs: zoned: only allocate data off of sequential zones
  btrfs-progs: collapse find_free_dev_extent into
    find_free_dev_extent_start
  btrfs-progs: zoned: only allocate data off of sequential zones


 fs/btrfs/volumes.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

-- 
2.52.0


