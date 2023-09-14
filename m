Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD37A0A42
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbjINQFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbjINQFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D701BE1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707544; x=1726243544;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nf0OYXIzMCrF6lIqT8+3WhVCgtORwFCZMCaG8O8IGqE=;
  b=oQu/zxfmXja8CLcbc1Xf/8C9itgl+E+tb+7XqrUNgzVAJh4tGY2P/jSR
   f8A8U1NnVQLynhs4qiTRVvj8wSwaplFKA2qMTnIlE4cnk1U/SGVkovcWi
   VlSELdaDFPM1jAGpcyIxNEVIdG66QWnn1mlth3nizwGaYiqrrJ03Qz5wi
   BOwiQQ66+UgokazpIeUrY9Zvhtxe97gS/GVeRFdlKOcOqfUm90a8DArzK
   sPY78ZoczpN/dJUXpoLj+wEcu41eXCZluXm65RIA0sS+/iKzSmsD9vjiu
   9E7PThv5DEKwMe4vRJw84sWGPfYbxGfx3CeJbN1jRcLo6f2q+GurqsI4W
   A==;
X-CSE-ConnectionGUID: K8nHfR9EQRebxGexSKxs1g==
X-CSE-MsgGUID: v9AYeDDqQ9qet5Bpn0nDRA==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="242196086"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:05:43 +0800
IronPort-SDR: 6A5rVGBtheKBrFbZYLQHl2I9ooaQDDn0DcV9bGMNveGAcBxIm1+cs9ZzwaciLvX87G8CHHf+fC
 MZh3BS0ZMiYNTH5oDs+anpAY6o1gj3MjDtI6oXx3tAgGaGeX+Hbu88Jm4dvZjO8FChl98QRLaF
 tR6gL+t6W83aOlaRmv6/PyBReWL98Dn4vNbFjcQ015lv49iQftDloc6HkEiweZjCBEjes9OlXF
 /4O14x8xRLgFVsZ9xdty+sdA4TaYVktLoaRzhOwFhs8EJpdo7xDQuyUyjOREtE6jJeerPHZc8Z
 kDI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:18:26 -0700
IronPort-SDR: 7tPxsckFkHk5YlwHSBTkOCvO3MGZaUNvXmeZA8zIvcAkdqCyOrJrwnMMabYsZ4bL3suK//vJ4y
 pxCGal9BshFIkQ6dXTnODn0pY98AwFeG1dTS1tbDSA8YjJObhX+hJjb44C/JFCXFPwksM0cd1f
 dDHuNVFDEcAZ+buLLVurqPUeirDPrVF7e8vFh8r1Ckiq9AuwviJUL37eG2zFSyH1PofwgmUKCi
 Agbe8x//5R4VyzlsmPF9KobSl7xtS+Ma25pM4psl9FtjCzhZ25eIDWV3Wn6ujAnYsMEbeer4cu
 dQY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:05:44 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:05:34 -0700
Subject: [PATCH v4 3/6] btrfs-progs: add dump tree support for the raid
 stripe tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v4-3-c921c15ec052@wdc.com>
References: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707540; l=4898;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=nf0OYXIzMCrF6lIqT8+3WhVCgtORwFCZMCaG8O8IGqE=;
 b=iSPpIkFpk4UBoQtvAtLaOjQZ5m0pWKZ395psn2llgKotTlpxso5j1oNJDCx10qFAzHB6tdK/i
 c8O1M6Fmjt1BChLCNhSsPeCjOJjrXC186Cr3w2FD00vqI++IEGkAykU
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add support for the RAID stripe tree to btrfs inspect-internal dump-tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 cmds/inspect-dump-tree.c   |  5 +++++
 kernel-shared/ctree.h      |  5 +++++
 kernel-shared/print-tree.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index bfc0fff148dd..328ecd76c8a0 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -170,6 +170,7 @@ static u64 treeid_from_string(const char *str, const char **end)
 		{ "TREE_RELOC", BTRFS_TREE_RELOC_OBJECTID },
 		{ "DATA_RELOC", BTRFS_DATA_RELOC_TREE_OBJECTID },
 		{ "BLOCK_GROUP_TREE", BTRFS_BLOCK_GROUP_TREE_OBJECTID },
+		{ "RAID_STRIPE", BTRFS_RAID_STRIPE_TREE_OBJECTID },
 	};
 
 	if (strncasecmp("BTRFS_", str, strlen("BTRFS_")) == 0)
@@ -729,6 +730,10 @@ again:
 				if (!skip)
 					pr_verbose(LOG_DEFAULT, "block group");
 				break;
+			case BTRFS_RAID_STRIPE_TREE_OBJECTID:
+				if (!skip)
+					printf("raid stripe");
+				break;
 			default:
 				if (!skip) {
 					pr_verbose(LOG_DEFAULT, "file");
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 035358436d8f..de09c15ca0eb 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -556,6 +556,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
  */
 #define BTRFS_EXTENT_DATA_KEY	108
 
+
 /*
  * csum items have the checksums for data in the extents
  */
@@ -640,6 +641,8 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_DEV_ITEM_KEY	216
 #define BTRFS_CHUNK_ITEM_KEY	228
 
+#define BTRFS_RAID_STRIPE_KEY	230
+
 #define BTRFS_BALANCE_ITEM_KEY	248
 
 /*
@@ -650,6 +653,8 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_QGROUP_LIMIT_KEY		244
 #define BTRFS_QGROUP_RELATION_KEY	246
 
+
+
 /*
  * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
  */
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 3eff82b364ef..d719ebaebb40 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -637,6 +637,51 @@ static void print_free_space_header(struct extent_buffer *leaf, int slot)
 	       (unsigned long long)btrfs_free_space_bitmaps(leaf, header));
 }
 
+struct raid_encoding_map {
+	u8 encoding;
+	char name[16];
+};
+
+static const struct raid_encoding_map raid_map[] = {
+	{ BTRFS_STRIPE_DUP,	"DUP" },
+	{ BTRFS_STRIPE_RAID0,	"RAID0" },
+	{ BTRFS_STRIPE_RAID1,	"RAID1" },
+	{ BTRFS_STRIPE_RAID1C3,	"RAID1C3" },
+	{ BTRFS_STRIPE_RAID1C4, "RAID1C4" },
+	{ BTRFS_STRIPE_RAID5,	"RAID5" },
+	{ BTRFS_STRIPE_RAID6,	"RAID6" },
+	{ BTRFS_STRIPE_RAID10,	"RAID10" }
+};
+
+static const char *stripe_encoding_name(u8 encoding)
+{
+	for (int i = 0; i < ARRAY_SIZE(raid_map); i++) {
+		if (raid_map[i].encoding == encoding)
+			return raid_map[i].name;
+	}
+
+	return "UNKNOWN";
+}
+
+static void print_raid_stripe_key(struct extent_buffer *eb,
+				  u32 item_size,
+				  struct btrfs_stripe_extent *stripe)
+{
+	int num_stripes;
+	u8 encoding = btrfs_stripe_extent_encoding(eb, stripe);
+	int i;
+
+	num_stripes = (item_size - offsetof(struct btrfs_stripe_extent, strides)) /
+		sizeof(struct btrfs_raid_stride);
+
+	printf("\t\t\tencoding: %s\n", stripe_encoding_name(encoding));
+	for (i = 0; i < num_stripes; i++)
+		printf("\t\t\tstripe %d devid %llu physical %llu length %llu\n", i,
+		       (unsigned long long)btrfs_raid_stride_devid_nr(eb, stripe, i),
+		       (unsigned long long)btrfs_raid_stride_offset_nr(eb, stripe, i),
+		       (unsigned long long)btrfs_raid_stride_length_nr(eb, stripe, i));
+}
+
 void print_key_type(FILE *stream, u64 objectid, u8 type)
 {
 	static const char* key_to_str[256] = {
@@ -681,6 +726,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_PERSISTENT_ITEM_KEY]	= "PERSISTENT_ITEM",
 		[BTRFS_UUID_KEY_SUBVOL]		= "UUID_KEY_SUBVOL",
 		[BTRFS_UUID_KEY_RECEIVED_SUBVOL] = "UUID_KEY_RECEIVED_SUBVOL",
+		[BTRFS_RAID_STRIPE_KEY]		= "RAID_STRIPE_KEY",
 	};
 
 	if (type == 0 && objectid == BTRFS_FREE_SPACE_OBJECTID) {
@@ -793,6 +839,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_CSUM_CHANGE_OBJECTID:
 		fprintf(stream, "CSUM_CHANGE");
 		break;
+	case  BTRFS_RAID_STRIPE_TREE_OBJECTID:
+		fprintf(stream, "RAID_STRIPE_TREE");
+		break;
 	case (u64)-1:
 		fprintf(stream, "-1");
 		break;
@@ -1469,6 +1518,9 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
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
2.41.0

