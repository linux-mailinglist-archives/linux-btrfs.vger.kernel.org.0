Return-Path: <linux-btrfs+bounces-4953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE2A8C4AA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 02:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53D9B221D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 00:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48317C2;
	Tue, 14 May 2024 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QSbP2H3Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11CEC5
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647979; cv=none; b=OMfHV3K+zUQC6/2z9fudCWFZbCsed+rUZpmQuNrd43EjYC+T15kd/roOdkA7OsNrjTqb2NvQcyVErHTOSN1Dji93Mpmj+BMBu5laSsaaje/Yds3SpxrBjtaueJqsDCE+CmNijkrynxVH036Sq7M9tTbUUTejVSKTIcRL5HMCark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647979; c=relaxed/simple;
	bh=EWa+nycVnu9xcR3fuzvCi6Dl/gxgwfsYes55fW6O9AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYRk/z2Zn5BTP8FiEdvM1E06QxmuH9aNY/Geh2xMPnvchlTa9+sCcyHK7Y8lVw0Fxs2FzMLsC8SYWC0VZd39Z3N4H4I+qLxmeRs1pQgz/LkuRlIiV+mdlrZD6tm9cUTiuXBzReJ5TBVSwHicWR0t8PyEPOqqSc5jfEzyvZLyg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QSbP2H3Q; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715647977; x=1747183977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EWa+nycVnu9xcR3fuzvCi6Dl/gxgwfsYes55fW6O9AU=;
  b=QSbP2H3Q1rt0ano+cuAxIDZ7ESqhwPZ0v7oExT/YdJn3da2wEV8mbVL4
   3TcTkdgWD72wZaHZGGqkMSK0kvttQQj+Mp5/PlmcGFdpo2hIyyOu6vMbZ
   UAYw4lCwPvuJ5KHNTAxpRoNsoJhxRuTHDGAsB6H8po3VUDiD/dfALFkMj
   rPe6xFacN97MhK/MD0cEGALBg/p8lXJidmkdhoK2UzVZ4KUk2BHk/pYjw
   43SzOMaq0vdn/yXS/m5DUoSGbCrQ6OfUaoR7V5U13NMmM9UksmMb2MBlx
   dT/bu22VzmW1OsjiGGtg3+sL++QuVwB64DGv7RPnT4yDLRixPEOW1A9/t
   g==;
X-CSE-ConnectionGUID: pxelTrMgR3C9E0/hkgYbiw==
X-CSE-MsgGUID: 9Nnpx4z8SMOzinEd+i7qfQ==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="15589457"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2024 08:51:48 +0800
IronPort-SDR: 6642a812_u4M2AvAcDDFMjU4Vbsms7jp+pzNH1Sy/UjHNt4mCpvO6nOR
 ib5B1FPj3Ceo7Bj+shXT04LyVTXC+YHvN5dq/vQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 16:53:54 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2024 17:51:46 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/7] btrfs-progs: zoned: proper "mkfs.btrfs -b" support
Date: Mon, 13 May 2024 18:51:26 -0600
Message-ID: <20240514005133.44786-1-naohiro.aota@wdc.com>
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

Patches 1 to 3 are clean up patches, so they should not change the behavior.

Patches 4 to 6 address the issues and the last patch adds a test case.

Naohiro Aota (7):
  btrfs-progs: rename block_count to byte_count
  btrfs-progs: mkfs: remove duplicated device size check
  btrfs-progs: mkfs: unify zoned mode minimum size calc into
    btrfs_min_dev_size()
  btrfs-progs: mkfs: fix minimum size calculation for zoned
  btrfs-progs: mkfs: check if byte_count is zone size aligned
  btrfs-progs: support byte length for zone resetting
  btrfs-progs: add test for zone resetting

 common/device-utils.c                    | 45 +++++++------
 kernel-shared/zoned.c                    | 23 ++++++-
 kernel-shared/zoned.h                    |  2 +-
 mkfs/common.c                            | 48 +++++++++++++-
 mkfs/common.h                            |  2 +-
 mkfs/main.c                              | 82 ++++++++++--------------
 tests/mkfs-tests/032-zoned-reset/test.sh | 62 ++++++++++++++++++
 7 files changed, 192 insertions(+), 72 deletions(-)
 create mode 100755 tests/mkfs-tests/032-zoned-reset/test.sh

--
2.45.0


