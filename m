Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF787400170
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349511AbhICOqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:46:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12660 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349117AbhICOqE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630680305; x=1662216305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tzgn+SA0Zz64WeFuI5q51Qn+YevhCFkQh2yR2wqnG8I=;
  b=L81VuRBjw14GiXhainGAtCdy9Rz8AGtrXsMwUFXXvtf+EAQlcICU69vR
   WnkmJrABGc1t4fC1+YRpm6T7Yqr+FfZk0ZdSRqgctN/jcy1Opd3LsAkqw
   w5xQBBuQDgsV4zaYuBSqEK2Kd3EwrX7URTmOpM0G2aHMJBFINv4QEqtwe
   cp9XVFPciz7TJEnYRJxf+XFOTIhEW8x0zHzGrg7WgjOuIINVO/a3n5D6w
   RRcwZUpHLHdZ6vPY4BGrXAEMjUnn3htakyTq8aiSwRmdn8jT/SipeEWcQ
   k6SNHM5Y3GDBBmTDojuYSKPEsZGZb4WMuYeFk5nqh4p8zlidT7DcVjga/
   A==;
X-IronPort-AV: E=Sophos;i="5.85,265,1624291200"; 
   d="scan'208";a="179681178"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2021 22:45:05 +0800
IronPort-SDR: 11Z5kH52JT0dykkyLdJUp6qcBzXPloVF7L0rqf6UExjyXQBjieDp94t6kUA+fFq4C9S2iCjyG/
 twJ8ENHqw7eTTdasPQuFPfntP6X1PMtt/j4NH8YsqUFW6DuKv9UOy4KrTX1V0Y6HNdrL1JSA4y
 UCvRhNCplQXmtRbAEEzjIirhL1LYflSrbt1c2TJgM9nGwF4S/Y1jB7/xLI6ESISCqnmFvZnaX0
 lEovAAtlch9yE5bZvY73kxEevaVW5C173dvBGBoqp+dMm7FRz/GVd1iLH0IdOv1VId3navgd6Y
 10xrWLHwNdjfqJEdnQ10gIMj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:20:07 -0700
IronPort-SDR: ZOSrjFcjgY+RqoPoSMbhUWjEPaL2x4h4UwTYIdfkOrmZp/l/qypL2PpTxEQzKtRqEC0kU6nlNs
 dMvEYHqSy2ZU2v4vpQZx8NYTE5l9CjbQ2I1yC7Tv7jq0y/Iu113QRA1uFk+x4uQ9YOTY/ogMgp
 +pQnHJQUtXaey0Jdv6SWwHfNdhYl2w9LHC0dQtA0OIPbAUmrKX0G7XVdK4IqY2U6R4yhcDMBTD
 cL3b069qO7JEL1Nbv8G3rNUKMHPrYWwbZvJ8Z4G4JlmA9if9nT+LxIzJDFCHIVZqWx2oyHsn7u
 ELE=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2021 07:45:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/6] btrfs: zoned: use regular writes for relocation
Date:   Fri,  3 Sep 2021 23:44:44 +0900
Message-Id: <ac0fb08cbaada419c4e7a65a78793401ac557e55.1630679569.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630679569.git.johannes.thumshirn@wdc.com>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a dedicated block group for relocation, we can use
REQ_OP_WRITE instead of  REQ_OP_ZONE_APPEND for writing out the data on
relocation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 28a06c2d80ad..be82823c9b16 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1490,6 +1490,9 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	if (!is_data_inode(&inode->vfs_inode))
 		return false;
 
+	if (btrfs_is_data_reloc_root(inode->root))
+		return false;
+
 	cache = btrfs_lookup_block_group(fs_info, start);
 	ASSERT(cache);
 	if (!cache)
-- 
2.32.0

