Return-Path: <linux-btrfs+bounces-705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE6806CC1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9E9B20F6F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB9E30CED;
	Wed,  6 Dec 2023 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eOUXRY9Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA16818F;
	Wed,  6 Dec 2023 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701860184; x=1733396184;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/PZsmw0zyU4nAM+H32DiGBfJFTVkJfKctQwr8KH9gZg=;
  b=eOUXRY9Y6PAlPzldFW33p1870AVb8RtexnNd6WdFweuTqQwwJ4ZoVIOV
   9j87t9OT4MpNncwA/H3QvP5Xu2rSvvVKcgPrFY32GDvyrhJpve+I+bsI6
   UxJ7y6NLmIjdhQDsL35WhvWYyabD77JCcp04nbyBx8Vkd+dRkKiHZNkOw
   wsKneIng3to80PXF1QMfHnnu9VO0sXU4hVYuYVJtRepj62ShD9yaZQN15
   uUYFouBV5KFy7lbqBdWzS9VauPRCO33xb1Q3/5feIp5apCNh7+qSE4jFj
   qLirORwNKx8N4UAQ39Rf+OdrMHFWBqnJJwNL5plMN/fACG97Bl6PzC954
   A==;
X-CSE-ConnectionGUID: r0CTVtJGTTWM/007/R5R3Q==
X-CSE-MsgGUID: PAveaZ1KRzWM4zIqlrs23w==
X-IronPort-AV: E=Sophos;i="6.04,255,1695657600"; 
   d="scan'208";a="4119711"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 18:56:23 +0800
IronPort-SDR: XTWe2I8MstbtIH0QwVmee2I1jkUhaw1pUTRIS4w5LS/d2OCj4ACHCVkehHBx9QASjd7NRp9YLk
 PiRt866JMB5g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2023 02:07:24 -0800
IronPort-SDR: ZMVgIjkgKgXeuZbt5lblUsVOADM4K5LhvhAo/1uXOraco4vLygK+fbYggIWFLIdNLklyOrhHs+
 AaAh6BZ1gtAw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Dec 2023 02:56:22 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 06 Dec 2023 02:56:15 -0800
Subject: [PATCH v4 3/8] common: add _require_btrfs_no_nodatacow helper
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-btrfs-raid-v4-3-578284dd3a70@wdc.com>
References: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
In-Reply-To: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701860179; l=590;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=/PZsmw0zyU4nAM+H32DiGBfJFTVkJfKctQwr8KH9gZg=;
 b=Eazl5y3ZqdmL1ATy1WU6JziLhfV0R7gxSN2Ix9jzs2h+Zb9hUk/xEa6zEds8pW5/yjIr4Ua/v
 Y5utBjhVBQwAJxXWzYvdodN8g53vWpld3QjbtKbKIObjCwogsRCUZbh
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/btrfs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index e3ccb4fa07d4..bf69bcee158b 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -120,6 +120,13 @@ _require_btrfs_no_compress()
 	fi
 }
 
+_require_btrfs_no_nodatacow()
+{
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatacow"; then
+		_notrun "This test requires no nodatacow enabled"
+	fi
+}
+
 _require_btrfs_no_block_group_tree()
 {
 	_scratch_mkfs > /dev/null 2>&1

-- 
2.43.0


