Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E879AD3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356063AbjIKWCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjIKMwp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC09E40;
        Mon, 11 Sep 2023 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436761; x=1725972761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahUMziwuV2b2WDbDuTtcGjuBKbJw2h6dfox5WSNvvWg=;
  b=EeUiZfb1zMMh9Nr5eJQ2+oCKv+I+MACxKSxraVrdPZMWuzqlQbVC40ps
   iQWa324cSSswfO5F5TqMdZ+rZKxcCozuhLGlx4SsAn1rKY30c/eiP6Ev2
   VfwKMQOQtgtWC+jQY4mKdbOaMek+2HkIlxXeABVbgocROGTfgABTyMolI
   PaO/y2cA99CE1p3JVmUwONjuOEXky/NepOSEtGxjjmTCtgobFQ5QveBYf
   rj0B154PejxmklKPK7on7gzpt/vD0l4N+fjqbeP+obmhbL1E2f0X4gNio
   zTzYZvk43Lfl0AkLzdyhP7oCF5gCQkUuSTclJ4kMIADbg2mck9IfB2Eal
   w==;
X-CSE-ConnectionGUID: Jsu749UERsqH+jii/AhXMg==
X-CSE-MsgGUID: nsp3ng1dShqSmxW6GwAK3A==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594406"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:41 +0800
IronPort-SDR: iDudBPp9nwTkKucHp/+L1r8j9y2B0RAiQgcbGlmzKWXt6JpKOJEPSfVKkpw7bgcV2UBPWjKuDg
 DBDQayF2zd1wLUtpGl+XLGB1zJDPeJ7uXwKcAiEg/1FVYj0gaWiP7oWqmqzfQRJpejDf5HDzHs
 TYZbHvvzWPig6wKOuJUOY5edYmpg2Sy+iLKOzPM7TxC/TIUtq9fdjZZznQIJMTso3Bs8qxIJ6H
 QSI7AIfKiSur+SD51+bPh1oSWecG2WQMxYHsbqZuw8okV9R42nlSxI5BFIpvwsn4jrFlvw6VFL
 zd4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:05:27 -0700
IronPort-SDR: rOc7GNb/zofhemKoiswWzje3vPgVzrWXlmdr4ZQFozPHEEVOsu+SGVpobuyw+gn/MfLUsn8PzG
 TsqqwytA+qoTh545DzGv7dZLFWqKRSNHmZIHRdp7dnpqW79Jet/S325QqpONKVY6VBW3pu3CYe
 axkY0TcIv7oRUcDTDN3ORoRAv5ncy55dNMZdOJD2Mg1qsmEvk2eACveOnuMugsNLKarchwjydr
 SvbjGfnha0v9Hs6/I6RGZNVhCNjVln8dbt6hhpWsIIusfhzPdZEbQ299A73kxMXsrCl+iCZE0S
 Srg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/11] btrfs: add trace events for RST
Date:   Mon, 11 Sep 2023 05:52:11 -0700
Message-ID: <20230911-raid-stripe-tree-v8-10-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=3845; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=ahUMziwuV2b2WDbDuTtcGjuBKbJw2h6dfox5WSNvvWg=; b=f+9/5xxBaR7XpDIPbN/9rrepqD2WMkaf5VyHlhjBbQOcAdcILzfLJ+yEwNmNc8DkKgybPKtah GwCY3/YJJEvCeggEni27Ve165ai7x4QpQW2R6GFsUikB5eSPLl6C86g
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 7ed02e4b79ec..5a9952cf557c 100644
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
@@ -120,6 +123,8 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
+	trace_btrfs_insert_one_raid_extent(fs_info, bioc->logical, bioc->size,
+					   num_stripes);
 	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
 	for (int i = 0; i < num_stripes; i++) {
 		u64 devid = bioc->stripes[i].dev->devid;
@@ -445,6 +450,9 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 
 		stripe->physical = physical + offset;
 
+		trace_btrfs_get_raid_extent_offset(fs_info, logical, *length,
+						   stripe->physical, devid);
+
 		ret = 0;
 		goto free_path;
 	}
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index b2db2c2f1c57..e2c6f1199212 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2497,6 +2497,81 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_write,
 	TP_ARGS(rbio, bio, trace_info)
 );
 
+TRACE_EVENT(btrfs_insert_one_raid_extent,
+
+	TP_PROTO(struct btrfs_fs_info *fs_info, u64 logical, u64 length,
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
+	TP_printk_btrfs("logical=%llu, length=%llu, num_stripes=%d",
+			__entry->logical, __entry->length,
+			__entry->num_stripes)
+);
+
+TRACE_EVENT(btrfs_raid_extent_delete,
+
+	TP_PROTO(struct btrfs_fs_info *fs_info, u64 start, u64 end,
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
+		__entry->start	=	start;
+		__entry->end	=	end;
+		__entry->found_start =	found_start;
+		__entry->found_end =	found_end;
+	),
+
+	TP_printk_btrfs("start=%llu, end=%llu, found_start=%llu, found_end=%llu",
+			__entry->start, __entry->end, __entry->found_start,
+			__entry->found_end)
+);
+
+TRACE_EVENT(btrfs_get_raid_extent_offset,
+
+	TP_PROTO(struct btrfs_fs_info *fs_info, u64 logical, u64 length,
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
+		__entry->logical	=	logical;
+		__entry->length		=	length;
+		__entry->physical	=	physical;
+		__entry->devid		=	devid;
+	),
+
+	TP_printk_btrfs("logical=%llu, length=%llu, physical=%llu, devid=%llu",
+			__entry->logical, __entry->length, __entry->physical,
+			__entry->devid)
+);
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */

-- 
2.41.0

