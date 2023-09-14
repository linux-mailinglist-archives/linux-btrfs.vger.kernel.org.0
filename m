Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C837A0A6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbjINQHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbjINQHV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:21 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBD91FFD;
        Thu, 14 Sep 2023 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707637; x=1726243637;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dAFGj2lSFggsGCAxlAi8drVBv+UlMJSnIu/xYz5RsQY=;
  b=OlSncPK6IwuAJqqRusaKBmItI6MEK89PelvbS+D1HXVBKi7vglXjNtmP
   XFg7YZY91x73fUZKu1yJGyeROOkHeXlg3rmPpPyuTdxN8SlLQGIHnCe38
   xcuNVFF4stK19Empq1YTxp1/8C5x59Bw30n3H9k6CBAYfGwo23kxnP/aO
   p756NthR+7BSrQTaDbb6yw4MtP3oCyw2eYbr5f+eCo/uc6Nxpxy2E3L/P
   v5zFROTdAorS7i0Z0soGK8q+VFsSRNlWHkEZBfljpquPd+gJNI23vmhmj
   oKrbg7dn7SwbpKIu49ffmjte5y8tWa1ehmSREyy7NnsvqrXfX5CT3ynnJ
   w==;
X-CSE-ConnectionGUID: FmfcZvvmSD+76dB2jk3zew==
X-CSE-MsgGUID: L71ry+ZZQ0KW29JWL0M17A==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490559"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:17 +0800
IronPort-SDR: 3AsZ+kunBFYzKfyu3zzBus9gbMJl9wU5cEdEkTrcVLEY45OfxnyjEPTk3Q26ni/op+s05fuG9k
 vIEEeB5ybaPqLwV7MZfyHVcz3UFrTS3C0RQ9r7zw0HTlfgOHg2UOZ48IUJKk2tJa24/x9Zayya
 tawBJAx8o1oGnf0vjywYw90M8gg769KjbyPGlOcslpoYPdQB58GhFFvOFXVb8hYAUirrxUj0Te
 IOHxkHSGZYK5w4M7yEVzsZJqe/27EAvhaZA5sdaVw+gLkeMu6SuJKNJBO5wVs6YJU7Ckvqydqd
 iTc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:18 -0700
IronPort-SDR: gqmI05Gt11sOtVS4hVMypzk0BmiyPmIS1c2fqlI5Lk7a8exO5LUHbaHpe4QrcKi0IkPv8t1uXI
 wR7sUdWa+YrGOTKq9l0/ujNJtIDjdc50iDa2I88VqAOVQ6BPuXX9+7f7o+yHD4mcOQvg1OArmg
 5wLuqlCOW9Uo7VKPejqiaiK/2yNBuia3lqKwQ3Mt5Cj3+8AF38ZDhU73cHERkAQgdlQ8uYHe9c
 fWiy9nLmmmiMyhhf4zscuZHQGhgFbPvG+igbrRkMbBi27pRTqzVwWPt7TgI+U9PTef1e4QkvLr
 BiQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:17 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:07:05 -0700
Subject: [PATCH v9 10/11] btrfs: add trace events for RST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-10-15d423829637@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=3855;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=dAFGj2lSFggsGCAxlAi8drVBv+UlMJSnIu/xYz5RsQY=;
 b=co+EasJda8IZv4EJ9EvHsTRizSP9zKL9+eZ6w2RoigsWuNiOAR9LVIw2Q4R8ZZC/iqO0y3r/c
 1Ke0AyETENDD10rDl5cPeiBaPq5ayEuBcnIq2SDXmcZjB4vf8iJ60uu
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add trace events for raid-stripe-tree operations.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c  |  8 +++++
 include/trace/events/btrfs.h | 75 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 63bf62c33436..ee4155377bf9 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -62,6 +62,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 		if (found_end <= start)
 			break;
 
+		trace_btrfs_raid_extent_delete(fs_info, start, end,
+					       found_start, found_end);
+
 		ASSERT(found_start >= start && found_end <= end);
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
@@ -94,6 +97,8 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
+	trace_btrfs_insert_one_raid_extent(fs_info, bioc->logical, bioc->size,
+					   num_stripes);
 	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
 	for (int i = 0; i < num_stripes; i++) {
 		u64 devid = bioc->stripes[i].dev->devid;
@@ -414,6 +419,9 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 
 		stripe->physical = physical + offset;
 
+		trace_btrfs_get_raid_extent_offset(fs_info, logical, *length,
+						   stripe->physical, devid);
+
 		ret = 0;
 		goto free_path;
 	}
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index b2db2c2f1c57..fcf246f84547 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2497,6 +2497,81 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_write,
 	TP_ARGS(rbio, bio, trace_info)
 );
 
+TRACE_EVENT(btrfs_insert_one_raid_extent,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 logical, u64 length,
+		 int num_stripes),
+
+	TP_ARGS(fs_info, logical, length, num_stripes),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	logical		)
+		__field(	u64,	length		)
+		__field(	int,	num_stripes	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->logical	= logical;
+		__entry->length		= length;
+		__entry->num_stripes	= num_stripes;
+	),
+
+	TP_printk_btrfs("logical=%llu length=%llu num_stripes=%d",
+			__entry->logical, __entry->length,
+			__entry->num_stripes)
+);
+
+TRACE_EVENT(btrfs_raid_extent_delete,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 start, u64 end,
+		 u64 found_start, u64 found_end),
+
+	TP_ARGS(fs_info, start, end, found_start, found_end),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	start		)
+		__field(	u64,	end		)
+		__field(	u64,	found_start	)
+		__field(	u64,	found_end	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->start		= start;
+		__entry->end		= end;
+		__entry->found_start	= found_start;
+		__entry->found_end	= found_end;
+	),
+
+	TP_printk_btrfs("start=%llu end=%llu found_start=%llu found_end=%llu",
+			__entry->start, __entry->end, __entry->found_start,
+			__entry->found_end)
+);
+
+TRACE_EVENT(btrfs_get_raid_extent_offset,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 logical, u64 length,
+		 u64 physical, u64 devid),
+
+	TP_ARGS(fs_info, logical, length, physical, devid),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	logical		)
+		__field(	u64,	length		)
+		__field(	u64,	physical	)
+		__field(	u64,	devid	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->logical	= logical;
+		__entry->length		= length;
+		__entry->physical	= physical;
+		__entry->devid		= devid;
+	),
+
+	TP_printk_btrfs("logical=%llu length=%llu physical=%llu devid=%llu",
+			__entry->logical, __entry->length, __entry->physical,
+			__entry->devid)
+);
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */

-- 
2.41.0

