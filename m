Return-Path: <linux-btrfs+bounces-15272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16640AFA9C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 04:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5DA7ABCB8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 02:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCD21CD1E1;
	Mon,  7 Jul 2025 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HVzoUPXE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864671C6FEC
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856350; cv=none; b=L3I0QFdfFBsipHsIZpxvMiy5v/gp7pX0de9+Dl0qbjg6SQop/ZNneAn7oAV0LeBwqkqSesv913niosYfZs0pnrKfZoKptUXO6t+5QzSe5BdQs9NmrjejLm+ePmQg+neMVnkNUXruLyas/eVNEnVn5+vAYW95ZWoEkJ7ppRj5K5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856350; c=relaxed/simple;
	bh=9/7eC7CJlL74mWBeqav0MYzeNmYcopuNhrIAjFgc4YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIRMjc6cKuef7QhDHy2j7YxjsL9PREiwN9IwW0K+3wCO2QOSFkV877GOhqAcU6a8H/oQ3Fuu/MzxY1FHccNOPluffJeCH33tCKMPYYopNFEXUkCz8K5oCVuGlLCeFEzuD+gsQReB+7sOc1Ycf6k8BU7MN9vvnprpUDn0mBnQzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HVzoUPXE; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751856347; x=1783392347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9/7eC7CJlL74mWBeqav0MYzeNmYcopuNhrIAjFgc4YM=;
  b=HVzoUPXETZF6JQeBOL7uw4IOuW55bba8znWvEeNhrCyPmSPA30FtR055
   DqmLwrij7Yt68Ubjjwddin+l5VJk9xeFIA0gEu9qNLUhbP+lze8pSwW3U
   VCT4edmKAzB/5gZ7N9lc8btLbllMVM66vVW6JnR6G4sQOKE/rqcCEIXha
   H9XSCiEJGy21oMnAyujrCVGCnECOxgFwYN2d5lRzXfgtj06fGqMrx3lRN
   HBr5I2tQsuTM1nf/IAsUuW1wINmpQ8gE8ebC75Xuo5yyRYv9KvzG+0ymW
   ZKl/kMx3EfUGJfi0L3q8lLMjQ71/BQPkUI1i13sd2Z2AG75d5ypZGR7Im
   w==;
X-CSE-ConnectionGUID: tY7N5SnTRfSe/NMptoXaUw==
X-CSE-MsgGUID: u2N2X41PTtyBvgMYLcCCsA==
X-IronPort-AV: E=Sophos;i="6.16,293,1744041600"; 
   d="scan'208";a="85911268"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2025 10:44:38 +0800
IronPort-SDR: 686b2603_+9Ae6P+rbB/5UVWSoF4QA5/lgE3bLutZnkCJh48jpVZJLLv
 1zdT6irnqYh8xpboeMPjjgYhRz/P/sl6sNONcbQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2025 18:42:27 -0700
WDCIronportException: Internal
Received: from 5cg217427s.ad.shared (HELO naota-xeon) ([10.224.173.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2025 19:44:38 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/3] btrfs: zoned: limitt active zones to max_open_zones
Date: Mon,  7 Jul 2025 11:44:09 +0900
Message-ID: <cover.1751611657.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
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

Naohiro Aota (3):
  btrfs: zoned: do not select metadata BG as finish target
  btrfs: zoned: fix write time activation failure for metadata block
    group
  btrfs: zoned: limit active zones to max_open_zones

 fs/btrfs/zoned.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.50.0


