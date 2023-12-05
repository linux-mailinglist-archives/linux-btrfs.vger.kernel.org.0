Return-Path: <linux-btrfs+bounces-659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF438805B4A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE5281EDF
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D86D68B9B;
	Tue,  5 Dec 2023 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nCIu8GRo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D421188;
	Tue,  5 Dec 2023 09:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701798426; x=1733334426;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
  b=nCIu8GRomJ3eieRMZo6xKaioYJeZiYVgLAcmbyIEFLFkntZWBxdEfXHL
   aVuNOaxARhBSi9reYQjZ2c1caZgzywJfN2flIzMXWry7B5FzwkMIHDRBn
   MOxYxRrBbo/4rsnjxbV2FG/vcBVGc/4ku42WSgNLQVIhEXA6cODT+vbSf
   586YxxFwGqzHmKyE7en3rf7N15qxKp4nFA+duEW0ioDe7/onJreoANwAj
   w/leZm7dYVjdgOXmUstRqp1HtF+qNtKd6lhcwh3AHI8di82R7Us9NatO2
   laCFK1BE2LrFP7/Bbg5vL9cu+GipLGlv39UEflaNYyoVOlRiNCfbPRMGL
   Q==;
X-CSE-ConnectionGUID: ke6ADZ/jSyOhwTWgG16JJg==
X-CSE-MsgGUID: 953kDhoJThWu3LJ9DR5TNQ==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="3944948"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 01:47:05 +0800
IronPort-SDR: SAQAzY1FxeKYvusdod0kqdYQFu6CcpvkJ/2e//o9e2PxhyxZ2XyYzuQZXEWDECCGXrssvCGzpm
 W9o0VuCGC5Gg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 08:52:26 -0800
IronPort-SDR: 9LBT7cG5JOftD4csJkISptlahmJfamTb4iPQXiU4jLkdxMf5IHNkGYHf4Bh1VXgqmyqxUCkyd3
 S5y8Lh/MNYQA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 09:47:05 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 09:47:01 -0800
Subject: [PATCH v3 1/7] fstests: doc: add new raid-stripe-tree group
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v3-1-0e857a5439a2@wdc.com>
References: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701798423; l=705;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
 b=aYw3M4v9D5N57gF5kMcAuHfk1hyiMC7CH233pVS9f+2Opc5rMgJhSZIjaeTIOuDtoiyUwVavo
 iV6+iqZOV1kDRsFVF6xByAqtsc/gfg+xxnc+jqK9L34dcP406fcT3Dn
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a new test group for testing the raid-stripe-tree feature of btrfs
with fstests.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 doc/group-names.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index c3dcca375537..9c1624868518 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -94,6 +94,7 @@ punch			fallocate FALLOC_FL_PUNCH_HOLE
 qgroup			btrfs qgroup feature
 quota			filesystem usage quotas
 raid			btrfs RAID
+raid-stripe-tree	btrfs raid-stripe-tree feature
 read_repair		btrfs error correction on read failure
 realtime		XFS realtime volumes
 recoveryloop		crash recovery loops

-- 
2.43.0


