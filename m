Return-Path: <linux-btrfs+bounces-15439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E358BB01475
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C199C4A3D96
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4BA1EB5E1;
	Fri, 11 Jul 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CKB1H7Ep"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A841E834B
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218644; cv=none; b=mNY0QP3EYbYTdi51SB22jMGTJKupVqWAzRspfddLXkNdJrryYQ1Grqd82NytV/k4w8bi89QtwCSXdq6U7hAj2+IMqtWbki82/PTGK8NBJ5ITNOPwmR3mtrPQccn57n/MgDHMWK5UGGJ9YpiDoO96bW9YnHxru6q8Z/7464BGwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218644; c=relaxed/simple;
	bh=PwefDhFCinhXaKlfg9ZrRjsA2zX8P5kFzQI+/4g9UCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+os8aWDgbNiXaBY3Mz5gNkg9S/i5VI6QBM5OdCw/5rR4R7ulc59BtfoAJ8trBhjrYgyjA73rmzbjE2XxrT1/WW8LsZEIDcKt0WFx3ozGat3N0hU+q2QmgfOYew0WD2jUD8n/WxLFLk3eP529QzBo/vZjF9tLFXpMBIfBiMgxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CKB1H7Ep; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752218643; x=1783754643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PwefDhFCinhXaKlfg9ZrRjsA2zX8P5kFzQI+/4g9UCg=;
  b=CKB1H7Epb3uFmS6KbEHAmGwE5M2WjSFt2TA53PoCrNRBvLxi2j0fhiRu
   B5Ysnq7FWnwVf1qZqF9zy8reoZUYccLm3BkUZzSUF1IUt0JSDxArupRb9
   ts12X5UDcQuQN0BK75hhxEpSrBgRoK7vmdKAdEPaJUYat35uDh7mwte0Z
   98SYB/iLOYDbW3FaPC4CajKkc2YmxOt5yoWcPgvY/GfaYKkUyvIbW+QTQ
   Fsd0coNcKV1cc1ebTifcp2zd6tMnwwwYFTIPXh0dWpqsF0/9Ij0PSPGYF
   ErfPB/bSTzYPq/b8Ag8xwuoP1wi5zPP/KfUMcwf50f2cyBEhKICs82T6d
   A==;
X-CSE-ConnectionGUID: fLVz3jvkS9y1GNYSqygpIg==
X-CSE-MsgGUID: wAdqk1H7SKSwzjQIms0j9Q==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="87607279"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 15:24:02 +0800
IronPort-SDR: 6870ad78_3vpe2LA1VyYp3jmHSvYgPXpHu9aC5XPLZaLVsXuBpsQ3d+9
 Ghq4ORlWpRjWEPNVSi7GltIl7trGM/FMBdNYhhw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 23:21:45 -0700
WDCIronportException: Internal
Received: from 5cg2012qjk.ad.shared (HELO naota-xeon) ([10.224.163.136])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2025 00:24:01 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/3] btrfs: zoned: limitt active zones to max_open_zones
Date: Fri, 11 Jul 2025 16:23:37 +0900
Message-ID: <cover.1752218199.git.naohiro.aota@wdc.com>
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

Changes:
- v2:
  - Refine commit message and add code comment to descrive the WARN
    condition.
  - Introduce and use BTRFS_DEFAULT_MAX_ACTIVE_ZONES (= 128).

Naohiro Aota (3):
  btrfs: zoned: do not select metadata BG as finish target
  btrfs: zoned: fix write time activation failure for metadata block
    group
  btrfs: zoned: limit active zones to max_open_zones

 fs/btrfs/zoned.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.50.0


