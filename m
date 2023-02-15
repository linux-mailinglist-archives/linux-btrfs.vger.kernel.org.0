Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93E697E5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBOObZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBOObX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:31:23 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1238B53
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471481; x=1708007481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WRtiSJO75ebZn8ltuTIySQlqT+20ngqQqnNsQlEx4zw=;
  b=DQzAgPXHUK8MJmsNTzITwfFxFO/OK8zcU8D/Z0j6wsB0hI2xgkOPEhOS
   rUKUxzZpnFFkYsnSMl9HS5Cd3QLz9Eo3PTR+oZQ2kyjMxndRTr7pdKAJf
   rt/3KiaUFLYMA3kz656Gqm9nIYhhkEuuhzzW34NcRezwASOz4r6brTiBd
   oXahkgTZKfp0Ent9HpWUgOE+RA2pBm/xmVPHafAp7mwkA+itAEejOXqyY
   IOZPoQsAGUciUkXRJQ16iIVc9zUof+0kddt8KSj5H/2bNnW4hiV5KbcjQ
   jQacvSSVcPP/NoghjAvNX/CsG3jRyxSZkedzNIJo9HcNpAJHCubv2dg8v
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223393913"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:31:14 +0800
IronPort-SDR: YGcBdK+FL46TMRqC7HPKwaaZXKeqdAeEKST+aM5dKTrpWfAcN8HJltM3GRPIxyI2OlCNY5xrKB
 BooOuozLf3/QbTdUenK2elNvIGw7qVkDw3PFTcRiqr427ZPGEuZmXhOI/6kGFEDClj3e+Sejpv
 APx+cRmZZSdwkqijcTQZNhlnE+Puy938Ftk2md3U4ipW/lG+wIb6mkEGRefB8pLRowq5JwGrc+
 RWxWW8+0yx84zFsLCWqQRlekry1Pbo7s68jwbUPPqEMfyyWc5oq2ISWVO5qAso9kAuSWqNylBh
 Yxo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:48:20 -0800
IronPort-SDR: cy4aamJFLe+Ayx3T6LPFAqiIcTEIPTbahwdjypRVZV6XDbNZcW8hkrOogr//sctBlzptHmIAkU
 cNv1ri1QpuxSU9d6D9AyWxeFadHOQlERYwYrgm734UeCBB2GOSJgTyKEhO3hL3CEK8F0zDczVA
 iYFRiluXr0xmW2D0bZrkp3aCBXpjeKILl013THSJ9a36g2zz3k8PO/DQuLxhjgfAZg6GUjfB7M
 azxG+VukjEnyO9S5Fklzrm7/K+MiZznkgHvc30mmnoFubr98xXHbQm0CwWo5wGUsed8mavURHJ
 cuw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:31:14 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/6] btrfs-progs: add dump tree support for the raid stripe tree
Date:   Wed, 15 Feb 2023 06:31:06 -0800
Message-Id: <20230215143109.2721722-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add support for the RAID stripe tree to btrfs inspect-internal dump-tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 cmds/inspect-dump-tree.c   |  5 +++++
 kernel-shared/ctree.h      |  3 +++
 kernel-shared/print-tree.c | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 8f28779c6d2f..a0c9163884d7 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -169,6 +169,7 @@ static u64 treeid_from_string(const char *str, const char **end)
 		{ "TREE_RELOC", BTRFS_TREE_RELOC_OBJECTID },
 		{ "DATA_RELOC", BTRFS_DATA_RELOC_TREE_OBJECTID },
 		{ "BLOCK_GROUP_TREE", BTRFS_BLOCK_GROUP_TREE_OBJECTID },
+		{ "RAID_STRIPE", BTRFS_RAID_STRIPE_TREE_OBJECTID },
 	};
 
 	if (strncasecmp("BTRFS_", str, strlen("BTRFS_")) == 0)
@@ -724,6 +725,10 @@ again:
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
index ab6b20a1abca..a9bb6eb39752 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1503,6 +1503,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_QGROUP_LIMIT_KEY		244
 #define BTRFS_QGROUP_RELATION_KEY	246
 
+
+#define BTRFS_RAID_STRIPE_KEY		247
+
 /*
  * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
  */
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 78e6aa2dcd5a..d6706f683bc1 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -635,6 +635,22 @@ static void print_free_space_header(struct extent_buffer *leaf, int slot)
 	       (unsigned long long)btrfs_free_space_bitmaps(leaf, header));
 }
 
+static void print_raid_stripe_key(struct extent_buffer *eb,
+				  u32 item_size,
+				  struct btrfs_stripe_extent *stripe)
+{
+	int num_stripes;
+	int i;
+
+	num_stripes = (item_size - offsetof(struct btrfs_stripe_extent, strides)) /
+		sizeof(struct btrfs_raid_stride);
+
+	for (i = 0; i < num_stripes; i++)
+		printf("\t\t\tstripe %d devid %llu offset %llu\n", i,
+		       (unsigned long long)btrfs_raid_stride_devid_nr(eb, stripe, i),
+		       (unsigned long long)btrfs_raid_stride_offset_nr(eb, stripe, i));
+}
+
 void print_key_type(FILE *stream, u64 objectid, u8 type)
 {
 	static const char* key_to_str[256] = {
@@ -679,6 +695,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_PERSISTENT_ITEM_KEY]	= "PERSISTENT_ITEM",
 		[BTRFS_UUID_KEY_SUBVOL]		= "UUID_KEY_SUBVOL",
 		[BTRFS_UUID_KEY_RECEIVED_SUBVOL] = "UUID_KEY_RECEIVED_SUBVOL",
+		[BTRFS_RAID_STRIPE_KEY]		= "RAID_STRIPE_KEY",
 	};
 
 	if (type == 0 && objectid == BTRFS_FREE_SPACE_OBJECTID) {
@@ -788,6 +805,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
 		fprintf(stream, "BLOCK_GROUP_TREE");
 		break;
+	case  BTRFS_RAID_STRIPE_TREE_OBJECTID:
+		fprintf(stream, "RAID_STRIPE_TREE");
+		break;
 	case (u64)-1:
 		fprintf(stream, "-1");
 		break;
@@ -1454,6 +1474,9 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
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
2.39.0

