Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3C46BF79
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbhLGPjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:39:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35689 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbhLGPjs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 10:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638891377; x=1670427377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JavpZOJSy917ZTOKrvFANscGut3+lDHjqpXWNZGNlNU=;
  b=Z5iwq3RO9p92vJdIgm2sV7fLN/P8SqggQmb8bTd0IUK43njjQt2xJAGX
   kajZvCmxGDCRCkSDwWNnQ5ALjNF36IaathPVCekkA1ospp8Bo1gEQRdPl
   GrwXGyu7R0TaRvmHejIhGqXSqvc5iL83B6OM2ioAIt78i+w0e5fbVAJJs
   TRWfTJlp4xmgvVJPIqCB8S80qsII376/TkM9j03fR4VOjJs2Q28z1B26J
   pY7FTLAmbSmVtB1tPw5JYsXf09jUhUnFWM0SEPJQs3G2Xv4+iDcKY9g82
   7F6dBs4KqwazhbjmUIHkDsonoIFPL9nbGEvf+mj2ixKsxTNWVqgM0Z5Kw
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="192442649"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 23:36:17 +0800
IronPort-SDR: I5Psf62Mi2JXTh+u2CcWIYkxGN9g93RMoV/MlJFr6+QTUmCsLvIpNilmADQNwFl/JEyJvDX5cJ
 SBZlrA+kZFZBnAIt/CQHp5qRdS8LeCP4qVWHHQEsKQ61h71SkZYQ/srukEyCCeDEUItCe7inrR
 eqMXT4MY7DlldgvtZTxbP0k06+MLU9CX1qcfRt4Il+foYGFSMH4WVfcLCAdKLp4621YG2kwM6f
 6BfH29558iP2AbBCtLkSA5xXkW+o7IwJsTMNP5/zIf6Hw5SjtXcmbTbSIdmo6vSNrxv3zg4eDf
 Wn/aBOvhMYxGEwQpl8wKK2PD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:09:23 -0800
IronPort-SDR: NKrXtCNuWho0MAt7UuWkNmX0xefmAeowf0WjYlEvZYZ4UjHoZf8YR5Kgg6o9Upn/b2kl1XhqWp
 02myEN9NzWjNc+UWbn2RWPNhnPNYLJNH3KxWUFD9Noq+TYXtXbsFmccUAlZeqqBLTHl6VtlfbF
 /wTW8TsaA7rNaNeV9ucWkYPwvECBZa0DwGbpXfbmZdRTT4Ol/Gl/2r8b4KhuGy8dLHAbZB3mB6
 SKilMK6ibw7LYl7PXEzrY5CX5hSWNBrkp1KfJrSpmlOJAcNpN+0ahX5j0x0/p/8r+K9X6FzDqA
 0to=
WDCIronportException: Internal
Received: from hx4cl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.41])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 07:36:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] btrfs: zoned: unset dedicated block group on allocation failure
Date:   Wed,  8 Dec 2021 00:35:47 +0900
Message-Id: <20211207153549.2946602-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207153549.2946602-1-naohiro.aota@wdc.com>
References: <20211207153549.2946602-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Allocating an extent from a block group can fail for various
reasons. When an allocation from a dedicated block group (for tree-log
or relocation data) fails, we need to unregister it as a dedicated one
so that we can allocate a new block group for the dedicated one.

However, we are returning early when the block group in case it is
read-only, fully used, or not be able to activate the zone. As a
result, we keep the non-usable block group as a dedicated one, leading
to further allocation failure. With many block groups, the allocator
will iterate hopeless loop to find a free extent, results in
a hung task.

Fix the issue by delaying the return and doing the proper cleanups.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3fd736a02c1e..34200c1a7da0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3790,23 +3790,35 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	spin_unlock(&fs_info->relocation_bg_lock);
 	if (skip)
 		return 1;
+
 	/* Check RO and no space case before trying to activate it */
 	spin_lock(&block_group->lock);
 	if (block_group->ro ||
 	    block_group->alloc_offset == block_group->zone_capacity) {
-		spin_unlock(&block_group->lock);
-		return 1;
+		ret = 1;
+		/*
+		 * May need to clear fs_info->{treelog,data_reloc}_bg.
+		 * Return the error after taking the locks.
+		 */
 	}
 	spin_unlock(&block_group->lock);
 
-	if (!btrfs_zone_activate(block_group))
-		return 1;
+	if (!ret && !btrfs_zone_activate(block_group)) {
+		ret = 1;
+		/*
+		 * May need to clear fs_info->{treelog,data_reloc}_bg.
+		 * Return the error after taking the locks.
+		 */
+	}
 
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
 	spin_lock(&fs_info->relocation_bg_lock);
 
+	if (ret)
+		goto out;
+
 	ASSERT(!ffe_ctl->for_treelog ||
 	       block_group->start == fs_info->treelog_bg ||
 	       fs_info->treelog_bg == 0);
-- 
2.34.1

