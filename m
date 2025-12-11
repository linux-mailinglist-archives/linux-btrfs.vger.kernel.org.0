Return-Path: <linux-btrfs+bounces-19649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACACCB51AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 09:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B3F73014106
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A927B358;
	Thu, 11 Dec 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RwbbyeLu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED217A30A
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441779; cv=none; b=mQtrIcfWTGRuwXcS/ny3fwYZYyDoFXZtn3sOm3qO8t7LXw68IEAsBydiiswfVD94kwvG6yRcj1B3G+NdhowOLbTlJd0k13s3O4+D3KBcbqnX5nbb7FHEaN9zbwQnWfJ5acgye8TE230F7gg0SsrwiiQwt9RurXqUU6UavcoyfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441779; c=relaxed/simple;
	bh=Z/feoyei+raqe+ANude0qnQBoyRshuLBbNRJzW0uxXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAsKS6C4eGRsQuARVdB4h3wTOMRI70+8R4CnZhzKy3PUw7uCW3moSryOcQNBMxBMLrgt0YGXRv6poJ9uPO/yjzcjYGMY3tHq6MtUBbXK8+MXsyFWTneO8xQz7vR8ENJXXqTrihx8iw+4O05Ha66meT4JBPRDcjjbTIy7HZ6ITVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RwbbyeLu; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765441776; x=1796977776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z/feoyei+raqe+ANude0qnQBoyRshuLBbNRJzW0uxXc=;
  b=RwbbyeLu6DdKjuTtyMkktQnr/32lfgB26uZUkqtnLovWoVQeKXPVxLit
   0w90ymPITm7syyT1YcQfDxlqJ+7aF5K5rwW+dCcsY81yqgNJzUKDTbRRx
   tONSBsZuZlL4BsNe+61+GXVS+bpwoEs2Gsbj+adYGddeTLL33pOXuh856
   ajsydHbepAh1u26I36tMmUol0ppsawBowLnCSmB1SuZSuIlCMsY/9kjGk
   d+PJffrB+yxwwQe3c8QKJJpZ5eVz7ygZMwSFaYIS8OWRUJY9S+TY79DCr
   47j1r0gq/wiErUEihTNh7vC2yCn+2pa3oOwXcF8hzRX/bn4cxmzLi/b3N
   A==;
X-CSE-ConnectionGUID: 5WbMdXZKT7+LaCW6B5Zc4w==
X-CSE-MsgGUID: BwKMohyLS9GYv+Dx1OnNvQ==
X-IronPort-AV: E=Sophos;i="6.20,265,1758556800"; 
   d="scan'208";a="136312461"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2025 16:29:35 +0800
IronPort-SDR: 693a80f0_SmKdcQUdIhBY7eUgM9CrYUKrGjhOEz3LLl7mW/OSlRKOnbE
 z68v4GvcLDLeJg+7xqff0p8PAWfUMDJU4BA1uUA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 00:29:36 -0800
WDCIronportException: Internal
Received: from 5cg0214bv2.ad.shared (HELO neo.wdc.com) ([10.224.28.116])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Dec 2025 00:29:33 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] btrfs: add the block-group type to the print of active zones.
Date: Thu, 11 Dec 2025 09:29:24 +0100
Message-ID: <20251211082926.36989-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the block-group type to the print of active zones.

Changes to v1:
- Move space_info_flag_to_str to block-group.h and rename to btrfs_bg_type_to_str
- Use btrfs_bg_type_to_str to decode block-group type

Johannes Thumshirn (2):
  btrfs: Rename space_info_flag_to_str() to btrfs_bg_type_to_str()
  btrfs: print block-group type for zoned statistics

 fs/btrfs/block-group.h | 16 ++++++++++++++++
 fs/btrfs/space-info.c  | 18 +-----------------
 fs/btrfs/sysfs.c       |  5 +++--
 3 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.52.0


