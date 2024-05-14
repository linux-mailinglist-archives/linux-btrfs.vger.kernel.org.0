Return-Path: <linux-btrfs+bounces-4981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3773F8C5B04
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68ACE1C218EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30A8180A69;
	Tue, 14 May 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AMddw8vP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C41E487
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711091; cv=none; b=ZRoPkBzz67kNo8btlgRVVELDlQQggNU779SvaMQOfeY/Fk5Urqk4+R9ut2V1BXBOiwcuZuQkELlKZnWEdbprf1Ji4256pIXRYs56FaNfOrVnRQcFFSa0FRq1Y4DowYQzuIQwGxZFwA1m2NgO60aoLcYesIP1jDTdwFPGGBorYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711091; c=relaxed/simple;
	bh=GI//ochLjvTb7HEy61AtIue6QkNn1IFcJSJ8s3MGnHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+8r88zdInPjNcDFd8HBt9iTO47gRxnH7G1TkBF6OuwfAiSOKzm+8pLfe8N13vNFPZOrl6w0l/Xgmgi5BpejfglEmGhgqksrcfVeMQY+eCgIi0QxSX+B6FVrYJYEA6IeZQ3cMD4dXBd4/+WBOMYInnSAa2qywXNxQpKHZqExPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AMddw8vP; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715711090; x=1747247090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GI//ochLjvTb7HEy61AtIue6QkNn1IFcJSJ8s3MGnHQ=;
  b=AMddw8vPiSTDo3T1JENtX01nmfdeogWre98PPNGbH4aI9KSLDDgYiKxT
   K0HaNoPMVT1QGKFQ+JGZNhxdBHjiwjRhYbmLZUemWHoV+LXKgz2zW8OVS
   kvsylT5ZdL0b1F984OF6vsV0ldC3JZBf4baws3d04Z/cUolh/fj/3jQUO
   wzmjhQjQoXt6eKIGhSiOswfW2usYOd3utYgpsp0XULmOMbsGvuLwncGw0
   V7RB6sPZlIMhHkcT06hqE1c+FHN9/znAhAy5JVKdCf4MgTGS813T8WaAg
   +I8CeTiPh+0KLXuc/e/8+DZXjfuJCiekY/4l5eXaQdiyu0PUaFSKyZqyP
   A==;
X-CSE-ConnectionGUID: Zr4yhHqwSdWsv6HUNun1Xg==
X-CSE-MsgGUID: xenhZENqSOGNWhc4O7282g==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="17162633"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 02:24:43 +0800
IronPort-SDR: 6643a02d_3+daIYIucWvsQk8zrWS6oe5fr3g1UzDFX5MVO/zRVwKCFnG
 6EjeMtrVXKiYjI+xl/jS+k8ssAU+wAqu0fm9Hpw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 10:32:30 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2024 11:24:42 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/8] btrfs-progs: zoned: proper "mkfs.btrfs -b" support
Date: Tue, 14 May 2024 12:22:19 -0600
Message-ID: <20240514182227.1197664-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
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
https://github.com/naota/btrfs-progs/actions/runs/9083915553

Patches 1 to 3 are clean up patches, so they should not change the behavior.

Patches 4 to 6 address the issues.

The last two patches handle the test cases. Patch 7 adds a new test for
zone resetting. And, patch 8 tweaks an existing test to use smaller zone
size to have enough zones than the new requirement.

Changes:
- v2
  - fix function declaration on older distro (non-ZONED setup)
  - fix mkfs test failure

Naohiro Aota (8):
  btrfs-progs: rename block_count to byte_count
  btrfs-progs: mkfs: remove duplicated device size check
  btrfs-progs: mkfs: unify zoned mode minimum size calc into
    btrfs_min_dev_size()
  btrfs-progs: mkfs: fix minimum size calculation for zoned mode
  btrfs-progs: mkfs: check if byte_count is zone size aligned
  btrfs-progs: support byte length for zone resetting
  btrfs-progs: add test for zone resetting
  btrfs-progs: test: use smaller emulated zone size

 .github/workflows/coverage.yml           |  2 +-
 .github/workflows/devel.yml              |  2 +-
 .github/workflows/pull-request.yml       |  2 +-
 common/device-utils.c                    | 45 +++++++------
 kernel-shared/zoned.c                    | 23 ++++++-
 kernel-shared/zoned.h                    |  7 +-
 mkfs/common.c                            | 48 +++++++++++++-
 mkfs/common.h                            |  2 +-
 mkfs/main.c                              | 82 ++++++++++--------------
 tests/mkfs-tests/030-zoned-rst/test.sh   |  7 +-
 tests/mkfs-tests/032-zoned-reset/test.sh | 62 ++++++++++++++++++
 11 files changed, 202 insertions(+), 80 deletions(-)
 create mode 100755 tests/mkfs-tests/032-zoned-reset/test.sh

--
2.45.0


