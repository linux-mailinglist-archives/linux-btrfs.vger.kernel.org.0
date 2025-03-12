Return-Path: <linux-btrfs+bounces-12211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9DEA5D40B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 02:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5CB3A8FE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 01:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2947B13A3F7;
	Wed, 12 Mar 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BC+3wf+O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504D288BA;
	Wed, 12 Mar 2025 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743142; cv=none; b=pVCmg9VmPM6PI4fH3oogyief0lGnOzsVg1K41LkfqFCUdALed2yerpzO/kcfv5jzfcJZwgRgi5oWTjFtWPQPtldxdjprXqCJJlq3W6wEA9mfIhG82kjF6mmhgd6ixGhGH6LvPUEEaNyK1cP/4IXj5SXapB2vA2kzCMUABBuIlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743142; c=relaxed/simple;
	bh=3HXkPpjaDv2Fk/dyHKIX6r2EqAVaGb2JhvF5jc/ID4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7n0VdRwR7L3lv0lKPI5/K2y5CLVSLe9fFO4PuWJADtnEpkbrTKfqgE1wEgCZUu1URrDW2DYDVYm3ZCwrNtTTmwxakZdjSHOkIToW5G4/SD2sw/dHXEPZBiB4MtIaRmeh6hn7fn8BBCzoHmIREVABo1/G1G+R9p0+Ar4rm09kb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BC+3wf+O; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741743140; x=1773279140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3HXkPpjaDv2Fk/dyHKIX6r2EqAVaGb2JhvF5jc/ID4o=;
  b=BC+3wf+OTIhO1+8J7AfyiDv2/Q4AoKAwl/usZhnJxvTG32aG96WitGt0
   RhARlGRq9fIe8Dji4NCXjVeLGLwAiAnETJQn5gXJA2Khbgl8LYWAiD2+Z
   /xZcegvEQX/oJrBLZVSpd5HBJm0W/18Km+r6lMlxJp4V5AWlRgO5V3weS
   N8g620+fgs7C7eQJWSiggBI4TeT0qbG6zONXD6xa0CdpExNGZhHSF3xPg
   SSQFQ82EQU+KsfRriwqUVXIywm73Xc0oMVotaEofZ0ITtDY5XCV+xbXPM
   Gx8KkXQpnkh10OcqR1O1aAct4Dcm8HDcPLTboZx+ehB9smRbs8Jq6w1mF
   g==;
X-CSE-ConnectionGUID: TAR9BIrLQ6ulYCi3L9atig==
X-CSE-MsgGUID: b89OwsL9TPSMEVMfsennqA==
X-IronPort-AV: E=Sophos;i="6.14,240,1736784000"; 
   d="scan'208";a="48299246"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 09:32:17 +0800
IronPort-SDR: 67d0d64b_qGd0lW4z24BudC5FxuTU8VRxGGjuqZFyCyWyuxUg/sN7E0I
 NVbA8MQrueADWsT13kUzHoxoE57kpl7PukSBx5w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 17:33:16 -0700
WDCIronportException: Internal
Received: from hy1cl13.ad.shared (HELO naota-xeon..) ([10.224.109.64])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Mar 2025 18:32:17 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: skip reporting zone for new block group
Date: Wed, 12 Mar 2025 10:31:02 +0900
Message-ID: <cover.1741596325.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newly created block group should reside on empty zones, whose write pointer
should always be 0. Also, we can load the zone capacity from the block
layer. So, we don't need to REPORT_ZONE to load the info.

The reporting zone on a new block group is not only unnecessary, but also
can cause a deadlock. When one process do a report zones and another
process freezes the block device, the report zones side cannot allocate
a tag because the freeze is already started. This can thus result in new
block group creation to hang forever, blocking the write path.

Naohiro Aota (2):
  block: introduce zone capacity helper
  btrfs: zoned: skip reporting zone for new block group

 fs/btrfs/zoned.c       | 18 ++++++++++++++++--
 include/linux/blkdev.h | 21 +++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.48.1


