Return-Path: <linux-btrfs+bounces-739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E368083C3
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5CAAB21F7F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E484F33CFB;
	Thu,  7 Dec 2023 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TstjjkRl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4470D53;
	Thu,  7 Dec 2023 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701939818; x=1733475818;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rATPhERYyunlfOBEUNyI4hcJ3o86Yremm7GSLR2lMKw=;
  b=TstjjkRlINUNCjlgCZk4I1e6IPL3x1mWPip4mbwFn4IN3q8ja5D+q1Uz
   MCdu1WcYfLwNDXTl1FzlxHW5rZ3LydoHoWc9fytM7ztnK41wrN8DRPwr/
   T0aSrbfnZGqh+4i/6Dy/9dRcqvsjLHOWmMnYQA/ul8z5OrsZ8wyIWi3vY
   o+ZVO/A/V89N7HG9WUL/BMQAA+Y8P2miNF4evOCo7Yl2Xigv6mxeyOccM
   Kn/VAsFH9DqGYO7Pbg+tjhflBSCp07+AYSISPzs/0I6yaYuvKPkIuuliW
   9aT7T3XBUpxjhpMvG5TFwq9XqHQs+kdhszpu9y7OM1biXNx1aiMYDyv4V
   A==;
X-CSE-ConnectionGUID: WjgvveiJQESgxZvWdn7BLw==
X-CSE-MsgGUID: rUfJRpmrT8aHsYswrXqJ6g==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4272776"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 17:03:38 +0800
IronPort-SDR: ud0VF/Dbyb5UbTHff9sXXYvBv8D2SZvMgA8UiFCnW6PKgJc1G2QQz7SoyWg3uJpblX2YGUs/AU
 5SOsOotL/omA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 00:14:38 -0800
IronPort-SDR: 8+L/iOPXot5y5boZ4r8tXZ+3F3S5ZVD6uG2mOMzcEwKbVth7z24noYkMDMKctvyF28WHPp2IPk
 jr2reDtRWeEQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2023 01:03:37 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 07 Dec 2023 01:03:31 -0800
Subject: [PATCH v5 4/9] common: add _require_btrfs_free_space_tree
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-btrfs-raid-v5-4-44aa1affe856@wdc.com>
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
In-Reply-To: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701939810; l=637;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=rATPhERYyunlfOBEUNyI4hcJ3o86Yremm7GSLR2lMKw=;
 b=dVvopVIn6PQJ6Flr4uSo3IMKUrAGqhKM2f+pFNHtoJvaQwkU7Zl4OY6yb6g5Tx2Yz4c9Lwsn4
 I8tay/3w8X4C6oUW1Zr3qCtDaY+XNCYL3Oj5QBLwWxc5L3qV8iNkZ+F
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/btrfs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index bf69bcee158b..95e46726a801 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -137,6 +137,16 @@ _require_btrfs_no_block_group_tree()
 	fi
 }
 
+_require_btrfs_free_space_tree()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	if ! $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
+		grep -q "FREE_SPACE_TREE"
+	then
+		_notrun "This test requires a free-space-tree"
+	fi
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1

-- 
2.43.0


