Return-Path: <linux-btrfs+bounces-2381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53956854F21
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 17:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17E9B2FA2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523A60BA8;
	Wed, 14 Feb 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F00lZ/Fj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BF5D912;
	Wed, 14 Feb 2024 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928938; cv=none; b=tUU/9nwC7iN6hcB5wrjQr0F0YiROaEKTC/IwzL8U+MuG9DNsnHfIAPPolOVj7ELSnCAzdGNDBL8WNz4KhWjRhx4+7/q43FGcrD5vAS6+cXoMxO6VQYbWiwpmIb+X980PvMerBVbUX2BJ2zSboILHsJcoht3JJG6NmlPzUAgDUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928938; c=relaxed/simple;
	bh=FQOLMUIyguPi50H5od2qVnt880S+HhvPsD7VCG5jpzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dVaJgbhnA1wTfFy8uMafxy7Vo7fn8TSgSI1O7fmuZEpL580AgmnTrpMy7NHAmeeRAO3RrzrIJKmASYkAeLoy2J6WaU9IC/gxOAfVt7JTmSMsIYttJCjpk2gCz6Jqco9HtEYIMpCw7pCwFzgr1fgYxT8YzX3EwScziSlIFu8NlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F00lZ/Fj; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707928936; x=1739464936;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=FQOLMUIyguPi50H5od2qVnt880S+HhvPsD7VCG5jpzc=;
  b=F00lZ/FjLO9rAumO4j3lDjvSlBK71g0RhLcT7yB3Uys4ALKGVn9+iH3A
   jIkkzXSZqJcUa/S+GI3Z0m6zX/NLGY0vIUiuIZGy2QRnZBpW27uL6fJ0T
   PZ3+rla5weL0UsGWK9DMFQvYATbSAcGTPU1R0SD1Rxnoad8dfqFxv4sY9
   P4lJTectr/iOWfgv4s8qRqTvRZT7dPCEK+fHE4J2SFUum8dCE0dD30V2u
   98NCM57VughFcgesbK98rhFqo5MJIQVKfrQnBwdYWoSUE2DZFTUsE7hBO
   VNfw709PPEz2k45HkiZxjeTHjJIJWguFzHVDUiw5/3amO0MYiFTBkIpaY
   Q==;
X-CSE-ConnectionGUID: xwQcr2eXSVaPgRneVZX4Rg==
X-CSE-MsgGUID: 4kx9rPHGS0GVNH2CZlC34Q==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9294729"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 00:42:15 +0800
IronPort-SDR: irJD8Ma9clCFJyfTdqNMAHuxDy94SOzdKu3lNQnqolH/Iqb0tnTgGi2FAYg0k5xzpDeBPso2qj
 yvDPwNty+N0Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 07:51:50 -0800
IronPort-SDR: 52SRSPlXGFO6ANjfjr/7UjhWO+yOps1k5PyhTvGniHaOZzZxhcUeWj4zBNQOVTNZotu7WZ6pdi
 8g2QE1L5wMhw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Feb 2024 08:42:13 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] btrfs: use the super_block as bdev holder
Date: Wed, 14 Feb 2024 08:42:11 -0800
Message-Id: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPtzGUC/x2MQQqAIBAAvxJ7bkEtIvtKdIhtzb2oKEQg/j3pO
 DAzFQpn4QLbUCHzI0Vi6KDHAcif4WaUqzMYZWZl9IyePF5dJMaYOOCkLDtLdqXFQK9SZifvf9y
 P1j4wMesxYQAAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707928933; l=1274;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=FQOLMUIyguPi50H5od2qVnt880S+HhvPsD7VCG5jpzc=;
 b=ZU3prLU8QgxKDtpW/YOQLtSAlE2My/C5Tcj/KsCEpOHKpS6XTVWlpIIch0ysEGVR1kqF1lLU0
 HQhY22oVOmHCRwaGlzXFWki3wi6miLEle2clOTsO0Cablsru0EvR9yc
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

This is a series I've picked up from Christoph, it changes the
block_device's bdev holder from fs_type to the super block.

Here's the original cover letter:
Hi all,

this series contains the btrfs parts of the "remove get_super" from June
that managed to get lost.

I've dropped all the reviews from back then as the rebase against the new
mount API conversion led to a lot of non-trivial conflicts.

Josef kindly ran it through the CI farm and provided a fixup based on that.

---
Christoph Hellwig (5):
      btrfs: always open the device read-only in btrfs_scan_one_device
      btrfs: call btrfs_close_devices from ->kill_sb
      btrfs: split btrfs_fs_devices.opened
      btrfs: open block devices after superblock creation
      btrfs: use the super_block as holder when mounting file systems

 fs/btrfs/disk-io.c |  4 +--
 fs/btrfs/super.c   | 71 ++++++++++++++++++++++++++++++------------------------
 fs/btrfs/volumes.c | 60 +++++++++++++++++++++++----------------------
 fs/btrfs/volumes.h |  8 +++---
 4 files changed, 78 insertions(+), 65 deletions(-)
---
base-commit: a50d41606b333e4364844987deb1060e7ea6c038
change-id: 20240214-hch-device-open-309ef9c98c62

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


