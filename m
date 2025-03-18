Return-Path: <linux-btrfs+bounces-12347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A078A6645E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 02:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1133B971B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272FD14AD0D;
	Tue, 18 Mar 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mE6gJ0DL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F1126BFA;
	Tue, 18 Mar 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259603; cv=none; b=sJHXOVgKrUacaZbNVXpyS+rzlfKaxEHl9WOn74ygnOobjzkfcFmTLh5GyUTDtTT5nX1QlO71XObtcVXTyAz209YMEXc46c4djIZCU5Kv/1Hkpp0Oh0xv9Qm4AARl8zBvWZLPGIQlPZleLjA0Wh++2glkcTeN9BoTSQWyrAgTbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259603; c=relaxed/simple;
	bh=1ADAxFxWLGir6QAMwrO5KOdveLvAY6tD4m43q1TuCDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhJeEE3Dw5sUV7V9eXIgbEnOXusCzEEgVfKFkFVoPk+YOLRyCG6VkNmPYtUBuuE9qgUYiqALzp546U1MsX5dCkbzoYbRmFmXCzQSpkYWXrKLTUF7mBfuR8bOIwL8k4nEMF5COplF9vYLAx0HV71njY4FWXw+Zf8rBoql40JQcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mE6gJ0DL; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742259601; x=1773795601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ADAxFxWLGir6QAMwrO5KOdveLvAY6tD4m43q1TuCDE=;
  b=mE6gJ0DLcUPF9nzAFtJcyA3Iwzaa7UeM0OTJgB5rM4cl1NyDC6QnVBdz
   f6jIvtqVMKrFjvWxsy4Gx8ixFhKzQTncT2g79VnLKw3g1Lla7zTRdDUbh
   ND2ehNKPTgQAbUdzXLpG3FiM89LxDvImXGx5gFJVL89xcZO0K55lA3/5t
   yNkEqkU009CHhpptPEZ99IZ/t1jTsLHjqYHO17MMeTrabk/B4oJ0PiYvf
   EHpJ3MHzATrQiOo1RkYGMVwCgJS0hO9j0UAtdtn9G/3hBHG9orRTf0MhY
   w+1ooFdqriRDIxXiBKdn8N8otRqlsUi++LGlAdMedUoX+VuO5UmjMOIJt
   w==;
X-CSE-ConnectionGUID: eGg2E3TUSQK/8WfESCjXaQ==
X-CSE-MsgGUID: 4w7nP0UWRTOCbW1O0jJz6w==
X-IronPort-AV: E=Sophos;i="6.14,255,1736784000"; 
   d="scan'208";a="52645822"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 08:59:55 +0800
IronPort-SDR: 67d8b7ad_AYefiJ7fwnr3y5Bcg0LGPrHUyVUVjjbj2E4An2hts5Vt18n
 FgzKs9T60BGqRC4mgtDBLsD6KnexfvMINWqO5mA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2025 17:00:45 -0700
WDCIronportException: Internal
Received: from 5cg21468mp.ad.shared (HELO naota-xeon..) ([10.224.109.129])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Mar 2025 17:59:54 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	hch@infradead.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/2] btrfs: zoned: skip reporting zone for new block group
Date: Tue, 18 Mar 2025 09:59:40 +0900
Message-ID: <cover.1742259006.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
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

v1: https://patch.msgid.link/cover.1741596325.git.naohiro.aota@wdc.com

Naohiro Aota (2):
  block: introduce zone capacity helper
  btrfs: zoned: skip reporting zone for new block group

 fs/btrfs/zoned.c       | 18 ++++++++++--
 include/linux/blkdev.h | 67 ++++++++++++++++++++++++++++--------------
 2 files changed, 61 insertions(+), 24 deletions(-)

-- 
2.49.0


