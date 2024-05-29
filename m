Return-Path: <linux-btrfs+bounces-5337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A38D2DDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332A61C2454C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57D1667CB;
	Wed, 29 May 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bLtPOPO1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007115B99A
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966819; cv=none; b=u6ZxD8LQQbT47eZiW2Ebj1VoPvzlKrTHdFzKGl13IIRJi0lyLBmZztkIYDiEKxe4jCzfAHhz4M5TRig3zbba0d8lEFdO/bC9ozsMO0uT5CDbkehD8c8u56O6uv4o35p9zaIXqFKAoF7ELsXuzbSTR/w4XEYIfgyfymWn2hIPq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966819; c=relaxed/simple;
	bh=ilfzHIYY9DlM/jaIBsQNEK1E04R6j89CXSCl03qHZiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VElUdHBI2lq0le/tA0TNoghjrheQTtLrjLkQPkAzkBiZRfXAnHHhs2jKhQMv2hVPQUXPejteTFvtsPqNf6b/YJd9j88/JCVyTb1ly0/6NG5QOOJccG0NvtDWWUkhmPsOMPzia07n2hQ2D5iK6KDzYfCOlEI79tJiEwWrsFPtTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bLtPOPO1; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966817; x=1748502817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ilfzHIYY9DlM/jaIBsQNEK1E04R6j89CXSCl03qHZiQ=;
  b=bLtPOPO1Q8xpagjSdRY7RQFjs+Sr0WgZ9CGqSSDp1BLYSoywYU0nF++S
   oJfavlck9wmUVMMUoVdskdLkGwp8529US9xTgFTQ2dTF5+olz25HcdFXt
   ovaVUY5iaXlrAcl3Wg8TxAcDIkJ3dKc85CXSAjgdkeazjCjFCoC71mo+g
   qwNhZJG+ATuoRbF6DxJPdO8t7VR6W4ZNVPkS4f4QMuU3MNpKmMNGKCb3A
   ObHSZMys7ST5a052NJm/SfdSb/SsHtp/gJlrzdCzAyBLFmgW6eyo7H1X1
   TR0VDjGt9F3s5bsWGNojsYNMzApSnv08eAYNBd7lVdyPlBolSOQ5/k0s8
   w==;
X-CSE-ConnectionGUID: z4fbV6WAQVOuH74ZVfKwpQ==
X-CSE-MsgGUID: zlf+PeEnQhWfpfBWZBjhoA==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865334"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:30 +0800
IronPort-SDR: 6656c94a_F8+Q5/7aHbCY//g/b/XyJcCXOQJonzi/AfweSzrlYNMGwO0
 mkJnGX7OaUVOFLdOXB+A0gR8r5+VNsrOGzG496Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:20:58 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:29 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 00/10] btrfs-progs: zoned: proper "mkfs.btrfs -b" support
Date: Wed, 29 May 2024 16:13:15 +0900
Message-ID: <20240529071325.940910-1-naohiro.aota@wdc.com>
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
- v4:
  -  Fix source directory size alignment.
- v3: https://lore.kernel.org/linux-btrfs/dfd8887b-a2cb-425f-8705-0d6a94cefb9c@gmx.com/
  - Tweak minimum FS size calculation style.
  - Round down the specified byte_count towards sectorsize and zone
    size, instead of banning unaligned byte_count.
  - Add active zone description in the commit log of patch 6.
  - Add nullb test functions and use them in tests.
- v2: https://lore.kernel.org/linux-btrfs/20240514182227.1197664-1-naohiro.aota@wdc.com/
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
 kernel-shared/zoned.c                    | 23 +++++-
 kernel-shared/zoned.h                    |  7 +-
 mkfs/common.c                            | 62 ++++++++++++++---
 mkfs/common.h                            |  2 +-
 mkfs/main.c                              | 89 ++++++++++--------------
 tests/common                             | 63 +++++++++++++++++
 tests/mkfs-tests/030-zoned-rst/test.sh   | 14 ++--
 tests/mkfs-tests/031-zoned-bgt/test.sh   | 30 ++------
 tests/mkfs-tests/032-zoned-reset/test.sh | 43 ++++++++++++
 10 files changed, 260 insertions(+), 118 deletions(-)
 create mode 100755 tests/mkfs-tests/032-zoned-reset/test.sh

--
2.45.1


