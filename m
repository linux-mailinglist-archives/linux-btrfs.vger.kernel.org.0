Return-Path: <linux-btrfs+bounces-19689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C357CB8146
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 08:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860A13073FE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8C2C181;
	Fri, 12 Dec 2025 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kfds4bYK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC283C38
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523420; cv=none; b=IpB1y2GwdyprZH59tsAaTM1xiwiSwqJYZGTcqLTO9Qw/bNsfdA8drA9/l9oFzrljwagyzfBF9clXmXNV9FnuOmt6ejlTv2jZ82dLn/U2KrzFrHL4tbFuipQGW+WjHlrEmh4eui/hk0kIpkas2WbI62Pxf1BPUPB6vbb8JQoH5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523420; c=relaxed/simple;
	bh=CmSNhJuTQz6K/S+d7aTYqcHmCe49/YnbcyIrUF6bl5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZCMBJLHsdYByR82Ae6omVS2NcIkQCP+nIofImNrTkJgav6WfA6ex7LK9i8fLQPNaOxC4AOHYypeMn2AENDHWqjEFOARJRI3FVpt7XkJUC5/y6T5WX7rNd+D8SCmCQJrp7I7zRw+ZmgyLYlBxfWIWz1s4xSVNkiQ28s1rYp3djw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kfds4bYK; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765523418; x=1797059418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CmSNhJuTQz6K/S+d7aTYqcHmCe49/YnbcyIrUF6bl5Q=;
  b=kfds4bYKcUjigsXf8w/+DjFpoXNBd3sFYyUQD3KTix4Q9UP7oxZ3B3Gq
   IN9LPRieudIhYVxOkMtTvke92x26uVkd2O8xzohGE87e4/oXSYwBwVUCs
   momQnlAFQlPZkfXJQUvlm5zihXa+l16x7/bU8cgbPZMcc13oPofkK7/WG
   qi5GWQ/L/aCO2/PHHcVtLHDOiMyLmZH+FmzL2p4DI02ZGrE0AE0NF87hf
   UyjIHcsaOqFi4IlIinsB+ihsQzogujFBozlwYfAfglNLKgserNbRsEfhV
   6CLp3sM/lD+APVvkR+7ggqEz6I2pyZK8DF2T4NC/1Y8d+2NldM+B61BUm
   g==;
X-CSE-ConnectionGUID: 5zd3QJekSIyyfkZPJoHyVA==
X-CSE-MsgGUID: r8E6yhGvTYS/pCb5ZXkOYg==
X-IronPort-AV: E=Sophos;i="6.21,143,1763395200"; 
   d="scan'208";a="136927258"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2025 15:10:07 +0800
IronPort-SDR: 693bbfcf_6l8Egqmk3K8VqQC19HM1lizbDJZqwr4mNyCwZPOJPu0roQy
 zMGBJQ98ejrXlIzFxvf0s6FC/8FNsvIEwVIjUbw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 23:10:08 -0800
WDCIronportException: Internal
Received: from 5cg1430htq.ad.shared (HELO neo.wdc.com) ([10.224.28.119])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Dec 2025 23:10:03 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/4] btrfs: zoned: zoned statistics fixes and updates
Date: Fri, 12 Dec 2025 08:09:56 +0100
Message-ID: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
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

 fs/btrfs/space-info.c | 18 +-------------
 fs/btrfs/space-info.h | 16 +++++++++++++
 fs/btrfs/super.c      | 12 ++++++++++
 fs/btrfs/sysfs.c      | 52 ----------------------------------------
 fs/btrfs/zoned.c      | 55 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      |  8 +++++++
 6 files changed, 92 insertions(+), 69 deletions(-)

-- 
2.52.0


