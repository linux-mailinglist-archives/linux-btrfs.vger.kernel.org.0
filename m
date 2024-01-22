Return-Path: <linux-btrfs+bounces-1590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA5836017
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 11:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4481C1C25C5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E01F3A8F1;
	Mon, 22 Jan 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MLTypmc5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E23A8CB;
	Mon, 22 Jan 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920675; cv=none; b=YM69OjpfxcsNqCML4cwAzR73eLRYm1x5VNaJJV7v55OinlRDx6yiLRM1AJZweHpo6bSPSpBDC92eeRIa90WKkxMSoPCUWmbC3Pf8j+OSNHuHg7I6+5xYhS5JhMdVBzO4qCFOSxcifOKzEv1GuQ7jhKIP4z8Jfy+LIVnt/mlWBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920675; c=relaxed/simple;
	bh=hblM66EStzsdA17y2t4XieuQflpR3FippN4aG+8doYU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ccz7BFzdIlFplf9D2Pdbc+I1te+BwP2i+XeLUOaMxs6LJqVgNJRIMiVXNnciAOoFpa1cPn8bla8LHS0SFSEPiZu8UQ9SnMPlx8rpc6ZWpy/Dvg8tX5lLJNh2LTZY6V1+Lum/8XQlBNiAc1kifMa1F33GdUY6Zz0fRcip0Yu8D7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MLTypmc5; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705920672; x=1737456672;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=hblM66EStzsdA17y2t4XieuQflpR3FippN4aG+8doYU=;
  b=MLTypmc5axQwYzJFc85PXU9ywpd9ul5nB8nEitYx3oRg27NjB8lH2vXR
   Pxr1xj7syKYhLhR1q80ouxuKM7A8aoqWKvzEg+III2fzwNwWSu3/ZRIjR
   ECVETsAfX84Cv8cLbUA2vPMapMx5ytvGJQT6++N72lSt2bNMAlNzKuGkZ
   tqcJBu+pUDMOyk7Hh8GXUAYNlG5fmEfAA1yaNTiHM1BfWv3MfFZyls25v
   iHZyBbk7AuQdPQdI3wMJPHqi2vhZjpZid72Bj1laVLBqhCIXiKm84dKuA
   aLgSzb4ns9u5mQfTAoXs5q81ZtaQ4DX+gyq4MzrZTymfpPOFmwtSb4tco
   A==;
X-CSE-ConnectionGUID: haax3MdsRkic5Wxt37dnfA==
X-CSE-MsgGUID: l9JBiYTSRmCGhPaTvCtSZw==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7427191"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 18:51:11 +0800
IronPort-SDR: +0Y0E6uctibl34RWkhWaoXm5aKy2OCHd6FFOsPIHQD0w1siG72AHnMRKqy4mVV0StxggK2vpML
 j64J5XVwXxIg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 02:01:15 -0800
IronPort-SDR: AMJTj8u5KR32hBllSKjF7fIJXtun2DFBY2iiwIY2OZDl3x2e/iea7PV+hODP+pE9T8N0H4RCLv
 DK4A/L2V01lA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Jan 2024 02:51:10 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: kick reclaim earlier on fast zoned
 devices
Date: Mon, 22 Jan 2024 02:51:02 -0800
Message-Id: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJZIrmUC/x2MSQqAMAwAv1JyttAGweUr4qHEVANaJQURpH+3e
 JyBmRcyq3CG0bygfEuWM1XwjQHaQlrZylIZ0GHrPKJVpj3IYaM81kcKPBB2kXqoxaVc9X+b5lI
 +VoIJMl0AAAA=
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705920670; l=1172;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=hblM66EStzsdA17y2t4XieuQflpR3FippN4aG+8doYU=;
 b=oFNEt+W3E5AmSwUQmfRs6rzVfH9HOg3o+3aWmV5Ohptu90hn8SBpR89w2jKpGuD4PtPZ1dy/n
 HgEdrB47zd9B8KNpQYOJnfhqbMmyeQL+n5jIEgEiuLCVgc/Thz7MiYc
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

We had a report from the field where filling a zoned drive with one file
60% of the drive's capacity and then overwriting this file results in
ENOSPC.

If said drive is fast and small enough, the problem can be easily
triggered, as both reclaim of dirty block-groups and deletion of unused
block-groups only happen at transaction commit time. But if the whole test
is faster than we're doing transaction commits we're unnecessarily running
out of usable space on a zoned drive.

This can easily be reproduced by the following fio snippet:
fio --name=foo --filename=$TEST/foo --size=$60_PERCENT_OF_DRIVE --rw=write\
	   --loops=2

A fstests testcase for this issue will be sent as well.

---
Johannes Thumshirn (2):
      btrfs: zoned: use rcu list for iterating devices to collect stats
      btrfs: zoned: wake up cleaner sooner if needed

 fs/btrfs/free-space-cache.c | 6 ++++++
 fs/btrfs/zoned.c            | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)
---
base-commit: d9796b728dcbf25e0190e542be33902222098fac
change-id: 20240122-reclaim-fix-1fcae9c27fc8

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


