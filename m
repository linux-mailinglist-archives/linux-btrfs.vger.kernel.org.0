Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFBB7A0A5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbjINQHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbjINQHN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB471FD5;
        Thu, 14 Sep 2023 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707629; x=1726243629;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wt2EjSnLJ8D+t3XufPg5cUvMG9P+h96vVSNkrRx35uY=;
  b=TzEtfM/PlVPeJdHNFjMkI+h1XGFu5zH2XGMNXZGzq2S0aNWbe2cI0ey1
   WtE+ZHSjRcc7MVq55biEo+lLIXjjhceO1vqZq84HIkTYieq6fZ+n6deow
   xfAvRqPaRoCYixOBL+not9TbwtCJrAXbP2aB7wLgM+gK8MCME/r6zBU3o
   NMZ6PO/9m2HLLBFj7jVfyTKYhfU3ju9Vs4sz+PhscYD9dgc9CNm9d8tIG
   fBjgoy5wu9HG2Za9fuMDW1GsFQk1qQijdfTV+QV3PxBLAYuUA68Jw6edu
   lOKWMJikQnApHxOQJ9wUtNgXQfgv53rWNFqfEwmH4zMHW2UKafxkIk7oS
   Q==;
X-CSE-ConnectionGUID: shcK7XbSTlyoIH/HOi24FQ==
X-CSE-MsgGUID: V1is4AJkS+SPYDSzl1ivsg==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490539"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:09 +0800
IronPort-SDR: 0MBxTIVMWkBibFUnPT2+WsV5BGB+TN6SLiLeUNHaqOnnm7dtNXr7PCaZcT1OmHzgevu+bnbbDF
 Dv/aM+w7GKeEJw6Je/OdEDwEs7qvyQFQJeRxJ+kPcBR1D3Z+KQn3rj+E5sL5w5P6CzLd2SRBIp
 +hOJu4CcYhvdKaXE3THicALzKQUAMErUXjR8TUiw1x3LO9rdZBYNkaAThidvnxGTiYso7gI2Wh
 Qae2O5rahUeuYXwQUahLUOe3TUsnA0wK1MZLJt4GxhkY/Ken9+DWh5dRaBm3fCXQg/j8p+nNFt
 FKc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:10 -0700
IronPort-SDR: NzMtAD0aBLJu4UVoVwnSplUvtXjWV5h/9Eskc4ze8PukHf4LcjXEG0nViwwNYu3dF7+M/YzreL
 2S0S41NuQ4tZ+ZkD5JkXohR9XZDZ1RbZdIMwhq9p4ZcfhYHOefpjH+XXvg3SbTrpTl0WUkDUkf
 uvVzg5MbOvQztuFqwqP8jhuFS3+O/H6Kj02O3rUii5G7X64TgIG3dWErSLF9o70mQqdwDHIFxD
 gz+rqtT0SvwSak1hqxTxT5WiaY/CrUFSE5dHYwk4MWUTUOOGQ470l1AxNJ23qFJUO9VxBPDcTQ
 iwU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:08 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:06:59 -0700
Subject: [PATCH v9 04/11] btrfs: delete stripe extent on extent deletion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-4-15d423829637@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=3151;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=wt2EjSnLJ8D+t3XufPg5cUvMG9P+h96vVSNkrRx35uY=;
 b=RtVjLsmQ9nmV1wv+PDIz8Cgkox8svVSkLIsVsv5ioDUxNpakVSWI+lka5XC5QuDZKXNLciTcf
 htX8Evb+aAoBv2qUa/n7NE1YXTZe2noQaaaTqSajUJeQ7TNR3MuCTkF
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As each stripe extent is tied to an extent item, delete the stripe extent
once the corresponding extent item is deleted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c      |  6 +++++
 fs/btrfs/raid-stripe-tree.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  2 ++
 3 files changed, 68 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 959d7449ea0d..27859c7773ce 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2860,6 +2860,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
+
+		ret = btrfs_delete_raid_extent(trans, bytenr, num_bytes);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 
 	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 7cdcc45a8796..517bc08803f1 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -15,6 +15,66 @@
 #include "misc.h"
 #include "print-tree.h"
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	u64 found_start;
+	u64 found_end;
+	u64 end = start + length;
+	int slot;
+	int ret;
+
+	if (!stripe_root)
+		return 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	while (1) {
+
+		key.objectid = start;
+		key.type = BTRFS_RAID_STRIPE_KEY;
+		key.offset = length;
+
+		ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
+		if (ret < 0)
+			break;
+		if (ret > 0) {
+			ret = 0;
+			if (path->slots[0] == 0)
+				break;
+			path->slots[0]--;
+		}
+
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		found_start = key.objectid;
+		found_end = found_start + key.offset;
+
+		/* That stripe ends before we start, we're done */
+		if (found_end <= start)
+			break;
+
+		ASSERT(found_start >= start && found_end <= end);
+		ret = btrfs_del_item(trans, stripe_root, path);
+		if (ret)
+			break;
+
+		btrfs_release_path(path);
+	}
+
+	btrfs_free_path(path);
+	return ret;
+
+}
+
 static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 				 int num_stripes,
 				 struct btrfs_io_context *bioc)
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 884f0e99d5e8..b3a127c997c8 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -11,6 +11,8 @@ struct btrfs_io_stripe;
 struct btrfs_ordered_extent;
 struct btrfs_trans_handle;
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_extent *ordered_extent);
 

-- 
2.41.0

