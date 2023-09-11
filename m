Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC279B0D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355929AbjIKWC1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbjIKNXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:18 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F75193
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694438594; x=1725974594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SDYGdOJH0EumI768Ubnvw2FIaQ00d/j26jaN2tdsPUk=;
  b=Wef4Me+M+nm+zAIBTZO0SVx+pdzBQNFDpMg4H3ysutd4MFDvHVb05nKg
   uiD2QgP5FEDmGxdTuywzkXu6Blns6GxY1BzgUvnUbIwrqL1xc7TaJ2IAU
   tiaSnOHmmWFB/yYEmv4piXI7kgvG/tvzMp+uPEYukS24lex/j8cY4GdnJ
   cCsUHZBuRqIsbt5nCIcC/00sFk3YNyBCNK7gsBTu+3cJn6npDVNkRoHxG
   JjQIvml+XItbn99kQJbDXzV9QsHYMYFoY4NhIWHqRAnGlzWbgTMDSHybH
   53dPcyJUNvyK1MzqNE64X8TwhXrXVZeVwSUQN0QkZs8pK9E+FLEQ2IuI3
   w==;
X-CSE-ConnectionGUID: y5v9epF7Qkyy8RloYOpX2A==
X-CSE-MsgGUID: 1XpEZX+iQpiv+9pFXySPNw==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="248143281"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 21:23:13 +0800
IronPort-SDR: /RbPAkl7yPgNouhQn3Q+mOiOUP1aRzLeWC1LWO83bhfM9bj6f78JdPl5kJp2ZUMcOOb9myYvqW
 hPlfpq+cvvX2yRQm83QY88x32iobDPpwDO6JQbDCGNoL0fAQPxm7bceHo5qK/vv07uRg2L1D01
 lEqDB+lxKQqRjJJnPX1LmyTflajZ5lesd4LYodZbYXvdlNMCTqw4ufC/KwIGdySbOMvtEgE9Nl
 stSzNf2eHG5nOJPeBWdQNOWBtkZH7iwQT8iy1fshL6G8FZn0xOPJx8nfOIqV+/RhQ2wRCs1PGn
 RZQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:30:18 -0700
IronPort-SDR: 7aEmYPPO/PKLbAQV9KMVXdUR28cWisBzkIV9z3xhQaoLLwHdBLPx+DIXNlVYjVX7rN2SbeSidJ
 emJzhd0DvO5uQflAo9yn6+nldvi3FbIw10NImZm4MqsOVrORwm2xMjpGIKGEHTL/g9xGgDugLX
 9jba2UAtZrxPgeoTAd6JmExwwl5+7pOEq5lyjoVQM+RhMDs3twtQUxddZRbhpiyoemEvg2G9iY
 mLLOaDp+EjQcbT63AmjPDzqL0xWX5eK8lb2HoARCbZXXR9a34R9mCTTQSvF8CsMe3bazved8xS
 63w=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2023 06:23:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs-progs: add dump tree support for the raid stripe tree
Date:   Mon, 11 Sep 2023 06:22:59 -0700
Message-ID: <20230911-raid-stripe-tree-v1-3-c8337f7444b5@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
References: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694438542; l=4472; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=SDYGdOJH0EumI768Ubnvw2FIaQ00d/j26jaN2tdsPUk=; b=K7hEWrPZdjPnwnnm/GiPTntGKPdSOf6+TDQ+ry/l9UVyiot0Fr53EZwhVd4IjJ6/czzCxy1Mq xkcfMernbyIDF4pI30pvsxEGp6+5Sm9D8zMvbzeS+45DmUTgkAHjQrx
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

Add support for the RAID stripe tree to btrfs inspect-internal dump-tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 cmds/inspect-dump-tree.c   |  5 +++++
 kernel-shared/ctree.h      |  3 +++
 kernel-shared/print-tree.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

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
index 035358436d8f..26ab0b6aea17 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -650,6 +650,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_QGROUP_LIMIT_KEY		244
 #define BTRFS_QGROUP_RELATION_KEY	246
 
+
+#define BTRFS_RAID_STRIPE_KEY		247
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

