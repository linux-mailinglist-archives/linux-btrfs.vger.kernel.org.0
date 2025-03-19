Return-Path: <linux-btrfs+bounces-12394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2C3A682E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 02:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787223B260B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 01:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BCA24E015;
	Wed, 19 Mar 2025 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WCUJ6xUo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11025760;
	Wed, 19 Mar 2025 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349124; cv=none; b=A9SAdyLerf7r1uDloJs+3n1Rbd02pn948wNcrltAT8DoOkXAX7DKmHs6kdWCiMGqLjfWvkVA0lJklk+ksYYmzgvUALX1iDQJ5mBxNHia8TnDwrYA51ImZr1Pu8VFzUAO0/wq169uY07e9eiFGCXm9fMZRsSaE/25y48Cy2g+JkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349124; c=relaxed/simple;
	bh=2vyRaOUIlTcHVmVvCyIoUILERixT/msGSRT3MY0J97M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhcrlPvGFV7j8j2Pce4I6wf2Uxq25movV7J8mGBdRj8/tDyu41boiJAlCDGxvwtL+UG44/d/i6IwP1ZIs6rGV9jT3GEQyHaWLZ2QgUMmhEKv6zjglMnjLh1vH4AaWPm5Hvx6DBlHA+AROVKMu81jXzWmEIxTlck0r4qeoi2W/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WCUJ6xUo; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742349122; x=1773885122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2vyRaOUIlTcHVmVvCyIoUILERixT/msGSRT3MY0J97M=;
  b=WCUJ6xUooEj91vg0/kVjTJr7Yq4MusuN1tRHKjDjcZJHWhLZ1yZTECBQ
   qKYsTbukKyQE7s+yy2rS8mPnn+RKEoyfcSQfYPBbQ95eJhwfIjgtJkf67
   +gyRUbvpEbu4wS7HE8clolm739B7fCiH8xinPBO1G+HT7cOWNHuGgIew+
   HCJmjoCTf2Dgjo1RkQrhencodp+H5OhGUpGQvJdh8lLXxyN3ojNepAfxO
   S32XdOo3n3zEkJzGU/lx5ECls+BY+WsezVYSjBhQnW17OEJnhYP55cGlK
   Mi125UeYd+LoO5tjv70V4PlxS+OwWDfcP8b+sbpGsJ8MJ6ky6ZjgdpiDM
   w==;
X-CSE-ConnectionGUID: FmLztPWfSbCQJlDdHg01VQ==
X-CSE-MsgGUID: 0dXxnS2mSKebp7J3D6Wy0w==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55009577"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 09:52:01 +0800
IronPort-SDR: 67da1562_e9p6hQ/88JRgBF7tZb04JkibPkB/SUEry260aFY1g5BjhvU
 Ct7DeIxbY5rj6n1HCqfuV/Igwu0r60OJHvE1vfg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 17:52:50 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 18:52:01 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	hch@infradead.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/2] btrfs: zoned: skip reporting zone for new block group
Date: Wed, 19 Mar 2025 10:49:15 +0900
Message-ID: <cover.1742348826.git.naohiro.aota@wdc.com>
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
v2: https://patch.msgid.link/cover.1742259006.git.naohiro.aota@wdc.com
  - Move other zone related functions into the same #ifdef block.
v3:
  - Rename argument variable and fix the kerneldoc.

Naohiro Aota (2):
  block: introduce zone capacity helper
  btrfs: zoned: skip reporting zone for new block group

 fs/btrfs/zoned.c       | 18 ++++++++++--
 include/linux/blkdev.h | 67 ++++++++++++++++++++++++++++--------------
 2 files changed, 61 insertions(+), 24 deletions(-)

-- 
2.49.0


