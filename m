Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD67E52B647
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiERJRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiERJRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 05:17:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C941CFCC
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652865442; x=1684401442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezC6m7jJf2tUpJVCviGpUIIm3wuctBs8UxcDDBa277g=;
  b=o7kg2b/+8xN9eOYmfuY1mbYKoEyWEpd07ZNZIgYE1SKfWcTgBf0aHfdO
   Dxv8XR1nl10apM09KfycEMF6RPFE472OGLmYQpVAgWOO7k9KY9Po17qpY
   nabmv/GX2QsajC995q+FHCVWZWy2NwvBBGXPqVcEov0yTLFvZccwC1ZmK
   42lRIhPMTEkAw1IYvsf0WFUJoWFdP1OEpvpJ0TtWU1tov/6WYLE0w8rxl
   It0LkPKc32pCneyPogUooMynRsGXv7POq0gLeFXJ/EEZqYtydMvrt3xPZ
   uNi0ii9qk5GaZnfvzjq3zNyLjVOrcQ2rgddX3zPe2NhVMBdhzYfDnQNju
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647273600"; 
   d="scan'208";a="201514745"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2022 17:17:21 +0800
IronPort-SDR: nGJs3OAsH4y4rGKFJvCNL66U/5jNBm//XXQ2Pe0zszw1W9GedVChA6O2yI6F4CG1U8h8QPpsXI
 flcrUh1gucWVnyss5S/bMSGEisPwbOVE8Zv9lQP1sPYDclqVDZfh9S1ofFafP5wKsgnSECv9Ho
 ovKazsFc6+/gYG/gEe2zUPHGGYXXcvf9l8DuJR8SeUkBBKKiQStgz9TDsPiM9lz6fWIB0nWIV8
 I/XMweoZANz8bL7agb9RyL37mXeEaAd9/NHqstxZ0ZxZrcq9P4fwOnkAq6PWLcqblxI4EOpip+
 5Iq/b2+fvGU32VTeqgHfdN0P
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 01:40:23 -0700
IronPort-SDR: g1pQox/b3egXTw6PqVZGbdmkZVKWxm9073Sl0B6kouTHSrOSX8TmLDl25B1dCE282svrnudLkc
 uJE/fdSMFDlReqth8lotElv5KLsmNS4mz8y2mNphCVXdZGKjafyun0zPt6qZKAxUQBjRxxDj3A
 Lab21LTvYpup6vwVzpsP32ZTxqffwUh2RyYHw/JDBOfDRINwiO/DHAQIu+CHyKrxnZZPT9fPh+
 S3DP7agNmdsxmRq8TvXO3a4USNTVRaLFTZWunOpiCC9DdeIiGRC0ZKzeuU+W69TZglFvq0EYSC
 oOI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2022 02:17:20 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 3/6] btrfs-progs: add dump tree support for the raid stripe tree
Date:   Wed, 18 May 2022 02:17:13 -0700
Message-Id: <20220518091716.786452-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
References: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 cmds/inspect-dump-tree.c   |  5 +++++
 kernel-shared/ctree.h      |  3 +++
 kernel-shared/print-tree.c | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index daa7f9255139..999047ea0c28 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -163,6 +163,7 @@ static u64 treeid_from_string(const char *str, const char **end)
 		{ "TREE_RELOC", BTRFS_TREE_RELOC_OBJECTID },
 		{ "DATA_RELOC", BTRFS_DATA_RELOC_TREE_OBJECTID },
 		{ "BLOCK_GROUP_TREE", BTRFS_BLOCK_GROUP_TREE_OBJECTID },
+		{ "RAID_STRIPE", BTRFS_RAID_STRIPE_TREE_OBJECTID },
 	};
 
 	if (strncasecmp("BTRFS_", str, strlen("BTRFS_")) == 0)
@@ -728,6 +729,10 @@ again:
 				if (!skip)
 					printf("block group");
 				break;
+			case BTRFS_RAID_STRIPE_TREE_OBJECTID:
+				if (!skip)
+					printf("raid stripe");
+				break;
 			default:
 				if (!skip) {
 					printf("file");
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 56b3185001af..40e5e09897b1 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1493,6 +1493,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_QGROUP_LIMIT_KEY		244
 #define BTRFS_QGROUP_RELATION_KEY	246
 
+
+#define BTRFS_RAID_STRIPE_KEY		247
+
 /*
  * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
  */
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 9c12dfcb4ca5..d1b51065c2f3 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -635,6 +635,26 @@ static void print_free_space_header(struct extent_buffer *leaf, int slot)
 	       (unsigned long long)btrfs_free_space_bitmaps(leaf, header));
 }
 
+static void print_raid_stripe_key(struct extent_buffer *eb,
+				  u32 item_size,
+				  struct btrfs_dp_stripe *stripe)
+{
+	int num_stripes;
+	int i;
+
+	num_stripes = (item_size - offsetof(struct btrfs_dp_stripe, extents)) /
+		sizeof(struct btrfs_stripe_extent);
+
+	printf("\t\tlogical %llu, size: %llu\n",
+	       (unsigned long long)btrfs_dp_stripe_logical(eb, stripe),
+	       (unsigned long long)btrfs_dp_stripe_size(eb, stripe));
+
+	for (i = 0; i < num_stripes; i++)
+		printf("\t\t\tstripe %d devid %llu offset %llu\n", i,
+		       (unsigned long long)btrfs_stripe_extent_devid_nr(eb, stripe, i),
+		       (unsigned long long)btrfs_stripe_extent_offset_nr(eb, stripe, i));
+}
+
 void print_key_type(FILE *stream, u64 objectid, u8 type)
 {
 	static const char* key_to_str[256] = {
@@ -679,6 +699,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_PERSISTENT_ITEM_KEY]	= "PERSISTENT_ITEM",
 		[BTRFS_UUID_KEY_SUBVOL]		= "UUID_KEY_SUBVOL",
 		[BTRFS_UUID_KEY_RECEIVED_SUBVOL] = "UUID_KEY_RECEIVED_SUBVOL",
+		[BTRFS_RAID_STRIPE_KEY]		= "RAID_STRIPE_KEY",
 	};
 
 	if (type == 0 && objectid == BTRFS_FREE_SPACE_OBJECTID) {
@@ -788,6 +809,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
 		fprintf(stream, "BLOCK_GROUP_TREE");
 		break;
+	case  BTRFS_RAID_STRIPE_TREE_OBJECTID:
+		fprintf(stream, "RAID_STRIPE_TREE");
+		break;
 	case (u64)-1:
 		fprintf(stream, "-1");
 		break;
@@ -1453,6 +1477,9 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		case BTRFS_TEMPORARY_ITEM_KEY:
 			print_temporary_item(eb, ptr, objectid, offset);
 			break;
+		case BTRFS_RAID_STRIPE_KEY:
+			print_raid_stripe_key(eb, item_size, ptr);
+			break;
 		};
 		fflush(stdout);
 	}
-- 
2.35.3

