Return-Path: <linux-btrfs+bounces-5190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A98CBAED
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD081F224B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B0478C93;
	Wed, 22 May 2024 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oYyTtfnK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B478C66
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357831; cv=none; b=iSCdA4HEttq0SuJS4Z/BC435ENDMsRYYDmQRfHPGPhJZU547Uj/0ioVYNRAXQydlEQfNDiFhk7AFsN3KmtYhHWT1J48VTTxvD31CtIo2nw9XC+YAlKBNe00abCMCsd/0TuEl0CcjV4ieGWH88dioSBOdwp2at6BSL9vCLk17SrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357831; c=relaxed/simple;
	bh=dW7lOL7wecZdTD3IUotrAWa9AX2ylG88Igrkf1x+r+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpvoNBFcLx+cZBBszMdOsdC9qogN44qLHBKVI2+5VHTOsrRrHgUhy3hr16ldCBNDhEBUmpye7oIzwA8+SY0j+7yXpcLePPC3/fmXfshKLcOnYMC24te414H2ia6AGKJqdNDWkIU9o+GtIFbf2UlGzBwpg6zuDy/l++hBPcZp/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oYyTtfnK; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357829; x=1747893829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dW7lOL7wecZdTD3IUotrAWa9AX2ylG88Igrkf1x+r+4=;
  b=oYyTtfnKYucAj/3FwRk8W01uwYmUPhzwoQlYztZtOVP4FPqyfcRayh2a
   exXEB9vuf9xFtQFq9MRtiAfkVI2vzpyUKg/ndL7gRaIYuWnkqkBqf3EU1
   j50EGzzuAwnCvPSkcTD4K0kP2l9HlSRCMN6R/UWgsQ/Dqw5LWe0HtV7ld
   SJva3tRYKR1F6hm5acqXlZvk2LHGYCAaYZW78oeR6uWn0XgHaa5Sdzwtm
   AtHbZ51/N4pMxjeGRx+jyiEe3no7XXaK73XR0jSj9G/o6CInkJI7WGVBv
   0GLq/gWKcvKU56sheGp5AXY5BR1IpkVAMuFz9kd69GoE/LoLfGeQ+QAS/
   w==;
X-CSE-ConnectionGUID: k9cMDFBSQ5OeDMKplAXn5w==
X-CSE-MsgGUID: Iisazmb2T7u/fB1cgjmSOQ==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="17170965"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:40 +0800
IronPort-SDR: 664d7d1e_fdfe2IxDowai5mvCWqMHjv9GKuxfBxqj9bxbQ6nXQVNJRLj
 Mk6QBqhQfnlZWeDtc/V7mSZLBZCrRD4NR2VECJw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:35 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:38 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 00/10] btrfs-progs: zoned: proper "mkfs.btrfs -b" support
Date: Wed, 22 May 2024 15:02:22 +0900
Message-ID: <20240522060232.3569226-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mkfs.btrfs -b <byte_count> on a zoned device has several issues listed
below.

- The FS size needs to be larger than minimal size that can host a btrfs,
  but its calculation does not consider non-SINGLE profile
- The calculation also does not ensure tree-log BG and data relocation BG
- It allows creating a FS not aligned to the zone boundary
- It resets all device zones beyond the specified length

This series fixes the issues with some cleanups.

This one passed CI workflow here:

Patches 1 to 3 are clean up patches, so they should not change the behavior.

Patches 4 to 6 address the issues.

Patches 7 to 10 add/modify the test cases. First, patch 7 adds nullb
functions to use in later patches. Patch 8 adds a new test for
zone resetting. And, patches 9 and 10 rewrites existing tests with the
nullb helper.

Changes:
- v3:
  - Tweak minimum FS size calculation style.
  - Round down the specified byte_count towards sectorsize and zone
    size, instead of banning unaligned byte_count.
  - Add active zone description in the commit log of patch 6.
  - Add nullb test functions and use them in tests.
- v2: https://lore.kernel.org/linux-btrfs/20240514182227.1197664-1-naohiro.aota@wdc.com/T/#t
  - fix function declaration on older distro (non-ZONED setup)
  - fix mkfs test failure
- v1: https://lore.kernel.org/linux-btrfs/20240514005133.44786-1-naohiro.aota@wdc.com/

Naohiro Aota (10):
  btrfs-progs: rename block_count to byte_count
  btrfs-progs: mkfs: remove duplicated device size check
  btrfs-progs: mkfs: unify zoned mode minimum size calc into
    btrfs_min_dev_size()
  btrfs-progs: mkfs: fix minimum size calculation for zoned mode
  btrfs-progs: mkfs: align byte_count with sectorsize and zone size
  btrfs-progs: support byte length for zone resetting
  btrfs-progs: test: add nullb setup functions
  btrfs-progs: test: add test for zone resetting
  btrfs-progs: test: use nullb helper and smaller zone size
  btrfs-progs: test: use nullb helpers in 031-zoned-bgt

 common/device-utils.c                    | 45 +++++++-----
 kernel-shared/zoned.c                    | 23 ++++++-
 kernel-shared/zoned.h                    |  7 +-
 mkfs/common.c                            | 62 ++++++++++++++---
 mkfs/common.h                            |  2 +-
 mkfs/main.c                              | 88 ++++++++++--------------
 tests/common                             | 63 +++++++++++++++++
 tests/mkfs-tests/030-zoned-rst/test.sh   | 14 ++--
 tests/mkfs-tests/031-zoned-bgt/test.sh   | 30 ++------
 tests/mkfs-tests/032-zoned-reset/test.sh | 43 ++++++++++++
 10 files changed, 259 insertions(+), 118 deletions(-)
 create mode 100755 tests/mkfs-tests/032-zoned-reset/test.sh

--
2.45.1


