Return-Path: <linux-btrfs+bounces-15519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C447B06FD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE203BD780
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0328E575;
	Wed, 16 Jul 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bpfr5/AB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF1272819
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652818; cv=none; b=t4hWInsxk5il7fnXg+nr1mpag+NMC2U4c4s0RP9hX6TVmykszh958dzSZ1z4qLNXpQYYSR8gLuxWKiGzpYPocbZKSy4HiFPoIuDM5H/7wwNRLjimQ13B5V5ghAaPq0X5R3evPmdzjbxPaDoMTyvM5q3LGIi4dICIKzk6Ouf61TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652818; c=relaxed/simple;
	bh=WCW4D9SAy/x0GzoXj7kesFL4eN5kCpkffRXFvq446vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JoOvlVCN7kn678VvTXirN6/D22zdQP35XKlzADOI/GFcbBV6cvncBLaaPJPhKqhmdSc2WVkku2kok8CDEMv796kIInpySTE9iInZkXlMGFzktrIVYCOrPS8unUvdtOwZYAEP21gGhPNBBoYvsxdrPf6sDSdj0NI8y2ld28xtH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bpfr5/AB; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752652816; x=1784188816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WCW4D9SAy/x0GzoXj7kesFL4eN5kCpkffRXFvq446vg=;
  b=bpfr5/ABlVEFcjTaik3B9aY2E/K1K+Csz8dMEVNCEpFooWFiePfW/KX1
   x8BnoyHacmdu+ERIuH19di6vjHnul3bhIs8u1JsEyJMnlpndmreWmkacj
   dySZVuwk7Ri545ATVd100T0aOA0D8xCtyxvfW9+uxLPXmsFoyljLqpomV
   SCr0vnf7UKsvg0VMWg+8wQznMi6R4ps7tpzl3/Z2607KwKs7Uh0yiBKTR
   bDNK71bcjMGDQLh+uDyb+bwzbgLZdGEgkoDBilk9zSsYPa74wKHehsbfH
   3ksKmMPfVhun+VTfhpVzYV9rKOMm+cEr44w4Jd4B8CCQHc/B6NIq5Gsqr
   w==;
X-CSE-ConnectionGUID: LKZ+shyITiCJ4Fp63S9dnQ==
X-CSE-MsgGUID: Lh2AOrEkR6WSbsKnxKwnUw==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="94432929"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 16:00:15 +0800
IronPort-SDR: 68774d6e_ocYf31+X3XwgJKz4aRVqka0PlZ40tGcTu8jDqmWv7Jg00d7
 B9jfdzoMrHpUtl+Uhvv+wlkZ948xCCHDJxDb24w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 23:57:50 -0700
WDCIronportException: Internal
Received: from wdap-0lwmw3epm9.ad.shared (HELO naota-xeon) ([10.224.173.10])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2025 01:00:15 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/4] btrfs: zoned: limit active zones to max_open_zones
Date: Wed, 16 Jul 2025 16:59:51 +0900
Message-ID: <cover.1752652539.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is no active zone limit, we can technically write into any
number of zones at the same time. However, exceeding the max open zones
can degrade performance. To prevent this, this series set the
max_active_zones to bdev_max_open_zones() if there is no active zone
limit.

Using max_open_zones as an active zone limit enables the active zone
tracking and enforcement on SMR too. The revealed some bugs on the
active zone tracking. This series also includes the fixes for them.

Changes:
- v3:
  - Added patch 2 to address WARN added by patch 4
- v2: https://lore.kernel.org/linux-btrfs/cover.1752218199.git.naohiro.aota@wdc.com/T/
  - Refine commit message and add code comment to descrive the WARN
    condition.
  - Introduce and use BTRFS_DEFAULT_MAX_ACTIVE_ZONES (= 128).
- v1: https://lore.kernel.org/linux-btrfs/cover.1751611657.git.naohiro.aota@wdc.com/T/

Naohiro Aota (4):
  btrfs: zoned: do not select metadata BG as finish target
  btrfs: zoned: fix data relocation block group reservation
  btrfs: zoned: fix write time activation failure for metadata block
    group
  btrfs: zoned: limit active zones to max_open_zones

 fs/btrfs/zoned.c | 78 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 14 deletions(-)

-- 
2.50.1


