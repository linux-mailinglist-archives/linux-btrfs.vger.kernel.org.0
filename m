Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F53B7A0A69
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbjINQHh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbjINQHT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004D01FE3;
        Thu, 14 Sep 2023 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707634; x=1726243634;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jHNTpGHD7Us3Cugii4qHZugLDNfI6sOo7DVvwa2B5jU=;
  b=krnD1OJKD1oc1lU+v0jK8YwnpT0KWECS/FC/mOFWEbCqIBjImch42QH5
   aedrUBuLI0OBQB+QdzQ8Lbscj+VF/WTTbw50cHjBNqa8asuQWeRaL8ukj
   yS1WR6G2fAMtSt8MvI8keodGYWhkUGLyEA2wqLlnJVM4NzJ2/9zqI4M8n
   3xi0RD0eJ3ZBvmNGiOXAP+hf5niveHbzsRkPBO43yorTkpuCoFA8QHtil
   jtONdGaelRZ+SwF0e2lTgQ0zONHJi0KfevfeWku5bCHfuA6E1g3fpyhEE
   opbx6tZS4vjUv1FbZBCVxnDDzosmxYAxr6hszLkwiAoTdfWWX3YUPmR4l
   w==;
X-CSE-ConnectionGUID: AWVtofuaRzmNv1bRWUvpVQ==
X-CSE-MsgGUID: /kI59yT5RpmwY20c+rFdGQ==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490550"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:14 +0800
IronPort-SDR: Y5rtLsaA8OFY2MiVaBk7s2cdV+Vtpr8+trUm2/1pv2NAYV55iaB/uT11b17yz2R6+OI4NiYAyv
 g5aSa8H5t2sTgcTnLqRG6eIV2e8NGOgk0uRrcb7k8RZ+9FVgQq/f8gYtMONgL+voxM2TILDjQJ
 JwEWAy1gEa1jshuXJw5IWn+UnNIw/EijO8KMNrkKqQP4O3jfNA+XHiKgBn5e7kiLrI9UHCCLrI
 Rn15+91X/oCMu8pFgZfwgSBMI/f7ZLzvwj1MlvFfMg0uLnyJyY2994OxA7BBhsmPTf3FRROji3
 1Ks=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:16 -0700
IronPort-SDR: PFmf0p6E6VfOBTvkuxvfAhTf5QNWbwqsBldqBAhQZ6xtPyAObXFwAay1ZJKzEnYxf0sHavSYZY
 wniyfwDn2gk7pODMMRfeUxDpsrORaMLLAEiZkGEaXdSThkgW37Jyh9pqcHWotHenmfhvpAj1Ir
 c1i3bdYwIPgwYT+stgbsN4yK34YhJPLJXtIrwZrZwxFpuszqobPWIz1lhUxvMvTRVo6TrEXMem
 FTSDy1/7ImM2moMjVcs5Ljv1QIy0R47KEP1rAwna7VZJpvhTC/JU5LczJNi6mZ70fmMWxxOqd/
 32M=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:14 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:07:03 -0700
Subject: [PATCH v9 08/11] btrfs: add raid stripe tree pretty printer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-8-15d423829637@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=2269;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=jHNTpGHD7Us3Cugii4qHZugLDNfI6sOo7DVvwa2B5jU=;
 b=kVcUV/kcn+5SUTEkumOm+TYwd5JbpcYGm96YEMSItELyx4qG0FUvausBCjeugt6Fny3e22rpL
 Go0jdc/fEp+D7lkt0CBgLNRRp7HoIhvuKIjMZ8+lY38wmou9b3aQ4sk
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Decode raid-stripe-tree entries on btrfs_print_tree().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/print-tree.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 0c93439e929f..f3f487fc6400 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -9,6 +9,8 @@
 #include "print-tree.h"
 #include "accessors.h"
 #include "tree-checker.h"
+#include "volumes.h"
+#include "raid-stripe-tree.h"
 
 struct root_name_map {
 	u64 id;
@@ -28,6 +30,7 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
 	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
+	{ BTRFS_RAID_STRIPE_TREE_OBJECTID,	"RAID_STRIPE_TREE"	},
 };
 
 const char *btrfs_root_name(const struct btrfs_key *key, char *buf)
@@ -189,6 +192,24 @@ static void print_uuid_item(const struct extent_buffer *l, unsigned long offset,
 	}
 }
 
+static void print_raid_stripe_key(const struct extent_buffer *eb, u32 item_size,
+				  struct btrfs_stripe_extent *stripe)
+{
+	const int num_stripes = btrfs_num_raid_stripes(item_size);
+	const u8 encoding = btrfs_stripe_extent_encoding(eb, stripe);
+	int i;
+
+	pr_info("\t\t\tencoding: %s\n",
+		(encoding && encoding < BTRFS_NR_RAID_TYPES) ?
+			btrfs_raid_array[encoding].raid_name : "unknown");
+
+	for (i = 0; i < num_stripes; i++)
+		pr_info("\t\t\tstride %d devid %llu physical %llu length %llu\n",
+			i, btrfs_raid_stride_devid(eb, &stripe->strides[i]),
+			btrfs_raid_stride_physical(eb, &stripe->strides[i]),
+			btrfs_raid_stride_length(eb, &stripe->strides[i]));
+}
+
 /*
  * Helper to output refs and locking status of extent buffer.  Useful to debug
  * race condition related problems.
@@ -349,6 +370,11 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			print_uuid_item(l, btrfs_item_ptr_offset(l, i),
 					btrfs_item_size(l, i));
 			break;
+		case BTRFS_RAID_STRIPE_KEY:
+			print_raid_stripe_key(l, btrfs_item_size(l, i),
+					      btrfs_item_ptr(l, i,
+							     struct btrfs_stripe_extent));
+			break;
 		}
 	}
 }

-- 
2.41.0

